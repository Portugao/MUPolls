{* purpose of this template: options view json view *}
{mupollsTemplateHeaders contentType='application/json'}[
{foreach item='option' from=$items name='options'}
    {if not $smarty.foreach.options.first},{/if}
    {$option->toJson()}
{/foreach}
]
