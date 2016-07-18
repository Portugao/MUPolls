{* purpose of this template: votes view xml view *}
{mupollsTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<votes>
{foreach item='vote' from=$items}
    {include file='vote/include.xml.tpl'}
{foreachelse}
    <noVote />
{/foreach}
</votes>
