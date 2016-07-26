{* purpose of this template: polls display view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="mupolls-poll mupolls-display">
    {gt text='Poll' assign='templateTitle'}
    {assign var='templateTitle' value=$poll->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='display' size='small' __alt='Details'}
            <h3>{$templateTitle|notifyfilters:'mupolls.filter_hooks.polls.filter'}{icon id="itemActions`$poll.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
            </h3>
        </div>
    {else}
        <h2>{$templateTitle|notifyfilters:'mupolls.filter_hooks.polls.filter'}{icon id="itemActions`$poll.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
        </h2>
    {/if}

	{if $lct eq 'admin'}
    <dl>
        <dt>{gt text='Title'}</dt>
        <dd>{$poll.title}</dd>
        <dt>{gt text='Description'}</dt>
        <dd>{$poll.description}</dd>
        
    </dl>
    {include file='helper/includeStandardFieldsDisplay.tpl' obj=$poll}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='mupolls.ui_hooks.polls.display_view' id=$poll.id urlobject=$currentUrlObject assign='hooks'}
        {foreach name='hookLoop' key='providerArea' item='hook' from=$hooks}
            {if $providerArea ne 'provider.scribite.ui_hooks.editor'}{* fix for #664 *}
                {$hook}
            {/if}
        {/foreach}
        {if count($poll._actions) gt 0}
            <p id="itemActions{$poll.id}">
                {foreach item='option' from=$poll._actions}
                    <a href="{$option.url.type|mupollsActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
                {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    mUMUPollsInitItemActions('poll', 'display', 'itemActions{{$poll.id}}');
                });
            /* ]]> */
            </script>
        {/if}
    {/if}
    {/if}
    {if $lct eq 'user'}
        <div>
        {if $poll.description ne ''}
		{$poll.description}{/if}<br />

		{if $poll.dateOfEnd|dateformat:'%Y-%m-%d %H:%M:%S' >= $smarty.now|date_format:"%Y-%m-%d %H:%M:%S"}
		{if $voted eq '0' || !$voted}
		    <form action="{modurl modname='MUPolls' type='vote' func='edit'}" method="post">
            {foreach item='option' from=$options}
            <label>
            <input type="radio" name="option" value="{$option.id}" id="option">
            <span style="color: {$option.colorOfOption}">{$option.title}</span>
            </label><br>
            {/foreach}<br />
            <input type="hidden" name="poll" value={$poll.id} />
            <input type="hidden" name="currentUrl" value="{$currentUrl}" />
            {if is_array($options)}
                <input class="btn btn-success" type="submit" value="{gt text="Vote}" />
            {/if}
            </form>
        {else}
        	{foreach item='option' from=$options}
        		<ul>
        			<li>{$option.title}</li>
        		</ul>
        	
        	{/foreach}
        {/if}
        {else}
        	{mupollsVoteCalculator pollId=$poll.id} 
        {/if}
        </div>
    
    {/if}
</div>
{include file="`$lct`/footer.tpl"}
