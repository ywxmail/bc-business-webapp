<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="createcarByDriver.title"/>-<s:property value="e.name" />' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/carByDriver/save" />'
	data-js='<s:url value=" /bc-business/charger/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.business.chargerForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carByDriverForm" theme="simple">
		<div class="formFields ui-widget-content">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label"><s:text name="carByDriver.car.plateNo"/>:</td>
						<td class="value "><s:textfield name="e.car.plateNo" /></td>
					</tr>
					<tr>
						<td class="label"> <s:text name="carByDriver.driver"/>:</td>
						<td class="value"><s:textfield name="e.driver.name" /></td>
						
					</tr>
					<tr>
						<td class="label"> <s:text name="carByDriver.classes"/>:</td>
						<td class="value"><s:select  name="e.classes" list="driverClasses" listKey="value"  listValue="value"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="carByDriver.timeInterva"/>:</td>
						<td class="value">从<input type="text" name="e.startDate" style="width: 170px" 
						class="bc-date" title='<s:text name="title.click2selectDate"/>'value='<s:date format="yyyy-MM-dd" name="e.startDate" />'/>
						到<input type="text" name="e.endDate" style="width: 170px" 
						class="bc-date" title='<s:text name="title.click2selectDate"/>'value='<s:date format="yyyy-MM-dd" name="e.endDate" />'/></td>
					</tr>
					<tr>
						<td class="label" colspan="4">
							<div class="formTopInfo">
								状态：<s:property value="%{statusesValue[e.status]}" />&nbsp;&nbsp;&nbsp;&nbsp;登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
								<s:if test="%{e.modifier != null}">
								，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<s:hidden name="e.uid" />
		<s:hidden name="e.status"/>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
	</s:form>
</div>