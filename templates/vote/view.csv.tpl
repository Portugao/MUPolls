{* purpose of this template: votes view csv view *}
{mupollsTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true fileName='Votes.csv'}
{strip}"{gt text='Id of option'}";"{gt text='Id of poll'}";"{gt text='Workflow state'}"
{/strip}
{foreach item='vote' from=$items}
{strip}
    "{$vote.idOfOption}";"{$vote.idOfPoll}";"{$vote.workflowState|mupollsObjectState:false|lower}"
{/strip}
{/foreach}
