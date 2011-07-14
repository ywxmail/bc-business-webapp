<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="motorcade.title"/>' data-type='form' class="bc-page"
    data-js='<s:url value=" /bc-business/motorcade/form.js" />'
	data-saveUrl='<s:url value="/bc-business/motorcade/save" />'
	data-option='{
		"buttons":[{"text":"<s:text name="motorcade.historicalInformation"/>","click":"bc.business.motorcade.check"},
		{"text":"<s:text name="label.save"/>","action":"save"}],
		"width":618,"minWidth":250,"minHeight":250,"modal":false}' style="overflow-y:auto;">
	<s:form name="motrcadeForm" theme="simple">
	    <div class="formTopInfo">
			<s:property value="e.authorName" />(<s:property value="e.departName" />) 创建于  <s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>
		</div>
		<div class="formFields ui-widget-content">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label">* <s:text name="label.code"/>:</td>
						<td class="value w200"><s:textfield name="e.code" data-validate="required"/></td>
						<td class="label"><s:text name="motorcade.payment_date"/>:</td>
						<td class="value"><input type="text" name="e.payment_date" data-validate="required" 
						class="bc-date" title='<s:text name="title.click2selectDate"/>'
						value='<s:date format="yyyy-MM-dd" name="e.payment_date" />'/></td>
					</tr>
					<tr>
						<td class="label">* <s:text name="motorcade.name"/>:</td>
						<td class="value"><s:textfield name="e.name" data-validate="required"/></td>
						<td class="label" ><s:text name="motorcade.principal"/>:</td>
						<td class="value" ><s:textfield name="e.principal"  id="addUsers" data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label">* <s:text name="motorcade.fullName"/>:</td>
						<td class="value"><s:textfield name="e.fullName" data-validate='required'/></td>
						<td class="label"><s:text name="label.phone"/>:</td>
						<td class="value"><s:textfield name="e.phone" data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label">* <s:text name="motorcade.company"/>:</td>
						<td class="value"><s:textfield name="e.company" data-validate='required'/></td>
						<td class="label"><s:text name="motorcade.fax"/>:</td>
						<td class="value"><s:textfield name="e.fax" data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label">* <s:text name="motorcade.colour"/>:</td>
						<td class="value"><s:textfield name="e.colour" data-validate='required'/></td>
						<td class="label"><s:text name="motorcade.address"/>:</td>
						<td class="value"><s:textfield name="e.address" data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label">* <s:text name="label.status"/>:</td>
						<td class="value"><s:radio name="e.status" list="#{'1':'启用中','2':'已删除','0':'已禁用'}" 
						value="e.status" cssStyle="width:auto;"/></td>
						<td class="label"><s:text name="motorcade.lastupdated_date"/>:</td>
						<td class="value"><s:property value="e. modifiedDate" /><s:text name="motorcade.changeName"/>:
						<s:property value="e.modifierName" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="motorcade.description"/>:</td>
						<td class="value" colspan="3"><s:textarea name="e.description" data-validate='required'/></td>
					</tr>
				</tbody>
			</table>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.author.name" />
		<s:hidden name="e.departId" />
		<s:hidden name="e.departName" />
		<s:hidden name="e.unitId" />
		<s:hidden name="e.unitName" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>