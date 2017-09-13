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

    return 'width=' + pWidth + ',height=' + pHeight + ',location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes';
}

/**
 * Open a popup window with the finder triggered by an editor button.
 */
function MUPollsModuleFinderOpenPopup(editor, editorName)
{
    var popupUrl;

    // Save editor for access in selector window
    currentMUPollsModuleEditor = editor;

    popupUrl = Routing.generate('mupollsmodule_external_finder', { objectType: 'poll', editor: editorName });

    if (editorName == 'ckeditor') {
        editor.popup(popupUrl, /*width*/ '80%', /*height*/ '70%', getMUPollsModulePopupAttributes());
    } else {
        window.open(popupUrl, '_blank', getMUPollsModulePopupAttributes());
    }
}


var mUPollsModule = {};

mUPollsModule.finder = {};

mUPollsModule.finder.onLoad = function (baseId, selectedId)
{
    if (jQuery('#mUPollsModuleSelectorForm').length < 1) {
        return;
    }
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
    if ('ckeditor' === editor) {
        mUPollsClosePopup();
    } else if ('quill' === editor) {
        mUPollsClosePopup();
    } else if ('summernote' === editor) {
        mUPollsClosePopup();
    } else if ('tinymce' === editor) {
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

    html = mUPollsGetPasteSnippet('html', itemId);
    editor = jQuery("[id$='editor']").first().val();
    if ('ckeditor' === editor) {
        if (null !== window.opener.currentMUPollsModuleEditor) {
            window.opener.currentMUPollsModuleEditor.insertHtml(html);
        }
    } else if ('quill' === editor) {
        if (null !== window.opener.currentMUPollsModuleEditor) {
            window.opener.currentMUPollsModuleEditor.clipboard.dangerouslyPasteHTML(window.opener.currentMUPollsModuleEditor.getLength(), html);
        }
    } else if ('summernote' === editor) {
        if (null !== window.opener.currentMUPollsModuleEditor) {
            html = jQuery(html).get(0);
            window.opener.currentMUPollsModuleEditor.invoke('insertNode', html);
        }
    } else if ('tinymce' === editor) {
        window.opener.currentMUPollsModuleEditor.insertContent(html);
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

jQuery(document).ready(function() {
    mUPollsModule.finder.onLoad();
});
