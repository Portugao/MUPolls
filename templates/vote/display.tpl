{* purpose of this template: votes display view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="mupolls-vote mupolls-display">
    {gt text='Vote' assign='templateTitle'}
    {assign var='templateTitle' value=$vote->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='display' size='small' __alt='Details'}
            <h3>{$templateTitle|notifyfilters:'mupolls.filter_hooks.votes.filter'}{icon id="itemActions`$vote.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
            </h3>
        </div>
    {else}
        <h2>{$templateTitle|notifyfilters:'mupolls.filter_hooks.votes.filter'}{icon id="itemActions`$vote.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
        </h2>
    {/if}


    <dl>
        <dt>{gt text='Id of option'}</dt>
        <dd>{$vote.idOfOption}</dd>
        <dt>{gt text='Id of poll'}</dt>
        <dd>{$vote.idOfPoll}</dd>
        
    </dl>
    {include file='helper/includeStandardFieldsDisplay.tpl' obj=$vote}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='mupolls.ui_hooks.votes.display_view' id=$vote.id urlobject=$currentUrlObject assign='hooks'}
        {foreach name='hookLoop' key='providerArea' item='hook' from=$hooks}
            {if $providerArea ne 'provider.scribite.ui_hooks.editor'}{* fix for #664 *}
                {$hook}
            {/if}
        {/foreach}
        {if count($vote._actions) gt 0}
            <p id="itemActions{$vote.id}">
                {foreach item='option' from=$vote._actions}
                    <a href="{$option.url.type|mupollsActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
                {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    mUMUPollsInitItemActions('vote', 'display', 'itemActions{{$vote.id}}');
                });
            /* ]]> */
            </script>
        {/if}
    {/if}
</div>
{include file="`$lct`/footer.tpl"}
