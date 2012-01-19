<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="caseAdvice.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/caseAdvice/save" />'
	data-js='<s:url value="/bc-business/caseAdvice/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.caseAdviceForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow: hidden;">
	<s:form name="caseAdviceForm" theme="simple">
	<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset" data-cfg="{height:380}"
		style="width:810px;overflow: hidden;">
        <div class="tabsContainer">
			<div class="slideContainer">
				<ul class="tabs ui-helper-reset">
	   				<li class="tab ui-widget-content first active"><a href="#otherFormFields1" class="ui-state-default ui-state-active">详细信息</a></li>
					<li class="tab ui-widget-content"><a href="#otherFormFields2" class="ui-state-default">处理情况</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">回发企业意见</a></li>
	          	</ul>
           	</div>
        </div>
        <div class="contentContainer ui-helper-reset ui-widget-content">
			<div id="otherFormFields1" class="content active">
				<table cellspacing="2" cellpadding="0">
					<tbody>
						<tr>
							<td colspan="4">
							    <fieldset class="ui-widget-content">
							    	<legend>投诉信息</legend>
							    	<table class="formFields" cellspacing="2" cellpadding="0">
										<tr class="widthMarker">
											<td style="width: 80px;">&nbsp;</td>
											<td style="width: 295px;">&nbsp;</td>
											<td style="width: 85px;">&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td class="label">*<s:text name="runcase.code" />:</td>
											<td class="value "><s:textfield name="e.code" data-validate="required" readonly="true" cssClass="ui-widget-content"/></td>
											<td class="label">*<s:text name="runcase.receiveDate3"/>:</td>
											<td class="value" style="position:relative;display: block;">
												<input type="text" name="e.receiveDate" data-validate='{"type":"datetime","required":true}'
												value='<s:date format="yyyy-MM-dd hh:mm:ss" name="e.receiveDate" />'
												class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true,timeFormat:"hh:mm:ss"}'/>
												<ul class="inputIcons">
													<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.receiveDate'></li>
												</ul>
											</td>
										<tr>
											<td class="label"><s:text name="runcase.receiveCode"/>:</td>
											<td class="value "><s:textfield name="e.receiveCode" cssClass="ui-widget-content"/></td>
											<td class="label">*<s:text name="runcase.adviceType"/>:</td>
											<td class="value">
												<s:select list="#{0:getText('runcase.select.complain'),1:getText('runcase.select.suggest')}"
													 cssStyle="width:100%;height:100%;" value="selected" data-validate="required"
													multiple="%{multiple}" name="e.adviceType" cssClass="ui-widget-content"/>
											</td>
										</tr>
							    		<tr>
							    			<td class="label">*<s:text name="runcase.subject2"/><s:text name="runcase.big"/>:</td>
											<td class="value relative">
												<s:textfield name="e.subject" data-validate="required" cssClass="ui-widget-content"/>
												<ul class="inputIcons">
											 		<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectSubject">
											 	</ul>
											</td>
											<td class="label">*<s:text name="runcase.happenDate"/>:</td>
											<td class="value" style="position:relative;display: block;">
												<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
												value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.happenDate" />'
												class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true,timeFormat:"hh:mm:ss"}'/>
												<ul class="inputIcons">
													<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.happenDate'></li>
												</ul>
											</td>
							    		</tr>
							    		<tr>
							    			<td class="label"><s:text name="runcase.subject2"/><s:text name="runcase.small"/>:</td>
											<td class="value"><s:textfield name="e.subject2" cssClass="ui-widget-content"/></td>
							    			<td class="label" ><s:text name="runcase.source"/>:</td>
											<td class="value" >
												<s:textfield name="e.from" cssClass="ui-widget-content" cssStyle="width: 15em" />(<s:property value="sourceStr"/>)
											</td>
										</tr>
										<tr>
											<td class="topLabel">
												<s:text name="runcase.detail"/>:
											</td>
											<td class="value" colspan="3"><s:textarea name="e.detail" cssStyle="width:50.8em;" rows="4" cssClass="ui-widget-content"/></td>
										</tr>
							    	</table>
							    </fieldset>
							</td>
						</tr>
						<tr>
							<td class="label" colspan="4">
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
							</td>
						</tr>
						<tr>
							<td colspan="2">
							    <fieldset class="ui-widget-content" style="height: 115px;">
							    	<legend>被投诉方信息</legend>
							        <table class="formFields" cellspacing="2" cellpadding="0" style="height:100px; width: 100%;">
										<tr class="widthMarker">
											<td >&nbsp;</td>
											<td style="width: 200px;"></td>
											<td style="width: 80px;"></td>
											<td style="width: 200px;"></td>
										</tr>
										<tr>
							               	<td class="label"><s:text name="runcase.carPlate"/>:</td>
											<td class="value" colspan="3">
												<div style="position:relative;display: inline-block" >
													<s:textfield name="e.carPlate" readonly="true" cssStyle="width:8em;"  cssClass="ui-widget-content "/>
													<ul class="inputIcons">
												 		<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectCarPlate">
												 	</ul>
											 	</div>
											 	<s:text name="runcase.carColor"/>:
											 	<s:textfield name="e.carColor" cssStyle="width:3em;"  cssClass="ui-widget-content"/>
											</td>
						               </tr>
						               <tr>
						               		<td class="label"><s:text name="runcase.driverName"/>:</td>
											<td class="value" colspan="3">
												<div style="position:relative;display: inline-block" >
													<s:textfield name="e.driverName" cssStyle="width:8em;" readonly="true" cssClass="ui-widget-content "/>
													<ul class="inputIcons">
											 			<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectDriverName">
											 		</ul>
												</div>
												<s:radio name="e.driverSex" list="#{'1':'男','2':'女'}" 
												value="e.sex" cssStyle="width:auto;"/>
											</td>
					                   </tr>
					                   <tr>
					                   		<td class="label" ><s:text name="runcase.motorcadeName"/>:</td>
											<td class="value" colspan="3">
												<s:select name="e.motorcadeId" list="motorcadeList" listKey="key" listValue="value" value="e.motorcadeId" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
											</td>
					                   </tr>
							        </table>
							   </fieldset>
							</td>
							<td colspan="2">
								<fieldset class="ui-widget-content" style="height: 115px;">
					          		<legend>投诉人信息</legend>
					          		<table class="formFields" cellspacing="2" cellpadding="0" style="height:100px;width: 100%;">
							          	<tr class="widthMarker">
											<td >&nbsp;</td>
											<td style="width: 200px;"></td>
											<td style="width: 80px;"></td>
											<td style="width: 200px;"></td>
										</tr>
							          	<tr>
							          		<td class="label">*<s:text name="runcase.advisorName" />:</td>
											<td class="value" colspan="3">
												<s:textfield name="e.advisorName" cssStyle="width:8em;" data-validate="required" cssClass="ui-widget-content"/>
												 <s:radio name="e.advisorSex" list="#{'1':'男','2':'女'}" 
												value="e.sex" cssStyle="width:auto;"/>
												<s:text name="runcase.advisorAge" />:<s:textfield name="e.advisorAge" cssStyle="width:2.5em;" cssClass="ui-widget-content"/>
											</td>
						                </tr>
						                <tr>
						                	<td class="label">*<s:text name="runcase.advisorPhone" />:</td>
						                	<td class="value" colspan="3">
												<s:textfield name="e.advisorPhone" data-validate='{"type":"number" ,"required":true}' cssClass="ui-widget-content"/>
											</td>
						                </tr>
						                <tr>
						               		<td class="label"><s:text name="runcase.advisorCert" />:</td>
						                	<td class="value" colspan="3">
												<s:textfield name="e.advisorCert" cssClass="ui-widget-content"/>
											</td>
						                </tr>
					        		</table>
					    		</fieldset>
					    	</td>
						</tr>
						<tr>
							<td colspan="4">
								<fieldset class="ui-widget-content" style="padding:0;">
					          		<legend style="margin:10px;">补充信息</legend>
					          		<table class="formFields" style="padding-bottom: 10px;" cellspacing="2" cellpadding="0">
										<tr class="widthMarker">
											<td style="width: 80px;">&nbsp;</td>
											<td style="width: 295px;">&nbsp;</td>
											<td style="width: 80px;">&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
					          			<tr>
											<td class="label"><s:text name="runcase.driverCert"/>:</td>
											<td class="value"><s:textfield name="e.driverCert" cssClass="ui-widget-content"/></td>
											<td class="label"><s:text name="runcase.driverFeature"/>:</td>
											<td class="value"><s:textfield name="e.driverFeature" cssClass="ui-widget-content"/></td>
										</tr>
										<tr>
											<td class="label"><s:text name="runcase.machinePrice"/>:</td>
											<td class="value"><s:textfield name="e.machinePrice" value="%{getText('bs.format.number',{e.machinePrice})}" cssClass="ui-widget-content"/></td>
											<td class="label"><s:text name="runcase.ticket"/>:</td>
											<td class="value"><s:textfield name="e.ticket" cssClass="ui-widget-content"/></td>
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
														<td style="width: 275px;"><s:textfield name="e.pathFrom" cssStyle="width:98%;" cssClass="ui-widget-content"/></td>
														<td style="width: 85px;text-align: right;">到&nbsp;</td>
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
											<td class="label"><s:text name="runcase.charge"/>:</td>
											<td class="value"><s:textfield name="e.charge" value="%{getText('bs.format.number',{e.charge})}" cssClass="ui-widget-content"/></td>
										</tr>
										<tr>
											<td class="label"><s:text name="runcase.gongjiao"/>:</td>
											<td class="value" colspan="3"><s:textfield name="e.path" cssClass="ui-widget-content"/></td>
										</tr>
					          		</table>
						        </fieldset>
					        </td>
						</tr>
					</tbody>
				</table>
			</div>
			<div id="otherFormFields2" class="content">
				<table class="formFields" cellspacing="2" cellpadding="0" >
					<tbody>
						<tr class="widthMarker">
							<td>&nbsp;</td>
							<td style="width: 325px;">&nbsp;</td>
							<td style="width: 90px;">&nbsp;</td>
							<td style="width: 290px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.extent"/></td>
							<td class="value">
							<s:select name="e.extent" list="degreeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
							</td>
							<td class="label"><s:text name="runcase.receiverName2"/>:</td>
							<td class="value relative">
								<s:textfield name="e.receiverName" cssClass="ui-widget-content "/>
								<ul class="inputIcons">
							 		<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectReceiverName">
							 	</ul>
							</td>
						</tr>
						<tr>
							<td class="label" ><s:text name="runcase.duty"/>:</td>
							<td class="value">
								<s:select name="e.duty" list="dutyList" listKey="value" listValue="value"  headerKey="" headerValue="" cssStyle="width:15em;" cssClass="ui-widget-content"></s:select>
								<s:checkbox name="e.invalid" cssStyle="width:1em;" />
								<s:text name="runcase.invalid"/>
							</td>
							<td class="label"><s:text name="runcase.noticeDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.noticeDate" data-validate='{"type":"datetime"}'
								value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.noticeDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,timeFormat:"hh:mm:ss"}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.noticeDate'></li>
								</ul>
							</td>
						</tr>
						<s:if test="e.status == 1">
						<tr>
							<td class="label"><s:text name="runcase.deliverDate3"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.deliverDate" data-validate='{"type":"datetime"}'
								value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.deliverDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,timeFormat:"hh:mm:ss"}'/>
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
							<td><s:textarea name="e.result" cssStyle="width:24em;" rows="4" cssClass="ui-widget-content"/></td>
							<td class="topLabel"><s:text name="runcase.description"/>:</td>
							<td><s:textarea name="e.description" cssStyle="width:22em;" rows="4" cssClass="ui-widget-content"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
		
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
	<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>