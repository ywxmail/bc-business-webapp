<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="cert.select.roadtransport"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/certRoadtransport/save" />'
	data-js='<s:url value="/bc-business/cert/car4cert/certRoadtransport/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/ui-libs/xheditor/1.1.7/xheditor-zh-cn.min.js?ts=0" />'
	data-initMethod='bc.certRoadtransportForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="certRoadtransportForm" theme="simple">
		<div class="formFields ui-widget-content"  style="width:730px;">
			<fieldset style="width: 680px">
				<legend>基本信息</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td >&nbsp;</td>
							<td style="width: 200px;">&nbsp;</td>
							<td style="width: 80px;">&nbsp;</td>
							<td style="width: 200px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label" style="width: 7em;">*<s:text name="cert.4car.car" />:</td>
							<td class="value relative">
								<s:if test="!e.isNew()">
									<s:textfield name="e.plate" data-validate="required" disabled="true" cssClass="ui-widget-content ui-state-disabled" readonly="true"/>
								</s:if>
								<s:else>
									<s:textfield name="e.plate" data-validate="required" cssClass="ui-widget-content ui-state-disabled" readonly="true" />
									<ul class="inputIcons">
								 		<li class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="cert.title.click2selectCar"/>' id="selectCarPlate">
								 	</ul>
								</s:else>
							</td>
							<td class="label" style="width: 7em;">*<s:text name="cert.4car.factory"/>:</td>
							<td class="value">
								<s:textfield name="e.factory" data-validate="required" cssClass="ui-widget-content" />
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.certCode"/>:</td>
							<td class="value">
								<s:textfield name="e.certCode" data-validate="required" cssClass="ui-widget-content" />
							</td>
							<td class="label">*<s:text name="cert.4car.businessCertNo"/>:</td>
							<td class="value">
								<s:textfield name="e.businessCertNo" data-validate="required"  cssClass="ui-widget-content"/>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.4car.scope"/>:</td>
							<td class="value">
								<s:textfield name="e.scope" data-validate="required"  cssClass="ui-widget-content"/>
							</td>
							<td class="label">*<s:text name="cert.issueDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.issueDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.issueDate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.issueDate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.4car.seat"/>:</td>
							<td class="value">
								<s:textfield name="e.seat" data-validate="required" cssClass="ui-widget-content"/>
							</td>
							<td class="label"><s:text name="cert.4car.dim2" />:</td>
							<td class="value" >
								<s:text name="cert.4car.dimLen" />
								<s:textfield name="e.dimLen" data-validate="number"  cssStyle="width:3em;" cssClass="ui-widget-content"/>
								<s:text name="cert.4car.dimWidth" />
								<s:textfield name="e.dimWidth" data-validate="number" cssStyle="width:3em;" cssClass="ui-widget-content"/>
								<s:text name="cert.4car.dimHeight" />
								<s:textfield name="e.dimHeight" data-validate="number"  cssStyle="width:3em;" cssClass="ui-widget-content"/>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.4car.owner2" />:</td>
							<td class="value" ><s:textfield name="e.owner" cssClass="ui-widget-content" readonly="true"	title='%{getText("cert.title.click2selectBelong")}' data-validate="required" />
							</td>
							<td class="label"><s:text name="cert.licencer"/>:</td>
							<td class="value">
								<s:textfield name="e.licencer" cssClass="ui-widget-content"/>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="cert.address"/>:</td>
							<td class="value" colspan="3">
								<s:textfield name="e.address" cssStyle="width:46em;" cssClass="ui-widget-content"/>
							</td>
						</tr>
						<tr>
							<td class="label" style="text-align: left"><s:text name="cert.4car.desc"/>:</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="value" colspan="4">
								<s:textarea name="e.desc" cssClass="ui-widget-content"/>
							</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<fieldset style="width: 700px">
				<legend>车辆审检及技术等级记录</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr>
							<td class="label">*<s:text name="cert.4car.level"/>:</td>
							<td class="value" style="width: 17em;">
								<s:textfield name="e.level" data-validate="required" cssClass="ui-widget-content" />
							</td>
							<td class="label">*<s:text name="cert.effectiveDate"/>:</td>
							<td class="value">
								<div style="position:relative;display: inline-block">
								&nbsp;从<input type="text" name="e.startDate" data-validate='{"type":"date","required":true}'
									value='<s:date format="yyyy-MM-dd" name="e.startDate" />' class="bc-date ui-widget-content"
									style="width: 9.25em;" />
									<ul class="inputIcons" style="right : 0px;">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.startDate' ></li>
									</ul>
								</div>
								<div style="position:relative;display: inline-block">
									&nbsp;到<input type="text" name="e.endDate" data-validate='{"type":"date","required":true}'
									value='<s:date format="yyyy-MM-dd" name="e.endDate" />' class="bc-date ui-widget-content"
									style="width: 9.25em;" />
									<ul class="inputIcons" style="right : 0px;">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.endDate' ></li>
									</ul>
								</div>
							</td>
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
							状态：<s:property value="%{statusesValue[e.status]}" />，
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