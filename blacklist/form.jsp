<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="blacklist.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/blacklist/save" />'
	data-js='<s:url value="/bc/libs/select.js" />,<s:url value="/bc-business/blacklist/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/carMan/select.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.business.blacklistForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="blacklistForm" theme="simple">
			<table class="formFields ui-widget-content" cellspacing="2" cellpadding="0" style="width:640px">
				<tbody>
					<tr class="widthMarker">
						<td style="width: 80px;">&nbsp;</td>
						<td style="width: 240px;">&nbsp;</td>
						<td style="width: 80px;">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="blacklist.subject"/>:</td>
						<td class="value " colspan="3"><s:textfield name="e.subject"  data-validate="required" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
					   <td class="label">*<s:text name="blacklist.car.plateNo"/>:</td>
					<s:if test="%{carManId != null || carId !=null }">
						<td class="value"><s:textfield name="plate" value="%{e.car.plateType+'.'+e.car.plateNo }" readonly="true" cssClass="ui-widget-content"/></td>
					    </s:if><s:else>
						<!--<td class="value" style="position:relative;display: block;"><s:textfield name="plate" value="%{e.car.plateType+'.'+e.car.plateNo }"
					    data-validate="required" cssClass="ui-widget-content" readonly="true" />
					    <span id="selectCar" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></span>
					    </td>--> 
						<td class="value relative">
							<div class="input ui-widget-content" data-validate="required" ><span class="link showCar" data-cfg='<s:property value="e.car.id" />' id="carInfo" ><s:property value="%{e.car.plateType+'.'+e.car.plateNo }" /></span>
							</div>
					    <span id="selectCar" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" style="margin: -8px 0.5px;" title='<s:text name="title.click2select"/>'></span>
					    </td> 
                        <!--<td class="value relative">
					      <div class="input ui-widget-content" data-validate="required" ><span class="link showCar" data-cfg='<s:property value="e.car.id" />' id="carInfo" ><s:property value="%{e.car.plateType+'.'+e.car.plateNo }" /></span>
					      </div>
					      <ul class="inputIcons">
					        <li class="selectCar inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>' data-cfg='e.car.id=id,carInfo=plate|text,carInfo=id|attr'></li>
					      </ul>
                        </td> -->
					    </s:else>
						<td class="label"><s:text name="blacklist.company4Happen"/>:</td>
						<td class="value"><s:textfield name="e.company" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="blacklist.driver"/>:</td>
						<td class="value relative">
							<!--<s:textfield name="drivers" cssClass="ui-widget-content" readonly="true"/>
							<ul class="inputIcons">
								<li id="selectdriverName" class="inputIcon ui-icon ui-icon-circle-plus" title='点击选择司机'></li>
								<li class="clearSelect inputIcon ui-icon ui-icon-circle-close" data-cfg="drivers,e.drivers" title='点击清除司机'></li>
							</ul>-->
							<div id="assignDrivers" style="position:relative;margin: 0;padding: 0;" class="input ui-widget-content" 
								data-removeTitle='<s:text name="title.click2remove" />'>
								<span id="addDrivers" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" style="" title='<s:text name="blacklist.title.click2selectCarMan"/>'></span>
								<s:if test="%{driversInfoList != null && !driversInfoList.isEmpty()}">
									<ul class="horizontal" style="padding: 0;">
									<s:iterator value="driversInfoList">
									<li class="horizontal" style="position: relative;margin:0 2px;float: left;padding: 0;"
										data-id=<s:property value="['id']" /> data-classes=<s:property value="['classes']" />>
									<span class="text"><a href="#" style="color: #1F1F1F;"><s:property value="['name']" /></a></span>
									<s:if test="!isReadonly()">
										<span class="click2remove verticalMiddle ui-icon ui-icon-close" style="margin: -8px -2px;" title='<s:text name="title.click2remove"/>'></span>
									</s:if>
									</li>
									</s:iterator>
									</ul>
								</s:if>	
							</div>
						</td>
					    <td class="label">*<s:text name="blacklist.motorcade4Happen.name"/>:</td>
						<td class="value"><s:select name="e.motorcade.id" list="motorcadeList" listKey="key" listValue="value" value="e.motorcade.id" data-validate="required"
							headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" ></s:select></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="blacklist.level"/>:</td>
						<td class="value" ><s:select list="blackLevelList" listKey="value" listValue="value" headerKey="" 
							headerValue="" name="e.level" cssClass="ui-widget-content"></s:select></td>
						<td class="label" ><s:text name="blacklist.relatedDepartmennts"/>:</td>
						<td class="value" ><s:select list="relatedDepartmenntsList" listKey="id" listValue="name" headerKey="" 
							headerValue="" name="e.relatedDepartmenntsId" cssClass="ui-widget-content"></s:select></td>
						<!--  <td class="label"><s:text name="blacklist.code"/>:</td>
						<td class="value"><s:textfield name="e.code" cssClass="ui-widget-content"/></td>-->
					</tr>
					<tr>
						<td class="label">*<s:text name="blacklist.type"/>:</td>
						<td class="value" colspan="3"><s:select list="blackTypeList" listKey="value" listValue="value" headerKey="" headerValue="%{getText('label.please.choose')}" name="e.type" 
							data-validate="required" cssClass="ui-widget-content" cssStyle="width: 29%;"></s:select><div class="bc-relativeContainer" style="width:4%;text-align:right;">从</div>	
							<div style="display: inline-block;width: 22.3%;" class="relative">
								<input type="text" name="e.appointDate" data-validate='{"type":"date","required":false}'
								value='<s:date format="yyyy-MM-dd" name="e.appointDate" />' class="bc-date ui-widget-content"/>
								<ul class="inputIcons" >
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.appointDate' ></li>
								</ul>
							</div>
							<div class="bc-relativeContainer" style="width:14%;text-align:center;">起变为:</div><s:select list="blackTypeList" listKey="value" listValue="value" headerKey="" headerValue="%{getText('label.please.choose')}" name="e.conversionType" 
							 cssClass="ui-widget-content" cssStyle="width: 28.5%;"></s:select>
						</td>
					</tr>
					<tr>
						<td class="label" colspan="2" style="text-align:left;">
						    <fieldset style="width:320px;height: 255px;padding: 5px;" class="ui-widget-content">
						          <legend>锁定原因</legend>
						          <s:textarea name="e.lockReason" rows="10" cssClass="ui-widget-content noresize" cssStyle="width:100%;box-sizing: border-box;"/>
						          <div class="label" style="text-align: right;"><s:text name="blacklist.locker.name"/>:<s:property value="e.locker.name" />(<s:date name="e.lockDate" format="yyyy-MM-dd HH:mm:ss"/>)</div>
						   </fieldset>
						</td>
						<td class="value" colspan="2" >
						    <fieldset style="width:320px;;height: 255px;padding: 5px;" class="ui-widget-content">
						          <legend>解锁原因</legend>
 						          <s:if test="e.status!=1" >
 						          	<s:textarea name="e.unlockReason" rows="10" cssClass="ui-widget-content noresize" cssStyle="width:100%;box-sizing: border-box;"/>
					               </s:if><s:else >
					               	<s:textarea name="e.unlockReason" rows="10" cssClass="ui-widget-content noresize" data-validate="required"/>
						          	<div class="label" style="text-align: right;"><s:text name="blacklist.unlocker.name"/>:<s:property value="e.unlocker.name" />(<s:date name="e.unlockDate" format="yyyy-MM-dd HH:mm:ss"/>)</div>
					                     </s:else>
						    </fieldset>
						</td>
					</tr>
					<tr>
						<td class="label" colspan="4">
							<div class="formTopInfo">
							        <s:if test="%{e.isNew()}">
							               状态：新建
							        </s:if><s:else>
							               状态：<s:property value="%{statusesValue[e.status]}" /> ,
							        </s:else>
									登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
									<s:if test="%{e.modifier != null}">
									最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
									</s:if>
						   </div>
						</td>
					</tr>
				</tbody>
			</table>
		<s:hidden name="e.id" />
		<s:hidden name="e.locker.id" />
		<s:hidden name="e.unlocker.id" />
		<s:hidden name="e.car.id" />
		<s:hidden name="e.drivers" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.modifier.id"/>
		<s:hidden name="e.status"/>
		<s:hidden name="isNullCarMan" />
		<s:hidden name="isNullCar" />
		<s:hidden name="isMoreCar" />
		<s:hidden name="isMoreCarMan" />
		<s:hidden name="carManId" />
		<s:hidden name="carId" />
		<s:hidden name="e.code" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		<input type="hidden" name="e.lockDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.lockDate" />'/>
		<input type="hidden" name="e.unlockDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.unlockDate" />'/>
	</s:form>
</div>