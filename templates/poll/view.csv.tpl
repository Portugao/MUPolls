{* purpose of this template: polls view csv view *}
{mupollsTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true fileName='Polls.csv'}
{strip}"{gt text='Title'}";"{gt text='Description'}";"{gt text='Multiple'}";"{gt text='Date of start'}";"{gt text='Date of end'}";"{gt text='Workflow state'}"
{/strip}
{foreach item='poll' from=$items}
{strip}
    "{$poll.title}";"{$poll.description}";"{if !$poll.multiple}0{else}1{/if}";"{$poll.dateOfStart|dateformat:'datebrief'}";"{$poll.dateOfEnd|dateformat:'datebrief'}";"{$poll.workflowState|mupollsObjectState:false|lower}"
{/strip}
{/foreach}
