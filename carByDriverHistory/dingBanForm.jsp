<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="shiftworkByDriver.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/shiftworkByDriver/save" />'
	data-js='<s:url value="/bc-business/carByDriverHistory/dingBanForm.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/bc-business/carByDriverHistory/form.js" />'
	data-initMethod='bc.business.shiftworkByDriverForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carByDriverForm" theme="simple" >
		<div class="formFields ui-widget-content" style="width:410px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
				    <tr class="widthMarker">
		                <td style="width:100px;">&nbsp;</td>
		                <td >&nbsp;</td>
	                </tr>
					<tr>
					<s:if test="%{carManId != null || !isNewest}">
						<td class="label"><s:text name="shiftworkByDriver.driver"/>:</td>
						<td class="value"><s:textfield name="e.driver.name" readonly="true" cssClass="ui-widget-content"/></td>
					</s:if><s:else>
					    <td class="label">*<s:text name="shiftworkByDriver.driver"/>:</td>
						<td class="value relative"><s:textfield name="e.driver.name" readonly="true" data-validate="required" cssClass="ui-widget-content" />
					        <ul class="inputIcons">
                               <li id="driverName" class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
                               <li class="clearSelect inputIcon ui-icon ui-icon-circle-close" data-cfg="e.driver.name" title='<s:text name="title.click2clear"/>'></li>
                            </ul>
					    </td>
					</s:else>
					</tr>
					<tr>
						<td class="label" colspan="2"><div style="width: 165px;"><s:radio name="e.toClasses" list="#{'3':'替班','5':'公共替班'}" value="e.toClasses" cssStyle="width:auto;"/></div></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="shiftworkByDriver.zhuguache"/>:</td>
						<s:if test="%{carId != null}">
                          <td class="value "><s:textfield name="plate" value="%{e.car.plateType+'.'+e.car.plateNo }" readonly="true"/></td>
                           </s:if><s:else>
                              <td class="value relative">
						      <div class="input ui-widget-content" data-validate="required" ><span class="link showCar" title='<s:text name="title.click2openCar"/>' data-cfg='<s:property value="e.toCar.id" />' id="carInfo" ><s:property value="%{e.toCar.plateType+'.'+e.toCar.plateNo }" /></span>
						      </div>
					          <s:if test="isNewest">
							      <ul class="inputIcons">
							        <li class="selectCar inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>' 
							        	data-cfg='e.toCar.id=id,carInfo=plate|text,carInfo=id|attr' data-status="-1,0,1"></li>
							      </ul>
						      </s:if>
                               </td>
						</s:else>
					</tr>
					<tr>
					    <td class="topLabel"><s:text name="shiftworkByDriver.dingbanche"/>:</td>
					    <td class="value">
						    <table style="width:100%;" style="margin:0;padding:0;" cellspacing="0" cellpadding="0" >
							    <tr>
								    <td><s:select name="plates" list="cars" listKey="key" listValue="value" theme="simple"
								     	multiple="true" cssStyle="width:100%;height:9em;;" cssClass="ui-widget-content" />
							     	</td>
									<s:if test="!isReadonly()">
								    <td style="width:40px;text-align: center;vertical-align: middle;">
					          			<s:if test="isNewest">
									    	<input type="button" id="addCar" 
									    		value="+" style="width:2em;height:2em;"/><br><input id="removeCar" type="button" value="-" 
									    	style="width:2em;height:2em;"/><br>
										    <input type="button" id="upCar" value="↑" style="width:2em;height:2em;"/><br><input 
										    type="button" id="downCar" value="↓" style="width:2em;height:2em;"/>
										</s:if>
									</td>
									</s:if>
							    </tr>
						    </table>
					    <td>
					</tr>
					<tr>
						<td class="label">*<s:text name="shiftworkByDriver.dbhtq"/>:</td>
						<td class="value">
							<div class="bc-dateContainer">
								&nbsp;从<input type="text" name="e.moveDate" 
								  data-validate='{"type":"date","required":false}' 
									value='<s:date format="yyyy-MM-dd" name="e.moveDate" />' 
									style="width: 9em;" class="bc-date ui-widget-content" />
									<ul class="inputIcons" style="right : 0px;">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.moveDate' ></li>
									</ul>
							</div>
				        	<div class="bc-dateContainer">
								&nbsp;到<input type="text" name="e.endDate"  data-validate='{"type":"date","required":true}'
									value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
									style="width: 9em;" class="bc-date ui-widget-content" />
									<ul class="inputIcons" style="right : 0px;">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.endDate' ></li>
									</ul>
							</div>
				       </td>
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="carByDriverHistory.description"/>:</td>
						<td class="value"><s:textarea name="e.description" rows="5" cssClass="ui-widget-content noresize"/></td>
					</tr>
					<tr>
						<td class="label" colspan="2">
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
		<s:hidden name="e.status" />
		<s:hidden name="e.moveType" />
		<s:hidden name="e.driver.id" />
		<s:hidden id="header" value="%{e.driver.name}"/>
		<s:hidden name="e.author.id" />
		<s:hidden name="e.modifier.id"/>
		<s:hidden name="e.fromCar.id"/>
		<s:hidden name="e.toCar.id"/>
		<s:hidden name="e.shiftwork" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>