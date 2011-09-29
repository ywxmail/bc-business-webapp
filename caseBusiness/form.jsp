<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="caseBusiness.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/caseBusiness/save" />'
	data-js='<s:url value="/bc-business/caseBusiness/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.caseBusinessForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseBusinessForm" theme="simple">
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
						<td class="label">*<s:text name="runcase.subject"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.subject	" cssStyle="width:53.7em;" data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.address"/>:</td>
						<td class="value "><s:textfield name="e.address"  data-validate="required" /></td>
						<td class="label">*<s:text name="runcase.caseNo2"/>:</td>
						<td class="value "><s:textfield name="e.caseNo" data-validate="required" /></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="runcase.motorcadeName"/>:</td>
						<td class="value" >
							<s:select name="e.motorcadeId" list="motorcadeList" listKey="id" listValue="name" value="e.motorcadeId" headerKey="" headerValue=""  ></s:select>
						</td>
						<td class="label">*<s:text name="runcase.happenDate"/>:</td>
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
						<td class="label" ><s:text name="runcase.receiveDate1"/>:</td>
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
						<td class="label"><s:text name="runcase.receiverName1"/>:</td>
						<td class="value "><s:textfield name="e.receiverName" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.chargerName"/>:</td>
						<td class="value "><s:textfield name="e.chargerName" /></td>
						<td class="label" ><s:text name="runcase.duty"/>:</td>
						<td class="value" >
							<s:select name="e.duty" list="dutyList" listKey="value" listValue="value"  headerKey="" headerValue="" ></s:select>
						</td>
					</tr>
					<tr>
						<td class="label" ><s:text name="runcase.sort"/>:</td>
						<td class="value" >
							<s:select name="e.sort" list="properitesList" listKey="value" listValue="value" headerKey="" headerValue="" ></s:select>
						</td>
						<td class="label">*<s:text name="runcase.code" />:</td>
						<td class="value "><s:textfield name="e.code" data-validate='{"required":true,"type":"number"}'/></td>					
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.extent"/></td>
						<td class="value">
						<s:select name="e.extent" list="degreeList" listKey="value" listValue="value" headerKey="" headerValue="" ></s:select>
						</td>
						<td class="label" ><s:text name="runcase.source"/>:</td>
						<td class="value" >
							<s:select name="e.source" list="sourcesValue" listKey="key" listValue="value" value="e.source"  headerKey="" headerValue=""  ></s:select>
						</td>
					</tr>
					<tr>
						<td class="label">
							<div id="divTitle" style="
								<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
									visibility: visible;
								</s:if>
								<s:else>
									visibility: hidden;
								</s:else>
								">
								<s:text name="runcase.closeDate"/>:
							</div>
						</td>
						<td class="value">
							<div id="divValue" style="
								<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
									visibility: visible;
								</s:if>
								<s:else>
									visibility: hidden;
								</s:else>
								">
								<input type="text" name="e.closeDate" data-validate='{"type": "date"}'
								value='<s:date format="yyyy-MM-dd" name="e.closeDate" />'
								class="bc-date" data-cfg='{changeYear:true}'/>
							</div>
						</td>	
						<td></td>
						<td></td>
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
				    <li class="tab ui-widget-content first active"><a href="#otherFormFields1" class="ui-state-default ui-state-active">扣罚信息</a></li>
					<li class="tab ui-widget-content"><a href="#otherFormFields2" class="ui-state-default">具体内容</a></li>
					<li class="tab ui-widget-content"><a href="#otherFormFields3" class="ui-state-default">处理意见</a></li>
                </ul>
            	</div>
	        </div>
	        <div class="contentContainer ui-helper-reset ui-widget-content">
	        	<div id="otherFormFields1" class="content active" style="width:800px;">
					<table class="formFields" cellspacing="2" cellpadding="0" >
						<tbody>
							<tr>
								<td style="height: 1px;"></td>
								<td style="width: 350px;">&nbsp;</td>
								<td style="width: 90px;">&nbsp;</td>
								<td style="width: 350px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="label" colspan="2" style="text-align: center">扣<s:textfield name="e.jeom" data-validate='{"type":"number","required":true}' cssStyle="width:2.5em;"/>分,
								罚款<s:textfield name="e.penalty" data-validate='{"type":"number","required":true}' cssStyle="width:2.5em;"/>元,
								违约金<s:textfield name="e.penalty2" data-validate='{"type":"number","required":true}' cssStyle="width:2.5em;"/>元.</td>
								<td class="label"><s:text name="runcase.receipt"/>:</td>
								<td class="value"><s:textfield name="e.receipt" /></td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.detain"/>:</td>
								<td class="value" colspan="3"><s:textfield name="e.detain	" cssStyle="width:53.7em;"/></td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.confiscateCertNo" />:</td>
								<td class="value "><s:textfield name="e.confiscateCertNo" data-validate='{"type":"digits"}'/></td>					
								<td class="label" ><s:text name="runcase.confiscateCertType"/>:</td>
								<td class="value" >
									<s:select name="e.confiscateCertType" list="certList" listKey="value" listValue="value" headerKey="" headerValue="" ></s:select>
								</td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.operator" />:</td>
								<td class="value "><s:textfield name="e.operator" /></td>					
								<td class="label" ><s:text name="runcase.operateUnit"/>:</td>
								<td class="value" >
									<s:select name="e.operateUnit" list="departmentList" listKey="value" listValue="value" headerKey="" headerValue="" ></s:select>
								</td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.area" />:</td>
								<td class="value "><s:textfield name="e.area" /></td>		
								<td class="label"><s:text name="runcase.pullUnit" />:</td>
								<td class="value "><s:textfield name="e.pullUnit" /></td>					
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
								<td class="value" colspan="4"><s:textarea name="e.comment" cssStyle="width:59.7em; text-align:right" rows="4" /></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="value" colspan="4">
									<s:checkbox name="e.deliver" cssStyle="width:1em;" />
									<s:text name="runcase.deliver2"/>
									<s:checkbox name="e.seal" cssStyle="width:1em;" />
									<s:text name="runcase.seal"/>
									<s:checkbox name="e.stop" cssStyle="width:1em;" />
									<s:text name="runcase.stop"/>
								</td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="otherFormFields3" class="content" style="width:800px;">
					<table class="formFields" cellspacing="2" cellpadding="0" >
						<tbody>
							<tr>
								<td style="height: 1px;"></td>
								<td style="width: 350px;">&nbsp;</td>
								<td style="width: 90px;">&nbsp;</td>
								<td style="width: 350px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="value" colspan="4"><s:textarea name="e.comment" cssStyle="width:59.7em; text-align:right" rows="4" /></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="value" colspan="4">
									<s:checkbox name="e.invalid" cssStyle="width:1em;" />
									<s:text name="runcase.invalid"/>
									<s:checkbox name="e.overdue" cssStyle="width:1em;" />
									<s:text name="runcase.overdue"/>
								</td>
								<td></td>
								<td></td>
								<td></td>
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
		<s:hidden name="e.chargerId" />
		<s:hidden name="e.closerId" />
		<s:hidden name="e.status" />
		<s:hidden name="e.receiverId" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>