{* Purpose of this template: Display one certain vote within an external context *}
<div id="vote{$vote.id}" class="mupolls-external-vote">
{if $displayMode eq 'link'}
    <p class="mupolls-external-link">
    <a href="{modurl modname='MUPolls' type='user' func='display' ot='vote'  id=$vote.id}" title="{$vote->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$vote->getTitleFromDisplayPattern()|notifyfilters:'mupolls.filter_hooks.votes.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='MUPolls::' instance='::' level='ACCESS_EDIT'}
    {* for normal users without edit permission show only the actual file per default *}
    {if $displayMode eq 'embed'}
        <p class="mupolls-external-title">
            <strong>{$vote->getTitleFromDisplayPattern()|notifyfilters:'mupolls.filter_hooks.votes.filter'}</strong>
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
        </p>
    *}
{/if}
</div>
