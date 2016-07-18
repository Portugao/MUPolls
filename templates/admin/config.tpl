{* purpose of this template: module configuration page *}
{include file='admin/header.tpl'}
<div class="mupolls-config">
    {gt text='Settings' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='config' size='small' __alt='Settings'}
        <h3>{$templateTitle}</h3>
    </div>

    {form cssClass='z-form'}
        {* add validation summary and a <div> element for styling the form *}
        {mupollsFormFrame}
            {formsetinitialfocus inputId='kindOfVoting'}
            {gt text='My settings' assign='tabTitle'}
            <fieldset>
                <legend>{$tabTitle}</legend>
            
                <p class="z-confirmationmsg">{gt text='Here you can manage all basic settings for this application.'}</p>
            
                <div class="z-formrow">
                    {formlabel for='kindOfVoting' __text='Kind of voting' cssClass=''}
                    {formdropdownlist id='kindOfVoting' group='config' __title='Choose the kind of voting'}
                </div>
            </fieldset>

            <div class="z-buttons z-formbuttons">
                {formbutton commandName='save' __text='Update configuration' class='z-bt-save'}
                {formbutton commandName='cancel' __text='Cancel' class='z-bt-cancel'}
            </div>
        {/mupollsFormFrame}
    {/form}
</div>
{include file='admin/footer.tpl'}
