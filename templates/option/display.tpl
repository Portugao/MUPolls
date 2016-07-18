{* purpose of this template: options display view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="mupolls-option mupolls-display">
    {gt text='Option' assign='templateTitle'}
    {assign var='templateTitle' value=$option->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='display' size='small' __alt='Details'}
            <h3>{$templateTitle|notifyfilters:'mupolls.filter_hooks.options.filter'}{icon id="itemActions`$option.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
            </h3>
        </div>
    {else}
        <h2>{$templateTitle|notifyfilters:'mupolls.filter_hooks.options.filter'}{icon id="itemActions`$option.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
        </h2>
    {/if}


    <dl>
        <dt>{gt text='Title'}</dt>
        <dd>{$option.title}</dd>
        <dt>{gt text='Color of option'}</dt>
        <dd>{$option.colorOfOption}</dd>
        <dt>{gt text='Id of poll'}</dt>
        <dd>{$option.idOfPoll}</dd>
        
    </dl>
    {include file='helper/includeStandardFieldsDisplay.tpl' obj=$option}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='mupolls.ui_hooks.options.display_view' id=$option.id urlobject=$currentUrlObject assign='hooks'}
        {foreach name='hookLoop' key='providerArea' item='hook' from=$hooks}
            {if $providerArea ne 'provider.scribite.ui_hooks.editor'}{* fix for #664 *}
                {$hook}
            {/if}
        {/foreach}
        {if count($option._actions) gt 0}
            <p id="itemActions{$option.id}">
                {foreach item='option' from=$option._actions}
                    <a href="{$option.url.type|mupollsActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
                {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    mUMUPollsInitItemActions('option', 'display', 'itemActions{{$option.id}}');
                });
            /* ]]> */
            </script>
        {/if}
    {/if}
</div>
{include file="`$lct`/footer.tpl"}
