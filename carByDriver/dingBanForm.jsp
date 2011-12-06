<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="shiftworkByDriver.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/carByDriver/save" />'
	data-js='<s:url value="/bc-business/carByDriver/form.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bs.carByDriverForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","action":"save"}],
		"width":400,"minWidth":320,"minHeight":400,"modal":false}' style="overflow-y:auto;">
	<s:form name="carByDriverForm" theme="simple" >
		<div class="formFields ui-widget-content" >
			<table class="formFields" cellspacing="2" cellpadding="0" style="height:350px ">
				<tbody>
					<tr>
					<s:if test="%{carManId != null}">
						<td class="label"><s:text name="carByDriver.driver"/>:</td>
						<td class="value"><s:textfield name="e.driver.name" readonly="true" cssClass="ui-state-disabled" /></td>
					</s:if><s:else>
					    <td class="label">*<s:text name="carByDriver.driver"/>:</td>
						<td class="value" style="position:relative;display: block;"><s:textfield name="e.driver.name" 
					    data-validate="required" cssClass="ui-widget-content" readonly="true"/>
					    <span id="selectDriver" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></span>
					    </td>
					</s:else>
					</tr>
					<tr>
					    <td class="topLabel"><s:text name="carByDriver.car.plateNo"/>:</td>
					    <td class="value">
						    <table style="width:100%;">
							    <tr>
								   <!--   <td ><s:textarea name="plates" value="%{e.car.plateType+e.car.plateNo }" readonly="true" rows="6" cssClass="ui-widget-content"/></td>-->
								    <td><s:select name="plates" list="cars" listKey="key" listValue="value" theme="simple" size="10" cssStyle="width:100%;height:80%;"/></td>
								    <td style="width:40px;text-align: center;vertical-align: middle;"><input type="button" id="selectShiftworkCar" value="+" style="width:30px;"/><br><input type="button" value="-" style="width:30px;"/><br>
									    <input type="button" value="↑" style="width:30px;"/><br><input type="button" value="↓" style="width:30px;"/></td>
							    </tr>
						    </table>
					    <td>
					</tr>
					<tr>
						<td class="label">*<s:text name="carByDriver.classes"/>:</td>
						<!--  
						<td class="value" ><s:select name="e.classes" list="#{0:'',1:'正班',2:'副班',3:'顶班'}" 
							listKey="key" listValue="value" data-validate="required" cssClass="ui-widget-content"/></td>-->
						<td class="value"><s:textfield  value="顶班" cssClass="ui-widget-content ui-state-disabled" readonly="true"/></td>
					</tr>
					<!-- 
					<tr>
						<td class="label"><s:text name="carByDriver.timeInterva"/>:</td>
						<td class="value">从<input type="text" name="e.startDate" style="width:120px" 
						class="bc-date" title='<s:text name="title.click2selectDate"/>'value='<s:date format="yyyy-MM-dd" name="e.startDate" />'/>
						到<input type="text" name="e.endDate" style="width: 120px" 
						class="bc-date" title='<s:text name="title.click2selectDate"/>'value='<s:date format="yyyy-MM-dd" name="e.endDate" />'/></td>
					</tr> -->
					<tr>
						<td class="label"><s:text name="carByDriver.statuses"/>:</td>
						<td><s:radio name="e.status" list="#{'0':'在案','1':'注销'}" value="0" cssStyle="width:auto;"/></td>
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="carByDriver.description"/>:</td>
						<td class="value"><s:textarea name="e.description" rows="5" cssClass="ui-widget-content"/></td>
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
		<s:hidden name="e.startDate" />
		<s:hidden name="e.endDate" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>