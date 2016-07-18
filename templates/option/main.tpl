{* purpose of this template: options main view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<p>{gt text='Welcome to the option section of the M u polls application.'}</p>
{include file="`$lct`/footer.tpl"}
