{* Purpose of this template: Display items within a block (fallback template) *}

<h4>{$item.title}</h4>
{if $item.description ne ''}
{$item.description}{/if}<br />

{if $item.dateOfEnd|dateformat:'%Y-%m-%d %H:%M:%S' >= $smarty.now|date_format:"%Y-%m-%d %H:%M:%S"}
	{if $voted eq '0' || !$voted}
	    <form action="{modurl modname='MUPolls' type='vote' func='edit'}" method="post">
        {foreach item='option' from=$options}
        <label>
        <input type="radio" name="option" value="{$option.id}" id="option">
        <span style="color: {$option.colorOfOption}">{$option.title}</span>
        </label><br>
        {/foreach}<br />
            <input type="hidden" name="poll" value={$item.id}>
            <input type="hidden" name="currentUrl" value="{$currentUrl}">
            {if is_array($options)}
                <input class="btn btn-success" type="submit" value="{gt text="Vote}">
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
    <br />{mupollsVoteCalculator pollId=$item.id assign='out'}
    {$out} 
{/if}
