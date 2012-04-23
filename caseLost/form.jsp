<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div 
	title='<s:text name="caseLost.title"/>' 
	data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/caseLost/save" />'
	data-js='<s:url value="/bc-business/caseLost/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.caseLostForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseLostForm" theme="simple">
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >车辆司机信息:</span>
				<span id="showGroups1" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="runcase.title.click2HiddenGroups"/>'></span>
			</div>
			<div id="div1">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 90px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
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
							<td class="label" ><s:text name="runcase.motorcadeName"/>:</td>
							<td class="value">
								<s:select name="e.motorcadeId" list="motorcadeList" listKey="key" listValue="value" value="e.motorcadeId" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
							</td>
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
								value="e.driverSex" cssStyle="width:auto;"/>
							</td>
							<td class="label"><s:text name="runcase.company"/>:</td>
							<td class="value"><s:textfield name="e.company" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.driverCert"/>:</td>
							<td class="value"><s:textfield name="e.driverCert" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="runcase.lost.driverFeature"/>:</td>
							<td class="value"><s:textfield name="e.driverFeature" cssClass="ui-widget-content"/></td>
							
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div style="width:710px;">
			<div class="formTopInfo">
				状态：<s:property value="%{statusesValue[e.status]}" />，
				<s:if test="%{e.closerName != null && e.status == 1}">
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
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >报失信息:</span>
				<span id="showGroups2" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="runcase.title.click2HiddenGroups"/>'></span>
			</div>
			<div id="div2">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 90px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
						</tr>
						<tr>
			    			<td class="label">*<s:text name="runcase.receiveCode"/>:</td>
							<td class="value">
								<s:textfield name="e.code" data-validate="required" cssClass="ui-widget-content"/>
							</td>
							<td class="label">*<s:text name="runcase.lost.receiveDate"/>:</td>
							<td class="value">
								<div style="position : relative; display: block">
									<input type="text" name="e.receiveDate" data-validate='{"type":"datetime","required":true}'
									value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.receiveDate" />'
									class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true,timeFormat:"hh:mm:ss"}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.receiveDate'></li>
									</ul>
								</div>
							</td>
			    		</tr>
			    		<tr>
			    			<td class="label">*<s:text name="runcase.lost.ownerName" />:</td>
							<td class="value">
								<s:textfield name="e.ownerName" cssStyle="width:8em;" data-validate="required" cssClass="ui-widget-content"/>
								 <s:radio name="e.ownerSex" list="#{'1':'男','2':'女'}" 
								value="e.ownerSex" cssStyle="width:auto;"/>
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
							<td class="label">*<s:text name="runcase.lost.ownerTel" />:</td>
		                	<td class="value">
								<s:textfield name="e.ownerTel" data-validate='{"type":"number" ,"required":true}' cssClass="ui-widget-content"/>
							</td>
							<td class="label" ><s:text name="runcase.source"/>:</td>
							<td class="value">
								<s:select name="e.from" list="fromList" listKey="value" listValue="value" cssClass="ui-widget-content"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.lost.items" />:</td>
		                	<td class="value">
								<s:textfield name="e.items" cssClass="ui-widget-content"/>
							</td>
							<td class="label" ><s:text name="runcase.lost.money"/>:</td>
							<td class="value">
								<s:textfield name="e.money" data-validate='{"type":"number"}' value="%{getText('bs.format.number',{e.money})}" cssClass="ui-widget-content" />
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.lost.level"/>:</td>
							<td class="value">
								<s:select name="e.level" list="levelList" listKey="key" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
							</td>
							<td class="label"><s:text name="runcase.lost.sitePostion"/>:</td>
							<td class="value">
								<s:select name="e.sitePostion" list="sitePostionList" listKey="key" listValue="value" headerKey="" cssClass="ui-widget-content"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.lost.machinePrice"/>:</td>
							<td class="value"><s:textfield name="e.machinePrice" value="%{getText('bs.format.number',{e.machinePrice})}" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="runcase.lost.charge"/>:</td>
							<td class="value"><s:textfield name="e.charge" value="%{getText('bs.format.number',{e.charge})}" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.lost.passengerCount"/>:</td>
							<td class="value">
								<s:textfield name="e.passengerCount"  data-validate='{"type":"number",max:9}' cssClass="ui-widget-content"/>
							</td>
							<td class="label"><s:text name="runcase.lost.ticket"/>:</td>
							<td class="value"><s:textfield name="e.ticket" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.lost.path"/>:</td>
							<td class="value" colspan="3">
								<s:textfield name="e.path" cssStyle="width:98%;" cssClass="ui-widget-content"/>
							</td>
						</tr>
						<tr>
							<td class="topLabel">
								<s:text name="runcase.description"/>:
							</td>
							<td class="value" colspan="3"><s:textarea name="e.description" rows="4" cssClass="ui-widget-content noresize"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >处理信息:</span>
				<span id="showGroups3" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="runcase.title.click2HiddenGroups"/>'></span>
			</div>
			<div id="div3" class="content">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 90px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.lost.result"/>:</td>
							<td class="value">
								<s:select name="e.result" list="resultList" listKey="key" listValue="value" cssClass="ui-widget-content"/>
							</td>
							<td class="label"><s:text name="runcase.lost.retrunDate"/>:</td>
							<td class="value">
								<div style="position : relative; display: block">
									<input type="text" name="e.retrunDate" data-validate='{"type":"datetime"}'
									value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.retrunDate" />'
									class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true,timeFormat:"hh:mm:ss"}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.retrunDate'></li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.lost.handleResult"/>:</td>
							<td class="value">
								<s:select name="e.handleResult" list="handleResultList" listKey="key" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" />
							</td>
							<td class="label"><s:text name="runcase.lost.replyDate"/>:</td>
							<td class="value">
								<div style="position : relative; display: block">
									<input type="text" name="e.replyDate" data-validate='{"type":"datetime"}'
									value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.replyDate" />'
									class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true,timeFormat:"hh:mm:ss"}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.replyDate'></li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.lost.transactorName"/>:</td>
							<td class="value relative">
								<s:textfield name="e.transactorName" cssClass="ui-widget-content"/>
								<ul class="inputIcons">
							 		<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectTransactorName">
							 	</ul>
							</td>	
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >领取:<s:checkbox name="e.took" cssStyle="width:1em;" id="tookId" /></span>
				<span id="showGroups4" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="runcase.title.click2HiddenGroups"/>'></span>
			</div>
			<div id="div4" class="content">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 90px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
						</tr>
						<tr>
			          		<td class="label"><s:text name="runcase.lost.takerName" />:</td>
							<td class="value">
								<s:textfield name="e.takerName" cssStyle="width:8em;"  cssClass="ui-widget-content"/>
								 <s:radio name="e.takerSex" list="#{'1':'男','2':'女'}" 
								value="e.takerSex" cssStyle="width:auto;"/>
								<s:text name="runcase.advisorAge" />:<s:textfield name="e.takerAge" cssStyle="width:2.5em;" cssClass="ui-widget-content"/>
							</td>
							<td class="label"><s:text name="runcase.lost.tookDate"/>:</td>
							<td class="value">
								<div style="position : relative; display: block">
									<input type="text" name="e.tookDate" data-validate='{"type":"datetime"}'
									value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.tookDate" />'
									class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true,timeFormat:"hh:mm:ss"}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.tookDate'></li>
									</ul>
								</div>
							</td>
		                </tr>
		                <tr>
		                	<td class="label"><s:text name="runcase.lost.takerUnit"/>:</td>
							<td class="value"><s:textfield name="e.takerUnit" cssClass="ui-widget-content"/></td>
		                	<td class="label"><s:text name="runcase.lost.takerTel"/>:</td>
							<td class="value"><s:textfield name="e.takerTel" cssClass="ui-widget-content"/></td>
		                </tr>
		                <tr>
		                	<td class="label"><s:text name="runcase.lost.takerIdentity"/>:</td>
							<td class="value"><s:textfield name="e.takerIdentity" cssClass="ui-widget-content"/></td>
		                </tr>
						<tr>
							<td class="topLabel"><s:text name="runcase.description"/>:</td>
							<td class="value" colspan="3"><s:textarea name="e.desc2" rows="4" cssClass="ui-widget-content noresize"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	<s:hidden name="e.uid" />
	<s:hidden name="e.id" />
	<s:hidden name="e.author.id" />
	<s:hidden name="e.motorcadeName" />
	<s:hidden name="e.carId" />
	<s:hidden name="e.driverId" />
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
	<s:hidden name="e.type" />
	<s:hidden name="e.transactorId" />
	
	<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	
	</s:form>
</div>