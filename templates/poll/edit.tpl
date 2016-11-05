{* purpose of this template: build the form to edit an instance of poll *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
{pageaddvar name='javascript' value='modules/MUPolls/javascript/MUPolls_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MUPolls/javascript/MUPolls_validation.js'}

{if $mode ne 'create'}
    {gt text='Edit poll' assign='templateTitle'}
    {if $lct eq 'admin'}
        {assign var='adminPageIcon' value='edit'}
    {/if}
{elseif $mode eq 'create'}
    {gt text='Create poll' assign='templateTitle'}
    {if $lct eq 'admin'}
        {assign var='adminPageIcon' value='new'}
    {/if}
{/if}
<div class="mupolls-poll mupolls-edit">
    {pagesetvar name='title' value=$templateTitle}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type=$adminPageIcon size='small' alt=$templateTitle}
            <h3>{$templateTitle}</h3>
        </div>
    {else}
        <h2>{$templateTitle}</h2>
    {/if}
{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {mupollsFormFrame}
        {formsetinitialfocus inputId='title'}

    {formvolatile}
        {assign var='useOnlyCurrentLanguage' value=true}
        {if $modvars.ZConfig.multilingual}
            {if is_array($supportedLanguages) && count($supportedLanguages) gt 1}
                {assign var='useOnlyCurrentLanguage' value=false}
                {nocache}
                {lang assign='currentLanguage'}
                {foreach item='language' from=$supportedLanguages}
                    {if $language eq $currentLanguage}
                        <fieldset>
                            <legend>{$language|getlanguagename|safehtml}</legend>
                            
                            <div class="z-formrow">
                                {formlabel for='title' __text='Title' mandatorysym='1' cssClass=''}
                                {formtextinput group='poll' id='title' mandatory=true readOnly=false __title='Enter the title of the poll' textMode='singleline' maxLength=255 cssClass='required'}
                                {mupollsValidationError id='title' class='required'}
                            </div>
                            
                            <div class="z-formrow">
                                {formlabel for='description' __text='Description' cssClass=''}
                                {formtextinput group='poll' id='description' mandatory=false __title='Enter the description of the poll' textMode='multiline' rows='6' cols='50' cssClass=''}
                            </div>
                        </fieldset>
                    {/if}
                {/foreach}
                {foreach item='language' from=$supportedLanguages}
                    {if $language ne $currentLanguage}
                        <fieldset>
                            <legend>{$language|getlanguagename|safehtml}</legend>
                            
                            <div class="z-formrow">
                                {formlabel for="title`$language`" __text='Title' mandatorysym='1' cssClass=''}
                                {formtextinput group="poll`$language`" id="title`$language`" mandatory=true readOnly=false __title='Enter the title of the poll' textMode='singleline' maxLength=255 cssClass='required'}
                                {mupollsValidationError id="title`$language`" class='required'}
                            </div>
                            
                            <div class="z-formrow">
                                {formlabel for="description`$language`" __text='Description' cssClass=''}
                                {formtextinput group="poll`$language`" id="description`$language`" mandatory=false __title='Enter the description of the poll' textMode='multiline' rows='6' cols='50' cssClass=''}
                            </div>
                        </fieldset>
                    {/if}
                {/foreach}
                {/nocache}
            {/if}
        {/if}
        {if $useOnlyCurrentLanguage eq true}
            {lang assign='language'}
            <fieldset>
                <legend>{$language|getlanguagename|safehtml}</legend>
                
                <div class="z-formrow">
                    {formlabel for='title' __text='Title' mandatorysym='1' cssClass=''}
                    {formtextinput group='poll' id='title' mandatory=true readOnly=false __title='Enter the title of the poll' textMode='singleline' maxLength=255 cssClass='required'}
                    {mupollsValidationError id='title' class='required'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='description' __text='Description' cssClass=''}
                    {formtextinput group='poll' id='description' mandatory=false __title='Enter the description of the poll' textMode='multiline' rows='6' cols='50' cssClass=''}
                </div>
            </fieldset>
        {/if}
    {/formvolatile}
    <fieldset>
        <legend>{gt text='Further properties'}</legend>
        
        <div class="z-formrow">
            {formlabel for='multiple' __text='Multiple' cssClass=''}
            {formcheckbox group='poll' id='multiple' readOnly=false __title='multiple ?' cssClass=''}
        </div>
        
        <div class="z-formrow">
            {formlabel for='dateOfStart' __text='Date of start' cssClass=''}
            {if $mode ne 'create'}
                {formdateinput group='poll' id='dateOfStart' mandatory=false __title='Enter the date of start of the poll' includeTime=true cssClass=' validate-daterange-poll'}
            {else}
                {formdateinput group='poll' id='dateOfStart' mandatory=false __title='Enter the date of start of the poll' includeTime=true cssClass=' validate-daterange-poll'}
            {/if}
            <span class="z-formnote z-sub"><a id="resetDateOfStartVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></span>
            {mupollsValidationError id='dateOfStart' class='validate-daterange-poll'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='dateOfEnd' __text='Date of end' cssClass=''}
            {if $mode ne 'create'}
                {formdateinput group='poll' id='dateOfEnd' mandatory=false __title='Enter the date of end of the poll' includeTime=true cssClass=' validate-daterange-poll'}
            {else}
                {formdateinput group='poll' id='dateOfEnd' mandatory=false __title='Enter the date of end of the poll' includeTime=true cssClass=' validate-daterange-poll'}
            {/if}
            <span class="z-formnote z-sub"><a id="resetDateOfEndVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></span>
            {mupollsValidationError id='dateOfEnd' class='validate-daterange-poll'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='inFrontend' __text='In frontend' cssClass=''}
            {formcheckbox group='poll' id='inFrontend' readOnly=false __title='in frontend ?' cssClass=''}
        </div>
    </fieldset>
    
    {if $mode ne 'create'}
        {include file='helper/includeStandardFieldsEdit.tpl' obj=$poll}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$poll.id}
        {notifydisplayhooks eventname='mupolls.ui_hooks.polls.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='mupolls.ui_hooks.polls.form_edit' id=null assign='hooks'}
    {/if}
    {if is_array($hooks) && count($hooks)}
        {foreach name='hookLoop' key='providerArea' item='hook' from=$hooks}
            {if $providerArea ne 'provider.scribite.ui_hooks.editor'}{* fix for #664 *}
                <fieldset>
                    {$hook}
                </fieldset>
            {/if}
        {/foreach}
    {/if}
    
    
    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatCreation' __text='Create another item after save'}
                {formcheckbox group='poll' id='repeatCreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
        {foreach item='action' from=$actions}
            {assign var='actionIdCapital' value=$action.id|@ucfirst}
            {gt text=$action.title assign='actionTitle'}
            {*gt text=$action.description assign='actionDescription'*}{* TODO: formbutton could support title attributes *}
            {if $action.id eq 'delete'}
                {gt text='Really delete this poll?' assign='deleteConfirmMsg'}
                {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass confirmMessage=$deleteConfirmMsg}
            {else}
                {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass}
            {/if}
        {/foreach}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel' formnovalidate='formnovalidate'}
    </div>
    {/mupollsFormFrame}
{/form}
</div>
{include file="`$lct`/footer.tpl"}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='removeImageArray'}


<script type="text/javascript">
/* <![CDATA[ */
    
    var formButtons, formValidator;
    
    function handleFormButton (event) {
        var result = formValidator.validate();
        if (!result) {
            // validation error, abort form submit
            Event.stop(event);
        } else {
            // hide form buttons to prevent double submits by accident
            formButtons.each(function (btn) {
                btn.addClassName('z-hide');
            });
        }
    
        return result;
    }
    
    document.observe('dom:loaded', function() {
    
        mUMUPollsAddCommonValidationRules('poll', '{{if $mode ne 'create'}}{{$poll.id}}{{/if}}');
        {{* observe validation on button events instead of form submit to exclude the cancel command *}}
        formValidator = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = formValidator.validate();
        {{/if}}
    
        formButtons = $('{{$__formid}}').select('div.z-formbuttons input');
    
        formButtons.each(function (elem) {
            if (elem.id != 'btnCancel') {
                elem.observe('click', handleFormButton);
            }
        });
    
        Zikula.UI.Tooltips($$('.mupolls-form-tooltips'));
        mUMUPollsInitDateField('dateOfStart');
        mUMUPollsInitDateField('dateOfEnd');
    });
/* ]]> */
</script>
