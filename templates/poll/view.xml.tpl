{* purpose of this template: polls view xml view *}
{mupollsTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<polls>
{foreach item='poll' from=$items}
    {include file='poll/include.xml.tpl'}
{foreachelse}
    <noPoll />
{/foreach}
</polls>
