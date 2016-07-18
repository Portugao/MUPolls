{* purpose of this template: polls delete confirmation view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="mupolls-poll mupolls-delete">
    {gt text='Delete poll' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='delete' size='small' __alt='Delete'}
            <h3>{$templateTitle}</h3>
        </div>
    {else}
        <h2>{$templateTitle}</h2>
    {/if}

    <p class="z-warningmsg">{gt text='Do you really want to delete this poll ?'}</p>

    <form class="z-form" action="{modurl modname='MUPolls' type=$lct func='delete' ot='poll'  id=$poll.id}" method="post">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" id="confirmation" name="confirmation" value="1" />
            <fieldset>
                <legend>{gt text='Confirmation prompt'}</legend>
                <div class="z-buttons z-formbuttons">
                    {gt text='Delete' assign='deleteTitle'}
                    {button src='14_layer_deletelayer.png' set='icons/small' text=$deleteTitle title=$deleteTitle class='z-btred'}
                    <a href="{modurl modname='MUPolls' type=$lct func='view' ot='poll'}">{icon type='cancel' size='small' __alt='Cancel' __title='Cancel'} {gt text='Cancel'}</a>
                </div>
            </fieldset>

            {notifydisplayhooks eventname='mupolls.ui_hooks.polls.form_delete' id="`$poll.id`" assign='hooks'}
            {foreach key='providerArea' item='hook' from=$hooks}
                <fieldset>
                    {*<legend>{$hookName}</legend>*}
                    {$hook}
                </fieldset>
            {/foreach}
        </div>
    </form>
</div>
{include file="`$lct`/footer.tpl"}
