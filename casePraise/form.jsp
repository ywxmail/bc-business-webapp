<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="casePraise.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/casePraise/save" />'
	data-js='<s:url value="/bc-business/casePraise/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.casePraiseForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="casePraiseForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:800px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td></td>
						<td style="width: 200px;">&nbsp;</td>
						<td style="width: 80px;">&nbsp;</td>
						<td style="width: 200px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.code" />:</td>
						<td class="value "><s:textfield name="e.code" data-validate="required" readonly="true" cssClass="ui-widget-content"/></td>
						<td class="label">*<s:text name="runcase.receiveDate3"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<input type="text" name="e.receiveDate" data-validate='{"type":"datetime","required":true}'
							value='<s:date format="yyyy-MM-dd HH:mm" name="e.receiveDate" />'
							class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
							<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectReceiveDate"></span>
						</td>
					<tr>
						<td class="label" colspan="4">
						    <fieldset>
						    	<legend>表扬项目</legend>
						    	<table class="formFields" cellspacing="2" cellpadding="0">
						    		<tr style="line-height: 1px;">
										<td></td>
										<td style="width: 380px;">&nbsp;</td>
										<td style="width: 20px;">&nbsp;</td>
										<td style="width: 130px;">&nbsp;</td>
									</tr>
						    		<tr>
						    			<td class="label">*<s:text name="runcase.subject3"/><s:text name="runcase.big"/>:</td>
										<td class="value">
										<div style="position:relative;">
											<s:textfield name="e.subject" cssStyle="width:29em;" data-validate="required" cssClass="ui-widget-content"/>
											<span id="selectSubject" class="verticalMiddle ui-icon ui-icon-circle-plus" style="margin-top : -7px;right: 48px" title='<s:text name="runcase.title.click2selectcomplain"/>'></span>
										</div>
										</td>
										<td class="label">*<s:text name="runcase.happenDate"/>:</td>
										<td class="value" style="position:relative;display: block;">
											<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
											value='<s:date format="yyyy-MM-dd HH:mm" name="e.happenDate" />'
											class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
											<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectHappenDate"></span>
										</td>
						    		</tr>
						    		<tr>
						    			<td class="label"><s:text name="runcase.subject3"/><s:text name="runcase.small"/>:</td>
										<td class="value"><s:textfield name="e.subject2" cssStyle="width:29em;" cssClass="ui-widget-content"/></td>
						    			<td class="label" ><s:text name="runcase.source"/>:</td>
										<td class="value" >
											<s:textfield name="e.from" cssClass="ui-widget-content" />
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
										<td class="value" colspan="4"><s:textarea name="e.detail" cssStyle="width:57em; text-align:left" rows="4" cssClass="ui-widget-content"/></td>
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
								    <fieldset style="height: 110px;width: 350px;">
								    	<legend>被表扬方信息</legend>
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
													<span style="position:relative;">
														<s:textfield name="e.carPlate" readonly="true" cssClass="ui-widget-content ui-state-disabled"/>
														<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectCarPlate" ></span>
													</span>
												</td>
												<td class="label">
													<s:text name="runcase.carColor"/>:
												</td>
												<td class="value">
													<s:textfield name="e.carColor" cssClass="ui-widget-content"  />
												</td>
							               </tr>
							               <tr>
							               		<td class="label"><s:text name="runcase.driverName" />:</td>
												<td class="value" colspan="3">
													<span style="position:relative;">
														<s:textfield name="e.driverName" cssStyle="width:9em;" readonly="true" cssClass="ui-widget-content ui-state-disabled" />
														<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectDriverName" style="right: 9px"></span>
													</span>
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
								<td class="value" colspan="2">
									<fieldset style="height: 110px;">
						          		<legend>表扬人信息</legend>
						          		<table class="formFields" cellspacing="2" cellpadding="0" style="height:100px;">
								          	<tr style="line-height: 1px;">
												<td style="width: 10px;"></td>
												<td style="width: 120px;">&nbsp;</td>
												<td style="width: 10px;">&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
								          	<tr>
								          		<td class="label">*<s:text name="runcase.praiseName" />:</td>
												<td class="value" colspan="3">
													<s:textfield name="e.advisorName" cssStyle="width:9em;" data-validate="required" cssClass="ui-widget-content"/>
													 <s:radio name="e.advisorSex" list="#{'1':'男','2':'女'}" 
													value="e.sex" cssStyle="width:auto;"/>
													<s:text name="runcase.advisorAge" />:<s:textfield name="e.advisorAge" cssStyle="width:2.5em;" cssClass="ui-widget-content"/>
												</td>
							                </tr>
							                <tr>
							                	<td class="label">*<s:text name="runcase.praiseHome" />:</td>
							                	<td class="value" colspan="3">
													<s:textfield name="e.advisorPhone" data-validate='{"type":"number" ,"required":true}' cssClass="ui-widget-content"/>
												</td>
							                </tr>
							                <tr>
							               		<td class="label"><s:text name="runcase.praiseCert" />:</td>
							                	<td class="value" colspan="3">
													<s:textfield name="e.advisorCert" cssClass="ui-widget-content"/>
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
											<tr class="widthMarker">
												<td></td>
												<td style="width: 200px;">&nbsp;</td>
												<td style="width: 80px;">&nbsp;</td>
												<td style="width: 200px;">&nbsp;</td>
											</tr>
						          			<tr>
												<td class="label"><s:text name="runcase.ticket"/>:</td>
												<td class="value"><s:textfield name="e.ticket" cssClass="ui-widget-content"/></td>
												<td class="label"><s:text name="runcase.driverFeature"/>:</td>
												<td class="value"><s:textfield name="e.driverFeature" cssClass="ui-widget-content"/></td>
											</tr>
											<tr>
												<td class="label"><s:text name="runcase.machinePrice"/>:</td>
												<td class="value"><s:textfield name="e.machinePrice" cssClass="ui-widget-content"/></td>
												<td class="label"><s:text name="runcase.driverCert"/>:</td>
												<td class="value"><s:textfield name="e.driverCert" cssClass="ui-widget-content"/></td>
											</tr>
											<tr>
												<td class="label"><s:text name="runcase.ridingTime"/>:</td>
												<td class="value">
													<span style="position:relative;">
														<input type="text" name="e.ridingStartTime" data-validate='{"type":"datetime"}'
														value='<s:date format="yyyy-MM-dd HH:mm" name="e.ridingStartTime" />'
														class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}' style="max-width: 8em;"/>
														<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectRidingStartTime"></span>
													</span>
													&nbsp;到
													<span style="position:relative;">
														<input type="text" name="e.ridingEndTime" data-validate='{"type":"datetime"}'
														value='<s:date format="yyyy-MM-dd HH:mm" name="e.ridingEndTime" />'
														class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}' style="max-width: 8em;"/>
														<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectRidingEndTime"></span>
													</span>
												</td>
												<td class="label"><s:text name="runcase.charge"/>:</td>
												<td class="value"><s:textfield name="e.charge" cssClass="ui-widget-content"/></td>
											</tr>
											<tr>
												<td class="label"><s:text name="runcase.path"/>:</td>
												<td class="value">
													<s:textfield name="e.pathFrom" cssStyle="width:8em;" cssClass="ui-widget-content"/>
													&nbsp;到
													<s:textfield name="e.pathTo" cssStyle="width:8em;" cssClass="ui-widget-content"/>
												</td>
												<td class="label"><s:text name="runcase.passengerCount"/>:</td>
												<td class="value"><s:textfield name="e.passengerCount" cssStyle="width:2.5em;" data-validate='{"type":"number",max:9}' cssClass="ui-widget-content"/>&nbsp;男<s:textfield name="e.passengerManCount" data-validate='{"type":"number",max:9}' cssStyle="width:2.5em;" cssClass="ui-widget-content"/>&nbsp;女
												<s:textfield name="e.passengerWomanCount" cssStyle="width:2.5em;" data-validate='{"type":"number",max:9}' cssClass="ui-widget-content"/>&nbsp;童<s:textfield name="e.passengerChildCount"cssStyle="width:2.5em;" data-validate='{"type":"number",max:9}' cssClass="ui-widget-content"/>
												</td>
											</tr>
											<tr>
												<td class="label"><s:text name="runcase.gongjiao"/>:</td>
												<td class="value" colspan="3"><s:textfield name="e.path" cssStyle="width:50em;" cssClass="ui-widget-content"/></td>
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
							<tr class="widthMarker">
								<td></td>
								<td style="width: 200px;">&nbsp;</td>
								<td style="width: 80px;">&nbsp;</td>
								<td style="width: 200px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.praiseType"/></td>
								<td class="value">
								<s:select name="e.extent" list="typeList" listKey="value" listValue="value" headerKey="" headerValue="" cssStyle="width:20.5em;" cssClass="ui-widget-content"></s:select>
								</td>
								<td class="label"><s:text name="runcase.receiverName2"/>:</td>
								<td class="value" style="position:relative;display: block;">
									<s:textfield name="e.receiverName" style="width:20em;" cssClass="ui-widget-content ui-state-disabled"/>		
									<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectReceiverName" style="right: 40px;"></span>
								</td>
							</tr>
							<tr>
								<td class="label" ><s:text name="runcase.rewardMoney"/>:</td>
								<td class="value" >
									<s:textfield name="e.rewardMoney" style="width:20em;" cssClass="ui-widget-content"/>
								</td>
								<td class="label"><s:text name="runcase.noticeDate"/>:</td>
								<td class="value" style="position:relative;display: block;">
									<input type="text" name="e.noticeDate" data-validate='{"type":"datetime"}'
									value='<s:date format="yyyy-MM-dd HH:mm" name="e.noticeDate" />'
									class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}' style="width:20em;" />
									<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectNoticeDate" style="right: 40px;"></span>
								</td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.result"/>:</td>
								<td><s:textarea name="e.result" cssStyle="width:20em; text-align:left" rows="4" cssClass="ui-widget-content"/></td>
								<td class="label"><s:text name="runcase.description"/>:</td>
								<td><s:textarea name="e.description" cssStyle="width:20em; text-align:left" rows="4" cssClass="ui-widget-content"/></td>
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
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>