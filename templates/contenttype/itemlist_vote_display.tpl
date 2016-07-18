{* Purpose of this template: Display votes within an external context *}
{foreach item='vote' from=$items}
    <h3>{$vote->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='MUPolls' type='user' ot='vote' func='display'  id=$vote.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
