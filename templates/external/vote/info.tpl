{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="vote{$vote.id}">
<dt>{$vote->getTitleFromDisplayPattern()|notifyfilters:'mupolls.filter_hooks.votes.filter'}</dt>
</dl>
