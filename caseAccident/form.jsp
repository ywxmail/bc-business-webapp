<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="caseAccident.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/caseAccident/save" />'
	data-js='<s:url value="/bc-business/caseAccident/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.caseAccidentForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseAccidentForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:800px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td style="height: 1px;"></td>
						<td style="width: 350px;">&nbsp;</td>
						<td style="width: 60px;">&nbsp;</td>
						<td style="width: 350px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.caseNo3"/>:</td>
						<td class="value "><s:textfield name="e.address"  data-validate="required" /></td>
						<td class="label">*<s:text name="runcase.address"/>:</td>
						<td class="value "><s:textfield name="e.caseNo" data-validate="required" /></td>
					</tr>
					
					<tr>
						<td class="label" ><s:text name="runcase.sort"/>:</td>
						<td class="value" >
							<s:select name="e.duty" list="dutyList" listKey="value" listValue="value"  headerKey="" headerValue="" ></s:select>
						</td>
						<td class="label"><s:text name="runcase.weather"/>:</td>
						<td class="value "><s:textfield name="e.chargerName" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.duty"/></td>
						<td class="value">
						<s:select name="e.extent" list="degreeList" listKey="value" listValue="value" headerKey="" headerValue="" ></s:select>
						</td>
						<td class="label" ><s:text name="runcase.happenDate"/>:</td>
						<td class="value" >
							<s:select name="e.source" list="sourcesValue" listKey="key" listValue="value" value="e.source"  headerKey="" headerValue=""  ></s:select>
						</td>
					</tr>
					<tr>
						<td class="label" ><s:text name="runcase.motorcadeName"/>:</td>
						<td class="value" >
							<s:select name="e.motorcadeId" list="motorcadeList" listKey="id" listValue="name" value="e.motorcadeId" headerKey="" headerValue=""  ></s:select>
						</td>
						<td class="label">*<s:text name="runcase.receiveDate2"/>:</td>
						<td class="value">
							<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
							value='<s:date format="yyyy-MM-dd HH:mm" name="e.happenDate" />'
							class="bc-datetime" data-cfg='{changeYear:true}'/>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.carPlate"/>:</td>
						<td class="value ">
							<s:textfield name="e.carPlate" data-validate="required" readonly="true" />
						</td>
						<td class="label" ><s:text name="runcase.receiveCode"/>:</td>
						<td class="value ">
								<input type="text" name="e.receiveDate" data-validate='{"type": "date"}'
								value='<s:date format="yyyy-MM-dd" name="e.receiveDate" />'
								class="bc-date" data-cfg='{changeYear:true}'/>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.driverName" />:</td>
						<td>
							<s:textfield name="e.driverName" cssStyle="width:5em;" data-validate="required"/>&nbsp;&nbsp;<s:text name="runcase.driverCert" /><s:textfield name="e.driverCert"  data-validate="required" />
						</td>
						<td class="label"><s:text name="runcase.department"/>:</td>
						<td class="value "><s:textfield name="e.receiverName" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.driverArea"/>:</td>
						<td class="value "><s:textfield name="e.chargerName" /></td>
						<td class="label" ><s:text name="runcase.receiverName2"/>:</td>
						<td class="value" >
							<s:select name="e.duty" list="dutyList" listKey="value" listValue="value"  headerKey="" headerValue="" ></s:select>
						</td>
					</tr>
					<tr>
						<td class="label" ><s:text name="runcase.driverType"/>:</td>
						<td class="value" >
							<s:select name="e.sort" list="properitesList" listKey="value" listValue="value" headerKey="" headerValue="" ></s:select>
						</td>
						<td class="label">*<s:text name="runcase.principal" />:</td>
						<td class="value "><s:textfield name="e.code" data-validate='{"required":true,"type":"number"}'/></td>					
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.driverClasses"/></td>
						<td class="value">
						<s:select name="e.extent" list="degreeList" listKey="value" listValue="value" headerKey="" headerValue="" ></s:select>
						</td>
						<td class="label"><s:text name="runcase.status"/>:</td>
						<td class="value" ><s:radio name="e.type" list="#{'0':'在案','1':'结案'}" cssStyle="width:auto;"/></td>
					</tr>
					<tr>
						<td class="label" colspan="4">
							<div class="formTopInfo">
								<s:if test="%{e.status != null && statusesValue[e.status] != null}">
								状态：<s:property value="%{statusesValue[e.status]}" />，
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
				    <li class="tab ui-widget-content first active"><a href="#otherFormFields1" class="ui-state-default ui-state-active">事故经过</a></li>
					<li class="tab ui-widget-content"><a href="#otherFormFields2" class="ui-state-default">损伤情况</a></li>
					<li class="tab ui-widget-content"><a href="#otherFormFields3" class="ui-state-default">理赔情况</a></li>
					<li class="tab ui-widget-content"><a href="#otherFormFields4" class="ui-state-default">事故现场图</a></li>
                </ul>
            	</div>
	        </div>
	        <div class="contentContainer ui-helper-reset ui-widget-content">
	        	<div id="otherFormFields1" class="content active" style="width:800px;height:600px">
					<table class="formFields" cellspacing="2" cellpadding="0" >
						<tbody>
							<tr>
								<td class="value" colspan="4" ><s:textarea name="e.comment" cssStyle="width:59.7em" rows="10" /></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="otherFormFields2" class="content" style="width:800px;">
					<table class="formFields" cellspacing="2" cellpadding="0" >
						<tbody>
							<tr style="height: 1px;line-height: 1px;">
								<td style="width: 80px;">&nbsp;</td>
								<td style="width: 350px;">&nbsp;</td>
								<td style="width: 80px;">&nbsp;</td>
								<td style="width: 350px;">&nbsp;</td>
							</tr>
							<tr>
							   <td class="label">*<s:text name="runcase.casualties"/>:</td>
						       <td class="value "><s:textfield name="e.address"  data-validate="required" cssStyle="width:20em;" /></td>
						       <td class="label">*<s:text name="runcase.costDetail"/>:</td>
						       <td class="value"></td>
							</tr>
							<tr>
							   <td class="label">*<s:text name="runcase.carHurt"/>:</td>
						       <td class="value "><s:textfield name="e.address"  data-validate="required" cssStyle="width:20em;"/></td>
						       <td class="value " colspan="2" rowspan="5"><s:textarea name="e.comment" cssStyle="width:29.4em" rows="7" /></td>	
							</tr>
							<tr>
							   <td class="label">*<s:text name="runcase.thirdParty"/>:</td>
						       <td class="value "><s:textfield name="e.address"  data-validate="required" cssStyle="width:16em;"/>
						       <s:checkbox name="e.stop" cssStyle="width:1em;" /><s:text name="runcase.rob"/></td>
							</tr>
							<tr>
							  <td class="label">*<s:text name="runcase.hurtCount" />:</td>
						<td>
							<s:textfield name="e.driverName" cssStyle="width:7em;" data-validate="required"/>&nbsp;&nbsp;<s:text name="runcase.deadCount" /><s:textfield name="e.driverCert"  data-validate="required" cssStyle="width:7em;"/>
						</td>
							</tr>
							<tr>
							   <td class="label">*<s:text name="runcase.actualLoss"/>:</td>
						       <td class="value "><s:textfield name="e.address"  data-validate="required" cssStyle="width:18em;"/>元</td>
							</tr>
							<tr>
							<td class="value "></td>	
						<td>
							<s:checkbox name="e.stop" cssStyle="width:1em;" /><s:text name="runcase.innerFix"/>&nbsp;&nbsp;<s:text name="runcase.fixCost" /><s:textfield name="e.driverCert"  data-validate="required" />元
						</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="otherFormFields3" class="content" style="width:800px;">
					<table class="formFields" cellspacing="2" cellpadding="0" ">
						<tbody>
							<tr style="height: 1px;line-height: 1px;">
								  <td style="width: 80px;">&nbsp;</td>
								  <td style="width: 350px;">&nbsp;</td>
								  <td style="width: 80px;">&nbsp;</td>
								  <td style="width: 350px;">&nbsp;</td>
							</tr>
							 <tr>
								   <td class="label">*<s:text name="runcase.insuranceCompany"/>:</td>
							       <td class="value "><s:textfield name="e.address"  data-validate="required" cssStyle="width:20em;" /></td>
							       <td class="label" style="width:700px">
							       <s:checkbox name="e.deliver" cssStyle="width:1em;" /><s:text name="runcase.deliver3"/>
							       <s:checkbox name="e.claim" cssStyle="width:1em;" /><s:text name="runcase.claim"/>
							       <s:checkbox name="e.pay" cssStyle="width:1em;" /><s:text name="runcase.pay"/></td>
							</tr>
							<tr>
								  <td class="label" style="text-align:left;" colspan="4">
								        <samp id="deliverDate2Title" style='<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										  visibility: visible;
									      </s:if>
									      <s:else>
										  visibility: hidden;
									      </s:else>
									      '>
									      &nbsp;&nbsp;<s:text name="runcase.deliverDate2"/>:
								      </samp>
								       <samp id="deliverDate2Value" style='width:80px;<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										 visibility: visible;
									     </s:if>
									     <s:else>
										 visibility: hidden;
									     </s:else>
									    '>
									     <input type="text" name="e.deliverDate" data-validate='{"type": "date"}'
									    value='<s:date format="yyyy-MM-dd" name="e.deliverDate" />'
									    class="bc-date" data-cfg='{changeYear:true}' style="width:80px "/>
								     </samp>
								     <samp id="deliverMoneyTitle" style='width:80px;<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										visibility: visible;
									    </s:if>
									    <s:else>
										visibility: hidden;
									    </s:else>
									    '>
									    <s:text name="runcase.deliverMoney"/>:
								     </samp>
								     <samp id="deliverMoneyValue" style="<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										 visibility: visible;
									     </s:if>
									     <s:else>
										 visibility: hidden;
									     </s:else>
									     ">
									     <input type="text" name="e.deliverMoney" style="width:80px "/>
								     </samp>
								   </td>
						    </tr>
						    <tr>     
						           <td class="label" style="text-align:left;"colspan="4"  >
								     <samp id="claimDateTitle" style='width:160px;<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										visibility: visible;
									    </s:if>
									    <s:else>
										visibility: hidden;
									    </s:else>
									    '>
									   &nbsp;&nbsp;<s:text name="runcase.claimDate"/>:
								     </samp>
								     <samp id="claimDateValue" style="<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										 visibility: visible;
									     </s:if>
									     <s:else>
										 visibility: hidden;
									     </s:else>
									     ">
									     <input type="text" name="e.claimDate" data-validate='{"type": "date"}'
									    value='<s:date format="yyyy-MM-dd" name="e.claimDate" />'
									    class="bc-date" data-cfg='{changeYear:true}' style="width:80px "/>
								     </samp>
								     <samp id="claimCodeTitle" style='width:80px;<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										visibility: visible;
									    </s:if>
									    <s:else>
										visibility: hidden;
									    </s:else>
									    '>
									    <s:text name="runcase.claimCode"/>:
								     </samp>
								     <samp id="claimCodeValue" style="<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										 visibility: visible;
									     </s:if>
									     <s:else>
										 visibility: hidden;
									     </s:else>
									     ">
									     <input type="text" name="e.claimCode" style="width:80px "/>
								     </samp>
								     <samp id="claimNo1Title" style='width:80px;<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										visibility: visible;
									    </s:if>
									    <s:else>
										visibility: hidden;
									    </s:else>
									    '>
									    <s:text name="runcase.claimNo1"/>:
								     </samp>
								     <samp id="claimNo1Value" style="<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										 visibility: visible;
									     </s:if>
									     <s:else>
										 visibility: hidden;
									     </s:else>
									     ">
									     <input type="text" name="e.claimNo1" style="width:80px "/>
								     </samp>
								     <samp id="claimNo1Title" style='width:80px;<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										visibility: visible;
									    </s:if>
									    <s:else>
										visibility: hidden;
									    </s:else>
									    '>
									    <s:text name="runcase.claimNo1"/>:
								     </samp>
								     <samp id="claimNo1Value" style="<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
										 visibility: visible;
									     </s:if>
									     <s:else>
										 visibility: hidden;
									     </s:else>
									     ">
									     <input type="text" name="e.claimNo1" style="width:80px "/>
								     </samp>
								   </td>
						    </tr>
							<tr>
							     <td class="label"><s:text name="runcase.insuranceInfo"/>:</td>
							</tr>
							<tr>
								 <td class="value" colspan="4"><s:textarea name="e.comment" cssStyle="width:59.4em" rows="5" /></td>
							</tr>
						</tbody>
					</table>
				</div>
	            <div id="otherFormFields4" class="content" style="width:800px;">
	                    <s:property value="%{attachsUI}" escapeHtml="false"/>
	        </div>
	      </div>
		</div>
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.motorcadeName" />
		<s:hidden name="e.carId" />
		<s:hidden name="e.driverId" />
		<s:hidden name="e.chargerId" />
		<s:hidden name="e.closerId" />
		<s:hidden name="e.status" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>