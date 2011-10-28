<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="caseAdvice.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/caseAdvice/save" />'
	data-js='<s:url value="/bc-business/caseAdvice/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.caseAdviceForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseAdviceForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:800px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr style="line-height: 1px;">
						<td></td>
						<td style="width: 350px;">&nbsp;</td>
						<td style="width: 60px;">&nbsp;</td>
						<td style="width: 350px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.code" />:</td>
						<td class="value "><s:textfield name="e.code" data-validate="required" /></td>
						<td class="label">*<s:text name="runcase.receiveDate3"/>:</td>
						<td class="value">
							<input type="text" name="e.receiveDate" data-validate='{"type":"datetime","required":true}'
							value='<s:date format="yyyy-MM-dd HH:mm" name="e.receiveDate" />'
							class="bc-datetime" data-cfg='{changeYear:true}'/>
						</td>
					<tr>
						<td class="label"><s:text name="runcase.receiveCode"/>:</td>
						<td class="value "><s:textfield name="e.receiveCode"  /></td>
						<td class="label">*<s:text name="runcase.adviceType"/>:</td>
						<td class="value ">
							<s:select list="#{0:getText('runcase.select.complain'),1:getText('runcase.select.suggest')}"
								 cssStyle="width:100%;height:100%;" value="selected" data-validate="required"
								multiple="%{multiple}" />
							</td>
					</tr>
					<tr>
						<td class="label" colspan="4">
						    <fieldset>
						    	<legend>投诉项目</legend>
						    	<table class="formFields" cellspacing="2" cellpadding="0">
						    		<tr style="line-height: 1px;">
										<td></td>
										<td style="width: 380px;">&nbsp;</td>
										<td style="width: 20px;">&nbsp;</td>
										<td style="width: 130px;">&nbsp;</td>
									</tr>
						    		<tr>
						    			<td class="label">*<s:text name="runcase.subject2"/><s:text name="runcase.big"/>:</td>
										<td class="value">
										<div style="position:relative;">
											<s:textfield name="e.subject" cssStyle="width:29em;" data-validate="required" />
											<span id="selectSubject" class="verticalMiddle ui-icon ui-icon-circle-plus" style="margin-top : -7px;" title='<s:text name="runcase.title.click2selectcomplain"/>'></span>
										</div>
										</td>
										<td class="label">*<s:text name="runcase.happenDate"/>:</td>
										<td class="value">
											<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
											value='<s:date format="yyyy-MM-dd HH:mm" name="e.happenDate" />'
											class="bc-datetime" data-cfg='{changeYear:true}'/>
										</td>
						    		</tr>
						    		<tr>
						    			<td class="label"><s:text name="runcase.subject2"/><s:text name="runcase.small"/>:</td>
										<td class="value"><s:textfield name="e.subject2" cssStyle="width:29em;"/></td>
						    			<td class="label" ><s:text name="runcase.source"/>:</td>
										<td class="value" >
											<s:select name="e.from" list="sourceList" listKey="value" listValue="value" headerKey="" headerValue="" ></s:select>
										</td>
									</tr>
									<tr>
										<td class="label" style="text-align: left;" >
											<s:text name="runcase.detail"/>:
										</td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td class="value" colspan="4"><s:textarea name="e.detail" cssStyle="width:57em; text-align:left" rows="4" /></td>
										<td></td>
										<td></td>
										<td></td>
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
				</tbody>
			</table>
		</div>
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset" data-cfg="{height:230}"
			style="height:230px;width:800px;overflow: hidden;">
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
	        	<div id="otherFormFields1" class="content active" style="width:800px;">
					<table class="formFields" cellspacing="2" cellpadding="0" >
						<tbody>
							<tr>
								<td class="label" colspan="2">
								    <fieldset style="width:400px;height: 110px;">
								    	<legend>被投诉方信息</legend>
								        <table class="formFields" cellspacing="2" cellpadding="0" style="height:100px">
											<tr style="line-height: 1px;">
												<td style="width: 10px;"></td>
												<td style="width: 120px;">&nbsp;</td>
												<td style="width: 10px;">&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											<tr>
								               	<td class="label"><s:text name="runcase.carPlate"/>:</td>
												<td class="value">
													<s:textfield name="e.carPlate" readonly="true" />
												</td>
												<td class="label">
													<s:text name="runcase.carColor"/>:
												</td>
												<td class="value">
													<s:textfield name="e.carColor"  />
												</td>
							               </tr>
							               <tr>
							               		<td class="label"><s:text name="runcase.driverName" />:</td>
												<td class="value" colspan="3">
													<s:textfield name="e.driverName" cssStyle="width:9em;" />
													 <s:radio name="e.driverSex" list="#{'1':'男','2':'女'}" 
													value="e.sex" cssStyle="width:auto;"/>
												</td>
						                   </tr>
						                   <tr>
						                   		<td class="label" ><s:text name="runcase.motorcadeName"/>:</td>
												<td class="value" colspan="3">
													<s:select name="e.motorcadeId" list="motorcadeList" listKey="id" listValue="name" value="e.motorcadeId" headerKey="" headerValue=""  ></s:select>
												</td>
						                   </tr>
								        </table>
								   </fieldset>
								</td>
								<td class="value" colspan="2">
									<fieldset style="width:400px;height: 110px;">
						          		<legend>投诉人信息</legend>
						          		<table class="formFields" cellspacing="2" cellpadding="0" style="height:100px;">
								          	<tr style="line-height: 1px;">
												<td style="width: 10px;"></td>
												<td style="width: 120px;">&nbsp;</td>
												<td style="width: 10px;">&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
								          	<tr>
								          		<td class="label">*<s:text name="runcase.advisorName" />:</td>
												<td class="value" colspan="3">
													<s:textfield name="e.advisorName" cssStyle="width:9em;" data-validate="required"/>
													 <s:radio name="e.advisorSex" list="#{'1':'男','2':'女'}" 
													value="e.sex" cssStyle="width:auto;"/>
													<s:text name="runcase.advisorAge" />:<s:textfield name="e.advisorAge" cssStyle="width:2.5em;" />
												</td>
							                </tr>
							                <tr>
							                	<td class="label">*<s:text name="runcase.advisorPhone" />:</td>
							                	<td class="value" colspan="3">
													<s:textfield name="e.advisorPhone" data-validate='{"type":"number" ,"required":true}'/>
												</td>
							                </tr>
							                <tr>
							               		<td class="label"><s:text name="runcase.advisorCert" />:</td>
							                	<td class="value" colspan="3">
													<s:textfield name="e.advisorCert" />
												</td>
							                </tr>
						        		</table>
						    		</fieldset>
						    	</td>
							</tr>
							<tr>
								<td class="label" colspan="4">
									<fieldset>
						          		<legend>补充信息</legend>
						          		<table class="formFields" cellspacing="2" cellpadding="0" style="height:100px;">
						          			<tr style="line-height: 1px;">
												<td></td>
												<td style="width: 350px;">&nbsp;</td>
												<td style="width: 90px;">&nbsp;</td>
												<td style="width: 350px;">&nbsp;</td>
											</tr>
						          			<tr>
												<td class="label"><s:text name="runcase.ticket"/>:</td>
												<td class="value"><s:textfield name="e.ticket" /></td>
												<td class="label"><s:text name="runcase.driverFeature"/>:</td>
												<td class="value"><s:textfield name="e.driverFeature" /></td>
											</tr>
											<tr>
												<td class="label"><s:text name="runcase.machinePrice"/>:</td>
												<td class="value"><s:textfield name="e.machinePrice" /></td>
												<td class="label"><s:text name="runcase.driverCert"/>:</td>
												<td class="value"><s:textfield name="e.driverCert" /></td>
											</tr>
											<tr>
												<td class="label"><s:text name="runcase.ridingTime"/>:</td>
												<td class="value">
													<input type="text" name="e.ridingStartTime	" data-validate='{"type":"datetime"}'
													value='<s:date format="yyyy-MM-dd HH:mm" name="e.ridingStartTime" />'
													class="bc-datetime" data-cfg='{changeYear:true}' style="max-width: 10em;"/>
													&nbsp;到
													<input type="text" name="e.ridingEndTime" data-validate='{"type":"datetime"}'
													value='<s:date format="yyyy-MM-dd HH:mm" name="e.ridingEndTime" />'
													class="bc-datetime" data-cfg='{changeYear:true}' style="max-width: 10em;"/>
												</td>
												<td class="label"><s:text name="runcase.charge"/>:</td>
												<td class="value"><s:textfield name="e.charge" /></td>
											</tr>
											<tr>
												<td class="label"><s:text name="runcase.path"/>:</td>
												<td class="value">
													<s:textfield name="e.pathFrom" cssStyle="width:10em;"/>
													&nbsp;到
													<s:textfield name="e.pathTo" cssStyle="width:10em;"/>
												</td>
												<td class="label"><s:text name="runcase.passengerCount"/>:</td>
												<td class="value"><s:textfield name="e.passengerCount" cssStyle="width:2.5em;" data-validate='{"type":"number"}' />&nbsp;男<s:textfield name="e.passengerManCount" data-validate='{"type":"number"}' cssStyle="width:2.5em;" />&nbsp;女
												<s:textfield name="e.passengerWomanCount" cssStyle="width:2.5em;" data-validate='{"type":"number"}' />&nbsp;童<s:textfield name="e.passengerChildCount"cssStyle="width:2.5em;" data-validate='{"type":"number"}' />
												</td>
											</tr>
											<tr>
												<td class="label"><s:text name="runcase.gongjiao"/>:</td>
												<td class="value" colspan="3"><s:textfield name="e.path" cssStyle="width:55.6em;" /></td>
											</tr>
						          		</table>
							        </fieldset>
						        </td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="otherFormFields2" class="content" style="width:800px;">
					<table class="formFields" cellspacing="2" cellpadding="0" >
						<tbody>
							<tr>
								<td style="height: 1px;"></td>
								<td style="width: 350px;">&nbsp;</td>
								<td style="width: 90px;">&nbsp;</td>
								<td style="width: 350px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.extent"/></td>
								<td class="value">
								<s:select name="e.extent" list="degreeList" listKey="value" listValue="value" headerKey="" headerValue="" ></s:select>
								</td>
								<td class="label"><s:text name="runcase.receiverName2"/>:</td>
								<td class="value "><s:textfield name="e.receiverName" /></td>
							</tr>
							<tr>
								<td class="label" ><s:text name="runcase.duty"/>:</td>
								<td class="value" >
									<s:select name="e.duty" list="dutyList" listKey="value" listValue="value"  headerKey="" headerValue="" cssStyle="width:12em;"  ></s:select>
									<s:checkbox name="e.invalid" cssStyle="width:1em;" />
									<s:text name="runcase.invalid"/>
								</td>
								<td class="label"><s:text name="runcase.noticeDate"/>:</td>
								<td class="value">
									<input type="text" name="e.noticeDate" data-validate='{"type":"datetime"}'
									value='<s:date format="yyyy-MM-dd HH:mm" name="e.noticeDate" />'
									class="bc-datetime" data-cfg='{changeYear:true}'/>
								</td>
							</tr>
							<s:if test="e.status == 1">
							<tr>
								<td class="label"><s:text name="runcase.deliverDate3"/>:</td>
								<td class="value">
									<input type="text" name="e.deliverDate data-validate='{"type":"datetime"}'
									value='<s:date format="yyyy-MM-dd HH:mm" name="e.deliverDate" />'
									class="bc-datetime" data-cfg='{changeYear:true}'/>
								</td>
								<td></td>
								<td></td>
							</tr>
							</s:if>
							<tr>
								<td class="label"><s:text name="runcase.result"/>:</td>
								<td><s:textarea name="e.result" cssStyle="width:24em; text-align:left" rows="4" /></td>
								<td class="label"><s:text name="runcase.description"/>:</td>
								<td><s:textarea name="e.description" cssStyle="width:24em; text-align:left" rows="4" /></td>
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
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>