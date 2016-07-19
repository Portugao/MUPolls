{* purpose of this template: polls xml inclusion template *}
<poll id="{$poll.id}" createdon="{$poll.createdDate|dateformat}" updatedon="{$poll.updatedDate|dateformat}">
    <id>{$poll.id}</id>
    <title><![CDATA[{$poll.title}]]></title>
    <description><![CDATA[{$poll.description}]]></description>
    <multiple>{if !$poll.multiple}0{else}1{/if}</multiple>
    <dateOfStart>{$poll.dateOfStart|dateformat:'datetimebrief'}</dateOfStart>
    <dateOfEnd>{$poll.dateOfEnd|dateformat:'datetimebrief'}</dateOfEnd>
    <workflowState>{$poll.workflowState|mupollsObjectState:false|lower}</workflowState>
</poll>
