{* Purpose of this template: Display options in text mailings *}
{foreach item='option' from=$items}
{$option->getTitleFromDisplayPattern()}
{modurl modname='MUPolls' type='user' func='display' ot='option' id=$option.id fqurl=true}
-----
{foreachelse}
{gt text='No options found.'}
{/foreach}
