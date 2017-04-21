{* Purpose of this template: edit view of generic item list content type *}
<div class="form-group">
    {gt text='Object type' domain='mupollsmodule' assign='objectTypeSelectorLabel'}
    {formlabel for='mUPollsModuleObjectType' text=$objectTypeSelectorLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {mupollsmoduleObjectTypeSelector assign='allObjectTypes'}
        {formdropdownlist id='mUPollsModuleObjectType' dataField='objectType' group='data' mandatory=true items=$allObjectTypes cssClass='form-control'}
        <span class="help-block">{gt text='If you change this please save the element once to reload the parameters below.' domain='mupollsmodule'}</span>
    </div>
</div>

<div class="form-group">
    {gt text='Sorting' domain='mupollsmodule' assign='sortingLabel'}
    {formlabel text=$sortingLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {formradiobutton id='mUPollsModuleSortRandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='mupollsmodule' assign='sortingRandomLabel'}
        {formlabel for='mUPollsModuleSortRandom' text=$sortingRandomLabel}
        {formradiobutton id='mUPollsModuleSortNewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='mupollsmodule' assign='sortingNewestLabel'}
        {formlabel for='mUPollsModuleSortNewest' text=$sortingNewestLabel}
        {formradiobutton id='mUPollsModuleSortDefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='mupollsmodule' assign='sortingDefaultLabel'}
        {formlabel for='mUPollsModuleSortDefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="form-group">
    {gt text='Amount' domain='mupollsmodule' assign='amountLabel'}
    {formlabel for='mUPollsModuleAmount' text=$amountLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {formintinput id='mUPollsModuleAmount' dataField='amount' group='data' mandatory=true maxLength=2 cssClass='form-control'}
    </div>
</div>

<div class="form-group">
    {gt text='Template' domain='mupollsmodule' assign='templateLabel'}
    {formlabel for='mUPollsModuleTemplate' text=$templateLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {mupollsmoduleTemplateSelector assign='allTemplates'}
        {formdropdownlist id='mUPollsModuleTemplate' dataField='template' group='data' mandatory=true items=$allTemplates cssClass='form-control'}
    </div>
</div>

<div id="customTemplateArea" class="form-group"{* data-switch="mUPollsModuleTemplate" data-switch-value="custom"*}>
    {gt text='Custom template' domain='mupollsmodule' assign='customTemplateLabel'}
    {formlabel for='mUPollsModuleCustomTemplate' text=$customTemplateLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {formtextinput id='mUPollsModuleCustomTemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80 cssClass='form-control'}
        <span class="help-block">{gt text='Example' domain='mupollsmodule'}: <em>itemlist_[objectType]_display.html.twig</em></span>
    </div>
</div>

<div class="form-group">
    {gt text='Filter (expert option)' domain='mupollsmodule' assign='filterLabel'}
    {formlabel for='mUPollsModuleFilter' text=$filterLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {formtextinput id='mUPollsModuleFilter' dataField='filter' group='data' mandatory=false maxLength=255 cssClass='form-control'}
        {*<span class="help-block">
            <a class="fa fa-filter" data-toggle="modal" data-target="#filterSyntaxModal">{gt text='Show syntax examples' domain='mupollsmodule'}</a>
        </span>*}
    </div>
</div>

{*include file='include_filterSyntaxDialog.tpl'*}

<script type="text/javascript">
    (function($) {
    	$('#mUPollsModuleTemplate').change(function() {
    	    $('#customTemplateArea').toggleClass('hidden', $(this).val() != 'custom');
	    }).trigger('change');
    })(jQuery)
</script>
