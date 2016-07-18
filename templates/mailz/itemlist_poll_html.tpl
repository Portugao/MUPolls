{* Purpose of this template: Display polls in html mailings *}
{*
<ul>
{foreach item='poll' from=$items}
    <li>
        <a href="{modurl modname='MUPolls' type='user' func='display' ot='poll' id=$poll.id fqurl=true}
        ">{$poll->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No polls found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_poll_display_description.tpl'}
