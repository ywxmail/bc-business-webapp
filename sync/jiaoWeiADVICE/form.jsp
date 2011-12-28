<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="jiaoWeiADVICE.title"/>' data-type='form' class="bc-page"
	data-js='<s:url value="/bc-business/sync/jiaoWeiADVICE/form.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.jiaoWeiADVICEForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="jiaoWeiADVICEForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:670px;overflow: hidden;">
			<fieldset class="ui-widget-content">
          		<legend>被投诉人信息</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td></td>
							<td style="width: 200px;">&nbsp;</td>
							<td style="width: 80px;">&nbsp;</td>
							<td style="width: 200px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.driverCert"/>:</td>
							<td class="value"><s:textfield name="e.driverCert" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiADVICE.driverChar"/>:</td>
							<td class="value"><s:textfield name="e.driverChar" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.driverSex"/>:</td>
							<td class="value"><s:textfield name="e.driverSex" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiADVICE.oldUnitName"/>:</td>
							<td class="value"><s:textfield name="e.oldUnitName" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.carPlate"/>:</td>
							<td class="value"><s:textfield name="e.carPlate" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiADVICE.busColor"/>:</td>
							<td class="value"><s:textfield name="e.busColor" cssClass="ui-widget-content"/></td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<fieldset class="ui-widget-content">
          		<legend>投诉人信息</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td></td>
							<td style="width: 200px;">&nbsp;</td>
							<td style="width: 80px;">&nbsp;</td>
							<td style="width: 200px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.advisorName"/>:</td>
							<td class="value"><s:textfield name="e.advisorName" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiADVICE.advisorCert"/>:</td>
							<td class="value"><s:textfield name="e.advisorCert" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.advisorPhone"/>:</td>
							<td class="value"><s:textfield name="e.advisorPhone" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiADVICE.advisorAge"/>:</td>
							<td class="value"><s:textfield name="e.advisorAge" cssStyle="width: 4em" cssClass="ui-widget-content"/>&nbsp;&nbsp;性别:<s:textfield name="e.advisorSex" cssStyle="width: 1.5em" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="topLabel"><s:text name="jiaoWeiADVICE.content"/>:</td>
							<td class="value" colspan="3"><s:textarea name="e.content" cssStyle="width: 42em" cssClass="ui-widget-content" cols="4"/></td>
						<tr>
							<td class="label" colspan="4">
								<div class="formTopInfo">
									状态：<s:property value="%{statusesValue[e.status]}" />
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<fieldset class="ui-widget-content">
          		<legend>处理信息</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td></td>
							<td style="width: 200px;">&nbsp;</td>
							<td style="width: 80px;">&nbsp;</td>
							<td style="width: 200px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.syncCode"/>:</td>
							<td class="value"><s:textfield name="e.syncCode"  cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="syncBase.syncDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.syncDate" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd HH:mm" name="e.syncDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
								<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectSyncDate"></span>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.receiveDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.receiveDate" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd HH:mm" name="e.receiveDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
								<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectReceiveDate"></span>
							</td>
							<td class="label"><s:text name="jiaoWeiADVICE.receiveCode"/>:</td>
							<td class="value"><s:textfield name="e.receiveCode" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.ridingTimeStart"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.ridingTimeStart" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd HH:mm" name="e.ridingTimeStart" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
								<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectRidingTimeStart"></span>
							</td>
							<td class="label"><s:text name="jiaoWeiADVICE.ridingTimeEnd"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.ridingTimeEnd" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd HH:mm" name="e.ridingTimeEnd" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
								<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectRidingTimeEnd"></span>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.subject"/>:</td>
							<td class="value"><s:textfield name="e.subject" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiADVICE.subject2"/>:</td>
							<td class="value"><s:textfield name="e.subject2" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.result"/>:</td>
							<td class="value"><s:textfield name="e.result" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiADVICE.adviceBs"/>:</td>
							<td class="value"><s:textfield name="e.adviceBs" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.machinePrice"/>:</td>
							<td class="value"><s:textfield name="e.machinePrice" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiADVICE.charge"/>:</td>
							<td class="value"><s:textfield name="e.charge" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.buslines"/>:</td>
							<td class="value"><s:textfield name="e.buslines" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiADVICE.suggestBs"/>:</td>
							<td class="value"><s:textfield name="e.suggestBs" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiADVICE.reply"/>:</td>
							<td class="value"><s:textfield name="e.reply" cssClass="ui-widget-content"/></td>
						</tr>
					</tbody>
				</table>
			</fieldset>
		</div>
		<s:hidden name="e.id" />
	</s:form>
</div>