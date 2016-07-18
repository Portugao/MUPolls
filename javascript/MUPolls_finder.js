'use strict';

var currentMUPollsEditor = null;
var currentMUPollsInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getMUPollsPopupAttributes()
{
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;

    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a Xinha button.
 */
function MUPollsFinderXinha(editor, mupollsUrl)
{
    var popupAttributes;

    // Save editor for access in selector window
    currentMUPollsEditor = editor;

    popupAttributes = getMUPollsPopupAttributes();
    window.open(mupollsUrl, '', popupAttributes);
}

/**
 * Open a popup window with the finder triggered by a CKEditor button.
 */
function MUPollsFinderCKEditor(editor, mupollsUrl)
{
    // Save editor for access in selector window
    currentMUPollsEditor = editor;

    editor.popup(
        Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=MUPolls&type=external&func=finder&editor=ckeditor',
        /*width*/ '80%', /*height*/ '70%',
        'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes'
    );
}


var mUPolls = {};

mUPolls.finder = {};

mUPolls.finder.onLoad = function (baseId, selectedId)
{
    $$('div.category-selector select').invoke('observe', 'change', mUPolls.finder.onParamChanged);
    $('mUPollsSort').observe('change', mUPolls.finder.onParamChanged);
    $('mUPollsSortDir').observe('change', mUPolls.finder.onParamChanged);
    $('mUPollsPageSize').observe('change', mUPolls.finder.onParamChanged);
    $('mUPollsSearchGo').observe('click', mUPolls.finder.onParamChanged);
    $('mUPollsSearchGo').observe('keypress', mUPolls.finder.onParamChanged);
    $('mUPollsSubmit').addClassName('z-hide');
    $('mUPollsCancel').observe('click', mUPolls.finder.handleCancel);
};

mUPolls.finder.onParamChanged = function ()
{
    $('mUPollsSelectorForm').submit();
};

mUPolls.finder.handleCancel = function ()
{
    var editor, w;

    editor = $F('editorName');
    if ('xinha' === editor) {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        mUMUPollsClosePopup();
    } else if (editor === 'ckeditor') {
        mUMUPollsClosePopup();
    } else {
        alert('Close Editor: ' + editor);
    }
};


function mUMUPollsGetPasteSnippet(mode, itemId)
{
    var quoteFinder, itemUrl, itemTitle, itemDescription, pasteMode;

    quoteFinder = new RegExp('"', 'g');
    itemUrl = $F('url' + itemId).replace(quoteFinder, '');
    itemTitle = $F('title' + itemId).replace(quoteFinder, '');
    itemDescription = $F('desc' + itemId).replace(quoteFinder, '');
    pasteMode = $F('mUPollsPasteAs');

    if (pasteMode === '2' || pasteMode !== '1') {
        return itemId;
    }

    // return link to item
    if (mode === 'url') {
        // plugin mode
        return itemUrl;
    }

    // editor mode
    return '<a href="' + itemUrl + '" title="' + itemDescription + '">' + itemTitle + '</a>';
}


// User clicks on "select item" button
mUPolls.finder.selectItem = function (itemId)
{
    var editor, html;

    editor = $F('editorName');
    if ('xinha' === editor) {
        if (null !== window.opener.currentMUPollsEditor) {
            html = mUMUPollsGetPasteSnippet('html', itemId);

            window.opener.currentMUPollsEditor.focusEditor();
            window.opener.currentMUPollsEditor.insertHTML(html);
        } else {
            html = mUMUPollsGetPasteSnippet('url', itemId);
            var currentInput = window.opener.currentMUPollsInput;

            if ('INPUT' === currentInput.tagName) {
                // Simply overwrite value of input elements
                currentInput.value = html;
            } else if ('TEXTAREA' === currentInput.tagName) {
                // Try to paste into textarea - technique depends on environment
                if (typeof document.selection !== 'undefined') {
                    // IE: Move focus to textarea (which fortunately keeps its current selection) and overwrite selection
                    currentInput.focus();
                    window.opener.document.selection.createRange().text = html;
                } else if (typeof currentInput.selectionStart !== 'undefined') {
                    // Firefox: Get start and end points of selection and create new value based on old value
                    var startPos = currentInput.selectionStart;
                    var endPos = currentInput.selectionEnd;
                    currentInput.value = currentInput.value.substring(0, startPos)
                                        + html
                                        + currentInput.value.substring(endPos, currentInput.value.length);
                } else {
                    // Others: just append to the current value
                    currentInput.value += html;
                }
            }
        }
    } else if ('tinymce' === editor) {
        html = mUMUPollsGetPasteSnippet('html', itemId);
        tinyMCE.activeEditor.execCommand('mceInsertContent', false, html);
        // other tinymce commands: mceImage, mceInsertLink, mceReplaceContent, see http://www.tinymce.com/wiki.php/Command_identifiers
    } else if ('ckeditor' === editor) {
        if (null !== window.opener.currentMUPollsEditor) {
            html = mUMUPollsGetPasteSnippet('html', itemId);

            window.opener.currentMUPollsEditor.insertHtml(html);
        }
    } else {
        alert('Insert into Editor: ' + editor);
    }
    mUMUPollsClosePopup();
};

function mUMUPollsClosePopup()
{
    window.opener.focus();
    window.close();
}




//=============================================================================
// MUPolls item selector for Forms
//=============================================================================

mUPolls.itemSelector = {};
mUPolls.itemSelector.items = {};
mUPolls.itemSelector.baseId = 0;
mUPolls.itemSelector.selectedId = 0;

mUPolls.itemSelector.onLoad = function (baseId, selectedId)
{
    mUPolls.itemSelector.baseId = baseId;
    mUPolls.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $('mUPollsObjectType').observe('change', mUPolls.itemSelector.onParamChanged);

    if ($(baseId + '_catidMain') != undefined) {
        $(baseId + '_catidMain').observe('change', mUPolls.itemSelector.onParamChanged);
    } else if ($(baseId + '_catidsMain') != undefined) {
        $(baseId + '_catidsMain').observe('change', mUPolls.itemSelector.onParamChanged);
    }
    $(baseId + 'Id').observe('change', mUPolls.itemSelector.onItemChanged);
    $(baseId + 'Sort').observe('change', mUPolls.itemSelector.onParamChanged);
    $(baseId + 'SortDir').observe('change', mUPolls.itemSelector.onParamChanged);
    $('mUPollsSearchGo').observe('click', mUPolls.itemSelector.onParamChanged);
    $('mUPollsSearchGo').observe('keypress', mUPolls.itemSelector.onParamChanged);

    mUPolls.itemSelector.getItemList();
};

mUPolls.itemSelector.onParamChanged = function ()
{
    $('ajax_indicator').removeClassName('z-hide');

    mUPolls.itemSelector.getItemList();
};

mUPolls.itemSelector.getItemList = function ()
{
    var baseId, params, request;

    baseId = mupolls.itemSelector.baseId;
    params = 'ot=' + baseId + '&';
    if ($(baseId + '_catidMain') != undefined) {
        params += 'catidMain=' + $F(baseId + '_catidMain') + '&';
    } else if ($(baseId + '_catidsMain') != undefined) {
        params += 'catidsMain=' + $F(baseId + '_catidsMain') + '&';
    }
    params += 'sort=' + $F(baseId + 'Sort') + '&' +
              'sortdir=' + $F(baseId + 'SortDir') + '&' +
              'q=' + $F(baseId + 'SearchTerm');

    request = new Zikula.Ajax.Request(
        Zikula.Config.baseURL + 'ajax.php?module=MUPolls&func=getItemListFinder',
        {
            method: 'post',
            parameters: params,
            onFailure: function(req) {
                Zikula.showajaxerror(req.getMessage());
            },
            onSuccess: function(req) {
                var baseId;
                baseId = mUPolls.itemSelector.baseId;
                mUPolls.itemSelector.items[baseId] = req.getData();
                $('ajax_indicator').addClassName('z-hide');
                mUPolls.itemSelector.updateItemDropdownEntries();
                mUPolls.itemSelector.updatePreview();
            }
        }
    );
};

mUPolls.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = mUPolls.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    itemSelector.length = 0;

    items = mUPolls.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (mUPolls.itemSelector.selectedId > 0) {
        $(baseId + 'Id').value = mUPolls.itemSelector.selectedId;
    }
};

mUPolls.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = mUPolls.itemSelector.baseId;
    items = mUPolls.itemSelector.items[baseId];

    $(baseId + 'PreviewContainer').addClassName('z-hide');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (mUPolls.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id === mUPolls.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (null !== selectedElement) {
        $(baseId + 'PreviewContainer')
            .update(window.atob(selectedElement.previewInfo))
            .removeClassName('z-hide');
    }
};

mUPolls.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = mUPolls.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    preview = window.atob(mUPolls.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + 'PreviewContainer').update(preview);
    mUPolls.itemSelector.selectedId = $F(baseId + 'Id');
};
