{* purpose of this template: polls view json view *}
{mupollsTemplateHeaders contentType='application/json'}[
{foreach item='poll' from=$items name='polls'}
    {if not $smarty.foreach.polls.first},{/if}
    {$poll->toJson()}
{/foreach}
]
