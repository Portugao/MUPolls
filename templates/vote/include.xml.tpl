{* purpose of this template: votes xml inclusion template *}
<vote id="{$vote.id}" createdon="{$vote.createdDate|dateformat}" updatedon="{$vote.updatedDate|dateformat}">
    <id>{$vote.id}</id>
    <idOfOption>{$vote.idOfOption}</idOfOption>
    <idOfPoll>{$vote.idOfPoll}</idOfPoll>
    <workflowState>{$vote.workflowState|mupollsObjectState:false|lower}</workflowState>
</vote>
