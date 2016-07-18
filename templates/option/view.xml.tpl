{* purpose of this template: options view xml view *}
{mupollsTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<options>
{foreach item='option' from=$items}
    {include file='option/include.xml.tpl'}
{foreachelse}
    <noOption />
{/foreach}
</options>
