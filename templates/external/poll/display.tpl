{* Purpose of this template: Display one certain poll within an external context *}
<div id="poll{$poll.id}" class="mupolls-external-poll">
{if $displayMode eq 'link'}
    <p class="mupolls-external-link">
    <a href="{modurl modname='MUPolls' type='user' func='display' ot='poll'  id=$poll.id}" title="{$poll->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$poll->getTitleFromDisplayPattern()|notifyfilters:'mupolls.filter_hooks.polls.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='MUPolls::' instance='::' level='ACCESS_EDIT'}
    {* for normal users without edit permission show only the actual file per default *}
    {if $displayMode eq 'embed'}
        <p class="mupolls-external-title">
            <strong>{$poll->getTitleFromDisplayPattern()|notifyfilters:'mupolls.filter_hooks.polls.filter'}</strong>
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
            {if $poll.description ne ''}{$poll.description}<br />{/if}
        </p>
    *}
{/if}
</div>
