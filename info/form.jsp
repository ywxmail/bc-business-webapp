<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:property value="typeDesc"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/info/save" />'
	data-js='js:bc_identity,js:redactor_css,js:redactor,js:redactor_cn,js:redactor_plugins_fullscreen,<s:url value="/bc-business/info/form.js" />'
	data-initMethod='bs.infoForm.init'
	data-option='<s:property value="formPageOption"/>' style="overflow-y:auto;">
	<s:form name="infoForm" theme="simple">
		<table class="formTable2 ui-widget-content" cellspacing="2" cellpadding="0" style="width:650px;">
			<tr class="widthMarker">
				<td >&nbsp;</td>
				<td style="width: 200px;">&nbsp;</td>
				<td style="width: 80px;">&nbsp;</td>
				<td style="width: 200px;">&nbsp;</td>
			</tr>
			<tr>
				<td class="label">*<s:text name="info.subject"/>:</td>
				<td class="value" colspan="3"><s:textfield name="e.subject" data-validate="required" cssClass="ui-widget-content"/></td>
			</tr>
			<tr>
				<td class="label">*<s:text name="info.sendDate"/>:</td>
				<td class="value relative">
					<input type="text" name="e.sendDate" data-validate='{"type":"date","required":true}'
					value='<s:date format="yyyy-MM-dd" name="e.sendDate" />'
					class="bc-date ui-widget-content" data-cfg='{changeYear:false}' />
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
					</ul>
				</td>
				<td class="label"><s:text name="info.endDate"/>:</td>
				<td class="value relative">
					<input type="text" name="e.endDate" data-validate='{"type":"date","required":false}'
					value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
					class="bc-date ui-widget-content" data-cfg='{changeYear:false}' />
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
					</ul>
				</td>
			</tr>
			<tr>
				<td class="label">*<s:text name="info.code"/>:</td>
				<td class="value"><s:textfield name="e.code" data-validate="required" cssClass="ui-widget-content"/></td>
				<td class="label">*<s:text name="info.source"/>:</td>
				<td class="value relative">
					<s:textfield name="e.source" data-validate="required" cssClass="ui-widget-content"/>
					<ul class="inputIcons">
						<li class="inputIcon ui-icon ui-icon-home selectDepartment" title="点击选择部门" data-cfg='e.source=name'></li>
					</ul>
				</td>
			</tr>
			<tr>
				<td class="label"><s:text name="info.scope"/>:</td>
				<td class="value" colspan="3" style="position: relative;">
					<s:textfield id="scope" cssClass="ui-widget-content"/>
					<ul class="inputIcons">
						<li class="inputIcon ui-icon ui-icon-person" title="点击添加用户" id="addUsers"></li>
						<li class="inputIcon ui-icon ui-icon-contact" title="点击添加岗位" id="addGroups"></li>
						<li class="inputIcon ui-icon ui-icon-home" title="点击添加单位或部门" id="addUnitOrDepartments"></li>
					</ul>
				</td>
			</tr>
			<tr>
				<td class="label" colspan="4">
					<div class="formTopInfo">
						状态：<s:property value="%{statuses[e.status]}" />，登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" 
							format="yyyy-MM-dd HH:mm"/>)<s:if test="%{e.modifier != null}">，最后修改：<s:property value="e.modifier.name" />(<s:date 
							name="e.modifiedDate" format="yyyy-MM-dd HH:mm"/>)
						</s:if>
					</div>
				</td>
			</tr>
		</table>
		<div class="formEditor" style="min-width:650px;font-weight: normal;overflow: hidden;">
			<textarea name="e.content" class="bc-redactor"
				 data-ptype="companyFile.editor" data-puid='${e.uid}' 
				 style="height:150px;"
				 data-readonly='${readonly}' data-tools='simple'>${e.content}</textarea>
		</div>
		<s:property value="attachsUI" escapeHtml="false"/>
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.status" />
		<s:hidden name="e.type" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		<s:hidden name="e.modifier.id" />
		<input type="hidden" name="e.modifiedDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.modifiedDate" />'/>
	</s:form>
</div>