<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="createMotorcade.title"/>-<s:property value="e.name" />' data-type='form' class="bc-page"
    data-js='<s:url value=" /bc-business/motorcade/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/charger/select.js" />'
    data-initMethod='bc.business.motorcadeForm.init'
	data-saveUrl='<s:url value="/bc-business/motorcade/save" />'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="motorcadeForm" theme="simple">
	    <div class="formTopInfo">
			<s:property value="e.authorName" />(<s:property value="e.authorDepartName" />) 创建于  <s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>
		</div>
		<div class="formFields ui-widget-content">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label">* <s:text name="label.code"/>:</td>
						<td class="value w200"><s:textfield name="e.code" data-validate="required"/></td>
						<td class="label">*<s:text name="motorcade.paymentDate"/>:</td>
						<td class="value"><input type="text" name="e.paymentDate"  data-validate="required"
						class="bc-date" title='<s:text name="title.click2selectDate"/>'
						value='<s:date format="yyyy-MM-dd" name="e.paymentDate" />'/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="motorcade.name"/>:</td>
						<td class="value"><s:textfield name="e.name" data-validate='required'/></td>
						<td class="label"><s:text name="motorcade.principal"/>:</td>
						<td class="value"><s:textfield name="e.principal"
						readonly="true" title='%{getText("motorcade.title.click2selectPrincipal")}'/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="motorcade.fullName"/>:</td>
						<td class="value"><s:textfield name="e.fullName" data-validate='required'/></td>
						<td class="label"><s:text name="label.phone"/>:</td>
						<td class="value"><s:textfield name="e.phone" data-validate='{required:false,type:"phone"}' /></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="motorcade.company"/>:</td>
						<td class="value"><s:textfield name="e.company" data-validate="required"
						readonly="true" title='%{getText("motorcade.title.click2selectCompany")}'/></td>
						<td class="label"><s:text name="motorcade.fax"/>:</td>
						<td class="value"><s:textfield name="e.fax"  data-validate='{required:false,type:"phone"}'/></td>
					</tr>
					<tr>
						<td class="label"> <s:text name="motorcade.colour"/>:</td>
						<td class="value"><s:textfield name="e.color" /></td>
						<td class="label"><s:text name="motorcade.address"/>:</td>
						<td class="value"><s:textfield name="e.address" /></td>
					</tr>
					<tr>
						<td class="label">* <s:text name="label.status"/>:</td>
						<td class="value"><s:radio name="e.status" list="#{'1':'启用中','2':'已删除','0':'已禁用'}" 
						value="e.status" cssStyle="width:auto;"/></td>
						<td class="label"><s:text name="motorcade.lastupdated_date"/>:</td>
						<td class="value"><s:date format="yyyy-MM-dd HH:mm:ss" name="e.modifiedDate" />
						<s:property value="e.modifierName" /></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="motorcade.description"/>:</td>
						<td class="value" colspan="3" rowspan="2"><s:textarea name="e.description" /></td>
					</tr>
				</tbody>
			</table>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.modifierName" />
		<s:hidden name="e.modifierId" />
		<s:hidden name="e.author.name" />
		<s:hidden name="e.authorDepartId" />
		<s:hidden name="e.authorDepartName" />
		<s:hidden name="e.authorUnitId" />
		<s:hidden name="e.authorUnitName" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		<input type="hidden" name="e.modifiedDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.modifiedDate" />'/>
	</s:form>
</div>