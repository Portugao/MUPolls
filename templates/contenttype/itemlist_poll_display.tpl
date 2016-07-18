{* Purpose of this template: Display polls within an external context *}
{foreach item='poll' from=$items}
    <h3>{$poll->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='MUPolls' type='user' ot='poll' func='display'  id=$poll.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
