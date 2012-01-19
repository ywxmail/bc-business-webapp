<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="shiftworkByDriver.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/shiftworkByDriver/save" />'
	data-js='<s:url value="/bc-business/carByDriverHistory/dingBanForm.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.business.shiftworkByDriverForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","action":"save"}],
		"width":400,"minWidth":320,"minHeight":400,"modal":false}' style="overflow-y:auto;">
	<s:form name="carByDriverForm" theme="simple" >
		<div class="formFields ui-widget-content" >
			<table class="formFields" cellspacing="2" cellpadding="0" style="height:350px ">
				<tbody>
					<tr>
					<s:if test="%{carManId != null}">
						<td class="label"><s:text name="shiftworkByDriver.driver"/>:</td>
						<td class="value"><s:textfield name="e.driver.name" readonly="true" cssClass="ui-state-disabled" /></td>
					</s:if><s:else>
					    <td class="label">*<s:text name="shiftworkByDriver.driver"/>:</td>
						<td class="value" style="position:relative;display: block;"><s:textfield name="driverName" 
					    data-validate="required" cssClass="ui-widget-content" />
					    <span id="selectShiftworkDriver" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></span>
					    </td>
					</s:else>
					</tr>
					<tr>
						<td class="label">*<s:text name="shiftworkByDriver.zhuguache"/>:</td>
						<s:if test="%{carId != null}">
                          <td class="value "><s:textfield name="plate" value="%{e.car.plateType+'.'+e.car.plateNo }" readonly="true"/></td>
                           </s:if><s:else>
                              <td class="value relative">
						      <div class="input ui-widget-content" data-validate="required" ><span class="link showCar" title='<s:text name="title.click2openCar"/>' data-cfg='<s:property value="e.toCar.id" />' id="carInfo" ><s:property value="%{e.toCar.plateType+'.'+e.toCar.plateNo }" /></span>
						      </div>
						      <ul class="inputIcons">
						        <li class="selectCar inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>' data-cfg='e.toCar.id=id,carInfo=plate|text,carInfo=id|attr'></li>
						      </ul>
                               </td>
						</s:else>
					</tr>
					<tr>
					    <td class="topLabel"><s:text name="shiftworkByDriver.dingbanche"/>:</td>
					    <td class="value">
						    <table style="width:100%;">
							    <tr>
								   <!--   <td ><s:textarea name="plates" value="%{e.car.plateType+e.car.plateNo }" readonly="true" rows="6" cssClass="ui-widget-content"/></td>-->
								    <td><s:select name="e.shiftwork" list="cars" listKey="key" listValue="value" theme="simple" size="10" cssStyle="width:100%;height:90%;" cssClass="ui-widget-content"/></td>
								    <td style="width:40px;text-align: center;vertical-align: middle;"><input type="button" id="addCar" value="+" style="width:30px;height:40px;"/><br><input id="removeCar" type="button" value="-" style="width:30px;height:40px;"/><br>
									    <input type="button" id="upCar" value="↑" style="width:30px;height:40px;"/><br><input type="button" id="downCar" value="↓" style="width:30px;height:40px;"/></td>
							    </tr>
						    </table>
					    <td>
					</tr>
					<tr>
						<td class="label">*<s:text name="shiftworkByDriver.dbhtq"/>:</td>
						<td class="value">
						<div style="position : relative; display: inline-block">
							&nbsp;从<input type="text" name="e.moveDate" 
                            data-validate='{required:true,type:"date"}'class="bc-date ui-widget-content" title='<s:text name="title.click2selectDate"/>'
                               value='<s:date format="yyyy-MM-dd" name="e.moveDate" />' style="width: 9em;"/>
                               <ul class="inputIcons" style="right : 0px;">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.commerialStartDate' ></li>
						    </ul>
						</div>
						<div style="position : relative; display: inline-block">
							&nbsp;到<input type="text" name="e.endDate" 
                            data-validate='{required:true,type:"date"}'class="bc-date ui-widget-content" title='<s:text name="title.click2selectDate"/>'
                               value='<s:date format="yyyy-MM-dd" name="e.endDate" />' style="width: 10em;"/>
                               <ul class="inputIcons" style="right : 0px;">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.commerialEndDate' ></li>
						    </ul>
						</div>
						</td>
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="carByDriverHistory.description"/>:</td>
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
		<s:hidden name="e.moveType" />
		<s:hidden name="e.driver.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.modifier.id"/>
		<s:hidden name="e.fromMotorcadedId"/>
		<s:hidden name="e.toMotorcadeId"/>
		<s:hidden name="e.fromCar.id"/>
		<s:hidden name="e.toCar.id"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>