<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="caseTraffic.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/caseTraffic/save" />'
	data-js='<s:url value="/bc-business/caseTraffic/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.caseTrafficForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseTrafficForm" theme="simple">
		<div class="formTable ui-widget-content bs-caseTraffic-containers" style="width:668px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >基本信息区:</span>
				<ul class="inputIcons">
					<li class="showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='展开'></li>
					<li class="hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='隐藏'></li>
				</ul>
			</div>
			<div class="bs-caseTraffic-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
				<table class="formFieldsTable" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td></td>
							<td style="width: 200px;">&nbsp;</td>
							<td style="width: 80px;">&nbsp;</td>
							<td style="width: 200px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="runcase.subject"/>:</td>
							<td class="value" colspan="3"><s:textfield name="e.subject" data-validate="required" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label">*<s:text name="runcase.address"/>:</td>
							<td class="value "><s:textfield name="e.address" data-validate="required" cssClass="ui-widget-content"/></td>
							<td class="label">*<s:text name="runcase.caseNo1"/>:</td>
							<td class="value "><s:textfield name="e.caseNo" data-validate="required" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label" ><s:text name="runcase.motorcadeName" />:</td>
							<td class="value" >
								<s:select name="e.motorcadeId" list="motorcadeList" listKey="key" listValue="value" value="e.motorcadeId" headerKey="" headerValue=""  cssClass="ui-widget-content"></s:select>
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
							<td class="label">*<s:text name="runcase.carPlate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<s:textfield name="e.carPlate" data-validate="required" readonly="true" cssClass="ui-widget-content "/>
								<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectCarPlate"></span>
							</td>
							<td class="label" ><s:text name="runcase.from"/>:</td>
							<td class="value" >
								<s:textfield name="e.from" cssClass="ui-widget-content" cssStyle="width: 10em" />(<s:property value="sourceStr"/>)
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.driverName" />:</td>
							<td>
								<div style="position:relative;display: inline-block" >
									<s:textfield name="e.driverName" cssStyle="width:5em;" cssClass="ui-widget-content "/>
									<ul class="inputIcons">
							 			<li class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectDriverName">
							 		</ul>
								</div>
								&nbsp;&nbsp;
								<s:text name="runcase.driverCert" /><s:textfield name="e.driverCert" cssStyle="width:6em;" cssClass="ui-widget-content"/>
							</td>
							<td class="label" ><s:text name="runcase.duty"/>:</td>
							<td class="value" >
								<s:select name="e.duty" list="dutyList" listKey="value" listValue="value"  headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.chargerName"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<s:textfield name="chargers" readonly="true" cssClass="ui-widget-content" />
								<ul class="inputIcons">
									<li id="selectChargerName" class="inputIcon ui-icon ui-icon-circle-plus" title='点击选择责任人'></li>
									<li class="clearSelect inputIcon ui-icon ui-icon-circle-close" data-cfg="chargers,e.charger" title='点击清除责任人'></li>
								</ul>
							</td>
							<td class="label"><s:text name="runcase.sort"/>:</td>
							<td class="value" >
								<s:select name="e.sort" list="properitesList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.jeom"/>:</td>
							<td class="value "><s:textfield name="e.jeom" value="%{getText('bs.format.number',{e.jeom})}" data-validate='{"type":"number",max:100}' cssClass="ui-widget-content"/></td>
							<td class="label">*<s:text name="runcase.code" />:</td>
							<td class="value "><s:textfield name="e.code" data-validate="required" readonly="true" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="runcase.infractCode"/>:</td>
							<!--<td class="value "><s:textfield name="e.infractCode"  cssClass="ui-widget-content"/></td>  -->
							<td class="value" ><s:textfield name="e.infractCode" cssClass="bc-select ui-widget-content" readonly="false"
								data-cfg='{"strict":true,"delay":100,"minLength":1, "labelMapping":"{{code}}", "valueMapping":"{{code}}","itemMapping":"{{code}}","callback":"bc.caseTrafficForm.afterSelectInfractCode"}'
								data-maxHeight="150px" 
								data-source='bc-business/case4InfractCode/find'/>
							</td>
							<td class="label"><s:text name="runcase.penalty" />:</td>
							<td class="value "><s:textfield name="e.penalty"  cssClass="ui-widget-content"
								value="%{getText('bs.format.numberRMB',{e.penalty})}"  data-validate="money" 
							/></td>
						</tr>
						<tr>
							<td class="label">
							</td>
							<td class="value">
								<s:checkbox name="e.deliver" cssStyle="width:1em;" />
								<s:text name="runcase.deliver1"/>
								<s:checkbox name="e.sign" cssStyle="width:1em;" />
								<s:text name="runcase.sign"/>
							</td>
							
							<td>
							</td>
							<td>
							</td>
						</tr>
						<tr>
							<td id="tdTitle1" class="label" style="
								<s:if test="%{e.deliverDate != null}">
									visibility: visible;
								</s:if>
								<s:else>
									visibility: hidden;
								</s:else>
								">
								<s:text name="runcase.deliverDate1"/>:
							</td>
							<td id="tdValue1" class="value" style="
								<s:if test="%{e.deliverDate != null}">
									visibility: visible;
								</s:if>
								<s:else>
									visibility: hidden;
								</s:else>
								">
								<div style="position:relative;">
									<input type="text" name="e.deliverDate" data-validate='{"type": "date"}'
									value='<s:date format="yyyy-MM-dd" name="e.deliverDate" />'
									class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.deliverDate'></li>
									</ul>
								</div>
							</td>
							<td id="tdTitle2" class="label" style="
								<s:if test="%{e.signDate != null}">
									visibility: visible;
								</s:if>
								<s:else>
									visibility: hidden;
								</s:else>
								">
								<s:text name="runcase.signDate"/>:
							</td>
							<td id="tdValue2" class="value"style="
								<s:if test="%{e.signDate != null}">
									visibility: visible;
								</s:if>
								<s:else>
									visibility: hidden;
								</s:else>
								">
								<div style="position:relative;">
									<input type="text" name="e.signDate" data-validate='{"type": "datetime"}'
									value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.signDate" />'
									class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,showSecond:true}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.signDate'></li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<td class="topLabel"><s:text name="runcase.comment"/>:</td>
							<td class="value" colspan="3"><s:textarea name="e.comment" rows="4" cssClass="ui-widget-content noresize"/></td>
						</tr>
						<tr>
							<td class="label" colspan="4">
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
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<s:if test="%{!isReadonly()}">
			<div  class="formTable2 ui-widget-content bs-caseTraffic-containers"  style="width:668px;">
				<div class="ui-widget-header title" style="position:relative;">
					<span class="text" >流程信息区:</span>
					<ul class="inputIcons">
						<li class="showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='展开'></li>
						<li class="hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='隐藏'></li>
					</ul>
				</div>
				<div class="bs-caseTraffic-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
					<table class="table bc-grid" cellspacing="0" cellpadding="0" style="width:100%;">
						<tr class="header row">
							<td class="first" style="width: 12em;">名称</td>
							<td class="middle" style="width: 10em;">主题</td>
							<td class="middle" style="width: 9em;">发起时间</td>
							<td class="middle" style="width: 9em;">结束时间</td>
							<td class="last" style="min-width: 0.001em;">流程状态</td>
						</tr>
						<s:iterator var="wr" value="carTrafficHandleFlowList">
							<tr class="ui-widget-content row" >
								<td class="first"  style="padding:0 0 0 4px;text-align:left;">
									<a class="bs-caseTraffic-workFlow-processName" href="#"><s:property value="name"/></a>
									<input type="hidden" class="bs-caseTraffic-workFlow-procInstId" value='<s:property value="pid"/>' />
								</td>
								<td class="middle"  style="padding:0 0 0 4px;text-align:left;" title='<s:property value="subject"/>'>
									<s:property value="subject"/>
								</td>
								<td class="middle"  style="padding:0 0 0 4px;text-align:left;">
									<s:property value="startTime"/>
								</td>
								<td class="middle"  style="padding:0 0 0 4px;text-align:left;">
									<s:property value="endTime"/>
								</td>
								<td class="last" style="padding:0 0 0 4px;text-align:left;">	
									<s:if test="%{status == 1}">流转中</s:if>
									<s:elseif test="%{status == 2}">已暂停</s:elseif>
									<s:elseif test="%{status == 3}">已结束</s:elseif>
								</td>
							</tr>
						</s:iterator>
					</table>
				</div>
			</div>
		</s:if>
		
		<div  class="formTable ui-widget-content bs-caseTraffic-containers" style="width:668px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >附件:</span>
				<ul class="inputIcons">
					<li class="showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='展开'></li>
					<li class="hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='隐藏'></li>
				</ul>
			</div>
			<div class="bs-caseTraffic-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
				<s:property value="%{attachsUI}" escapeHtml="false"/>
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
		<s:hidden name="e.charger"/>
		<s:hidden name="e.company"/>
		<!-- <s:hidden name="isExist" /> -->
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>