{* purpose of this template: polls list view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="mupolls-poll mupolls-view">
    {gt text='Poll list' assign='templateTitle'}
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
        {checkpermissionblock component='MUPolls:Poll:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create poll' assign='createTitle'}
            <a href="{modurl modname='MUPolls' type=$lct func='edit' ot='poll'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1 && $lct eq 'admin'}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUPolls' type=$lct func='view' ot='poll'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUPolls' type=$lct func='view' ot='poll' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {if $lct eq 'admin'}
        {include file='poll/viewQuickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}
    {/if}
    
    {if $lct eq 'admin'}
    <form action="{modurl modname='MUPolls' type='poll' func='handleSelectedEntries' lct=$lct}" method="post" id="pollsViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
    {/if}
        <table class="z-datatable">
            <colgroup>
                {if $lct eq 'admin'}
                    <col id="cSelect" />
                {/if}
                <col id="cTitle" />
                {if $lct eq 'admin'}
                <col id="cDescription" />
                <col id="cMultiple" />
                {/if}
                <col id="cDateOfStart" />
                <col id="cDateOfEnd" />
                {if $lct eq 'admin'}
                <col id="cItemActions" />
                {/if}
            </colgroup>
            <thead>
            <tr>
                {if $lct eq 'admin'}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="togglePolls" />
                    </th>
                {/if}
                <th id="hTitle" scope="col" class="z-left">
                    {sortlink __linktext='Title' currentsort=$sort modname='MUPolls' type=$lct func='view' sort='title' sortdir=$sdir all=$all own=$own workflowState=$workflowState q=$q pageSize=$pageSize multiple=$multiple ot='poll'}
                </th>
                {if $lct eq 'admin'}
                <th id="hDescription" scope="col" class="z-left">
                    {sortlink __linktext='Description' currentsort=$sort modname='MUPolls' type=$lct func='view' sort='description' sortdir=$sdir all=$all own=$own workflowState=$workflowState q=$q pageSize=$pageSize multiple=$multiple ot='poll'}
                </th>
                <th id="hMultiple" scope="col" class="z-center">
                    {sortlink __linktext='Multiple' currentsort=$sort modname='MUPolls' type=$lct func='view' sort='multiple' sortdir=$sdir all=$all own=$own workflowState=$workflowState q=$q pageSize=$pageSize multiple=$multiple ot='poll'}
                </th>
                {/if}
                <th id="hDateOfStart" scope="col" class="z-left">
                    {sortlink __linktext='Date of start' currentsort=$sort modname='MUPolls' type=$lct func='view' sort='dateOfStart' sortdir=$sdir all=$all own=$own workflowState=$workflowState q=$q pageSize=$pageSize multiple=$multiple ot='poll'}
                </th>
                <th id="hDateOfEnd" scope="col" class="z-left">
                    {sortlink __linktext='Date of end' currentsort=$sort modname='MUPolls' type=$lct func='view' sort='dateOfEnd' sortdir=$sdir all=$all own=$own workflowState=$workflowState q=$q pageSize=$pageSize multiple=$multiple ot='poll'}
                </th>
                <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
            </tr>
            </thead>
            <tbody>
        {if $lct eq 'user'}
            <tr><td colspan="4">{gt text='Open polls'}</td></tr>
        {/if}
        {foreach item='poll' from=$items}
            <tr class="{cycle values='z-odd, z-even'}">
                {if $lct eq 'admin'}
                    <td headers="hSelect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$poll.id}" class="polls-checkbox" />
                    </td>
                {/if}
                <td headers="hTitle" class="z-left">
                    <a href="{modurl modname='MUPolls' type=$lct func='display' ot='poll'  id=$poll.id}" title="{gt text='View detail page'}">{$poll.title|notifyfilters:'mupolls.filterhook.polls'}</a>
                </td>
                {if $lct eq 'admin'}
                <td headers="hDescription" class="z-left">
                    {$poll.description}
                </td>
                <td headers="hMultiple" class="z-center">
                    {$poll.multiple|yesno:true}
                </td>
                {/if}
                <td headers="hDateOfStart" class="z-left">
                    {$poll.dateOfStart|dateformat:'datetimebrief'}
                </td>
                <td headers="hDateOfEnd" class="z-left">
                    {$poll.dateOfEnd|dateformat:'datetimebrief'}
                </td>
                <td id="itemActions{$poll.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                    {if count($poll._actions) gt 0}
                        {icon id="itemActions`$poll.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                        {foreach item='option' from=$poll._actions}
                            <a href="{$option.url.type|mupollsActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                        {/foreach}
                        <script type="text/javascript">
                        /* <![CDATA[ */
                            document.observe('dom:loaded', function() {
                                mUMUPollsInitItemActions('poll', 'view', 'itemActions{{$poll.id}}');
                            });
                        /* ]]> */
                        </script>
                    {/if}
                </td>
            </tr>
        {foreachelse}
            <tr class="z-{if $lct eq 'admin'}admin{else}data{/if}tableempty">
                <td class="z-left" colspan="{if $lct eq 'admin'}5{else}4{/if}">
            {gt text='No polls found.'}
              </td>
            </tr>
        {/foreach}
        {if $lct eq 'user'}
        <tr><td colspan="4">{gt text='Coming polls'}</td></tr>
        {foreach item='comingpoll' from=$comingItems}
            <tr class="{cycle values='z-odd, z-even'}">
                {if $lct eq 'admin'}
                    <td headers="hSelect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$comingpoll.id}" class="polls-checkbox" />
                    </td>
                {/if}
                <td headers="hTitle" class="z-left">
                    {$comingpoll.title|notifyfilters:'mupolls.filterhook.polls'}
                </td>
                {if $lct eq 'admin'}
                <td headers="hDescription" class="z-left">
                    {$comingpoll.description}
                </td>
                <td headers="hMultiple" class="z-center">
                    {$comingpoll.multiple|yesno:true}
                </td>
                {/if}
                <td headers="hDateOfStart" class="z-left">
                    {$comingpoll.dateOfStart|dateformat:'datetimebrief'}
                </td>
                <td headers="hDateOfEnd" class="z-left">
                    {$comingpoll.dateOfEnd|dateformat:'datetimebrief'}
                </td>
                <td id="itemActions{$comingpoll.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                    {*if count($comingpoll._actions) gt 0}
                        {icon id="itemActions`$comingpoll.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                        {foreach item='option' from=$comingpoll._actions}
                            <a href="{$option.url.type|mupollsActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                        {/foreach}
                        <script type="text/javascript">
                        /* <![CDATA[ */
                            document.observe('dom:loaded', function() {
                                mUMUPollsInitItemActions('poll', 'view', 'itemActions{{$comingpoll.id}}');
                            });
                        /* ]]> */
                        </script>
                    {/if*}
                </td>
            </tr>
        {foreachelse}
            <tr class="z-{if $lct eq 'admin'}admin{else}data{/if}tableempty">
                <td class="z-left" colspan="{if $lct eq 'admin'}5{else}4{/if}">
            {gt text='No polls found.'}
              </td>
            </tr>
        {/foreach}
        
        <tr><td colspan="4">{gt text='Closed polls'}</td></tr>
        {foreach item='poll' from=$terminatedItems}
            <tr class="{cycle values='z-odd, z-even'}">
                {if $lct eq 'admin'}
                    <td headers="hSelect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$poll.id}" class="polls-checkbox" />
                    </td>
                {/if}
                <td headers="hTitle" class="z-left">
                    <a href="{modurl modname='MUPolls' type=$lct func='display' ot='poll'  id=$poll.id}" title="{gt text='View detail page'}">{$poll.title|notifyfilters:'mupolls.filterhook.polls'}</a>
                </td>
                {if $lct eq 'admin'}
                <td headers="hDescription" class="z-left">
                    {$poll.description}
                </td>
                <td headers="hMultiple" class="z-center">
                    {$poll.multiple|yesno:true}
                </td>
                {/if}
                <td headers="hDateOfStart" class="z-left">
                    {$poll.dateOfStart|dateformat:'datetimebrief'}
                </td>
                <td headers="hDateOfEnd" class="z-left">
                    {$poll.dateOfEnd|dateformat:'datetimebrief'}
                </td>
                <td id="itemActions{$poll.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                    {if count($poll._actions) gt 0}
                        {icon id="itemActions`$poll.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                        {foreach item='option' from=$poll._actions}
                            <a href="{$option.url.type|mupollsActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                        {/foreach}
                        <script type="text/javascript">
                        /* <![CDATA[ */
                            document.observe('dom:loaded', function() {
                                mUMUPollsInitItemActions('poll', 'view', 'itemActions{{$poll.id}}');
                            });
                        /* ]]> */
                        </script>
                    {/if}
                </td>
            </tr>
        {foreachelse}
            <tr class="z-{if $lct eq 'admin'}admin{else}data{/if}tableempty">
                <td class="z-left" colspan="{if $lct eq 'admin'}5{else}4{/if}">
            {gt text='No polls found.'}
              </td>
            </tr>
        {/foreach}
        {/if}
        
            </tbody>
        </table>
        
        {if !isset($showAllEntries) || $showAllEntries ne 1}
            {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='MUPolls' type=$lct func='view' ot='poll'}
        {/if}
    {if $lct eq 'admin'}
            <fieldset>
                <label for="mUPollsAction">{gt text='With selected polls'}</label>
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
        {notifydisplayhooks eventname='mupolls.ui_hooks.polls.display_view' urlobject=$currentUrlObject assign='hooks'}
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
            if ($('togglePolls') != undefined) {
                $('togglePolls').observe('click', function (e) {
                    Zikula.toggleInput('pollsViewForm');
                    e.stop();
                });
            }
        {{/if}}
    });
/* ]]> */
</script>
