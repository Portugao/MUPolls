'use strict';

function mUMUPollsToday(format)
{
    var timestamp, todayDate, month, day, hours, minutes, seconds;

    timestamp = new Date();
    todayDate = '';
    if (format !== 'time') {
        month = new String((parseInt(timestamp.getMonth()) + 1));
        if (month.length === 1) {
            month = '0' + month;
        }
        day = new String(timestamp.getDate());
        if (day.length === 1) {
            day = '0' + day;
        }
        todayDate += timestamp.getFullYear() + '-' + month + '-' + day;
    }
    if (format === 'datetime') {
        todayDate += ' ';
    }
    if (format != 'date') {
        hours = new String(timestamp.getHours());
        if (hours.length === 1) {
            hours = '0' + hours;
        }
        minutes = new String(timestamp.getMinutes());
        if (minutes.length === 1) {
            minutes = '0' + minutes;
        }
        seconds = new String(timestamp.getSeconds());
        if (seconds.length === 1) {
            seconds = '0' + seconds;
        }
        todayDate += hours + ':' + minutes;// + ':' + seconds;
    }
    return todayDate;
}

// returns YYYY-MM-DD even if date is in DD.MM.YYYY
function mUMUPollsReadDate(val, includeTime)
{
    // look if we have YYYY-MM-DD
    if (val.substr(4, 1) === '-' && val.substr(7, 1) === '-') {
        return val;
    }

    // look if we have DD.MM.YYYY
    if (val.substr(2, 1) === '.' && val.substr(5, 1) === '.') {
        var newVal = val.substr(6, 4) + '-' + val.substr(3, 2) + '-' + val.substr(0, 2);
        if (includeTime === true) {
            newVal += ' ' + val.substr(11, 5);
        }
        return newVal;
    }
}

function mUMUPollsValidateNoSpace(val)
{
    var valStr;
    valStr = new String(val);

    return (valStr.indexOf(' ') === -1);
}

function mUMUPollsValidateHtmlColour(val)
{
    var valStr;
    valStr = new String(val);

    return valStr === '' || (/^#[0-9a-f]{3}([0-9a-f]{3})?$/i.test(valStr));
}

function mUMUPollsValidateDateRangePoll(val)
{
    var cmpVal, cmpVal2, result;
    cmpVal = mUMUPollsReadDate($F('dateOfStart'), true);
    cmpVal2 = mUMUPollsReadDate($F('dateOfEnd'), true);
    result = (cmpVal <= cmpVal2);
    if (result) {
        $('advice-validate-daterange-poll-dateOfStart').hide();
        $('advice-validate-daterange-poll-dateOfEnd').hide();
        $('dateOfStart').removeClassName('validation-failed').addClassName('validation-passed');
        $('dateOfEnd').removeClassName('validation-failed').addClassName('validation-passed');
    } else {
        $('advice-validate-daterange-poll-dateOfStart').innerHTML = Zikula.__('The start must be before the end.', 'module_mupolls_js');
        $('advice-validate-daterange-poll-dateOfEnd').innerHTML = Zikula.__('The start must be before the end.', 'module_mupolls_js');

        $('advice-validate-daterange-poll-dateOfStart').show();
        $('advice-validate-daterange-poll-dateOfEnd').show();
        $('dateOfStart').removeClassName('validation-passed').addClassName('validation-failed');
        $('dateOfEnd').removeClassName('validation-passed').addClassName('validation-failed');
    }

    return result;
}

/**
 * Adds special validation rules.
 */
function mUMUPollsAddCommonValidationRules(objectType, currentEntityId)
{
    Validation.addAllThese([
        ['validate-nospace', Zikula.__('No spaces', 'module_mupolls_js'), function(val, elem) {
            return mUMUPollsValidateNoSpace(val);
        }],
        ['validate-htmlcolour', Zikula.__('Please select a valid html colour code.', 'module_mupolls_js'), function(val, elem) {
            return mUMUPollsValidateHtmlColour(val);
        }],
        ['validate-daterange-poll', Zikula.__('The start must be before the end.', 'module_mupolls_js'), function(val, elem) {
            return mUMUPollsValidateDateRangePoll(val);
        }],
    ]);
}
