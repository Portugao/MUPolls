{* Purpose of this template: Display polls in text mailings *}
{foreach item='poll' from=$items}
{$poll->getTitleFromDisplayPattern()}
{modurl modname='MUPolls' type='user' func='display' ot='poll' id=$poll.id fqurl=true}
-----
{foreachelse}
{gt text='No polls found.'}
{/foreach}
