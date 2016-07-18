{* purpose of this template: polls display ics view *}
{mupollsTemplateHeaders contentType='text/calendar; charset=iso-8859-15' asAttachment=true fileName="poll_`$poll->getTitleFromDisplayPattern()`.ics"}
BEGIN:VCALENDAR
VERSION:2.0
PRODID:{$baseurl}
METHOD:PUBLISH
BEGIN:VEVENT
DTSTART:{php}$poll = $this->get_template_vars('poll'); echo gmdate('Ymd\THi00\Z', $poll['dateOfStart']) . "\r\n";{/php}
DTEND:{php}$poll = $this->get_template_vars('poll'); echo gmdate('Ymd\THi00\Z', $poll['dateOfEnd']) . "\r\n";{/php}
{if $poll.zipcode ne '' && $poll.city ne ''}{assign var='location' value="`$poll.zipcode` `$poll.city`"}LOCATION{$location|mupollsFormatIcalText}{/if}
TRANSP:OPAQUE
SEQUENCE:0
UID:{php}$poll = $this->get_template_vars('poll'); echo md5('ICAL' . $poll['dateOfStart'] . rand(1, 5000) . $poll['dateOfEnd']) . "\r\n";{/php}
DTSTAMP:{php}echo gmdate('Ymd\THi00\Z', time()) . "\r\n";{/php}
ORGANIZER;CN="{usergetvar name='uname' uid=$poll.createdUserId}":MAILTO:{usergetvar name='email' uid=$poll.createdUserId}
SUMMARY{$poll->getTitleFromDisplayPattern()|mupollsFormatIcalText}
{if $poll.description ne ''}DESCRIPTION{$poll.description|mupollsFormatIcalText}{/if}
PRIORITY:5
CLASS:PUBLIC
STATUS:CONFIRMED
END:VEVENT
END:VCALENDAR
