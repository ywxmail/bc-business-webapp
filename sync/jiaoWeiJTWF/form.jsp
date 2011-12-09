<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="jiaoWeiJTWF.title"/>' data-type='form' class="bc-page"
	data-js='<s:url value="/bc-business/sync/jiaoWeiJTWF/form.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.jiaoWeiJTWFForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="jiaoWeiJTWFForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:600px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td></td>
						<td style="width: 200px;">&nbsp;</td>
						<td style="width: 80px;">&nbsp;</td>
						<td style="width: 200px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label"><s:text name="jinDunJTWF.carPlate"/>:</td>
						<td class="value"><s:textfield name="e.carPlate" cssClass="ui-widget-content"/></td>
						<td class="label"><s:text name="jinDunJTWF.happenDate"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
							value='<s:date format="yyyy-MM-dd HH:mm" name="e.happenDate" />'
							class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
							<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectHappenDate"></span>
						</td>
					</tr>
					<tr>
						<td class="label"><s:text name="jiaoWeiJTWF.driverName"/>:</td>
						<td class="value"><s:textfield name="e.driverName" cssClass="ui-widget-content"/></td>
						<td class="label"><s:text name="jiaoWeiJTWF.driverCert"/>:</td>
						<td class="value"><s:textfield name="e.driverCert" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="jiaoWeiJTWF.jeom"/>:</td>
						<td class="value"><s:textfield name="e.jeom" cssClass="ui-widget-content"/></td>
						<td class="label"><s:text name="jiaoWeiJTWF.syncCode"/>:</td>
						<td class="value"><s:textfield name="e.syncCode"  cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="jiaoWeiJTWF.content"/>:</td>
						<td class="value" colspan="3"><s:textarea name="e.content" cssStyle="width: 38.4em" cssClass="ui-widget-content"/></td>
					<tr>
						<td class="label" colspan="4">
							<div class="formTopInfo">
								状态：<s:property value="%{statusesValue[e.status]}" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<s:hidden name="e.id" />
	</s:form>
</div>