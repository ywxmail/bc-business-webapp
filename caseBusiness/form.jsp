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
					<tr class="widthMarker">
						<td></td>
						<td style="width: 200px;">&nbsp;</td>
						<td style="width: 80px;">&nbsp;</td>
						<td style="width: 200px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.subject"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.subject" cssStyle="width:53.7em;" data-validate="required" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.address"/>:</td>
						<td class="value"><s:textfield name="e.address"  data-validate="required" cssClass="ui-widget-content"/></td>
						<td class="label">*<s:text name="runcase.caseNo2"/>:</td>
						<td class="value "><s:textfield name="e.caseNo" data-validate="required" cssClass="ui-widget-content" /></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="runcase.motorcadeName"/>:</td>
						<td class="value" >
							<s:select name="e.motorcadeId" list="motorcadeList" listKey="key" listValue="value" value="e.motorcadeId" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
						</td>
						<td class="label">*<s:text name="runcase.happenDate"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
							value='<s:date format="yyyy-MM-dd hh:mm:ss" name="e.happenDate" />'
							class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true,timeFormat:"hh:mm:ss"}'/>
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.happenDate'></li>
							</ul>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.carPlate"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<s:textfield name="e.carPlate" data-validate="required" readonly="true" cssClass="ui-widget-content "/>
							<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectCarPlate"></span>
						</td>
						<td class="label" ><s:text name="runcase.receiveDate1"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<input type="text" name="e.receiveDate" data-validate='{"type": "date"}'
							value='<s:date format="yyyy-MM-dd" name="e.receiveDate" />'
							class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.receiveDate'></li>
							</ul>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.driverName" />:</td>
						<td>
							<span style="position:relative;">
								<s:textfield name="e.driverName" cssStyle="width:5em;" data-validate="required" cssClass="ui-widget-content "/>
								<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectDriverName"></span>
							</span>
							&nbsp;&nbsp;
							<s:text name="runcase.driverCert" /><s:textfield name="e.driverCert" data-validate="required" cssClass="ui-widget-content"/>
						</td>
						<td class="label"><s:text name="runcase.receiverName1"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<s:textfield name="e.receiverName" cssClass="ui-widget-content"/>
							<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectReceiverName"></span>
						</td>
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.chargerName"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<s:textfield name="e.chargerName" cssClass="ui-widget-content"/>
							<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectChargerName"></span>
						</td>
						<td class="label" ><s:text name="runcase.duty"/>:</td>
						<td class="value" >
							<s:select name="e.duty" list="dutyList" listKey="value" listValue="value"  headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
						</td>
					</tr>
					<tr>
						<td class="label" ><s:text name="runcase.sort"/>:</td>
						<td class="value" >
							<s:select name="e.sort" list="properitesList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
						</td>
						<td class="label">*<s:text name="runcase.code" />:</td>
						<td class="value "><s:textfield name="e.code" data-validate="required" readonly="true" cssClass="ui-widget-content"/></td>					
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.extent"/></td>
						<td class="value">
						<s:select name="e.extent" list="degreeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
						</td>
						<td class="label" ><s:text name="runcase.source"/>:</td>
						<td class="value" >
							<s:textfield name="e.from" cssClass="ui-widget-content" cssStyle="width: 15em" />(<s:property value="sourceStr"/>)
						</td>
					</tr>
					<!--
					<tr>
						<td class="label">
							<div id="divTitle" style="
								<s:if test="%{ e.status == 1}">
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
								<s:if test="%{ e.status == 1}">
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
					 -->
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
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset"
			style="width:800px;overflow: hidden;">
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
							<tr style="line-height: 1px;">
								<td></td>
								<td style="width: 350px;">&nbsp;</td>
								<td style="width: 90px;">&nbsp;</td>
								<td style="width: 350px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="label" colspan="2" style="text-align: center">*扣<s:textfield name="e.jeom" value="%{getText('bs.format.number',{e.jeom})}" data-validate='{"type":"number","required":true}' cssStyle="width:2.5em;" cssClass="ui-widget-content"/>分,
								罚款<s:textfield name="e.penalty" value="%{getText('bs.format.number',{e.penalty})}" data-validate='{"type":"number","required":true}' cssStyle="width:2.5em;" cssClass="ui-widget-content"/>元,
								违约金<s:textfield name="e.penalty2" value="%{getText('bs.format.number',{e.penalty2})}" data-validate='{"type":"number","required":true}' cssStyle="width:2.5em;" cssClass="ui-widget-content"/>元.</td>
								<td class="label"><s:text name="runcase.receipt"/>:</td>
								<td class="value"><s:textfield name="e.receipt" cssClass="ui-widget-content"/></td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.detain"/>:</td>
								<td class="value" colspan="3"><s:textfield name="e.detain	" cssStyle="width:53.7em;" cssClass="ui-widget-content"/></td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.confiscateCertNo" />:</td>
								<td class="value "><s:textfield name="e.confiscateCertNo" cssClass="ui-widget-content"/></td>					
								<td class="label" ><s:text name="runcase.confiscateCertType"/>:</td>
								<td class="value" >
									<s:select name="e.confiscateCertType" list="certList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
								</td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.operator" />:</td>
								<td class="value "><s:textfield name="e.operator" cssClass="ui-widget-content"/></td>					
								<td class="label" ><s:text name="runcase.operateUnit"/>:</td>
								<td class="value" >
									<s:select name="e.operateUnit" list="departmentList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
								</td>
							</tr>
							<tr>
								<td class="label"><s:text name="runcase.area" />:</td>
								<td class="value "><s:textfield name="e.area" cssClass="ui-widget-content"/></td>		
								<td class="label"><s:text name="runcase.pullUnit" />:</td>
								<td class="value "><s:textfield name="e.pullUnit" cssClass="ui-widget-content"/></td>					
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
								<td class="value" colspan="4"><s:textarea name="e.description" cssStyle="width:59.7em; text-align:left" rows="4" cssClass="ui-widget-content"/></td>
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
								<td class="value" colspan="4"><s:textarea name="e.comment" cssStyle="width:59.7em; text-align:left" rows="4" cssClass="ui-widget-content"/></td>
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
		<s:hidden name="e.closerName" />
		<s:hidden name="e.receiverId" />
		<s:hidden name="e.status" />
		<s:hidden name="e.syncUid" />
		<s:hidden name="e.syncId" />
		<s:hidden name="isMoreCar" />
		<s:hidden name="isMoreCarMan" />
		<s:hidden name="carId" />
		<s:hidden name="carManId" />
		<s:hidden name="isNullCarMan" />
		<s:hidden name="isNullCar" />
		<s:hidden name="isSync" />
		<s:hidden name="syncId" />
		<s:hidden name="e.source"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>