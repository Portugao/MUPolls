{* Purpose of this template: Display options in html mailings *}
{*
<ul>
{foreach item='option' from=$items}
    <li>
        <a href="{modurl modname='MUPolls' type='user' func='display' ot='option' id=$option.id fqurl=true}
        ">{$option->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No options found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_option_display_description.tpl'}
