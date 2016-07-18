{* purpose of this template: votes view json view *}
{mupollsTemplateHeaders contentType='application/json'}[
{foreach item='vote' from=$items name='votes'}
    {if not $smarty.foreach.votes.first},{/if}
    {$vote->toJson()}
{/foreach}
]
