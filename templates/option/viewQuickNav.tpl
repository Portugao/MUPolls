{* purpose of this template: options view filter form *}
{checkpermissionblock component='MUPolls:Option:' instance='::' level='ACCESS_EDIT'}
{assign var='objectType' value='option'}
<form action="{$modvars.ZConfig.entrypoint|default:'index.php'}" method="get" id="mUPollsOptionQuickNavForm" class="mupolls-quicknav">
    <fieldset>
        <h3>{gt text='Quick navigation'}</h3>
        <input type="hidden" name="module" value="{modgetinfo modname='MUPolls' info='url'}" />
        <input type="hidden" name="type" value="{$lct}" />
        <input type="hidden" name="func" value="view" />
        <input type="hidden" name="ot" value="option" />
        <input type="hidden" name="all" value="{$all|default:0}" />
        <input type="hidden" name="own" value="{$own|default:0}" />
        {gt text='All' assign='lblDefault'}
        {if !isset($workflowStateFilter) || $workflowStateFilter eq true}
            <label for="workflowState">{gt text='Workflow state'}</label>
            <select id="workflowState" name="workflowState">
                <option value="">{$lblDefault}</option>
            {foreach item='option' from=$workflowStateItems}
            <option value="{$option.value}"{if $option.title ne ''} title="{$option.title|safetext}"{/if}{if $option.value eq $workflowState} selected="selected"{/if}>{$option.text|safetext}</option>
            {/foreach}
            </select>
        {/if}
        {if !isset($searchFilter) || $searchFilter eq true}
            <label for="searchTerm">{gt text='Search'}</label>
            <input type="text" id="searchTerm" name="q" value="{$q}" />
        {/if}
        {if !isset($sorting) || $sorting eq true}
            <label for="sortBy">{gt text='Sort by'}</label>
            &nbsp;
            <select id="sortBy" name="sort">
                <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
                <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
                <option value="colorOfOption"{if $sort eq 'colorOfOption'} selected="selected"{/if}>{gt text='Color of option'}</option>
                <option value="idOfPoll"{if $sort eq 'idOfPoll'} selected="selected"{/if}>{gt text='Id of poll'}</option>
                <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
                <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
            </select>
            <select id="sortDir" name="sortdir">
                <option value="asc"{if $sdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                <option value="desc"{if $sdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
            </select>
        {else}
            <input type="hidden" name="sort" value="{$sort}" />
            <input type="hidden" name="sdir" value="{if $sdir eq 'desc'}asc{else}desc{/if}" />
        {/if}
        {if !isset($pageSizeSelector) || $pageSizeSelector eq true}
            <label for="num">{gt text='Page size'}</label>
            <select id="num" name="num">
                <option value="5"{if $pageSize eq 5} selected="selected"{/if}>5</option>
                <option value="10"{if $pageSize eq 10} selected="selected"{/if}>10</option>
                <option value="15"{if $pageSize eq 15} selected="selected"{/if}>15</option>
                <option value="20"{if $pageSize eq 20} selected="selected"{/if}>20</option>
                <option value="30"{if $pageSize eq 30} selected="selected"{/if}>30</option>
                <option value="50"{if $pageSize eq 50} selected="selected"{/if}>50</option>
                <option value="100"{if $pageSize eq 100} selected="selected"{/if}>100</option>
            </select>
        {/if}
        <input type="submit" name="updateview" id="mupolls_optionquicknav_updateview" value="{gt text='OK'}" />
    </fieldset>
</form>
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        mUMUPollsInitQuickNavigation('option');
        {{if isset($searchFilter) && $searchFilter eq false}}
            {{* we can hide the submit button if we have no quick search field *}}
            $('mupolls_optionquicknav_updateview').addClassName('z-hide');
        {{/if}}
    });
/* ]]> */
</script>
{/checkpermissionblock}
