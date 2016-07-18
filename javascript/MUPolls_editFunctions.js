'use strict';


/**
 * Resets the value of a date or datetime input field.
 */
function mUMUPollsResetDateField(fieldName)
{
    if (null != $(fieldName)) {
        $(fieldName).value = '';
    }
    if (null != $(fieldName + 'cal')) {
        $(fieldName + 'cal').update(Zikula.__('No date set.', 'module_mupolls_js'));
    }
}

/**
 * Initialises the reset button for a certain date input.
 */
function mUMUPollsInitDateField(fieldName)
{
    var fieldNameCapitalised;

    fieldNameCapitalised = fieldName.charAt(0).toUpperCase() + fieldName.substring(1);
    if (null != $('reset' + fieldNameCapitalised + 'Val')) {
        $('reset' + fieldNameCapitalised + 'Val').observe('click', function (evt) {
            evt.preventDefault();
            mUMUPollsResetDateField(fieldName);
        }).removeClassName('z-hide').setStyle({ display: 'block' });
    }
}

