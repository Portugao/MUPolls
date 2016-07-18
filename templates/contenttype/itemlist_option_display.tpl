{* Purpose of this template: Display options within an external context *}
{foreach item='option' from=$items}
    <h3>{$option->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='MUPolls' type='user' ot='option' func='display'  id=$option.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
