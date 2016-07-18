{* Purpose of this template: edit view of generic item list content type *}
<div class="z-formrow">
    {gt text='Object type' domain='module_mupolls' assign='objectTypeSelectorLabel'}
    {formlabel for='mUPollsObjectType' text=$objectTypeSelectorLabel}
        {mupollsObjectTypeSelector assign='allObjectTypes'}
        {formdropdownlist id='mUPollsOjectType' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
        <span class="z-sub z-formnote">{gt text='If you change this please save the element once to reload the parameters below.' domain='module_mupolls'}</span>
</div>

{formvolatile}
{if $properties ne null && is_array($properties)}
    {nocache}
    {foreach key='registryId' item='registryCid' from=$registries}
        {assign var='propName' value=''}
        {foreach key='propertyName' item='propertyId' from=$properties}
            {if $propertyId eq $registryId}
                {assign var='propName' value=$propertyName}
            {/if}
        {/foreach}
        <div class="z-formrow">
            {modapifunc modname='MUPolls' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
            {gt text='Category' domain='module_mupolls' assign='categorySelectorLabel'}
            {assign var='selectionMode' value='single'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' domain='module_mupolls' assign='categorySelectorLabel'}
                {assign var='selectionMode' value='multiple'}
            {/if}
            {formlabel for="mUPollsCatIds`$propertyName`" text=$categorySelectorLabel}
                {formdropdownlist id="mUPollsCatIds`$propName`" items=$categories.$propName dataField="catids`$propName`" group='data' selectionMode=$selectionMode}
                <span class="z-sub z-formnote">{gt text='This is an optional filter.' domain='module_mupolls'}</span>
        </div>
    {/foreach}
    {/nocache}
{/if}
{/formvolatile}

<div class="z-formrow">
    {gt text='Sorting' domain='module_mupolls' assign='sortingLabel'}
    {formlabel text=$sortingLabel}
    <div>
        {formradiobutton id='mUPollsSortRandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='module_mupolls' assign='sortingRandomLabel'}
        {formlabel for='mUPollsSortRandom' text=$sortingRandomLabel}
        {formradiobutton id='mUPollsSortNewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='module_mupolls' assign='sortingNewestLabel'}
        {formlabel for='mUPollsSortNewest' text=$sortingNewestLabel}
        {formradiobutton id='mUPollsSortDefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='module_mupolls' assign='sortingDefaultLabel'}
        {formlabel for='mUPollsSortDefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="z-formrow">
    {gt text='Amount' domain='module_mupolls' assign='amountLabel'}
    {formlabel for='mUPollsAmount' text=$amountLabel}
        {formintinput id='mUPollsAmount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {gt text='Template' domain='module_mupolls' assign='templateLabel'}
    {formlabel for='mUPollsTemplate' text=$templateLabel}
        {mupollsTemplateSelector assign='allTemplates'}
        {formdropdownlist id='mUPollsTemplate' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div id="customTemplateArea" class="z-formrow z-hide">
    {gt text='Custom template' domain='module_mupolls' assign='customTemplateLabel'}
    {formlabel for='mUPollsCustomTemplate' text=$customTemplateLabel}
        {formtextinput id='mUPollsCustomTemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80}
        <span class="z-sub z-formnote">{gt text='Example' domain='module_mupolls'}: <em>itemlist_[objectType]_display.tpl</em></span>
</div>

<div class="z-formrow z-hide">
    {gt text='Filter (expert option)' domain='module_mupolls' assign='filterLabel'}
    {formlabel for='mUPollsFilter' text=$filterLabel}
        {formtextinput id='mUPollsFilter' dataField='filter' group='data' mandatory=false maxLength=255}
        <span class="z-sub z-formnote">
            ({gt text='Syntax examples' domain='module_mupolls'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)
        </span>
</div>

{pageaddvar name='javascript' value='prototype'}
<script type="text/javascript">
/* <![CDATA[ */
    function mUMUPollsToggleCustomTemplate() {
        if ($F('mUPollsTemplate') == 'custom') {
            $('customTemplateArea').removeClassName('z-hide');
        } else {
            $('customTemplateArea').addClassName('z-hide');
        }
    }

    document.observe('dom:loaded', function() {
        mUMUPollsToggleCustomTemplate();
        $('mUPollsTemplate').observe('change', function(e) {
            mUMUPollsToggleCustomTemplate();
        });
    });
/* ]]> */
</script>
