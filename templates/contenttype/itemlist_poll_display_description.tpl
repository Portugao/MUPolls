{* Purpose of this template: Display polls within an external context *}
<dl>
    {foreach item='poll' from=$items}
        <dt>{$poll->getTitleFromDisplayPattern()}</dt>
        {if $poll.description}
            <dd>{$poll.description|strip_tags|truncate:200:'&hellip;'}</dd>
        {/if}
        <dd><a href="{modurl modname='MUPolls' type='user' ot='poll' func='display'  id=$poll.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
