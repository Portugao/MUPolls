{* purpose of this template: options view csv view *}
{mupollsTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true fileName='Options.csv'}
{strip}"{gt text='Title'}";"{gt text='Color of option'}";"{gt text='Id of poll'}";"{gt text='Workflow state'}"
{/strip}
{foreach item='option' from=$items}
{strip}
    "{$option.title}";"{$option.colorOfOption}";"{$option.idOfPoll}";"{$option.workflowState|mupollsObjectState:false|lower}"
{/strip}
{/foreach}
