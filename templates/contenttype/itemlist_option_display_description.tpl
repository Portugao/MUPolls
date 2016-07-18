{* Purpose of this template: Display options within an external context *}
<dl>
    {foreach item='option' from=$items}
        <dt>{$option->getTitleFromDisplayPattern()}</dt>
        {if $option.title}
            <dd>{$option.title|strip_tags|truncate:200:'&hellip;'}</dd>
        {/if}
        <dd><a href="{modurl modname='MUPolls' type='user' ot='option' func='display'  id=$option.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
