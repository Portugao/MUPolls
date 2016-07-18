'use strict';

var mUMUPollsContextMenu;

mUMUPollsContextMenu = Class.create(Zikula.UI.ContextMenu, {
    selectMenuItem: function ($super, event, item, item_container) {
        // open in new tab / window when right-clicked
        if (event.isRightClick()) {
            item.callback(this.clicked, true);
            event.stop(); // close the menu
            return;
        }
        // open in current window when left-clicked
        return $super(event, item, item_container);
    }
});

/**
 * Initialises the context menu for item actions.
 */
function mUMUPollsInitItemActions(objectType, func, containerId)
{
    var triggerId, contextMenu, icon;

    triggerId = containerId + 'Trigger';

    // attach context menu
    contextMenu = new mUMUPollsContextMenu(triggerId, { leftClick: true, animation: false });

    // process normal links
    $$('#' + containerId + ' a').each(function (elem) {
        // hide it
        elem.addClassName('z-hide');
        // determine the link text
        var linkText = '';
        if (func === 'display') {
            linkText = elem.innerHTML;
        } else if (func === 'view') {
            elem.select('img').each(function (imgElem) {
                linkText = imgElem.readAttribute('alt');
            });
        }

        // determine the icon
        icon = '';
        if (func === 'display') {
            if (elem.hasClassName('z-icon-es-preview')) {
                icon = 'xeyes.png';
            } else if (elem.hasClassName('z-icon-es-display')) {
                icon = 'kview.png';
            } else if (elem.hasClassName('z-icon-es-edit')) {
                icon = 'edit';
            } else if (elem.hasClassName('z-icon-es-saveas')) {
                icon = 'filesaveas';
            } else if (elem.hasClassName('z-icon-es-delete')) {
                icon = '14_layer_deletelayer';
            } else if (elem.hasClassName('z-icon-es-back')) {
                icon = 'agt_back';
            }
            if (icon !== '') {
                icon = Zikula.Config.baseURL + 'images/icons/extrasmall/' + icon + '.png';
            }
        } else if (func === 'view') {
            elem.select('img').each(function (imgElem) {
                icon = imgElem.readAttribute('src');
            });
        }
        if (icon !== '') {
            icon = '<img src="' + icon + '" width="16" height="16" alt="' + linkText + '" /> ';
        }

        contextMenu.addItem({
            label: icon + linkText,
            callback: function (selectedMenuItem, isRightClick) {
                var url;

                url = elem.readAttribute('href');
                if (isRightClick) {
                    window.open(url);
                } else {
                    window.location = url;
                }
            }
        });
    });
    $(triggerId).removeClassName('z-hide');
}

function mUMUPollsCapitaliseFirstLetter(string)
{
    return string.charAt(0).toUpperCase() + string.substring(1);
}

/**
 * Submits a quick navigation form.
 */
function mUMUPollsSubmitQuickNavForm(objectType)
{
    $('mupolls' + mUMUPollsCapitaliseFirstLetter(objectType) + 'QuickNavForm').submit();
}

/**
 * Initialise the quick navigation panel in list views.
 */
function mUMUPollsInitQuickNavigation(objectType)
{
    if ($('mupolls' + mUMUPollsCapitaliseFirstLetter(objectType) + 'QuickNavForm') == undefined) {
        return;
    }

    if ($('catid') != undefined) {
        $('catid').observe('change', function () { mUMUPollsSubmitQuickNavForm(objectType); });
    }
    if ($('sortBy') != undefined) {
        $('sortBy').observe('change', function () { mUMUPollsSubmitQuickNavForm(objectType); });
    }
    if ($('sortDir') != undefined) {
        $('sortDir').observe('change', function () { mUMUPollsSubmitQuickNavForm(objectType); });
    }
    if ($('num') != undefined) {
        $('num').observe('change', function () { mUMUPollsSubmitQuickNavForm(objectType); });
    }

    switch (objectType) {
    case 'option':
        if ($('workflowState') != undefined) {
            $('workflowState').observe('change', function () { mUMUPollsSubmitQuickNavForm(objectType); });
        }
        break;
    case 'poll':
        if ($('workflowState') != undefined) {
            $('workflowState').observe('change', function () { mUMUPollsSubmitQuickNavForm(objectType); });
        }
        if ($('multiple') != undefined) {
            $('multiple').observe('change', function () { mUMUPollsSubmitQuickNavForm(objectType); });
        }
        break;
    case 'vote':
        if ($('workflowState') != undefined) {
            $('workflowState').observe('change', function () { mUMUPollsSubmitQuickNavForm(objectType); });
        }
        break;
    default:
        break;
    }
}
