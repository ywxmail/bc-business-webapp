<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="cert.select.vehicelicense"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/certVehicelicense/save" />'
	data-js='<s:url value="/bc-business/cert/car4cert/certVehicelicense/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/ui-libs/xheditor/1.1.7/xheditor-zh-cn.min.js?ts=0" />'
	data-initMethod='bc.certVehicelicenseForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="certVehicelicenseForm" theme="simple">
		<div class="formFields ui-widget-content"  style="width:750px;">
			<fieldset style="width: 700px">
				<legend>基本信息</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr>
							<td class="label" style="width: 7em;">*<s:text name="cert.4car.car" />:</td>
							<td class="value">
								<s:if test="!e.isNew()">
									<s:textfield name="e.plate" data-validate="required" disabled="true" />
								</s:if>
								<s:else>
									<s:textfield name="e.plate" data-validate="required" title='%{getText("cert.title.click2selectCar")}' readonly="true" />
								</s:else>
							</td>
							<td class="label" style="width: 7em;">*<s:text name="cert.4car.vehiceType"/>:</td>
							<td class="value">
								<s:textfield name="e.vehiceType" data-validate="required" />
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.4car.owner" />:</td>
							<td class="value" ><s:textfield name="e.owner"
							readonly="true"	title='%{getText("cert.title.click2selectBelong")}' data-validate="required" />
							</td>
							<td class="label">*<s:text name="cert.4car.useCharacter"/>:</td>
							<td class="value">
								<s:textfield name="e.useCharacter" data-validate="required" />
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.4car.factory"/>:</td>
							<td class="value">
								<s:textfield name="e.factory" data-validate="required" />
							</td>
							<td class="label">*<s:text name="cert.4car.registerDate"/>:</td>
							<td class="value">
								<input type="text" name="e.registerDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.registerDate" />'
								class="bc-date" data-cfg='{changeYear:true}' />
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.4car.vin"/>:</td>
							<td class="value">
								<s:textfield name="e.vin" data-validate='{"type":"number","required":true}' />
							</td>
							<td class="label">*<s:text name="cert.issueDate"/>:</td>
							<td class="value">
								<input type="text" name="e.issueDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.issueDate" />'
								class="bc-date" data-cfg='{changeYear:true}' />
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.4car.engineNo"/>:</td>
							<td class="value">
								<s:textfield name="e.engineNo" data-validate='{"type":"number","required":true}' />
							</td>
							<td class="label">*<s:text name="cert.4car.scrapDate"/>:</td>
							<td class="value">
								<input type="text" name="e.scrapDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.scrapDate" />'
								class="bc-date" data-cfg='{changeYear:true}' />
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.4car.archiveNo"/>:</td>
							<td class="value">
								<s:textfield name="e.archiveNo" data-validate='{"type":"number","required":true}' />
							</td>
							<td class="label">*<s:text name="cert.4car.cert.effectiveDateTo"/>:</td>
							<td class="value">
								<input type="text" name="e.endDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
								class="bc-date" data-cfg='{changeYear:true}' />
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="cert.address"/>:</td>
							<td class="value" colspan="3">
								<s:textfield name="e.address" cssStyle="width:46em;"/>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="cert.licencer"/>:</td>
							<td class="value" colspan="3">
								<s:textfield name="e.licencer" cssStyle="width:46em;"/>
							</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<fieldset style="width: 700px">
				<legend>其他信息</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr style="height: 1px;">
							<td style="width: 80px;">&nbsp;</td>
							<td style="width: 270px;">&nbsp;</td>
							<td style="width: 85px;">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.4car.accessCount" />:</td>
							<td class="value">
								<s:textfield name="e.accessCount" data-validate='{"type":"number","required":true}'  cssStyle="width:3em;"/>&nbsp;人
							</td>
							<td class="label">*<s:text name="cert.4car.totalWeight" />:</td>
							<td class="value">
								<s:textfield name="e.totalWeight" data-validate='{"type":"number","required":true}'  cssStyle="width:3em;"/>&nbsp;kg
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.4car.curbWeight" />:</td>
							<td class="value" >
								<s:textfield name="e.curbWeight" data-validate='{"type":"number","required":true}'  cssStyle="width:3em;"/>&nbsp;kg
							</td>
							<td class="label"><s:text name="cert.4car.accessWeight" />:</td>
							<td class="value" >
								<s:textfield name="e.accessWeight" data-validate="number" cssStyle="width:3em;"/>&nbsp;kg
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.4car.dim" />:</td>
							<td class="value" >
								<s:textfield name="e.dimLen" data-validate='{"type":"number","required":true}'  cssStyle="width:3em;"/>
								X
								<s:textfield name="e.dimWidth" data-validate='{"type":"number","required":true}' cssStyle="width:3em;"/>
								X
								<s:textfield name="e.dimHeight" data-validate='{"type":"number","required":true}'  cssStyle="width:3em;"/>&nbsp;mm
							</td>
							<td class="label"><s:text name="cert.4car.pullWeight" />:</td>
							<td class="value" >
								<s:textfield name="e.pullWeight" data-validate="number"  cssStyle="width:3em;"/>&nbsp;mm
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="cert.4car.desc"/>:</td>
							<td class="value" colspan="3">
								<s:textfield name="e.desc" cssStyle="width:46em;"/>
							</td>
						</tr>
						<tr>
							<td class="label" style="text-align: left"><s:text name="cert.4car.record"/>:</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="value" colspan="4">
								<s:textarea name="e.record" />
							</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<fieldset style="width: 700px">
				<legend>复印件</legend>
				<s:property value="%{attachsUI}" escapeHtml="false" />
			</fieldset>
		</div>
		<table class="formFields" cellspacing="2" cellpadding="0">
			<tbody>
				<tr>
					<td class="label" colspan="4">
						<div class="formTopInfo">
							<s:if test="%{e.status != null && statusesValue[e.status] != null}">
							状态：<s:property value="%{statusesValue[e.status]}" />，
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
		<s:hidden name="e.uid"/>
		<s:hidden name="e.type"/>
		<s:hidden name="carId"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>