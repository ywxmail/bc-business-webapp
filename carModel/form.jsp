<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="carmodel.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/carModel/save" />'
	data-js='<s:url value="/bc-business/carModel/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.carModelForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carmodelForm" theme="simple">
		<div class="formFields ui-widget-content"  style="width:710px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td >&nbsp;</td>
						<td style="width: 200px;">&nbsp;</td>
						<td style="width: 100px;">&nbsp;</td>
						<td style="width: 220px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carModel.factoryModel"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.factoryModel" data-validate="required" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carModel.factoryType"/>:</td>
						<td class="value" >
							<s:select name="e.factoryType" list="factoryTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" data-validate="required"></s:select>
						</td>
						<td class="label" ><s:text name="carModel.engineType"/>:</td>
						<td class="value" ><s:textfield name="e.engineType" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carModel.fuelType"/>:</td>
						<td class="value" >
							<s:select name="e.fuelType" list="fuelTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" data-validate="required"></s:select>
						</td>
						<td class="label" ><s:text name="carModel.turnType"/>:</td>
						<td class="value" ><s:textfield name="e.turnType" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carModel.displacement"/>/<s:text name="carModel.power"/>:</td>
						<td class="value" ><s:textfield name="e.displacement" data-validate='{"type" : "digits"}'  cssStyle="width:5em;" cssClass="ui-widget-content"/>&nbsp;ml&nbsp;&nbsp;<s:textfield name="e.power" value="%{getText('bs.format.number',{e.power})}" data-validate='{"type" : "number"}' cssStyle="width:5em;" cssClass="ui-widget-content"/>&nbsp;kw</td>
						<td class="label"  >
							<s:text name="carModel.dim" />:
						</td>
						<td class="value" >
							<s:text name="carModel.dimLen" />
							<s:textfield name="e.dimLen" data-validate='{"type" : "digits"}'  cssStyle="width:3em;" cssClass="ui-widget-content"/>
							<s:text name="carModel.dimWidth"/>
							<s:textfield name="e.dimWidth" data-validate='{"type" : "digits"}'  cssStyle="width:3em;" cssClass="ui-widget-content"/>
							<s:text name="carModel.dimHeight" />
							<s:textfield name="e.dimHeight" data-validate='{"type" : "digits"}'   cssStyle="width:3em;" cssClass="ui-widget-content"/>&nbsp;mm
						</td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carModel.totalWeight"/>:</td>
						<td class="value" ><s:textfield name="e.totalWeight" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
						<td class="label" ><s:text name="carModel.pieceCount"/>:</td>
						<td class="value" ><s:textfield name="e.pieceCount" data-validate='{"type" : "digits"}'cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carModel.tireStandard" />:</td>
						<td class="value" ><s:textfield name="e.tireStandard" cssClass="ui-widget-content"/></td>
						<td class="label" ><s:text name="carModel.tireCount"/>:</td>
						<td class="value" ><s:textfield name="e.tireCount" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carModel.tireFrontDistance" />:</td>
						<td class="value" ><s:textfield name="e.tireFrontDistance"  data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
						<td class="label" ><s:text name="carModel.tireBehindDistance"/>:</td>
						<td class="value" ><s:textfield name="e.tireBehindDistance" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carModel.axisCount" />:</td>
						<td class="value" ><s:textfield name="e.axisCount" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
						<td class="label" ><s:text name="carModel.axisDistance"/>:</td>
						<td class="value" ><s:textfield name="e.axisDistance" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carModel.accessWeight" />:</td>
						<td class="value" ><s:textfield name="e.accessWeight" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
						<td class="label" ><s:text name="carModel.accessCount"/>:</td>
						<td class="value" ><s:textfield name="e.accessCount" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
					</tr>
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
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.uid"/>
		<s:hidden name="e.status"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>