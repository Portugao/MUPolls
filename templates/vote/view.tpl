{* purpose of this template: votes list view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="mupolls-vote mupolls-view">
    {gt text='Vote list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='view' size='small' alt=$templateTitle}
            <h3>{$templateTitle}</h3>
        </div>
    {else}
        <h2>{$templateTitle}</h2>
    {/if}

    {if $canBeCreated}
        {checkpermissionblock component='MUPolls:Vote:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create vote' assign='createTitle'}
            <a href="{modurl modname='MUPolls' type=$lct func='edit' ot='vote'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUPolls' type=$lct func='view' ot='vote'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUPolls' type=$lct func='view' ot='vote' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='vote/viewQuickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    {if $lct eq 'admin'}
    <form action="{modurl modname='MUPolls' type='vote' func='handleSelectedEntries' lct=$lct}" method="post" id="votesViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
    {/if}
        <table class="z-datatable">
            <colgroup>
                {if $lct eq 'admin'}
                    <col id="cSelect" />
                {/if}
                <col id="cIdOfOption" />
                <col id="cIdOfPoll" />
                <col id="cItemActions" />
            </colgroup>
            <thead>
            <tr>
                {if $lct eq 'admin'}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleVotes" />
                    </th>
                {/if}
                <th id="hIdOfOption" scope="col" class="z-right">
                    {sortlink __linktext='Id of option' currentsort=$sort modname='MUPolls' type=$lct func='view' sort='idOfOption' sortdir=$sdir all=$all own=$own workflowState=$workflowState q=$q pageSize=$pageSize ot='vote'}
                </th>
                <th id="hIdOfPoll" scope="col" class="z-right">
                    {sortlink __linktext='Id of poll' currentsort=$sort modname='MUPolls' type=$lct func='view' sort='idOfPoll' sortdir=$sdir all=$all own=$own workflowState=$workflowState q=$q pageSize=$pageSize ot='vote'}
                </th>
                <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
            </tr>
            </thead>
            <tbody>
        
        {foreach item='vote' from=$items}
            <tr class="{cycle values='z-odd, z-even'}">
                {if $lct eq 'admin'}
                    <td headers="hSelect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$vote.id}" class="votes-checkbox" />
                    </td>
                {/if}
                <td headers="hIdOfOption" class="z-right">
                    {$vote.idOfOption}
                </td>
                <td headers="hIdOfPoll" class="z-right">
                    {$vote.idOfPoll}
                </td>
                <td id="itemActions{$vote.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                    {if count($vote._actions) gt 0}
                        {icon id="itemActions`$vote.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                        {foreach item='option' from=$vote._actions}
                            <a href="{$option.url.type|mupollsActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                        {/foreach}
                        <script type="text/javascript">
                        /* <![CDATA[ */
                            document.observe('dom:loaded', function() {
                                mUMUPollsInitItemActions('vote', 'view', 'itemActions{{$vote.id}}');
                            });
                        /* ]]> */
                        </script>
                    {/if}
                </td>
            </tr>
        {foreachelse}
            <tr class="z-{if $lct eq 'admin'}admin{else}data{/if}tableempty">
                <td class="z-left" colspan="{if $lct eq 'admin'}4{else}3{/if}">
            {gt text='No votes found.'}
              </td>
            </tr>
        {/foreach}
        
            </tbody>
        </table>
        
        {if !isset($showAllEntries) || $showAllEntries ne 1}
            {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='MUPolls' type=$lct func='view' ot='vote'}
        {/if}
    {if $lct eq 'admin'}
            <fieldset>
                <label for="mUPollsAction">{gt text='With selected votes'}</label>
                <select id="mUPollsAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>
    {/if}

    
    {* here you can activate calling display hooks for the view page if you need it *}
    {*if $lct ne 'admin'}
        {notifydisplayhooks eventname='mupolls.ui_hooks.votes.display_view' urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
    {/if*}
</div>
{include file="`$lct`/footer.tpl"}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        {{if $lct eq 'admin'}}
            {{* init the "toggle all" functionality *}}
            if ($('toggleVotes') != undefined) {
                $('toggleVotes').observe('click', function (e) {
                    Zikula.toggleInput('votesViewForm');
                    e.stop();
                });
            }
        {{/if}}
    });
/* ]]> */
</script>
