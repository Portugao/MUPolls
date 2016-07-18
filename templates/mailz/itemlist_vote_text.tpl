{* Purpose of this template: Display votes in text mailings *}
{foreach item='vote' from=$items}
{$vote->getTitleFromDisplayPattern()}
{modurl modname='MUPolls' type='user' func='display' ot='vote' id=$vote.id fqurl=true}
-----
{foreachelse}
{gt text='No votes found.'}
{/foreach}
