{* Purpose of this template: Display one certain option within an external context *}
<div id="option{$option.id}" class="mupolls-external-option">
{if $displayMode eq 'link'}
    <p class="mupolls-external-link">
    <a href="{modurl modname='MUPolls' type='user' func='display' ot='option'  id=$option.id}" title="{$option->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$option->getTitleFromDisplayPattern()|notifyfilters:'mupolls.filter_hooks.options.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='MUPolls::' instance='::' level='ACCESS_EDIT'}
    {* for normal users without edit permission show only the actual file per default *}
    {if $displayMode eq 'embed'}
        <p class="mupolls-external-title">
            <strong>{$option->getTitleFromDisplayPattern()|notifyfilters:'mupolls.filter_hooks.options.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="mupolls-external-snippet">
        &nbsp;
    </div>

    {* you can distinguish the context like this: *}
    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}

    {* you can enable more details about the item: *}
    {*
        <p class="mupolls-external-description">
            {if $option.title ne ''}{$option.title}<br />{/if}
        </p>
    *}
{/if}
</div>
