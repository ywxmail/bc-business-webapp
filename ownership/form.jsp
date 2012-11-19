<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="ownership.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/ownership/save" />'
	data-js='<s:url value="/bc-business/ownership/form.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bs.ownershipForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="ownershipForm" theme="simple">
			<table class="formFields" cellspacing="2" cellpadding="0" style="width: 380px;">
				<tbody>
					<tr class="widthMarker">
						<td style="width: 100px;">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="ownership.owner"/>:</td>
						<td class="value" ><s:select list="owners" listKey="value" listValue="value" data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" name="e.owner" cssClass="ui-widget-content"></s:select></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="car.certNo2"/>:</td>
						<td class="value"><s:textfield name="e.number" data-validate="required" /></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="ownership.owner_ship"/>:</td>
						<td class="value"><s:textfield name="e.ownership" data-validate="required" /></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="ownership.situation"/>:</td>
						<td class="value" ><s:select list="situations" listKey="value" listValue="value" data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" name="e.situation" cssClass="ui-widget-content"></s:select></td>
					</tr>
					<tr>
					    <td class="label">*<s:text name="ownership.nature"/>:</td>
						<td class="value" ><s:select list="natures" listKey="value" listValue="value" data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" name="e.nature" cssClass="ui-widget-content"></s:select></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="ownership.source"/>:</td>
						<td class="value"><s:textfield name="e.source" data-validate="required" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="ownership.whither"/>:</td>
						<td class="value"><s:textfield name="e.whither" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="label.status"/>:</td>
					    <td class="value"><s:radio name="e.status" list="#{'0':'在案','1':'注销'}" cssStyle="width:auto;"/></td>
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="ownership.description"/>:</td>
						<td class="value"><s:textarea name="e.description" rows="5" cssClass="ui-widget-content noresize"/></td>
					</tr>
					<tr>
						<td class="label" colspan="2" rowspan="2">
							<div class="formTopInfo">
								状态：<s:property value="%{statusesValue[e.status]}" />，
								登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
								<s:if test="%{e.modifier != null}">
								<br/>最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.modifier.id"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>