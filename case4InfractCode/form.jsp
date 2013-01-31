<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="case4InfractCode.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/case4InfractCode/save" />'
	data-js='<s:url value="/bc-business/caseTraffic/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.caseTrafficForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseTrafficForm" theme="simple">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td style="width: 80px;">&nbsp;</td>
						<td style="width: 80px;">&nbsp;</td>
						<td style="width: 80px;">&nbsp;</td>
						<td style="width: 80px;">&nbsp;</td>
						<td style="width: 90px;">&nbsp;</td>
						<td >&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.code.code"/>:</td>
						<td class="value"><s:textfield name="e.code" data-validate="required" cssClass="ui-widget-content"/></td>
						<td class="label">*<s:text name="runcase.code.jeom"/>:</td>
						<td class="value"><s:textfield name="e.jeom" data-validate='{"type":"number","required":true}' 
							value="%{getText('bs.format.numberRMB',{e.jeom})}" cssClass="ui-widget-content"/></td>
						<td class="label">*<s:text name="runcase.code.penalty"/>:</td>
						<td class="value"><s:textfield name="e.penalty" value="%{getText('bs.format.numberRMB',{e.penalty})}" 
							data-validate='{"type":"money","required":true}' cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="topLabel">*<s:text name="runcase.code.subject"/>:</td>
						<td class="value" colspan="5"><s:textarea name="e.subject"  rows="2" cssClass="ui-widget-content noresize"/></td>
					</tr>
					<tr>
						<td class="topLabel">*<s:text name="runcase.code.according"/>:</td>
						<td class="value" colspan="5"><s:textarea name="e.according"  rows="2" cssClass="ui-widget-content noresize"/></td>
					</tr>
					<tr>
						<td class="label" colspan="6">
							<div class="formTopInfo">
								<s:if test="%{e.closerName != null && e.status == 1}">
									结案人:<s:property value="e.closerName" />(<s:date name="e.closeDate" format="yyyy-MM-dd HH:mm:ss"/>),
								</s:if>
								<s:if test="%{e.author.name != null}">
								登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
								<s:if test="%{e.modifier != null}">
								，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>