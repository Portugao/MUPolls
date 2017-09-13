'use strict';

var mUPollsModule = {};

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
    jQuery('#ajaxIndicator').removeClass('hidden');

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

    jQuery.getJSON(Routing.generate('mupollsmodule_ajax_getitemlistfinder'), params, function( data ) {
        var baseId;

        baseId = mUPollsModule.itemSelector.baseId;
        mUPollsModule.itemSelector.items[baseId] = data;
        jQuery('#ajaxIndicator').addClass('hidden');
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

jQuery(document).ready(function() {
    var infoElem;

    infoElem = jQuery('#itemSelectorInfo');
    if (infoElem.length == 0) {
        return;
    }

    mUPollsModule.itemSelector.onLoad(infoElem.data('base-id'), infoElem.data('selected-id'));
});
