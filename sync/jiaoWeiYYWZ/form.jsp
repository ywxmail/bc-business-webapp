<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="jiaoWeiYYWZ.title"/>' data-type='form' class="bc-page"
	data-js='<s:url value="/bc-business/sync/jiaoWeiYYWZ/form.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.jiaoWeiYYWZForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="jiaoWeiYYWZForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:670px;overflow: hidden;">
			<fieldset>
          		<legend>当事人信息</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td></td>
							<td style="width: 200px;">&nbsp;</td>
							<td style="width: 80px;">&nbsp;</td>
							<td style="width: 200px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.driverName"/>:</td>
							<td class="value"><s:textfield name="e.driverName" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.driverCert"/>:</td>
							<td class="value"><s:textfield name="e.driverCert" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.idcardType"/>:</td>
							<td class="value"><s:textfield name="e.idcardType" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.idcardCode"/>:</td>
							<td class="value"><s:textfield name="e.idcardCode" cssClass="ui-widget-content"/></td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<fieldset>
          		<legend>违章信息</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td></td>
							<td style="width: 200px;">&nbsp;</td>
							<td style="width: 80px;">&nbsp;</td>
							<td style="width: 200px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.carPlate"/>:</td>
							<td class="value"><s:textfield name="e.carPlate" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.syncCode"/>:</td>
							<td class="value"><s:textfield name="e.syncCode"  cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.address"/>:</td>
							<td class="value"><s:textfield name="e.address"  cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.happenDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd HH:mm" name="e.happenDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
								<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectHappenDate"></span>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.wzStatus"/>:</td>
							<td class="value"><s:textfield name="e.wzStatus"  cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.wzType"/>:</td>
							<td class="value"><s:textfield name="e.wzType"  cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.company"/>:</td>
							<td class="value"><s:textfield name="e.company"  cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="syncBase.syncDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.syncDate" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd HH:mm" name="e.syncDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
								<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectSyncDate"></span>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.area"/>:</td>
							<td class="value"><s:textfield name="e.area" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.closeDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.closeDate" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd HH:mm" name="e.closeDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
								<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectCloseDate"></span>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.content"/>:</td>
							<td class="value" colspan="3"><s:textarea name="e.content" cssStyle="width: 42em" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="value" colspan="4">
								<fieldset>
				          		<legend>扣罚信息</legend>
									<table class="formFields" cellspacing="2" cellpadding="0">
										<tr class="widthMarker">
											<td >&nbsp;</td>
											<td style="width: 200px;">&nbsp;</td>
											<td style="width: 80px;">&nbsp;</td>
											<td style="width: 220px;">&nbsp;</td>
										</tr>
										<tr>
											<td class="label"><s:text name="jiaoWeiYYWZ.detain"/>:</td>
											<td class="value"><s:textfield name="e.detain" cssClass="ui-widget-content"/></td>
											<td class="label"><s:text name="jiaoWeiYYWZ.penalty"/>:</td>
											<td class="value"><s:textfield name="e.penalty" value="%{getText('bs.format.number',{e.penalty})}" cssClass="ui-widget-content"/></td>
										</tr>
										<tr>
											<td class="label"><s:text name="jiaoWeiYYWZ.pullUnit"/>:</td>
											<td class="value"><s:textfield name="e.pullUnit"  cssClass="ui-widget-content"/></td>
											<td class="label"><s:text name="jiaoWeiYYWZ.receipt"/>:</td>
											<td class="value"><s:textfield name="e.receipt"  cssClass="ui-widget-content"/></td>
										</tr>
									</table>
								</fieldset>
							</td>
						</tr>
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
			<fieldset>
          		<legend>其它信息</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td></td>
							<td style="width: 200px;">&nbsp;</td>
							<td style="width: 80px;">&nbsp;</td>
							<td style="width: 200px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.notice"/>:</td>
							<td class="value"><s:textfield name="e.notice"  cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.buslines"/>:</td>
							<td class="value"><s:textfield name="e.buslines"  cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.owner"/>:</td>
							<td class="value"><s:textfield name="e.owner"  cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.ownerId"/>:</td>
							<td class="value"><s:textfield name="e.ownerId"  cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.bsCertNo"/>:</td>
							<td class="value"><s:textfield name="e.bsCertNo"  cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.evidenceUnit"/>:</td>
							<td class="value"><s:textfield name="e.evidenceUnit"  cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.carplateColor"/>:</td>
							<td class="value"><s:textfield name="e.carplateColor"  cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.commitStatus"/>:</td>
							<td class="value"><s:textfield name="e.commitStatus"  cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.businessCertNo"/>:</td>
							<td class="value"><s:textfield name="e.businessCertNo"  cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.seating"/>:</td>
							<td class="value"><s:textfield name="e.seating" value="%{getText('bs.format.number',{e.seating})}" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.oweRecord"/>:</td>
							<td class="value"><s:textfield name="e.oweRecord"  cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.oweSignature"/>:</td>
							<td class="value"><s:textfield name="e.oweSignature"  cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.leaveTroops"/>:</td>
							<td class="value"><s:textfield name="e.leaveTroops"  cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="jiaoWeiYYWZ.clone"/>:</td>
							<td class="value"><s:textfield name="e.clone"  cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="jiaoWeiYYWZ.desc"/>:</td>
							<td class="value"><s:textfield name="e.desc"  cssClass="ui-widget-content"/></td>
						</tr>
					</tbody>
				</table>
			</fieldset>
		</div>
		<s:hidden name="e.id" />
	</s:form>
</div>