<div class="block">
{*<label>{"Filename:"|i18n("design/standard/content/datatype")}</label><div class="labelbreak"></div>*}
<input type="hidden" name="MAX_FILE_SIZE" value="{$attribute.contentclass_attribute.data_int1}000000"/>
<input name="ContentObjectAttribute_data_binaryfilename_{$attribute.id}" type="file" />
</div>

{section show=$attribute.content}
<div class="block">
<div class="element">
<label>{"Filename:"|i18n("design/standard/content/datatype")}</label><div class="labelbreak"></div>
<p class="box">	{$attribute.content.original_filename|wash(xhtml)}</p>
</div>
<div class="element">
<label>{"MIME Type:"|i18n("design/standard/content/datatype")}</label><div class="labelbreak"></div>
<p class="box">{$attribute.content.mime_type|wash(xhtml)}</p>
</div>
<div class="element">
<label>{"Filesize:"|i18n("design/standard/content/datatype")}</label><div class="labelbreak"></div>
<p class="box">{$attribute.content.filesize|si(byte)}</p>
</div>
<div class="element">
<input class="smallbutton" type="submit" name="CustomActionButton[{$attribute.id}_delete_binary]" value="{'Remove'|i18n('design/standard/content/datatype')}" />
</div>
<div class="break"></div>
</div>
{/section}
