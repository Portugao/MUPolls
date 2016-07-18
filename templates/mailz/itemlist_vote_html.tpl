{* Purpose of this template: Display votes in html mailings *}
{*
<ul>
{foreach item='vote' from=$items}
    <li>
        <a href="{modurl modname='MUPolls' type='user' func='display' ot='vote' id=$vote.id fqurl=true}
        ">{$vote->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No votes found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_vote_display_description.tpl'}
