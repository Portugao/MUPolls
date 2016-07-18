{* purpose of this template: votes main view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<p>{gt text='Welcome to the vote section of the M u polls application.'}</p>
{include file="`$lct`/footer.tpl"}
