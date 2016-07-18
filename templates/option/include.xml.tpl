{* purpose of this template: options xml inclusion template *}
<option id="{$option.id}" createdon="{$option.createdDate|dateformat}" updatedon="{$option.updatedDate|dateformat}">
    <id>{$option.id}</id>
    <title><![CDATA[{$option.title}]]></title>
    <colorOfOption><![CDATA[{$option.colorOfOption}]]></colorOfOption>
    <idOfPoll>{$option.idOfPoll}</idOfPoll>
    <workflowState>{$option.workflowState|mupollsObjectState:false|lower}</workflowState>
</option>
