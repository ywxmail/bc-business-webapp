<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="insuranceType.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/insuranceType/save" />'
	data-js='<s:url value="/bc-business/insuranceType/form.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bs.insuranceTypeForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="insuranceTypeForm" theme="simple">
		<div class="formFields ui-widget-content" >
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
					    <td class="label"><s:text name="insuranceType.name"/>:</td>
						<td class="value "><s:textfield name="e.name" cssClass="ui-state-disabled"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="insuranceType.coverage"/>:</td>
						<td class="value"><s:textfield name="e.coverage"cssClass="ui-state-disabled" /></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="insuranceType.premium"/>:</td>
						<td class="value"><s:textfield name="e.premium"cssClass="ui-state-disabled" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="insuranceType.statuses"/>:</td>
						<td><s:radio name="e.status" list="#{'0':'在案','1':'禁用'}" cssStyle="width:auto;"/></td>
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="insuranceType.description"/>:</td>
						<td class="value"><s:textarea name="e.description" rows="5" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" colspan="2" rowspan="2">
							<div class="formTopInfo">
								登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
								<s:if test="%{e.modifier != null}">
								<br/>最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>