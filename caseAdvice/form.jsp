<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div 
	<s:if test="%{e.type == 2}">
		title='<s:text name="caseAdvice1.title"/>' 
	</s:if>
	<s:elseif test="%{e.type == 6}">
		title='<s:text name="caseAdvice2.title"/>' 
	</s:elseif>
	data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/caseAdvice/save" />'
	data-js='<s:url value="/bc-business/caseAdvice/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.caseAdviceForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseAdviceForm" theme="simple">
		<div class="formTable2 ui-widget-content" style="width:670px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >车辆司机信息:</span>
				<span id="showGroups1" class="verticalMiddle ui-icon ui-icon-carat-1-s" title='<s:text name="runcase.title.click2ShowGroups"/>'></span>
			</div>
			<div id="div1">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td>&nbsp;</td>
							<td style="width: 250px;">&nbsp;</td>
							<td style="width: 85px;">&nbsp;</td>
							<td style="width: 250px;">&nbsp;</td>
						</tr>
						<tr>
			               	<td class="label"><s:text name="runcase.carPlate"/>:</td>
							<td class="value">
								<div style="position:relative;display:block" >
									<s:textfield name="e.carPlate" readonly="true" cssClass="ui-widget-content "/>
									<ul class="inputIcons">
								 		<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectCarPlate">
								 	</ul>
							 	</div>
							</td>
							<td class="label"><s:text name="runcase.carColor"/>:</td>
							<td class="value">
							 	<s:textfield name="e.carColor" cssClass="ui-widget-content"/>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.company"/>:</td>
							<td class="value"><s:textfield name="e.company" cssClass="ui-widget-content"/></td>
							<td class="label" ><s:text name="runcase.motorcadeName"/>:</td>
							<td class="value">
								<s:select name="e.motorcadeId" list="motorcadeList" listKey="key" listValue="value" value="e.motorcadeId" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.chargers"/>:</td>
							<td class="value relative">
								<s:textfield name="chargers" cssClass="ui-widget-content" readonly="true"/>
								<ul class="inputIcons">
									<li id="selectCharger" class="inputIcon ui-icon ui-icon-circle-plus" title='点击选择责任人'></li>
									<li class="clearSelect inputIcon ui-icon ui-icon-circle-close" data-cfg="chargers,e.charger" title='点击清除责任人'></li>
								</ul>
							</td>
							<td class="label"><s:text name="runcase.businessType"/>:</td>
							<td class="value"><s:textfield name="businessType" cssClass="ui-widget-content" readonly="true"/></td>
						</tr>
						<tr>
		               		<td class="label"><s:text name="runcase.driverName"/>:</td>
							<td class="value">
								<div style="position:relative;display: inline-block" >
									<s:textfield name="e.driverName" cssStyle="width:8em;" readonly="true" cssClass="ui-widget-content"/>
									<ul class="inputIcons">
							 			<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectDriverName">
							 		</ul>
								</div>
								<s:radio name="e.driverSex" list="#{'1':'男','2':'女'}" 
								value="e.sex" cssStyle="width:auto;"/>
							</td>
							<td class="label"><s:text name="runcase.driverCert"/>:</td>
							<td class="value"><s:textfield name="e.driverCert" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.driverFeature"/>:</td>
							<td class="value"><s:textfield name="e.driverFeature" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="runcase.birthDate"/>:</td>
							<td class="value"><input type="text" name="birthDate" value='<s:date format="yyyy-MM-dd" name="birthdate"/>'
							 class="ui-widget-content" readonly="readonly"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.origin"/>:</td>
							<td class="value"><s:textfield name="origin" cssClass="ui-widget-content" readonly="true"/></td>
							<td class="label"><s:text name="runcase.workDate"/>:</td>
							<td class="value"><input type="text" name="workDate" value='<s:date format="yyyy-MM-dd" name="workDate"/>'
							 class="ui-widget-content" readonly="readonly"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div style="width:670px;">
			<div class="formTopInfo">
				状态：<s:property value="%{statusesValue[e.status]}" />，
				<s:if test="%{e.closerName != null && e.closeDate && e.status == 1}">
					结案人:<s:property value="e.closerName" />(<s:date name="e.closeDate" format="yyyy-MM-dd HH:mm:ss"/>),
				</s:if>
				<s:if test="%{e.author.name != null}">
				登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
				</s:if>
				<s:if test="%{e.modifier != null}">
				，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
				</s:if>
			</div>
		</div>
		<div class="formTable2 ui-widget-content" style="width:670px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >投诉信息:</span>
				<span id="showGroups2" class="verticalMiddle ui-icon ui-icon-carat-1-s" title='<s:text name="runcase.title.click2ShowGroups"/>'></span>
			</div>
			<div id="div2">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td>&nbsp;</td>
							<td style="width: 250px;">&nbsp;</td>
							<td style="width: 85px;">&nbsp;</td>
							<td style="width: 250px;">&nbsp;</td>
						</tr>
						<tr>
			    			<td class="label">*<s:text name="runcase.subject2"/>:</td>
							<td class="value">
								<div style="position : relative; display: block">
									<s:textfield name="e.subject" data-validate="required" cssClass="ui-widget-content"/>
									<ul class="inputIcons">
							 			<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectSubject">
							 		</ul>
							 	</div>
							</td>
							<td class="label">*<s:text name="runcase.happenDate"/>:</td>
							<td class="value">
								<div style="position : relative; display: block">
									<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
									value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.happenDate" />'
									class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true,timeFormat:"hh:mm:ss"}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.happenDate'></li>
									</ul>
								</div>
							</td>
			    		</tr>
			    		<tr>
			    			<td class="label">*<s:text name="runcase.advisorName" />:</td>
							<td class="value">
								<s:textfield name="e.advisorName" cssStyle="width:8em;" data-validate="required" cssClass="ui-widget-content"/>
								 <s:radio name="e.advisorSex" list="#{'1':'男','2':'女'}" 
								value="e.sex" cssStyle="width:auto;"/>
								<s:text name="runcase.advisorAge" />:<s:textfield name="e.advisorAge" cssStyle="width:2.5em;" cssClass="ui-widget-content"/>
							</td>
							<s:if test="type == 2"><!-- 客管投诉 -->
								<td class="label">*<s:text name="runcase.receiveCode" />:</td> 
								<td class="value">
									<s:textfield name="e.receiveCode" data-validate="required" cssClass="ui-widget-content"/>
								</td>
							</s:if>
							<s:else><!-- 公司投诉 -->
								<td class="label"><s:text name="runcase.company.receiveCode" />:</td>
								<td class="value">
									<s:textfield name="e.receiveCode" cssClass="ui-widget-content"/>
								</td>
							</s:else>
						</tr>
						<tr>
							<td class="label">*<s:text name="runcase.advisorPhone" />:</td>
		                	<td class="value">
								<s:textfield name="e.advisorPhone" data-validate='{"type":"number" ,"required":true}' cssClass="ui-widget-content"/>
							</td>
		               		<td class="label"><s:text name="runcase.advisorCert" />:</td>
		                	<td class="value">
								<s:textfield name="e.advisorCert" cssClass="ui-widget-content"/>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.machinePrice"/>:</td>
							<td class="value"><s:textfield name="e.machinePrice" value="%{getText('bs.format.number',{e.machinePrice})}" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="runcase.charge"/>:</td>
							<td class="value"><s:textfield name="e.charge" value="%{getText('bs.format.number',{e.charge})}" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.ridingStartTime"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.ridingStartTime" data-validate='{"type":"datetime"}'
								value='<s:date format="yyyy-MM-dd hh:mm:ss" name="e.ridingStartTime" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true,timeFormat:"hh:mm:ss"}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.ridingStartTime'></li>
								</ul>
							</td>
							<td class="label"><s:text name="runcase.ridingEndTime"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.ridingEndTime" data-validate='{"type":"datetime"}'
								value='<s:date format="yyyy-MM-dd hh:mm:ss" name="e.ridingEndTime" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true,timeFormat:"hh:mm:ss"}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.ridingEndTime'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.path"/>:</td>
							<td class="value" colspan="3">
					      		<table style="width:100%;" cellspacing="0" cellpadding="0">
									<tr>
										<td style="width: 20px;">从</td>
										<td style="width: 255px;"><s:textfield name="e.pathFrom" cssStyle="width:87%;" cssClass="ui-widget-content"/></td>
										<td style="width: 61px;text-align: right;">到&nbsp;</td>
										<td><s:textfield name="e.pathTo" cssStyle="width:98%;" cssClass="ui-widget-content"/></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.passengerCount"/>:</td>
							<td class="value"><s:textfield name="e.passengerCount" cssStyle="width:2.5em;" data-validate='{"type":"number",max:9}' cssClass="ui-widget-content"/>&nbsp;男<s:textfield name="e.passengerManCount" data-validate='{"type":"number",max:9}' cssStyle="width:2.5em;" cssClass="ui-widget-content"/>&nbsp;女
							<s:textfield name="e.passengerWomanCount" cssStyle="width:2.5em;" data-validate='{"type":"number",max:9}' cssClass="ui-widget-content" />&nbsp;童<s:textfield name="e.passengerChildCount"cssStyle="width:2.5em;" data-validate='{"type":"number",max:9}' cssClass="ui-widget-content"/>
							</td>
							<td class="label"><s:text name="runcase.ticket"/>:</td>
							<td class="value"><s:textfield name="e.ticket" cssClass="ui-widget-content"/></td>
						</tr>
						<s:if test="%{e.path != null}">
							<tr>
								<td class="label"><s:text name="runcase.gongjiao"/>:</td>
								<td class="value" colspan="3"><s:textfield name="e.path" cssClass="ui-widget-content"/></td>
							</tr>
						</s:if>
						<tr>
							<td class="label" ><s:text name="runcase.source"/>:</td>
							<td class="value" colspan="3">
								<s:textfield name="e.from" cssClass="ui-widget-content" cssStyle="width: 38em" />(<s:property value="sourceStr"/>)
							</td>
						</tr>
						<tr>
							<td class="topLabel">
								<s:text name="runcase.detail"/>:
							</td>
							<td class="value" colspan="3"><s:textarea name="e.detail" rows="4" cssClass="ui-widget-content noresize"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="formTable2 ui-widget-content" style="width:670px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >处理信息:</span>
				<span id="showGroups3" class="verticalMiddle ui-icon ui-icon-carat-1-s" title='<s:text name="runcase.title.click2ShowGroups"/>'></span>
			</div>
			<div id="div3" class="content">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td>&nbsp;</td>
							<td style="width: 250px;">&nbsp;</td>
							<td style="width: 85px;">&nbsp;</td>
							<td style="width: 250px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.extent"/>:</td>
							<td class="value">
							<s:select name="e.extent" list="degreeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
							</td>
							<td class="label" ><s:text name="runcase.duty"/>:</td>
							<td class="value">
								<s:select name="e.duty" list="dutyList" listKey="value" listValue="value"  headerKey="" headerValue="" cssStyle="width:8em;" cssClass="ui-widget-content"></s:select>
								<s:checkbox name="e.invalid" cssStyle="width:1em;" />
								<s:text name="runcase.invalid"/>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.dedit"/>:</td>
							<td class="value"><s:textfield name="e.dedit" value="%{getText('bs.format.number',{e.dedit})}" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="runcase.noticeDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.noticeDate" data-validate='{"type":"datetime"}'
								value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.noticeDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,timeFormat:"hh:mm:ss",showSecond:true}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.noticeDate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.stopProduction"/>:</td>
							<td class="value">
								<s:select name="e.stopProduction" list='#{"1":"一天","2":"二天","3":"三天","4":"四天",
								"5":"五天"}' cssClass="ui-widget-content" listKey="key" listValue="value"/>
							</td>
							<td class="label"><s:text name="runcase.study"/>:</td>
							<td class="value">
								<s:select name="e.study" list='#{"1":"一天","2":"二天","3":"三天","4":"四天",
								"5":"五天"}' cssClass="ui-widget-content" listKey="key" listValue="value"/>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.transactorName"/>:</td>
							<td class="value relative">
								<s:textfield name="e.transactorName" cssClass="ui-widget-content "/>
								<ul class="inputIcons">
							 		<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectTransactorName">
							 	</ul>
							</td>
							<td class="label"><s:text name="runcase.branchChargerName"/>:</td>
							<td class="value relative">
								<s:textfield name="e.branchChargerName" cssClass="ui-widget-content"/>
								<ul class="inputIcons">
							 		<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectBranchChargerName">
							 	</ul>
						 	</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.companyApprovalName"/>:</td>
							<td class="value relative">
								<s:textfield name="e.companyApprovalName" cssClass="ui-widget-content"/>
								<ul class="inputIcons">
							 		<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectCompanyApprovalName">
							 	</ul>
							</td>	
							<td class="label"><s:text name="runcase.driverRating"/>:</td>
							<td class="value"><s:textfield name="e.driverRating" cssClass="ui-widget-content"/></td>
						</tr>
						<s:if test="e.status == 1">
							<tr>
								<td class="label"><s:text name="runcase.deliverDate3"/>:</td>
								<td class="value" style="position:relative;display: block;">
									<input type="text" name="e.deliverDate" data-validate='{"type":"datetime"}'
									value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.deliverDate" />'
									class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,timeFormat:"hh:mm:ss",showSecond:true}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.deliverDate'></li>
									</ul>
								</td>
								<td></td>
								<td></td>
							</tr>
						</s:if>
						<tr>
							<td class="topLabel"><s:text name="runcase.result"/>:</td>
							<td class="value" colspan="3"><s:textarea name="e.result" rows="4" cssClass="ui-widget-content noresize"/></td>
						</tr>
						<tr>
							<td class="topLabel"><s:text name="runcase.description"/>:</td>
							<td class="value" colspan="3"><s:textarea name="e.description" rows="4" cssClass="ui-widget-content noresize"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<s:if test="%{e.type == 6 && e.handleStatus == 1}">
			<div class="formTable2 ui-widget-content" style="width:670px;">
				<div class="ui-widget-header title" style="position:relative;">
					<span class="text" >核准信息:</span>
					<span id="showGroups4" class="verticalMiddle ui-icon ui-icon-carat-1-s" title='<s:text name="runcase.title.click2ShowGroups"/>'></span>
				</div>
				<div id="div4" class="content">
					<table class="formFields" cellspacing="2" cellpadding="0">
						<tbody>
							<tr class="widthMarker">
								<td>&nbsp;</td>
								<td style="width: 250px;">&nbsp;</td>
								<td style="width: 85px;">&nbsp;</td>
								<td style="width: 250px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.handlerName"/>:</td>
								<td class="value"><s:textfield name="e.handlerName" cssClass="ui-widget-content" readonly="true"/></td>
								<td class="label"><s:text name="runcase.handleDate"/>:</td>
								<td class="value">
									<input type="text" name="e.handleDate"
									value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.handleDate" />' readonly="readonly"
									class="ui-widget-content" />
								</td>
							</tr>
							<tr>
								<td class="topLabel"><s:text name="runcase.handleOpinion"/>:</td>
								<td class="value" colspan="3"><s:textarea name="e.handleOpinion" rows="4" cssClass="ui-widget-content noresize"/></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			
		</s:if>
	<s:hidden name="e.uid" />
	<s:hidden name="e.id" />
	<s:hidden name="e.author.id" />
	<s:hidden name="e.motorcadeName" />
	<s:hidden name="e.carId" />
	<s:hidden name="e.driverId" />
	<!--
	<s:hidden name="e.chargerId" />
	!-->
	<s:hidden name="e.closerId" />
	<s:hidden name="e.closerName" />
	<s:hidden name="e.receiverId" />
	<s:hidden name="e.status" />
	<s:hidden name="isMoreCar" />
	<s:hidden name="isMoreCarMan" />
	<s:hidden name="carId" />
	<s:hidden name="carManId" />
	<s:hidden name="isNullCarMan" />
	<s:hidden name="isNullCar" />
	<s:hidden name="e.source"/>
	<s:hidden name="e.syncUid" />
	<s:hidden name="e.syncId" />
	<s:hidden name="isSync" />
	<s:hidden name="syncId" />
	<s:hidden name="e.type" />
	<s:hidden name="e.branchChargerId" />
	<s:hidden name="e.companyApprovalId" />
	<s:hidden name="e.charger"/>
	<s:hidden name="e.handlerId"/>
	<s:hidden name="e.handleStatus"/>
	
	<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	
	<!-- 曾显示,现屏蔽 -->
	<s:hidden name="e.code" />
	<s:hidden name="e.subject2" />
	<input type="hidden" name="e.receiveDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.receiveDate" />'/>
	<s:hidden name="e.adviceType" value="0" />
		
	</s:form>
</div>