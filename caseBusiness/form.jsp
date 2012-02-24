<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="caseBusiness.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/caseBusiness/save" />'
	data-js='<s:url value="/bc-business/caseBusiness/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js"/>'
	data-initMethod='bc.caseBusinessForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseBusinessForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >车辆司机信息:</span>
				<span id="showGroups1" class="verticalMiddle ui-icon ui-icon-carat-1-s" title='<s:text name="runcase.title.click2ShowGroups"/>'></span>
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
							<td class="label"><s:text name="runcase.company"/>:</td>
							<td class="value"><s:textfield name="e.company" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label" ><s:text name="runcase.motorcadeName"/>:</td>
							<td class="value">
								<s:select name="e.motorcadeId" list="motorcadeList" listKey="key" listValue="value" value="e.motorcadeId" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
							</td>
							<td class="label"><s:text name="runcase.businessType"/>:</td>
							<td class="value"><s:textfield name="businessType" cssClass="ui-widget-content" readonly="true"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.registerDate"/>:</td>
							<td class="value"><input type="text" name="registerDate" value='<s:date format="yyyy-MM-dd" name="registerDate"/>'
							 class="ui-widget-content" readonly="readonly"/></td>
							<td class="label"><s:text name="runcase.scrapDate"/>:</td>
							<td class="value"><input type="text" name="scrapDate" value='<s:date format="yyyy-MM-dd" name="scrapDate"/>'
							 class="ui-widget-content" readonly="readonly"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.chargers"/>:</td>
							<td class="value relative">
								<s:textfield name="chargers" cssClass="ui-widget-content" readonly="true"/>
								<ul class="inputIcons">
									<li id="selectChargerName" class="inputIcon ui-icon ui-icon-circle-plus" title='点击选择责任人'></li>
									<li class="clearSelect inputIcon ui-icon ui-icon-circle-close" data-cfg="chargers,e.charger" title='点击清除责任人'></li>
								</ul>
							</td>
							<td class="label"><s:text name="runcase.origin"/>:</td>
							<td class="value"><s:textfield name="origin" cssClass="ui-widget-content" readonly="true"/></td>
						</tr>
						<tr>
		               		<td class="label"><s:text name="runcase.driverName"/>:</td>
							<td class="value relative">
								<s:textfield name="e.driverName" readonly="true" cssClass="ui-widget-content"/>
								<ul class="inputIcons">
						 			<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectDriverName">
						 		</ul>
							</td>
							<td class="label"><s:text name="runcase.driverCert"/>:</td>
							<td class="value"><s:textfield name="e.driverCert" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.birthDate"/>:</td>
							<td class="value"><input type="text" name="birthDate" value='<s:date format="yyyy-MM-dd" name="birthdate"/>'
							 class="ui-widget-content" readonly="readonly"/></td>
							<td class="label"><s:text name="runcase.workDate"/>:</td>
							<td class="value"><input type="text" name="workDate" value='<s:date format="yyyy-MM-dd" name="workDate"/>'
							 class="ui-widget-content" readonly="readonly"/></td>
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
		<div class="formFields ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >违章信息:</span>
				<span id="showGroups2" class="verticalMiddle ui-icon ui-icon-carat-1-s" title='<s:text name="runcase.title.click2ShowGroups"/>'></span>
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
							<td class="label">*<s:text name="runcase.subject"/>:</td>
							<td class="value" colspan="3"><s:textfield name="e.subject" data-validate="required" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label">*<s:text name="runcase.address2"/>:</td>
							<td class="value" colspan="3"><s:textfield name="e.address"  data-validate="required" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label">*<s:text name="runcase.happenDate2"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd hh:mm:ss" name="e.happenDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true,timeFormat:"hh:mm:ss"}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.happenDate'></li>
								</ul>
							</td>
							<td class="label">*<s:text name="runcase.caseNo2"/>:</td>
							<td class="value "><s:textfield name="e.caseNo" data-validate="required" cssClass="ui-widget-content" /></td>
						</tr>
						<tr>
							<td class="label">*<s:text name="runcase.category"/>:</td>
							<td class="value">
								<s:select name="e.category" list="categoryValue" listKey="key" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" data-validate="required"></s:select>
							</td>
							<td class="label" ><s:text name="runcase.sort"/>:</td>
							<td class="value" >
								<s:select name="e.sort" list="properitesList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label" ><s:text name="runcase.duty"/>:</td>
							<td class="value" >
								<s:select name="e.duty" list="dutyList" listKey="value" listValue="value"  headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
							</td>
							<td class="label"><s:text name="runcase.extent"/>:</td>
							<td class="value">
							<s:select name="e.extent" list="degreeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label" ><s:text name="runcase.receiveDate1"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.receiveDate" data-validate='{"type": "date"}'
								value='<s:date format="yyyy-MM-dd" name="e.receiveDate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.receiveDate'></li>
								</ul>
							</td>
							<td class="label"><s:text name="runcase.receiverName1"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<s:textfield name="e.receiverName" cssClass="ui-widget-content"/>
								<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectReceiverName"></span>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.code" />:</td>
							<td class="value "><s:textfield name="e.code" readonly="true" cssClass="ui-widget-content"/></td>					
							<td class="label" ><s:text name="runcase.source"/>:</td>
							<td class="value" >
								<s:textfield name="e.from" cssClass="ui-widget-content" cssStyle="width: 15em" />(<s:property value="sourceStr"/>)
							</td>
						</tr>
						<tr>
							<td class="topLabel"><s:text name="runcase.description" />:</td>
							<td class="value" colspan="3"><s:textarea name="e.description" rows="4" cssClass="ui-widget-content noresize"/></td>
						</tr>
						<tr>
							<td class="label"></td>
							<td class="value" colspan="3">
								<s:checkbox name="e.deliver" cssStyle="width:1em;" />
								<s:text name="runcase.deliver2"/>
								<s:checkbox name="e.seal" cssStyle="width:1em;" />
								<s:text name="runcase.seal"/>
								<s:checkbox name="e.stop" cssStyle="width:1em;" />
								<s:text name="runcase.stop"/>
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
					</tbody>
				</table>
			</div>
		</div>
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >主管部门处理信息:</span>
				<span id="showGroups3" class="verticalMiddle ui-icon ui-icon-carat-1-s" title='<s:text name="runcase.title.click2ShowGroups"/>'></span>
			</div>
			<div id="div3">
				<table class="formFields" cellspacing="2" cellpadding="0" >
					<tbody>
						<tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label" colspan="2" style="text-align: right">扣<s:textfield name="e.jeom" value="%{getText('bs.format.number',{e.jeom})}" data-validate='{"type":"number"}' cssStyle="width:2.5em;" cssClass="ui-widget-content"/>分,
							罚款<s:textfield name="e.penalty" value="%{getText('bs.format.number',{e.penalty})}" data-validate='{"type":"number","required":true}' cssStyle="width:2.5em;" cssClass="ui-widget-content"/>元,
							违约金<s:textfield name="e.penalty2" value="%{getText('bs.format.number',{e.penalty2})}" data-validate='{"type":"number","required":true}' cssStyle="width:2.5em;" cssClass="ui-widget-content"/>元.&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td class="label"><s:text name="runcase.receipt"/>:</td>
							<td class="value"><s:textfield name="e.receipt" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.detain"/>:</td>
							<td class="value" colspan="3"><s:textfield name="e.detain" cssClass="ui-widget-content"/></td>
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
		</div>
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >公司处理信息:</span>
				<span id="showGroups4" class="verticalMiddle ui-icon ui-icon-carat-1-s" title='<s:text name="runcase.title.click2ShowGroups"/>'></span>
			</div>
			<div id="div4">
				<table class="formFields" cellspacing="2" cellpadding="0" >
					<tbody>
						<tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
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
						<tr>
							<td class="topLabel"><s:text name="runcase.comment" />:</td>
							<td class="value" colspan="3"><s:textarea name="e.comment" rows="4" cssClass="ui-widget-content noresize"/></td>
						</tr>
						<tr>
							<td class="label"></td>
							<td class="value" colspan="3">
								<s:checkbox name="e.invalid" cssStyle="width:1em;" />
								<s:text name="runcase.invalid"/>
								<s:checkbox name="e.overdue" cssStyle="width:1em;" />
								<s:text name="runcase.overdue"/>
							</td>
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
		<s:hidden name="e.charger" />
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