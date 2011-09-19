<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="createcarByDriver.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/carByDriver/save" />'
	data-js='<s:url value="/bc-business/carByDriver/form.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bs.carByDriverForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carByDriverForm" theme="simple">
		<div class="formFields ui-widget-content" >
			<table class="formFields" cellspacing="2" cellpadding="0" style="height:260px">
				<tbody>
					<tr>
					<s:if test="%{carId != null}">
					    <td class="label"><s:text name="carByDriver.car.plateNo"/>:</td>
						<td class="value "><s:textfield name="plate"  value="%{e.car.plateType+e.car.plateNo }" readonly="true" cssClass="ui-state-disabled"/></td>
					</s:if><s:else>
						<td class="label"><s:text name="carByDriver.car.plateNo"/>:</td>
						<td class="value "><s:textfield name="plate" title='%{getText("carByDriver.title.click2selectCar")}' value="%{e.car.plateType+e.car.plateNo }" readonly="true" id="carName"/></td>
						</s:else>
					</tr>
					<tr>
					<s:if test="%{carManId != null}">
						<td class="label"> <s:text name="carByDriver.driver"/>:</td>
						<td class="value"><s:textfield name="e.driver.name" readonly="true" cssClass="ui-state-disabled" /></td>
					</s:if><s:else>
					    <td class="label"> <s:text name="carByDriver.driver"/>:</td>
						<td class="value"><s:textfield name="e.driver.name" title='%{getText("carByDriver.title.click2selectCarMan")}' id="driverName" readonly="true"/></td>
					</s:else>
					</tr>
					<tr>
						<td class="label"> *<s:text name="carByDriver.classes"/>:</td>
						<td class="value" ><s:select  name="e.classes"  list="#{0:'',1:'正班',2:'副班',3:'顶班'}" listKey="key" listValue="value"   headerKey="" headerValue="%{getText('label.please.choose')}"  data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="carByDriver.timeInterva"/>:</td>
						<td class="value">从<input type="text" name="e.startDate" style="width:120px" 
						class="bc-date" title='<s:text name="title.click2selectDate"/>'value='<s:date format="yyyy-MM-dd" name="e.startDate" />'/>
						到<input type="text" name="e.endDate" style="width: 120px" 
						class="bc-date" title='<s:text name="title.click2selectDate"/>'value='<s:date format="yyyy-MM-dd" name="e.endDate" />'/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="carByDriver.statuses"/>:</td>
						<td><s:radio name="e.status" list="statusesValueList" listKey="key"
							value="e.status" cssStyle="width:auto;"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carByDriver.description"/>:</td>
						<td class="value" rowspan="2"><s:textarea name="e.description" /></td>
					</tr>
					<tr>
						<td class="label" colspan="2" rowspan="2">
							<div class="formTopInfo">
								登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
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