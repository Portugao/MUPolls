{* Purpose of this template: Display votes within an external context *}
<dl>
    {foreach item='vote' from=$items}
        <dt>{$vote->getTitleFromDisplayPattern()}</dt>
        <dd><a href="{modurl modname='MUPolls' type='user' ot='vote' func='display'  id=$vote.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
