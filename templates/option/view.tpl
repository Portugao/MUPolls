{* purpose of this template: options list view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="mupolls-option mupolls-view">
    {gt text='Option list' assign='templateTitle'}
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
        {checkpermissionblock component='MUPolls:Option:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create option' assign='createTitle'}
            <a href="{modurl modname='MUPolls' type=$lct func='edit' ot='option'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUPolls' type=$lct func='view' ot='option'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUPolls' type=$lct func='view' ot='option' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='option/viewQuickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    {if $lct eq 'admin'}
    <form action="{modurl modname='MUPolls' type='option' func='handleSelectedEntries' lct=$lct}" method="post" id="optionsViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
    {/if}
        <table class="z-datatable">
            <colgroup>
                {if $lct eq 'admin'}
                    <col id="cSelect" />
                {/if}
                <col id="cTitle" />
                <col id="cColorOfOption" />
                <col id="cIdOfPoll" />
                <col id="cItemActions" />
            </colgroup>
            <thead>
            <tr>
                {if $lct eq 'admin'}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleOptions" />
                    </th>
                {/if}
                <th id="hTitle" scope="col" class="z-left">
                    {sortlink __linktext='Title' currentsort=$sort modname='MUPolls' type=$lct func='view' sort='title' sortdir=$sdir all=$all own=$own workflowState=$workflowState q=$q pageSize=$pageSize ot='option'}
                </th>
                <th id="hColorOfOption" scope="col" class="z-left">
                    {sortlink __linktext='Color of option' currentsort=$sort modname='MUPolls' type=$lct func='view' sort='colorOfOption' sortdir=$sdir all=$all own=$own workflowState=$workflowState q=$q pageSize=$pageSize ot='option'}
                </th>
                <th id="hIdOfPoll" scope="col" class="z-right">
                    {sortlink __linktext='Id of poll' currentsort=$sort modname='MUPolls' type=$lct func='view' sort='idOfPoll' sortdir=$sdir all=$all own=$own workflowState=$workflowState q=$q pageSize=$pageSize ot='option'}
                </th>
                <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
            </tr>
            </thead>
            <tbody>
        
        {foreach item='option' from=$items}
            <tr class="{cycle values='z-odd, z-even'}">
                {if $lct eq 'admin'}
                    <td headers="hSelect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$option.id}" class="options-checkbox" />
                    </td>
                {/if}
                <td headers="hTitle" class="z-left">
                    <a href="{modurl modname='MUPolls' type=$lct func='display' ot='option'  id=$option.id}" title="{gt text='View detail page'}">{$option.title|notifyfilters:'mupolls.filterhook.options'}</a>
                </td>
                <td headers="hColorOfOption" class="z-left">
                    {$option.colorOfOption}
                </td>
                <td headers="hIdOfPoll" class="z-right">
                    {$option.idOfPoll}
                </td>
                <td id="itemActions{$option.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                    {if count($option._actions) gt 0}
                        {icon id="itemActions`$option.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                        {foreach item='option' from=$option._actions}
                            <a href="{$option.url.type|mupollsActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                        {/foreach}
                        <script type="text/javascript">
                        /* <![CDATA[ */
                            document.observe('dom:loaded', function() {
                                mUMUPollsInitItemActions('option', 'view', 'itemActions{{$option.id}}');
                            });
                        /* ]]> */
                        </script>
                    {/if}
                </td>
            </tr>
        {foreachelse}
            <tr class="z-{if $lct eq 'admin'}admin{else}data{/if}tableempty">
                <td class="z-left" colspan="{if $lct eq 'admin'}5{else}4{/if}">
            {gt text='No options found.'}
              </td>
            </tr>
        {/foreach}
        
            </tbody>
        </table>
        
        {if !isset($showAllEntries) || $showAllEntries ne 1}
            {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='MUPolls' type=$lct func='view' ot='option'}
        {/if}
    {if $lct eq 'admin'}
            <fieldset>
                <label for="mUPollsAction">{gt text='With selected options'}</label>
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
        {notifydisplayhooks eventname='mupolls.ui_hooks.options.display_view' urlobject=$currentUrlObject assign='hooks'}
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
            if ($('toggleOptions') != undefined) {
                $('toggleOptions').observe('click', function (e) {
                    Zikula.toggleInput('optionsViewForm');
                    e.stop();
                });
            }
        {{/if}}
    });
/* ]]> */
</script>
