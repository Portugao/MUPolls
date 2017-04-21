'use strict';

var currentMUPollsModuleEditor = null;
var currentMUPollsModuleInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getMUPollsModulePopupAttributes()
{
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;

    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a CKEditor button.
 */
function MUPollsModuleFinderCKEditor(editor, pollsUrl)
{
    // Save editor for access in selector window
    currentMUPollsModuleEditor = editor;

    editor.popup(
        Routing.generate('mupollsmodule_external_finder', { objectType: 'poll', editor: 'ckeditor' }),
        /*width*/ '80%', /*height*/ '70%',
        'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes'
    );
}


var mUPollsModule = {};

mUPollsModule.finder = {};

mUPollsModule.finder.onLoad = function (baseId, selectedId)
{
    jQuery('select').not("[id$='pasteAs']").change(mUPollsModule.finder.onParamChanged);
    
    jQuery('.btn-default').click(mUPollsModule.finder.handleCancel);

    var selectedItems = jQuery('#mupollsmoduleItemContainer a');
    selectedItems.bind('click keypress', function (event) {
        event.preventDefault();
        mUPollsModule.finder.selectItem(jQuery(this).data('itemid'));
    });
};

mUPollsModule.finder.onParamChanged = function ()
{
    jQuery('#mUPollsModuleSelectorForm').submit();
};

mUPollsModule.finder.handleCancel = function (event)
{
    var editor;

    event.preventDefault();
    editor = jQuery("[id$='editor']").first().val();
    if ('tinymce' === editor) {
        mUPollsClosePopup();
    } else if ('ckeditor' === editor) {
        mUPollsClosePopup();
    } else {
        alert('Close Editor: ' + editor);
    }
};


function mUPollsGetPasteSnippet(mode, itemId)
{
    var quoteFinder;
    var itemPath;
    var itemUrl;
    var itemTitle;
    var itemDescription;
    var pasteMode;

    quoteFinder = new RegExp('"', 'g');
    itemPath = jQuery('#path' + itemId).val().replace(quoteFinder, '');
    itemUrl = jQuery('#url' + itemId).val().replace(quoteFinder, '');
    itemTitle = jQuery('#title' + itemId).val().replace(quoteFinder, '').trim();
    itemDescription = jQuery('#desc' + itemId).val().replace(quoteFinder, '').trim();
    pasteMode = jQuery("[id$='pasteAs']").first().val();

    // item ID
    if (pasteMode === '3') {
        return '' + itemId;
    }

    // relative link to detail page
    if (pasteMode === '1') {
        return mode === 'url' ? itemPath : '<a href="' + itemPath + '" title="' + itemDescription + '">' + itemTitle + '</a>';
    }
    // absolute url to detail page
    if (pasteMode === '2') {
        return mode === 'url' ? itemUrl : '<a href="' + itemUrl + '" title="' + itemDescription + '">' + itemTitle + '</a>';
    }

    return '';
}


// User clicks on "select item" button
mUPollsModule.finder.selectItem = function (itemId)
{
    var editor, html;

    editor = jQuery("[id$='editor']").first().val();
    if ('tinymce' === editor) {
        html = mUPollsGetPasteSnippet('html', itemId);
        tinyMCE.activeEditor.execCommand('mceInsertContent', false, html);
        // other tinymce commands: mceImage, mceInsertLink, mceReplaceContent, see http://www.tinymce.com/wiki.php/Command_identifiers
    } else if ('ckeditor' === editor) {
        if (null !== window.opener.currentMUPollsModuleEditor) {
            html = mUPollsGetPasteSnippet('html', itemId);

            window.opener.currentMUPollsModuleEditor.insertHtml(html);
        }
    } else {
        alert('Insert into Editor: ' + editor);
    }
    mUPollsClosePopup();
};

function mUPollsClosePopup()
{
    window.opener.focus();
    window.close();
}




//=============================================================================
// MUPollsModule item selector for Forms
//=============================================================================

mUPollsModule.itemSelector = {};
mUPollsModule.itemSelector.items = {};
mUPollsModule.itemSelector.baseId = 0;
mUPollsModule.itemSelector.selectedId = 0;

mUPollsModule.itemSelector.onLoad = function (baseId, selectedId)
{
    mUPollsModule.itemSelector.baseId = baseId;
    mUPollsModule.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    jQuery('#mUPollsModuleObjectType').change(mUPollsModule.itemSelector.onParamChanged);

    jQuery('#' + baseId + '_catidMain').change(mUPollsModule.itemSelector.onParamChanged);
    jQuery('#' + baseId + '_catidsMain').change(mUPollsModule.itemSelector.onParamChanged);
    jQuery('#' + baseId + 'Id').change(mUPollsModule.itemSelector.onItemChanged);
    jQuery('#' + baseId + 'Sort').change(mUPollsModule.itemSelector.onParamChanged);
    jQuery('#' + baseId + 'SortDir').change(mUPollsModule.itemSelector.onParamChanged);
    jQuery('#mUPollsModuleSearchGo').click(mUPollsModule.itemSelector.onParamChanged);
    jQuery('#mUPollsModuleSearchGo').keypress(mUPollsModule.itemSelector.onParamChanged);

    mUPollsModule.itemSelector.getItemList();
};

mUPollsModule.itemSelector.onParamChanged = function ()
{
    jQuery('#ajax_indicator').removeClass('hidden');

    mUPollsModule.itemSelector.getItemList();
};

mUPollsModule.itemSelector.getItemList = function ()
{
    var baseId;
    var params;

    baseId = mUPollsModule.itemSelector.baseId;
    params = {
        ot: baseId,
        sort: jQuery('#' + baseId + 'Sort').val(),
        sortdir: jQuery('#' + baseId + 'SortDir').val(),
        q: jQuery('#' + baseId + 'SearchTerm').val()
    }
    if (jQuery('#' + baseId + '_catidMain').length > 0) {
        params[catidMain] = jQuery('#' + baseId + '_catidMain').val();
    } else if (jQuery('#' + baseId + '_catidsMain').length > 0) {
        params[catidsMain] = jQuery('#' + baseId + '_catidsMain').val();
    }

    jQuery.ajax({
        type: 'POST',
        url: Routing.generate('mupollsmodule_ajax_getitemlistfinder'),
        data: params
    }).done(function(res) {
        // get data returned by the ajax response
        var baseId;
        baseId = mUPollsModule.itemSelector.baseId;
        mUPollsModule.itemSelector.items[baseId] = res.data;
        jQuery('#ajax_indicator').addClass('hidden');
        mUPollsModule.itemSelector.updateItemDropdownEntries();
        mUPollsModule.itemSelector.updatePreview();
    });
};

mUPollsModule.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = mUPollsModule.itemSelector.baseId;
    itemSelector = jQuery('#' + baseId + 'Id');
    itemSelector.length = 0;

    items = mUPollsModule.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.get(0).options[i] = new Option(item.title, item.id, false);
    }

    if (mUPollsModule.itemSelector.selectedId > 0) {
        jQuery('#' + baseId + 'Id').val(mUPollsModule.itemSelector.selectedId);
    }
};

mUPollsModule.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = mUPollsModule.itemSelector.baseId;
    items = mUPollsModule.itemSelector.items[baseId];

    jQuery('#' + baseId + 'PreviewContainer').addClass('hidden');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (mUPollsModule.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id == mUPollsModule.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (null !== selectedElement) {
        jQuery('#' + baseId + 'PreviewContainer')
            .html(window.atob(selectedElement.previewInfo))
            .removeClass('hidden');
    }
};

mUPollsModule.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = mUPollsModule.itemSelector.baseId;
    itemSelector = jQuery('#' + baseId + 'Id').get(0);
    preview = window.atob(mUPollsModule.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    jQuery('#' + baseId + 'PreviewContainer').html(preview);
    mUPollsModule.itemSelector.selectedId = jQuery('#' + baseId + 'Id').val();
};
