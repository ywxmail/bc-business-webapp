<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="caseAccident.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/caseAccident/save" />'
	data-js='<s:url value="/bc-business/caseAccident/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.caseAccidentForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseAccidentForm" theme="simple">
			<table class="formTable2 ui-widget-content" cellspacing="2" cellpadding="0" style="width:800px;">
				<tbody>
					<tr class="widthMarker">
						<td style="width: 80px;"></td>
						<td style="width: 320px;">&nbsp;</td>
						<td style="width: 80px;">&nbsp;</td>
						<td >&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.caseNo3"/>:</td>
						<td class="value "><s:textfield name="e.code"  data-validate="required" cssClass="ui-widget-content"/></td>
						<td class="label">*<s:text name="runcase.receiveDate2"/>:</td>
						<td class="value">
							<div style="position : relative; display: block">
								<s:if test="%{isManage()}">
									<input type="text" name="e.receiveDate" data-validate='{"type":"datetime","required":true}'
										value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.receiveDate" />'
										class="bc-datetime ui-widget-content" data-cfg='{showSecond:true,timeFormat:"hh:mm:ss"}'/>
									<ul class="inputIcons" style="right : 4px;">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.receiveDate' ></li>
									</ul>
								</s:if><s:else>
									<input type="text" name="e.receiveDate" data-validate='{"type":"datetime","required":true}'
										value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.receiveDate" />'
										class="ui-widget-content" data-cfg='{showSecond:true,timeFormat:"hh:mm:ss"}'/>
								</s:else>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label" >*<s:text name="runcase.happenDate"/>:</td>
						<td class="value" >
							<div style="position : relative; display: block">
								<s:if test="%{isManage()}">
									<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
										value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.happenDate" />'
										class="bc-datetime ui-widget-content" 
										data-cfg='{showSecond:true,timeFormat:"hh:mm:ss"}'/>
									<ul class="inputIcons" style="right : 4px;">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.happenDate' ></li>
									</ul>
								</s:if><s:else>
									<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
										value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.happenDate" />'
										class="ui-widget-content" 
										data-cfg='{showSecond:true,timeFormat:"hh:mm:ss"}'/>
								</s:else>
							</div>
						</td>
						<td class="label">*<s:text name="runcase.address"/>:</td>
						<td class="value "><s:textfield name="e.address" data-validate="required" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<s:if test="%{carManId != null || carId !=null }">
							<td class="label">*<s:text name="runcase.carPlate"/>:</td>
							<td class="value">
								<s:textfield name="e.carPlate"  readonly="true" cssClass="ui-widget-content"cssStyle="width:8em;" />
								<div style="width:26px;display:inline-block;"></div>
								<s:text name="runcase.motorcadeName"/>:
								<s:select name="e.motorcadeId" list="motorcadeList" listKey="key" cssStyle="width:8em;"
										listValue="value" value="e.motorcadeId" headerKey="" headerValue="" cssClass="ui-widget-content"/>
							</td>
					    </s:if>
					    <s:else>
						    <td class="label">*<s:text name="runcase.carPlate"/>:</td>
							<td class="value">
								<div style="position : relative; display: inline-block">
									<s:textfield name="e.carPlate" 
									    data-validate="required" cssClass="ui-widget-content" readonly="true" cssStyle="width:8em;"/>
									    <ul class="inputIcons ">
								 			<li class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectCar" title='<s:text name="title.click2select"/>'>
								 		</ul>
								</div>
								<div style="width:26px;display:inline-block;"></div>
								<s:text name="runcase.motorcadeName"/>:
								<s:select name="e.motorcadeId" list="motorcadeList" listKey="key" cssStyle="width:8em;"
										listValue="value" value="e.motorcadeId" headerKey="" headerValue="" cssClass="ui-widget-content"/>
						    </td>
					    </s:else>
					    <td class="label"><s:text name="runcase.company2"/>:</td>
						<td class="value">
								<s:textfield name="e.company"  cssClass="ui-widget-content" cssStyle="width:8em;"/>
								<div style="width:24px;display:inline-block;"></div>
								<s:text name="runcase.weather"/>:
								<s:textfield name="e.weather" cssClass="ui-widget-content" cssStyle="width:8em;"/>
						</td>
					</tr>
					<tr>
						<s:if test="%{carManId != null || carId !=null}">
						<td class="label"><s:text name="runcase.driverName"/>:</td>
						<td class="value">
									<s:textfield name="e.driverName" cssStyle="width:8em;" readonly="true" cssClass="ui-widget-content" />
									<div style="width:0px;display:inline-block;"></div>
									<s:text name="runcase.driverCertNo" />:
									<s:textfield name="e.driverCert" readonly="true" data-validate="required" 
											cssStyle="width:8em;" cssClass="ui-widget-content"/></td>
					    </s:if><s:else>
					    <td class="label"><s:text name="runcase.driverName"/>:</td>
						<td class="value">
									<div style="position:relative;display: inline-block" >
										<s:textfield name="e.driverName" cssStyle="width:8em;"  readonly="true" cssClass="ui-widget-content"/>
										<ul class="inputIcons">
								 			<li class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectDriverName">
								 		</ul>
									</div>
									<div style="width:0px;display:inline-block;"></div>
									<s:text name="runcase.driverCertNo" />:
									<s:textfield name="e.driverCert" readonly="true" data-validate="required" 
											cssStyle="width:8em;" cssClass="ui-widget-content"/></td>
					     </s:else>
					  	<td class="label">*<s:text name="runcase.accident.sort"/>:</td>
						<td class="value">
								<s:select name="e.sort" list="sortList" listKey="value" cssStyle="width:8em;"
									listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" data-validate="required" />
								<div style="width:0px;display:inline-block;"></div>
								<s:text name="runcase.department"/>:
								<s:if test="%{!isManage()}">
									<s:textfield name="e.department" cssClass="ui-widget-content" cssStyle="width:8em;"/>
								</s:if>
								<s:else>
									<div class="bc-relativeContainer" style="position : relative; display: inline-block">
										<input type="text" name="e.department" value='<s:property value="e.department"/>' style="width:8em;" 
											data-validate='{"maxLen": 50,"type":"string"}' class="bc-select ui-widget-content"
											data-maxHeight="150px"
											data-source='<s:property value="departmentList"/>'/>
										<ul class="inputIcons">
											<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
										</ul>
									</div>
								</s:else>
						</td>
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.driverArea"/>:</td>
						<td class="value">
								<s:select list="#{0:'',1:'本市',2:'本省',3:'外省'}" listKey="key" listValue="value"  cssStyle="width:8em;"  
										headerValue="" name="e.driverArea" cssClass="ui-widget-content"/>
								<div style="width:2px;display:inline-block;"></div>
								司机<s:text name="runcase.origin"/>:
								<s:textfield name="e.origin" cssStyle="width:8em;"  cssClass="ui-widget-content"/>
						</td>
						<td class="label" ><s:text name="runcase.duty"/>:</td>
						<td class="value" >
							<s:select name="e.duty" cssStyle="width:8em;" list="dutyList" listKey="value" 
									listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"/>
							<div style="width:0px;display:inline-block;"></div>
							<s:text name="runcase.receiveCodeNo"/>:	
							<s:textfield name="e.receiveCode" cssClass="ui-widget-content" cssStyle="width:8em;"/>
						</td>
						
					</tr>
					<tr>
					    <td class="label"><s:text name="runcase.driverClasses"/>:</td>
						<td class="value">
								<s:select name="e.driverClasses" list="#{0:'',1:'正班',2:'副班',3:'顶班'}" listKey="key" 
										listValue="value" cssStyle="width:8em;" cssClass="ui-widget-content"/>
								<div style="width:2px;display:inline-block;"></div>
								<s:text name="runcase.driverType"/>:
								<s:select name="e.driverType" list="#{0:'',1:'司机',2:'车主',3:'非编'}" listKey="key" 
										listValue="value" cssStyle="width:8em;" cssClass="ui-widget-content"/>
						</td>
						<td class="label" ><s:text name="runcase.receiverName2"/>:</td>
						<td class="value">
							<div style="position : relative; display: inline-block">
									<s:textfield name="e.receiverName" cssClass="ui-widget-content" cssStyle="width:8em;" readonly="true"/>
									<ul class="inputIcons">
										 <li id="selectReceiver" class=" inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
									</ul>
							</div>
							<div style="width:12px;display:inline-block;"></div>
							<div style="position : relative; display: inline-block">
									<s:text name="runcase.principal" />:
									<s:textfield name="e.chargerName" cssClass="ui-widget-content" cssStyle="width:8em;" readonly="true"/>
									<ul class="inputIcons">
										 <li id="selectPrincipal" class=" inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
									</ul>
							</div>
						</td>					
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="runcase.jingguo"/>:</td>
						<td class="value" colspan="3" ><s:textarea name="e.description" rows="5" cssClass="ui-widget-content noresize"/>
						</td>
					</tr>
					<!-- 相关保单-->
					<tr>
						<td class="topLabel" >
							<div>
								<s:text name="runcase.insuranceInfo"/>:
							</div>
							<div style="position : relative;">
								<ul class="inputIcons" style="top:5px;">
											<li class="inputIcon ui-icon ui-icon-lightbulb"
											 title='<s:text name="runcase.accident.loadPolicyTips"/>' id="loadPolicy">
								</ul>	
							</div>	
						</td>
						<td id="buildPolicyTable" class="value" colspan="3" >
							<textarea rows="3" Class="ui-widget-content noresize"></textarea>
						</td>
					</tr>
					<tr style="line-height: 5px;">
						<td>&nbsp;</td>
					</tr>
				</tbody>
			</table>
			
			<!-- 损失情况 -->
			<div  class="formTable2 ui-widget-content"  style="width:800px;">
				<div class="ui-widget-header title" style="position:relative;">
						<span class="text" >损失情况:</span>
						<span id="ShowGroups1" class="verticalMiddle ui-icon ui-icon-carat-1-s" title='<s:text name="runcase.title.click2ShowGroups"/>'></span>
						<span id="HiddenGroups1" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="runcase.title.click2HiddenGroups"/>'></span>
				</div>
				<div id="Groups1">
					<fieldset style="margin: 6px;" class="ui-widget-content">
					<legend>自车</legend>
						<table class="formFields ui-widget-content" cellspacing="2" cellpadding="0">
							<tbody>
								<tr style="line-height: 1px;">
									<td style="width: 110px;">&nbsp;</td>
									<td style="width: 250px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
								<tr>
									<td class="label"><s:checkbox name="e.innerFix" cssStyle="width:1em;" /><s:text name="runcase.innerFix"/></td>
									<td class="value" >
											<div style="width:2px;display:inline-block;"></div>
											<span id="fixCostText"><s:text name="runcase.fixCost" />(元):</span>
											<s:textfield name="e.fixCost" cssClass="ui-widget-content" cssStyle="width:130px;"
												    value="%{getText('bs.format.numberRMB',{e.fixCost})}"  data-validate="money"  />
									</td>
									<td class="label"><s:text name="runcase.claimAmount" />(元):</td>
									<td class="value"><s:textfield name="e.claimAmount" cssClass="ui-widget-content"  
																   value="%{getText('bs.format.numberRMB',{e.claimAmount})}"  data-validate="money" /></td>
								</tr>
								<tr>
									<td class="label"><s:text name="runcase.trailerCost" />(元):</td>
									<td class="value"><s:textfield name="e.carmanCost" cssClass="ui-widget-content"  
																   value="%{getText('bs.format.numberRMB',{e.carmanCost})}"  data-validate="money" /></td>
									<td class="label"><s:text name="runcase.carWounding" />(元):</td>
									<td class="value"><s:textfield name="e.carWounding" cssClass="ui-widget-content" 
																   value="%{getText('bs.format.numberRMB',{e.carWounding})}"  data-validate="money" /></td>
								</tr>
								<tr>
									<td class="label"><s:text name="runcase.carHurt" />:</td>
									<td class="value"><s:textfield name="e.carHurt" cssClass="ui-widget-content"  /></td>
									<td class="label"></td>
									<td class="value"></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
					<fieldset style="margin: 6px;" class="ui-widget-content">
					<legend>第三者</legend>
						<table class="formFields ui-widget-content" cellspacing="2" cellpadding="0">
							<tbody>
								<tr style="line-height: 1px;">
									<td style="width: 110px;">&nbsp;</td>
									<td style="width: 250px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
									<tr>
									<td class="label"><s:text name="runcase.thirdLoss" />(元):</td>
									<td class="value"><s:textfield name="e.thirdLoss" cssClass="ui-widget-content" 
																   value="%{getText('bs.format.numberRMB',{e.thirdLoss})}"  data-validate="money"  /></td>
									<td class="label"><s:text name="runcase.trailerCost" />(元):</td>
									<td class="value"><s:textfield name="e.thirdCost" cssClass="ui-widget-content"  /></td>
								</tr>
								<tr>
									<td class="label"><s:text name="runcase.third.hurt" />(元):</td>
									<td class="value"><s:textfield name="e.thirdWounding" cssClass="ui-widget-content"  
																   value="%{getText('bs.format.numberRMB',{e.thirdWounding})}"  data-validate="money" /></td>
									<td class="label"><s:text name="runcase.medicalFee" />(元):</td>
									<td class="value"><s:textfield name="e.medicalFee" cssClass="ui-widget-content" 
																   value="%{getText('bs.format.numberRMB',{e.medicalFee})}"  data-validate="money"  /></td>
								</tr>
								<tr>
									<td class="label"><s:text name="runcase.accident.thirdLossInfo" />:</td>
									<td class="value"><s:textfield name="e.thirdLossInfo" cssClass="ui-widget-content" /></td>
							
								</tr>
							</tbody>
						</table>
					</fieldset>
					<fieldset style="margin: 6px;" class="ui-widget-content">
						<legend>总体损失</legend>	
						<table  class="formFields ui-widget-content" cellspacing="2" cellpadding="0">
								<tbody>
									<tr style="line-height: 1px;">
									<td style="width: 110px;">&nbsp;</td>
									<td style="width: 250px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
									<tr>
										<td class="label"><s:text name="runcase.hurtCount"/>:</td>
										<td class="value"><s:textfield name="e.hurtCount" cssClass="ui-widget-content" cssStyle="width:80px;" data-validate="number"/>
										<s:text name="runcase.deadCount"/>:
										<s:textfield name="e.deadCount" cssClass="ui-widget-content" cssStyle="width:80px;" data-validate="number"/></td>
										<td class="label"><s:text name="runcase.agreementPayment"/>(元):</td>
										<td class="value"><s:textfield name="e.agreementPayment" cssClass="ui-widget-content"
																	   value="%{getText('bs.format.numberRMB',{e.agreementPayment})}"  data-validate="money" /></td>
									</tr>
									<tr>
										<td class="label"><s:checkbox name="e.rob" cssStyle="width:1em;" /><s:text name="runcase.rob"/></td>
										<td class="value"></td>
										<td class="label"><s:text name="runcase.actualLoss"/>(元):</td>
										<td class="value"><s:textfield name="e.actualLoss" cssClass="ui-widget-content"/></td>
									</tr>
									<tr>
										<td class="topLabel"><s:text name="runcase.costDetail"/>:</td>
										<td class="value" colspan="3"><s:textarea name="e.costDetail"  rows="3" cssClass="ui-widget-content noresize"/></td>
									</tr>
								</tbody>
						</table>
					</fieldset>
				</div>
			</div>
			
			<!-- 理赔情况 -->
			<div  class="formTable2 ui-widget-content"  style="width:800px;">
				<div class="ui-widget-header title" style="position:relative;">
						<span class="text" >理赔情况:</span>
						<span id="ShowGroups2" class="verticalMiddle ui-icon ui-icon-carat-1-s" title='<s:text name="runcase.title.click2ShowGroups"/>'></span>
						<span id="HiddenGroups2" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="runcase.title.click2HiddenGroups"/>'></span>
				</div>
				<div id="Groups2">
					<fieldset style="margin: 6px;" class="ui-widget-content">
					<legend>送保信息</legend>
						<table class="formFields ui-widget-content" cellspacing="3" cellpadding="0">
							<tbody>
								<tr style="line-height: 1px;">
									<td style="width: 110px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 160px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 140px;">&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
								<tr>
									<td class="label"><s:checkbox name="e.deliver" cssStyle="width:1em;" /><s:text name="runcase.deliver3"/></td>
									<td></td>
									<td class="label">
										<samp id="deliver" style='<s:if test="%{e.deliver}">display:block;</s:if><s:else>display:none;</s:else>'>
											<s:checkbox name="e.claim" cssStyle="width:1em;"  /><s:text name="runcase.claim"/>
										</samp>
									</td>
									<td></td>
									<!-- 司机受款按钮 -->
									<td class="label">
										<samp id="claim"  style='<s:if test="%{e.claim}">display:block;</s:if><s:else>display:none;</s:else>'>
											<s:if test="%{isPayManage()}">
													<s:checkbox name="e.pay"  cssStyle="width:1em;" cssClass="payManage" />
											</s:if><s:else>
													<s:checkbox name="e.pay" onclick="return false" ondblclick="return false" cssStyle="width:1em;" />
											</s:else><s:text name="runcase.pay"/>
										</samp>
									</td>
									<td></td>
								</tr>
								<tr>
									<td class="label">
										<samp id="deliver" style='<s:if test="%{e.deliver}">display:block;</s:if><s:else>display:none;</s:else>'>
										      &nbsp;&nbsp;<s:text name="runcase.deliverDate2"/>:
								       </samp>
								    </td>
									<td class="value" >
										<samp id="deliver" style='<s:if test="%{e.deliver}">display:block;</s:if><s:else>display:none;</s:else>'>
									    	<div style="position : relative; display: block">
									    		<s:if test="%{isManage()}">
									    			<input type="text" name="e.deliverDate" data-validate='{"type": "date"}'
														value='<s:date format="yyyy-MM-dd" name="e.deliverDate" />'
														class="bc-date ui-widget-content" />
													<ul class="inputIcons" style="right : 0px;">
														<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.deliverDate' ></li>
													</ul>
												</s:if><s:else>
													<input type="text" name="e.deliverDate" data-validate='{"type": "date"}'
														value='<s:date format="yyyy-MM-dd" name="e.deliverDate" />'
														class="ui-widget-content" />
												</s:else>
											</div>
										</samp>
									</td>
									<td class="label">
										<samp id="claim" style='<s:if test="%{e.claim}">display:block;</s:if><s:else>display:none;</s:else>'>
									  		 &nbsp;&nbsp;<s:text name="runcase.claimDate"/>:
								     	</samp>
								     </td>
									<td class="value"> 
										<samp id="claim" style='<s:if test="%{e.claim}">display:block;</s:if><s:else>display:none;</s:else>'>
										     <div style="position : relative; display: block">
											     <s:if test="%{isManage()}">
												<input type="text" name="e.claimDate" data-validate='{"type": "date"}'
											    	value='<s:date format="yyyy-MM-dd" name="e.claimDate" />'
											    	class="bc-date ui-widget-content"  />
											    <ul class="inputIcons" style="right : 0px;">
													<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.claimDate' ></li>
												</ul>
											</s:if><s:else>
												<input type="text" name="e.claimDate" data-validate='{"type": "date"}'
											    	value='<s:date format="yyyy-MM-dd" name="e.claimDate" />'
											    	class="ui-widget-content"  />
											</s:else>
											</div>
										</samp>
									</td>
									<!-- 受款司机 -->
									<td class="label"  >
										<samp id="pay"  style='<s:if test="%{e.pay}">display:block;</s:if><s:else>display:none;</s:else>'>
											<s:text name="runcase.driverName"/>: 
										</samp>
									</td>
									<td class="value relative">
										<samp id="pay"  style='<s:if test="%{e.pay}">display:block;</s:if><s:else>display:none;</s:else>'>
									    	 <div style="position:relative;display: inline-block" >
												<s:if test="%{isPayManage()}">
													<s:textfield name="e.payDriver" cssStyle="width:8em;"  readonly="true" cssClass="ui-widget-content"/>
													<ul class="inputIcons ">
											 			<li class="payManage selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectPayDriver" title="点击选择受款司机">
											 		</ul>
												</s:if><s:else>
													<s:textfield name="e.payDriver" cssStyle="width:8em;"  readonly="true" cssClass="ui-widget-content"/>
												</s:else> 
											</div>
										</samp>	
									</td>								
								</tr>
								<tr>
									<td class="label"> 
										<samp id="deliver" style='<s:if test="%{e.deliver}">display:block;</s:if><s:else>display:none;</s:else>'>
									    	<s:text name="runcase.deliverMoney"/>(元):
								     	</samp>
								    </td>
									<td class="value">
										<samp id="deliver" style='<s:if test="%{e.deliver}">display:block;</s:if><s:else>display:none;</s:else>'>
										     <s:textfield name="e.deliverMoney"  cssClass="ui-widget-content" 
										     			value="%{getText('bs.format.numberRMB',{e.deliverMoney})}"  data-validate="money" />
									     </samp>
									</td>
									<td class="label">
										<samp id="claim" style='<s:if test="%{e.claim}">display:block;</s:if><s:else>display:none;</s:else>'>
										    <s:text name="runcase.claimMoney"/>(元):
								     	</samp>
								    </td>
									<td class="value"> 
										<samp id="claim"  style='<s:if test="%{e.claim}">display:block;</s:if><s:else>display:none;</s:else>'>
										     <s:textfield name="e.claimMoney"  cssClass="ui-widget-content"  
										     		value="%{getText('bs.format.numberRMB',{e.claimMoney})}"  data-validate="money" />
									     </samp>
									</td>
									<!-- 司机受款日期 -->
									<td class="label">
										<samp id="pay"  style='<s:if test="%{e.pay}">display:block;</s:if><s:else>display:none;</s:else>'>
										      <s:text name="runcase.payDate"/>:
								      	</samp>
								     </td>
									<td class="value">
										<samp id="pay"  style='<s:if test="%{e.pay}">display:block;</s:if><s:else>display:none;</s:else>'>
										    <div style="position : relative; display: block">
										     	<s:if test="%{isPayManage()}">
										     	<input type="text" name="e.payDate" data-validate='{"type": "date"}'
												    value='<s:date format="yyyy-MM-dd" name="e.payDate" />'
												    class="bc-date ui-widget-content"  />
													<ul class="inputIcons" style="right : 0px;">
														<li class="payManage selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.payDate' ></li>
													</ul>
												</s:if><s:else>
													<input type="text" name="e.payDate" data-validate='{"type": "date"}'
												    	value='<s:date format="yyyy-MM-dd" name="e.payDate" />'
												    	class="ui-widget-content" readonly="readonly" />
												</s:else>  
											</div>
									    </samp>
									 </td>
								</tr>
								<tr>
									<td class="label"> 
										<samp id="deliver" style='<s:if test="%{e.deliver}">display:block;</s:if><s:else>display:none;</s:else>'>
									    	   使用<s:text name="runcase.deliver3Two"/>:
								       </samp> 
									 </td>
									<td class="value">
										<samp id="deliver" style='width:auto;<s:if test="%{e.deliver}" >display:block;</s:if><s:else>display:none;</s:else>'>
									        <s:checkbox name="e.deliverSecond" style='width:auto;' />
								        </samp>
								    </td>
									<td></td>
									<td></td>
									<!-- 司机受款金额-->
									<td class="label">
										<samp id="pay"  style='<s:if test="%{e.pay}">display:block;</s:if><s:else>display:none;</s:else>'>
									    	<s:text name="runcase.payMoney"/>(元):
								     	</samp>
								    </td>
									<td class="value">
										<samp id="pay"   style='<s:if test="%{e.pay}">display:block;</s:if><s:else>display:none;</s:else>'>
										<s:if test="%{isPayManage()}">
											<s:textfield name="e.payMoney"  cssClass="ui-widget-content payManage"  
									     		value="%{getText('bs.format.numberRMB',{e.payMoney})}"  data-validate="money" />
										</s:if><s:elseif test="%{isPayRead()}">
											<s:textfield name="e.payMoney"  cssClass="ui-widget-content"  readonly="true" 
									     		value="%{getText('bs.format.numberRMB',{e.payMoney})}"  data-validate="money" />
										</s:elseif><s:elseif test="%{e.payMoney!=null&&e.payMoney>0}">
											<s:textfield name="e.payMoney" readonly="true" cssClass="ui-widget-content"  
									     		value="******"  />
										</s:elseif><s:else>
											<s:textfield name="e.payMoney" readonly="true" cssClass="ui-widget-content" />
										</s:else>
								     	</samp>
								    </td>
								</tr> 
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td class="label">
										<samp id="pay"   style='<s:if test="%{e.pay}">display:block;</s:if><s:else>display:none;</s:else>'>
									   		  司机受款说明:
								     	</samp>
								    </td>
									<td class="value">
										<samp id="pay"   style='<s:if test="%{e.pay}">display:block;</s:if><s:else>display:none;</s:else>'>
										<s:if test="%{isPayManage()}">
											<s:textfield name="e.payDesc"  cssClass="ui-widget-content payManage"  />
										</s:if><s:elseif test="%{isPayRead()}">
											<s:textfield name="e.payDesc" readonly="true" cssClass="ui-widget-content"  />
										</s:elseif><s:elseif test="%{e.payDesc!=null&&e.payDesc.length()>0}">
											<s:textfield name="e.payDesc"  readonly="true" value="******" cssClass="ui-widget-content"  />
										</s:elseif><s:else>
											<s:textfield name="e.payDesc" readonly="true" cssClass="ui-widget-content"  />
										</s:else>
								     	</samp>
								    </td>
								</tr>
							</tbody>
						</table>
					</fieldset>	
					
					<samp id="idSecondDeliver" style='<s:if test="%{e.deliverSecond}">display:block;</s:if><s:else>display:none;</s:else>'>
					<fieldset id="" style="margin: 6px;" class="ui-widget-content">
					<legend>二次送保</legend>
						<table class="formFields ui-widget-content" cellspacing="3" cellpadding="0">
							<tbody>
								<tr style="line-height: 1px;">
									<td style="width: 110px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 160px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 140px;">&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
								<tr>
									<td class="label">
										<s:checkbox name="e.deliverTwo" cssStyle="width:1em;" /><s:text name="runcase.deliver3"/>
									</td>
									<td></td>
									<td class="label">
										<samp id="deliverTwo" style='<s:if test="%{e.deliverTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
												<s:checkbox name="e.claimTwo" cssStyle="width:1em;" /><s:text name="runcase.claim"/>
										</samp>
									</td>
									<td></td>
									<td class="label">
										<samp id="claimTwo" style='<s:if test="%{e.claimTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
									     	<s:if test="%{isPayManage()}">
													<s:checkbox name="e.payTwo"  cssStyle="width:1em;" cssClass="payManage"/>
											</s:if><s:else>
													<s:checkbox name="e.payTwo" onclick="return false" ondblclick="return false" cssStyle="width:1em;" />
											</s:else><s:text name="runcase.pay"/>
									     </samp>
									</td>
									<td></td>
								</tr>
								<tr>
									<td class="label">
										<samp id="deliverTwo" style='<s:if test="%{e.deliverTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
									      		&nbsp;&nbsp;<s:text name="runcase.deliverDate2"/>:
								       </samp>
								    </td>
									<td class="value" >
										<samp id="deliverTwo" style='<s:if test="%{e.deliverTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
											    <div style="position : relative; display: block">
												    <s:if test="%{isManage()}">
														<input type="text" name="e.deliverDateTwo" data-validate='{"type": "date"}'
															value='<s:date format="yyyy-MM-dd" name="e.deliverDateTwo" />'
															class="bc-date ui-widget-content"  />
														<ul class="inputIcons" style="right : 0px;">
															<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.deliverDateTwo' ></li>
													    </ul>
													</s:if><s:else>
														<input type="text" name="e.deliverDateTwo" data-validate='{"type": "date"}'
															value='<s:date format="yyyy-MM-dd" name="e.deliverDateTwo" />'
															class="ui-widget-content"  />
													</s:else>
												</div>
										</samp>
									</td>
									<td class="label">
										<samp id="claimTwo" style='<s:if test="%{e.claimTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
									   		&nbsp;&nbsp;<s:text name="runcase.claimDate"/>:
								     	</samp>
								    </td>
									<td class="value"> 
										<samp id="claimTwo" style='<s:if test="%{e.claimTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
												<div style="position : relative; display: block">
													<s:if test="%{isManage()}">
														<input type="text" name="e.claimDateTwo" data-validate='{"type": "date"}'
												    		value='<s:date format="yyyy-MM-dd" name="e.claimDateTwo" />'
												   			 class="bc-date ui-widget-content" />
											   			 <ul class="inputIcons" style="right : 0px;">
															<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.claimDateTwo' ></li>
													    </ul>
													</s:if><s:else>
														<input type="text" name="e.claimDateTwo" data-validate='{"type": "date"}'
												    		value='<s:date format="yyyy-MM-dd" name="e.claimDateTwo" />'
												   			 class="ui-widget-content" />
													</s:else>
												</div>
										 </samp>
									</td>
									<td class="label"  >
										<samp id="payTwo" style='<s:if test="%{e.payTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
												<s:text name="runcase.driverName"/>:
										</samp>
									</td>
									<td class="value">
										<samp id="payTwo" style='<s:if test="%{e.payTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
												<div style="position:relative;display: inline-block" >
											 		<s:if test="%{isPayManage()}">
														<s:textfield name="e.payDriverTwo" cssStyle="width:8em;"  readonly="true" cssClass="ui-widget-content"/>
														<ul class="inputIcons">
												 			<li class="payManage selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectPayDriverTwo">
												 		</ul>
													</s:if><s:else>
														<s:textfield name="e.payDriverTwo" cssStyle="width:8em;"  readonly="true" cssClass="ui-widget-content"/>
													</s:else> 
												</div>
										</samp>
									</td>								
								</tr>
								<tr>
									<td class="label"> 
										<samp id="deliverTwo" style='<s:if test="%{e.deliverTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
									    	<s:text name="runcase.deliverMoney"/>(元):
								     	</samp>
								     </td>
									<td class="value">
										<samp id="deliverTwo" style='<s:if test="%{e.deliverTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
									     		<s:textfield name="e.deliverMoneyTwo"  cssClass="ui-widget-content"
									     			 value="%{getText('bs.format.numberRMB',{e.deliverMoneyTwo})}"  data-validate="money" />
								     	</samp>
								    </td>
									<td class="label">
										<samp id="claimTwo" style='<s:if test="%{e.claimTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
									    		<s:text name="runcase.claimMoney"/>(元):
								     	</samp>
								    </td>
									<td class="value"> 
										<samp id="claimTwo" style='<s:if test="%{e.claimTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
									    		 <s:textfield name="e.claimMoneyTwo"  cssClass="ui-widget-content" 
									    		 		value="%{getText('bs.format.numberRMB',{e.claimMoneyTwo})}"  data-validate="money" />
								     	</samp>
								    </td>
									<td class="label">
										<samp id="payTwo" style='<s:if test="%{e.payTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
									      		<s:text name="runcase.payDate"/>:
								      	</samp>
								    </td>
									<td class="value">
										<samp id="payTwo" style='<s:if test="%{e.payTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
										    <div style="position : relative; display: inline-block">
										    	<s:if test="%{isPayManage()}">
													<input type="text" name="e.payDateTwo" data-validate='{"type": "date"}'
													    value='<s:date format="yyyy-MM-dd" name="e.payDateTwo" />'
													    class="bc-date ui-widget-content"  />
													  <ul class="inputIcons" style="right : 0px;">
															<li class="payManage selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.payDateTwo' ></li>
													  </ul>
												</s:if><s:else>
													<input type="text" name="e.payDateTwo" data-validate='{"type": "date"}'
													    value='<s:date format="yyyy-MM-dd" name="e.payDateTwo" />'
													    class="ui-widget-content"  />
												</s:else> 
											</div>
										</samp>
								</td>
								</tr>
								<tr>
									<td class="label"> </td>
									<td class="value"></td>
									<td></td>
									<td></td>
									<td class="label">
										<samp id="payTwo" style='<s:if test="%{e.payTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
									    		<s:text name="runcase.payMoney"/>(元):
								     	</samp>
								    </td>
									<td class="value">
										<samp id="payTwo" style='<s:if test="%{e.payTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
										<s:if test="%{isPayManage()}">
											<s:textfield name="e.payMoneyTwo"  cssClass="ui-widget-content payManage"  
									     		value="%{getText('bs.format.numberRMB',{e.payMoneyTwo})}"  data-validate="money" />
										</s:if><s:elseif test="%{isPayRead()}">
											<s:textfield name="e.payMoneyTwo"  cssClass="ui-widget-content"  readonly="true" 
									     		value="%{getText('bs.format.numberRMB',{e.payMoneyTwo})}"  data-validate="money" />
										</s:elseif><s:elseif test="%{e.payMoney!=null&&e.payMoney>0}">
											<s:textfield name="e.payMoneyTwo" readonly="true" cssClass="ui-widget-content"  
									     		value="******"  />
										</s:elseif><s:else>
											<s:textfield name="e.payMoneyTwo" readonly="true" cssClass="ui-widget-content" />
										</s:else>
								     	</samp>
								     </td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td class="label">
										<samp id="payTwo"  style='<s:if test="%{e.payTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
									   		  司机受款说明:
								     	</samp>
								    </td>
									<td class="value">
										<samp id="payTwo"  style='<s:if test="%{e.payTwo}">display:block;</s:if><s:else>display:none;</s:else>'>
										<s:if test="%{isPayManage()}">
											<s:textfield name="e.payDescTwo"  cssClass="ui-widget-content payManage"  />
										</s:if><s:elseif test="%{isPayRead()}">
											<s:textfield name="e.payDescTwo" readonly="true" cssClass="ui-widget-content"  />
										</s:elseif><s:elseif test="%{e.payDescTwo!=null&&e.payDescTwo.length()>0}">
											<s:textfield name="e.payDescTwo"  readonly="true" value="******" cssClass="ui-widget-content"  />
										</s:elseif><s:else>
											<s:textfield name="e.payDescTwo" readonly="true" cssClass="ui-widget-content"  />
										</s:else>
								     	</samp>
								   </td>
								 </tr>
							</tbody>
						</table>
					</fieldset>	
					</samp>
				</div>
			</div>
			
			<!-- 事故截图 -->
			<div  class="formTable2 ui-widget-content"  style="width:800px;">
				<div class="ui-widget-header title" style="position:relative;">
						<span class="text" >事故截图:</span>
						<span id="ShowGroups3" class="verticalMiddle ui-icon ui-icon-carat-1-s" title='<s:text name="runcase.title.click2ShowGroups"/>'></span>
						<span id="HiddenGroups3" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="runcase.title.click2HiddenGroups"/>'></span>
				</div>
				<div id="Groups3">
						 <s:property value="%{attachsUI}" escapeHtml="false"/>
				</div>
			</div>
			
			<!-- 状态 -->
			<table class="formFields ui-widget-content" cellspacing="2" cellpadding="0" style="width:800px;" >
				<tbody>
				<tr>
					<td style="height: 1px;"></td>
					<td style="width: 350px;">&nbsp;</td>
					<td style="width: 60px;">&nbsp;</td>
					<td style="width: 350px;">&nbsp;</td>
				</tr>
				<tr>
					<td class="label" colspan="4">
							<div class="formTopInfo">
								状态：<s:property value="%{statusesValue[e.status]}" /> ,
								<s:if test="%{e.closerId != null}">
								    结案人：<s:property value="e.closerName" />(<s:date name="e.closeDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
								&nbsp;&nbsp;&nbsp;&nbsp;登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
								<s:if test="%{e.modifier != null}">
								  最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
							</div>
					</td>
				</tr>
				</tbody>
			</table>		
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.carId" />
		<s:hidden name="e.driverId" />
		<s:hidden name="e.status" />
		<s:hidden name="e.closerId" />
		<s:hidden name="e.receiverId" />
		<s:hidden name="e.chargerId" />
		<s:hidden name="isClosed" />
		<s:hidden name="isMoreCar" />
		<s:hidden name="isMoreCarMan" />
		<s:hidden name="carManId" />
		<s:hidden name="carId" />
		<s:hidden name="isNullCarMan" />
		<s:hidden name="isNullCar" />
		<s:hidden name="e.motorcadeName" />
		<s:hidden name="e.payDriverId" />
		<s:hidden name="e.payDriverIdTwo" />
		<input type="hidden" name="isPayManage" value='<s:property value="%{isPayManage()}" />'/>
		<input type="hidden" name="isPayRead" value='<s:property value="%{isPayRead()}" />'/>
		<input type="hidden" name="isManage" value='<s:property value="%{isManage()}" />'/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>