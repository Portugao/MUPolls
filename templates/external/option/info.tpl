{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="option{$option.id}">
<dt>{$option->getTitleFromDisplayPattern()|notifyfilters:'mupolls.filter_hooks.options.filter'}</dt>
{% if option.title is not empty %}<dd>{{ option.title }}</dd>{% endif %}
</dl>
