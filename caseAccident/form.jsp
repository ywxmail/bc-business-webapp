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
					<tr>
						<td style="height: 1px;"></td>
						<td style="width: 350px;">&nbsp;</td>
						<td style="width: 60px;">&nbsp;</td>
						<td style="width: 350px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.caseNo3"/>:</td>
						<td class="value "><s:textfield name="e.code"  data-validate="required" cssClass="ui-widget-content"/></td>
						<td class="label">*<s:text name="runcase.address"/>:</td>
						<td class="value "><s:textfield name="e.address" data-validate="required" cssClass="ui-widget-content"/></td>
					</tr>
					
					<tr>
						<td class="label" ><s:text name="runcase.sort"/>:</td>
						<td class="value" >
							<s:select name="e.sort" list="sortList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
						</td>
						<td class="label"><s:text name="runcase.weather"/>:</td>
						<td class="value "><s:textfield name="e.weather" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.duty"/></td>
						<td class="value">
						<s:select name="e.duty" list="dutyList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
						</td>
						<td class="label" >*<s:text name="runcase.happenDate"/>:</td>
						<td class="value" >
							<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
							value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.happenDate" />'
							class="bc-datetime" data-cfg='{showSecond:true,timeFormat:"hh:mm:ss"}'/>
						</td>
					</tr>
					<tr>
					<s:if test="%{carManId != null || carId !=null }">
						<td class="label">*<s:text name="runcase.carPlate"/>:</td>
						<td class="value"><s:textfield name="e.carPlate"  readonly="true" cssClass="ui-state-disabled ui-widget-content" /></td>
					    </s:if><s:else>
					    <td class="label">*<s:text name="runcase.carPlate"/>:</td>
						<td class="value" style="position:relative;display: block;"><s:textfield name="e.carPlate" 
					    data-validate="required" cssClass="ui-widget-content" readonly="true"/>
					    <span id="selectCar" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></span>
					    </td>
					    </s:else>
						<td class="label">*<s:text name="runcase.receiveDate2"/>:</td>
						<td class="value">
							<input type="text" name="e.receiveDate" data-validate='{"type":"datetime","required":true}'
							value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.receiveDate" />'
							class="bc-datetime" data-cfg='{showSecond:true,timeFormat:"hh:mm:ss"}'/>
						</td>
					</tr>
					<tr>
					    <td class="label" ><s:text name="runcase.motorcadeName"/>:</td>
						<td class="value" >
							<s:select name="e.motorcadeId" list="motorcadeList" listKey="key" listValue="value" value="e.motorcadeId" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
						</td>
						<td class="label" ><s:text name="runcase.receiveCode"/>:</td>
						<td class="value "><s:textfield name="e.receiveCode" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<s:if test="%{carManId != null || carId !=null}">
						<td class="label"><s:text name="runcase.driverName"/>:</td>
						<td class="value"><s:textfield name="e.driverName" cssStyle="width:8em;" readonly="true" cssClass="ui-state-disabled ui-widget-content" />
						&nbsp;&nbsp;<s:text name="runcase.driverCert" />:<s:textfield name="e.driverCert" readonly="true" data-validate="required" cssStyle="width:10em;" cssClass="ui-state-disabled ui-widget-content"/></td>
					    </s:if><s:else>
					    <td class="label"><s:text name="runcase.driverName"/>:</td>
						<td class="value"><s:textfield name="e.driverName" cssStyle="width:8em;"  readonly="true" cssClass="ui-state-disabled ui-widget-content"/>
						&nbsp;&nbsp;<s:text name="runcase.driverCert" />:<s:textfield name="e.driverCert" readonly="true" data-validate="required" cssStyle="width:10em;" cssClass="ui-state-disabled ui-widget-content"/></td>
					     </s:else>
						<td class="label"><s:text name="runcase.department"/>:</td>
						<td class="value "><s:select name="e.department" list="departmentList" listKey="value" listValue="value"  headerKey="" headerValue=""  cssClass="ui-widget-content"/>
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.driverArea"/>:</td>
						<td class="value">
								<s:select list="#{0:'',1:'本市',2:'本省',3:'外省'}" listKey="key" listValue="value"  cssStyle="width:8em;"  headerValue="" name="e.driverArea" cssClass="ui-widget-content"/>
								&nbsp;&nbsp;司机<s:text name="runcase.origin"/>:
								<s:textfield name="e.origin" cssStyle="width:8em;"  cssClass="ui-widget-content"/>
						</td>
						<td class="label" ><s:text name="runcase.receiverName2"/>:</td>
						<td class="value relative"><s:textfield name="e.receiverName"  />
						<ul class="inputIcons">
							 <li id="selectReceiver" class=" inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
						</ul>
						</td>
					</tr>
					<tr>
					    <td class="label"><s:text name="runcase.driverClasses"/></td>
						<td class="value">
								<s:select name="e.driverClasses" list="#{0:'',1:'正班',2:'副班',3:'顶班'}" listKey="key" listValue="value" cssStyle="width:8em;"  data-validate="required" cssClass="ui-widget-content"/>
								&nbsp;&nbsp;<s:text name="runcase.driverType"/>:
								<s:select name="e.driverType" list="#{0:'',1:'车主',2:'司机',3:'非编'}" listKey="key" listValue="value" cssStyle="width:8em;" cssClass="ui-widget-content"/>
						</td>
						<td class="label"><s:text name="runcase.principal" />:</td>
						<td class="value relative"><s:textfield name="e.chargerName" cssClass="ui-widget-content"/>
						<ul class="inputIcons">
							 <li id="selectPrincipal" class=" inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
						</ul>
						</td>					
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="runcase.jingguo"/>:</td>
						<td class="value" colspan="3" ><s:textarea name="e.description" rows="5" cssClass="ui-widget-content noresize"/>
						</td>
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
					<fieldset style="margin: 6px;" class="ui-corner-all ui-widget-content">
					<legend>自车</legend>
						<table class="formFields ui-widget-content" cellspacing="2" cellpadding="0">
							<tbody>
								<tr style="line-height: 1px;">
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 260px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
								<tr>
									<td class="label"><s:checkbox name="e.innerFix" cssStyle="width:1em;" /><s:text name="runcase.innerFix"/></td>
									<td class="value">
											<s:text name="runcase.fixCost" />(元):<s:textfield name="e.fixCost" cssClass="ui-widget-content" cssStyle="width:184px;"
												    value="%{getText('bs.format.numberRMB',{e.fixCost})}"  data-validate="money"  />
									</td>
									<td class="label"><s:text name="runcase.claimAmount" />(元):</td>
									<td class="value"><s:textfield name="e.claimAmount" cssClass="ui-widget-content"  
																   value="%{getText('bs.format.numberRMB',{e.claimAmount})}"  data-validate="money" /></td>
								</tr>
								<tr>
									<td class="label"><s:text name="runcase.trailerCost" />(元):</td>
									<td class="value"><s:textfield name="e.carmanCost" cssClass="ui-widget-content" cssStyle="width:250px;" 
																   value="%{getText('bs.format.numberRMB',{e.carmanCost})}"  data-validate="money" /></td>
									<td class="label"><s:text name="runcase.carWounding" />(元):</td>
									<td class="value"><s:textfield name="e.carWounding" cssClass="ui-widget-content" 
																   value="%{getText('bs.format.numberRMB',{e.carWounding})}"  data-validate="money" /></td>
								</tr>
								<tr>
									<td class="label"><s:text name="runcase.carHurt" />:</td>
									<td class="value"><s:textfield name="e.carHurt" cssClass="ui-widget-content" cssStyle="width:250px;" /></td>
									<td class="label"></td>
									<td class="value"></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
					<fieldset style="margin: 6px;" class="ui-corner-all ui-widget-content">
					<legend>第三者</legend>
						<table class="formFields ui-widget-content" cellspacing="2" cellpadding="0">
							<tbody>
								<tr style="line-height: 1px;">
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 260px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
									<tr>
									<td class="label"><s:text name="runcase.thirdLoss" />(元):</td>
									<td class="value"><s:textfield name="e.thirdLoss" cssClass="ui-widget-content" cssStyle="width:250px;"
																   value="%{getText('bs.format.numberRMB',{e.thirdLoss})}"  data-validate="money"  /></td>
									<td class="label"><s:text name="runcase.trailerCost" />(元):</td>
									<td class="value"><s:textfield name="e.thirdCost" cssClass="ui-widget-content"  /></td>
								</tr>
								<tr>
									<td class="label"><s:text name="runcase.third.hurt" />(元):</td>
									<td class="value"><s:textfield name="e.thirdWounding" cssClass="ui-widget-content" cssStyle="width:250px;" 
																   value="%{getText('bs.format.numberRMB',{e.thirdWounding})}"  data-validate="money" /></td>
									<td class="label"><s:text name="runcase.medicalFee" />(元):</td>
									<td class="value"><s:textfield name="e.medicalFee" cssClass="ui-widget-content" 
																   value="%{getText('bs.format.numberRMB',{e.medicalFee})}"  data-validate="money"  /></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
					<fieldset style="margin: 6px;" class="ui-corner-all ui-widget-content">
						<legend>总体损失</legend>	
						<table  class="formFields ui-widget-content" cellspacing="2" cellpadding="0">
								<tbody>
									<tr style="line-height: 1px;">
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 260px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
									<tr>
										<td class="label"><s:text name="runcase.hurtCount"/>:</td>
										<td class="value"><s:textfield name="e.hurtCount" cssClass="ui-widget-content" cssStyle="width:85px;" data-validate="number"/>
										<s:text name="runcase.deadCount"/>:
										<s:textfield name="e.deadCount" cssClass="ui-widget-content" cssStyle="width:85px;" data-validate="number"/></td>
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
					<fieldset style="margin: 6px;" class="ui-corner-all ui-widget-content">
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
									<td class="label"><samp id="deliver" style='<s:if test="%{e.deliver==true}">
										  display:block;
									      </s:if>
									      <s:else>
										 display:none;
									      </s:else>
									      '>
									<s:checkbox name="e.claim" cssStyle="width:1em;" /><s:text name="runcase.claim"/>
									</samp>
									</td>
									<td></td>
									<td class="label"><samp id="claim" style='<s:if test="%{e.claim==true}">
										 display:block;
									     </s:if>
									     <s:else>
										display:none;
									     </s:else>
									     '>
									<s:checkbox name="e.pay" cssStyle="width:1em;" /><s:text name="runcase.pay"/>
									</samp>
									</td>
									<td></td>
								</tr>
								<tr>
									<td class="label"><samp id="deliver" style='<s:if test="%{e.deliver==true}">
										  display:block;
									      </s:if>
									      <s:else>
										 display:none;
									      </s:else>
									      '>
									      &nbsp;&nbsp;<s:text name="runcase.deliverDate2"/>:
								       </samp></td>
									<td class="value" ><samp id="deliver" style='<s:if test="%{e.deliver==true}">
										 display:block;
									     </s:if>
									     <s:else>
										display:none;
									     </s:else>
									    '>
									     <input type="text" name="e.deliverDate" data-validate='{"type": "date"}'
											value='<s:date format="yyyy-MM-dd" name="e.deliverDate" />'
											class="bc-date"  /></samp></td>
									<td class="label"><samp id="claim" style='<s:if test="%{e.claim==true}">
										display:block;
									    </s:if>
									    <s:else>
										display:none;
									    </s:else>
									    '>
									   &nbsp;&nbsp;<s:text name="runcase.claimDate"/>:
								     </samp></td>
									<td class="value"> <samp id="claim" style='<s:if test="%{e.claim==true}">
										 display:block;
									     </s:if>
									     <s:else>
										display:none;
									     </s:else>
									     '>
									     <input type="text" name="e.claimDate" data-validate='{"type": "date"}'
									    value='<s:date format="yyyy-MM-dd" name="e.claimDate" />'
									    class="bc-date"  /></samp></td>
									<td class="label"  ><samp id="pay" style='<s:if test="%{e.pay==true}">
										 display:block;
									     </s:if>
									     <s:else>
										 display:none;
									     </s:else>
									     '>
									<s:text name="runcase.driverName"/>: </samp></td>
									<td class="value relative">
									<samp id="pay" style='<s:if test="%{e.pay==true}">display:block;</s:if><s:else> display:none; </s:else>'>
								    	 <div class="input ui-widget-content"  >
								     			<span class="link showCarMan" data-cfg='<s:property value="e.payDriverId"/>' id="carManInfo" >
								     			<s:property value="%{e.payDriver}" /></span>
								      	</div>
								      	<ul class="inputIcons">
								        		<li class="selectCarMan inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>' 
								        		data-cfg='e.payDriverId=id,e.payDriver=name,carManInfo=name|text'></li>
								      	</ul>
										</samp>	
									</td>								
								</tr>
								<tr>
									<td class="label"> <samp id="deliver" style='<s:if test="%{e.deliver==true}">
										display:block;
									    </s:if>
									    <s:else>
										display:none;
									    </s:else>
									    '>
									    <s:text name="runcase.deliverMoney"/>(元):
								     </samp></td>
									<td class="value"><samp id="deliver" style='<s:if test="%{e.deliver==true}">
										 display:block;
									     </s:if>
									     <s:else>
										 display:none;
									     </s:else>
									     '>
									     <s:textfield name="e.deliverMoney"  cssClass="ui-widget-content" value="%{getText('bs.format.numberRMB',{e.deliverMoney})}"  data-validate="money" />
								     </samp></td>
									<td class="label"><samp id="claim" style='<s:if test="%{e.claim==true}">
										display:block;
									    </s:if>
									    <s:else>
										display:none;
									    </s:else>
									    '>
									    <s:text name="runcase.claimMoney"/>(元):
								     </samp></td>
									<td class="value"> <samp id="claim" style='<s:if test="%{e.claim==true}">
										 display:block;
									     </s:if>
									     <s:else>
										 display:none;
									     </s:else>
									     '>
									     <s:textfield name="e.claimMoney"  cssClass="ui-widget-content"  value="%{getText('bs.format.numberRMB',{e.claimMoney})}"  data-validate="money" />
								     </samp></td>
									<td class="label"><samp id="pay" style='<s:if test="%{e.pay==true}">
										  display:block;
									      </s:if>
									      <s:else>
										  display:none;
									      </s:else>
									      '>
									      <s:text name="runcase.payDate"/>:
								      </samp></td>
									<td class="value"><samp id="pay" style='<s:if test="%{e.pay==true}">
										 display:block;
									     </s:if>
									     <s:else>
										 display:none;
									     </s:else>
									    '>
									     <input type="text" name="e.payDate" data-validate='{"type": "date"}'
									    value='<s:date format="yyyy-MM-dd" name="e.payDate" />'
									    class="bc-date"  /></samp></td>
								</tr>
								<tr>
									<td class="label"> 
									<samp id="deliver" style='<s:if test="%{e.deliver==true}">
										  display:block;
									      </s:if>
									      <s:else>
										  display:none;
									      </s:else>
									      '>
									       使用<s:text name="runcase.deliver3Two"/>:
								       </samp> 
									 </td>
									<td class="value"><samp id="deliver" style='width:auto;<s:if test="%{e.deliver==true}" >
										  display:block;
									      </s:if>
									      <s:else>
										  display:none;
									      </s:else>
									      '>
									        <s:checkbox name="e.deliverSecond" style='width:auto;' />
								       </samp></td>
									<td></td>
									<td></td>
									<td class="label"><samp id="pay" style='<s:if test="%{e.pay==true}">
										display:block;
									    </s:if>
									    <s:else>
										display:none;
									    </s:else>
									    '>
									    <s:text name="runcase.payMoney"/>(元):
								     </samp></td>
									<td class="value"><samp id="pay" style='<s:if test="%{e.pay==true}">
										 display:block;
									     </s:if>
									     <s:else>
										 display:none;
									     </s:else>
									     '>
									     <s:textfield name="e.payMoney"  cssClass="ui-widget-content"  value="%{getText('bs.format.numberRMB',{e.payMoney})}"  data-validate="money" />
								     </samp></td>
								</tr>
							</tbody>
						</table>
					</fieldset>	
					
					<fieldset id="idSecondDeliver" style="margin: 6px;" class="ui-corner-all ui-widget-content">
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
									<td class="label"><s:checkbox name="e.deliverTwo" cssStyle="width:1em;" /><s:text name="runcase.deliver3"/></td>
									<td></td>
									<td class="label"><samp id="deliverTwo" style='<s:if test="%{e.deliverTwo==true}">
										  display:block;
									      </s:if>
									      <s:else>
										  display:none;
									      </s:else>
									      '>
										<s:checkbox name="e.claimTwo" cssStyle="width:1em;" /><s:text name="runcase.claim"/></samp></td>
									<td></td>
									<td class="label"><samp id="claimTwo" style='<s:if test="%{e.claimTwo==true}">
										 display:block;
									     </s:if>
									     <s:else>
										 display:none;
									     </s:else>
									     '>
									     <s:checkbox name="e.payTwo" cssStyle="width:1em;" /><s:text name="runcase.pay"/></samp></td>
									<td></td>
								</tr>
								<tr>
									<td class="label"><samp id="deliverTwo" style='<s:if test="%{e.deliverTwo==true}">
										  display:block;
									      </s:if>
									      <s:else>
										  display:none;
									      </s:else>
									      '>
									      &nbsp;&nbsp;<s:text name="runcase.deliverDate2"/>:
								       </samp></td>
									<td class="value" ><samp id="deliverTwo" style='<s:if test="%{e.deliverTwo==true}">
										 display:block;
									     </s:if>
									     <s:else>
										 display:none;
									     </s:else>
									    '>
									     <input type="text" name="e.deliverDateTwo" data-validate='{"type": "date"}'
											value='<s:date format="yyyy-MM-dd" name="e.deliverDateTwo" />'
											class="bc-date"  /></samp></td>
									<td class="label"><samp id="claimTwo" style='<s:if test="%{e.claimTwo==true}">
										display:block;
									    </s:if>
									    <s:else>
										display:none;
									    </s:else>
									    '>
									   &nbsp;&nbsp;<s:text name="runcase.claimDate"/>:
								     </samp></td>
									<td class="value"> <samp id="claimTwo" style='<s:if test="%{e.claimTwo==true}"> display:block; </s:if> <s:else> display:none;</s:else>'>
									     <input type="text" name="e.claimDateTwo" data-validate='{"type": "date"}'
									    		value='<s:date format="yyyy-MM-dd" name="e.claimDateTwo" />'
									   			 class="bc-date" /></samp>
									   			 </td>
									<td class="label"  ><samp id="payTwo" style='<s:if test="%{e.payTwo==true}"> display:block;</s:if><s:else> display:none; </s:else> '>
											<s:text name="runcase.driverName"/>: </samp>
											</td>
									<td class="value relative">
									<samp id="payTwo" style='<s:if test="%{e.payTwo==true}"> display:block;</s:if><s:else> display:none;</s:else>'>
										<div class="input ui-widget-content" >
								     			<span class="link showCarMan" data-cfg='<s:property value="e.payDriverIdTwo"/>' id="carManInfo" >
								     			<s:property value="%{e.payDriverTwo}" /></span>
								      	</div>
								      	<ul class="inputIcons">
								        		<li class="selectCarMan inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>' 
								        		data-cfg='e.payDriverIdTwo=id,e.payDriverTwo=name,carManInfo=name|text'></li>
								      	</ul>
								      
									</samp>
									</td>								
								</tr>
								<tr>
									<td class="label"> <samp id="deliverTwo" style='<s:if test="%{e.deliverTwo==true}">
										display:block;
									    </s:if>
									    <s:else>
										display:none;
									    </s:else>
									    '>
									    <s:text name="runcase.deliverMoney"/>(元):
								     </samp></td>
									<td class="value"><samp id="deliverTwo" style='<s:if test="%{e.deliverTwo==true}">
										 display:block;
									     </s:if>
									     <s:else>
										 display:none;
									     </s:else>
									     '>
									     <s:textfield name="e.deliverMoneyTwo"  cssClass="ui-widget-content" value="%{getText('bs.format.numberRMB',{e.deliverMoneyTwo})}"  data-validate="money" />
								     </samp></td>
									<td class="label"><samp id="claimTwo" style='<s:if test="%{e.claimTwo==true}">
										display:block;
									    </s:if>
									    <s:else>
										display:none;
									    </s:else>
									    '>
									    <s:text name="runcase.claimMoney"/>(元):
								     </samp></td>
									<td class="value"> <samp id="claimTwo" style='<s:if test="%{e.claimTwo==true}">
										 display:block;
									     </s:if>
									     <s:else>
										 display:none;
									     </s:else>
									     '>
									     <s:textfield name="e.claimMoneyTwo"  cssClass="ui-widget-content" value="%{getText('bs.format.numberRMB',{e.claimMoneyTwo})}"  data-validate="money" />
								     </samp></td>
									<td class="label"><samp id="payTwo" style='<s:if test="%{e.payTwo==true}">
										  display:block;
									      </s:if>
									      <s:else>
										  display:none;
									      </s:else>
									      '>
									      <s:text name="runcase.payDate"/>:
								      </samp></td>
									<td class="value"><samp id="payTwo" style='<s:if test="%{e.payTwo==true}">
										 display:block;
									     </s:if>
									     <s:else>
										 display:none;
									     </s:else>
									    '>
									     <input type="text" name="e.payDateTwo" data-validate='{"type": "date"}'
									    value='<s:date format="yyyy-MM-dd" name="e.payDateTwo" />'
									    class="bc-date"  /></samp></td>
								</tr>
								<tr>
									<td class="label"> </td>
									<td class="value"></td>
									<td></td>
									<td></td>
									<td class="label"><samp id="payTwo" style='<s:if test="%{e.payTwo==true}">
										display:block;
									    </s:if>
									    <s:else>
										display:none;
									    </s:else>
									    '>
									    <s:text name="runcase.payMoney"/>(元):
								     </samp></td>
									<td class="value"><samp id="payTwo" style='<s:if test="%{e.payTwo==true}">
										 display:block;
									     </s:if>
									     <s:else>
										 display:none;
									     </s:else>
									     '>
									     <s:textfield name="e.payMoneyTwo"  cssClass="ui-widget-content" value="%{getText('bs.format.numberRMB',{e.payMoneyTwo})}"  data-validate="money" />
								     </samp></td>
								</tr>
							</tbody>
						</table>
					</fieldset>	
					<fieldset style="margin: 6px;" class="ui-corner-all ui-widget-content">
						<legend>相关保单</legend>
								<table class="formFields ui-widget-content" cellspacing="2" cellpadding="0">
								<tbody>
									<tr>
										<td class="value" ><pre><s:property value="e.insuranceInfo" /></pre></td>
									</tr>
								</tbody>
						</table>
					</fieldset>
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
		<s:hidden name="e.payDriver" />
		<s:hidden name="e.payDriverIdTwo" />
		<s:hidden name="e.payDriverTwo" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>