{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="poll{$poll.id}">
<dt>{$poll->getTitleFromDisplayPattern()|notifyfilters:'mupolls.filter_hooks.polls.filter'}</dt>
{% if poll.description is not empty %}<dd>{{ poll.description }}</dd>{% endif %}
</dl>
