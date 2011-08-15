<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="createcarByDriver.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/carByDriver/save" />'
	data-js='<s:url value=" /bc-business/carByDriver/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/car/select.js" />'
	data-initMethod='bc.business.carByDriverForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carByDriverForm" theme="simple">
		<div class="formFields ui-widget-content">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label"><s:text name="carByDriver.car.plateNo"/>:</td>
						<td class="value "><s:textfield name="plate" title='%{getText("carByDriver.title.click2selectCar")}' value="%{e.car.plateType+e.car.plateNo }"/></td>
					</tr>
					<tr>
						<td class="label"> <s:text name="carByDriver.driver"/>:</td>
						<td class="value"><s:textfield name="e.driver.name"  readonly="true"/></td>
						
					</tr>
					<tr>
						<td class="label"> <s:text name="carByDriver.classes"/>:</td>
						<td class="value" ><s:select  name="e.classes" list="driverClasses" listKey="value"  listValue="value" style="width:283px"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="carByDriver.timeInterva"/>:</td>
						<td class="value">从<input type="text" name="e.startDate" style="width:120px" 
						class="bc-date" title='<s:text name="title.click2selectDate"/>'value='<s:date format="yyyy-MM-dd" name="e.startDate" />'/>
						到<input type="text" name="e.endDate" style="width: 120px" 
						class="bc-date" title='<s:text name="title.click2selectDate"/>'value='<s:date format="yyyy-MM-dd" name="e.endDate" />'/></td>
					</tr>
					<tr>
						<td class="label" colspan="3">
							<div class="formTopInfo">
								状态：<s:property value="%{statusesValue[e.status]}" />&nbsp;&nbsp;&nbsp;&nbsp;登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
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
		<s:hidden name="e.car.id" />
		<s:hidden name="e.driver.id" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>