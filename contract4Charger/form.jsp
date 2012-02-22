<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="contract4Charger.title"/> - v<s:property value="e.verMajor" />.<s:property value="e.verMinor" />' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/contract4Charger/save" />'
	data-js='js:editor,js:bc_identity,<s:url value="/bc-business/bs.js" />,<s:url value="/bc-business/contract4Charger/form.js" />'
	data-initMethod='bc.contract4ChargerForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="contract4ChargerForm" theme="simple">
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset" data-cfg="{height:300}"
			style="height:300px;width:710px;overflow: hidden;">
			<div class="tabsContainer">
           	 	<div class="slideContainer">
					<ul class="tabs ui-helper-reset">
						<li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">基本信息</a></li>
						<li class="tab ui-widget-content"><a href="#contractContents" class="ui-state-default">合同内容</a></li>
						<li class="tab ui-widget-content"><a href="#contractOldContents" class="ui-state-default">旧合同内容</a></li>
						<li class="tab ui-widget-content"><a href='#attachment' class="ui-state-default">附件</a></li>
						<s:if test="e.main == 0">
							<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/contract4Chargers/list?contractId=%{(e.pid != null)?e.pid:0}&patchNo=%{e.patchNo}"/>' class="ui-state-default">历史版本</a></li>
						</s:if>
					</ul>
				</div>
			</div>
			<div class="contentContainer ui-helper-reset ui-widget-content">
				<div id="otherFormFields" class="content active" >
					<table class="formFields" cellspacing="2" cellpadding="0">
						<tbody>
							<tr class="widthMarker">
								<td >&nbsp;</td>
								<td style="width: 250px;">&nbsp;</td>
								<td style="width: 60px;">&nbsp;</td>
								<td style="width: 250px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="label">*<s:text name="contract.code"/>:</td>
								<td class="value ">
									<s:if test="e.isNew()"><!-- 新建 -->
										<s:textfield name="e.code" data-validate="required" cssClass="ui-widget-content"/>
									</s:if>
									<s:else>
										<s:textfield name="e.code" data-validate="required" cssClass="ui-widget-content" readonly="true"/>
									</s:else>
								</td>
								<td class="label">*<s:text name="contract4Charger.signType"/>:</td>
								<td class="value ">
									<s:select name="e.signType" list="signTypeList" listKey="value" listValue="value"  data-validate="required" headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
								</td>
							</tr>
							<tr>
								<td class="label">*<s:text name="contract.car"/>:</td>
								<td class="value relative">
									<!-- 
										<s:if test="!e.isNew()">
											<s:textfield name="ext_str1_temp" value="%{e.ext_str1}" data-validate="required" disabled="true" />
											<s:hidden name="e.ext_str1" />
										</s:if>
									 -->
									<s:textfield name="e.ext_str1" data-validate="required" readonly="true" cssClass="ui-widget-content" />
									<s:if test="e.isNew()">
										<ul class="inputIcons">
											<li class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="contract.title.click2selectCar"/>' id="selectCarPlate">
										</ul>
									</s:if>
								</td>
								<td class="label" >*<s:text name="contract4Charger.businessType"/>:</td>
								<td class="value" >
									<s:select name="e.businessType" list="businessTypeList" listKey="value" listValue="value"  data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content"></s:select>
								</td>
							</tr>
							<tr>
								<td class="label"><s:text name="contract.wordNo"/>:</td>
								<td class="value "><s:textfield name="e.wordNo" cssClass="ui-widget-content" /></td>
								<td class="label">*<s:text name="contract.signDate"/>:</td>
								<td class="value" style="position:relative;display: block;">
									<input type="text" name="e.signDate" data-validate='{"type":"date","required":true}'
									value='<s:date format="yyyy-MM-dd" name="e.signDate" />'
									class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.signDate' ></li>
									</ul>
								</td>
								<!-- 经办人
									<td class="label">*<s:text name="contract.transactor"/>:</td>
									<td class="value" style="position:relative;display: block;">
										<s:textfield name="e.transactorName" data-validate="required" readonly="true"	
										title='%{getText("contract.select.transactor")}' cssClass="ui-widget-content " />
										<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectTransactorName" ></span>
									</td>
								 -->
							</tr>
							<tr>
								<td class="label" ><s:text name="contract4Charger.contractVersionNo"/>:</td>
								<td class="value">
									<s:select name="e.contractVersionNo" list="contractVersionNoList" listKey="key" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
								</td>
								<td class="label">*<s:text name="contract.deadline"/>:</td>
								<td class="value">
									<s:if test="e.isNew()">
										<div style="position : relative; display: inline-block">
											&nbsp;从<input type="text" name="e.startDate" readonly="readonly" data-validate='{"type":"date","required":true}' 
												value='<s:date format="yyyy-MM-dd" name="e.startDate" />' 
												style="width: 7em;" class="bc-date ui-widget-content" />
												<ul class="inputIcons" style="right : 0px;">
													<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.startDate' ></li>
												</ul>
										</div>
										<div style="position : relative; display: inline-block">
											&nbsp;到<input type="text" name="e.endDate" readonly="readonly" data-validate='{"type":"date","required":true}'
												value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
												style="width: 7em;" class="bc-date ui-widget-content" />
												<ul class="inputIcons" style="right : 0px;">
													<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.endDate' ></li>
												</ul>
										</div>
									</s:if>
									<s:else>
										&nbsp;从<input type="text" name="e.startDate" readonly="readonly" data-validate='{"type":"date","required":true}' 
												value='<s:date format="yyyy-MM-dd" name="e.startDate" />' 
												style="width: 7em;" class="ui-widget-content" />
										&nbsp;到<input type="text" name="e.endDate" readonly="readonly" data-validate='{"type":"date","required":true}'
												value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
												style="width: 7em;" class="ui-widget-content" />
									</s:else>
								</td>
							</tr>
							<tr>
								<td class="label"><s:text name="contract4Charger.paymentDate"/>:</td>
								<td class="value">
									<s:select name="e.paymentDate" list="paymentDates" listKey="key" listValue="value" headerKey="" headerValue=""
									 cssClass="ui-widget-content"/>
								</td>
								<td></td>
								<td class="label" style="text-align: right;">
									<s:checkbox name="e.takebackOrigin" cssStyle="width:1em;"/>
									<s:text name="contract4Charger.takebackOrigin"/>
									<s:checkbox name="e.includeCost" cssStyle="width:1em;" />
									<s:text name="contract4Charger.includeCost"/>
								</td>
							</tr>			
							<tr>
								<td class="label" colspan="4">
									<div class="formTopInfo">
										状态：<s:property value="%{statusesValue[e.status]}" />
										<s:if test="%{e.author.name != null}">
										，登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
										</s:if>
										<s:if test="%{e.modifier != null && e.status == 0}">
										，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
										</s:if>
										<s:if test="%{e.logoutId != null && e.status == 1}">
										，注销人：<s:property value="e.logoutId.name" />(<s:date name="e.logoutDate" format="yyyy-MM-dd HH:mm:ss"/>)
										</s:if>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 责任人信息 -->
					<div id="assignChargers" style="position:relative;border-width:1px 0 0 0;" class="ui-widget-content" 
						data-removeTitle='<s:text name="title.click2remove" />'>
						<div class="ui-widget-header title" style="position:relative;">
							<span class="text"><s:text name="contract4Charger.charger"/>：
								<s:if test="%{chargerInfoMap == null || chargerInfoMap.isEmpty()}"><s:text name="label.empty"/></s:if>
							</span>
							<span id="addChargers" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="contract.title.click2selectCharger"/>'></span>
						</div>
						<s:if test="%{chargerInfoMap != null && !chargerInfoMap.isEmpty()}">
						<ul class="horizontal">
						<s:iterator value="chargerInfoMap">
							<li class="horizontal ui-widget-content ui-corner-all" data-id='<s:property value="key" />'>
								<span class="text"><a href="#"><s:property value="value" /></a></span>
								<span class="click2remove verticalMiddle ui-icon ui-icon-close" title='<s:text name="title.click2remove"/>'></span>
							</li>
						</s:iterator>
						</ul>
						</s:if>	
					</div>
				</div>
				<div id="contractContents" class="content" >
					<div class="formEditor">
						<textarea name="e.content" class="bc-editor" style="width: 690px;height:215px" data-validate="required"
							 data-ptype="contractCharger" data-puid='${e.uid}' 
							 data-readonly='${readonly}'>
							 ${e.content}
						</textarea>
					</div>
				</div>
				<div id="contractOldContents" class="content" >
					<div class="formEditor">
						<textarea name="e.oldContent" class="bc-editor" style="width: 690px;height:215px" data-validate="required"
							 data-ptype="contractCharger" data-puid='${e.uid}' 
							 data-readonly='${readonly}'>
							 ${e.content}
						</textarea>
					</div>
				</div>
				<div id="attachment" class="content" >
					<s:property value="%{attachsUI}" escapeHtml="false"/>
				</div>
			</div>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.uid"/>
		<s:hidden name="e.type"/>
		<s:hidden name="carId" />
		<s:hidden name="assignChargerIds" />
		<s:hidden name="assignChargerNames" />
		<s:hidden name="e.status"/>
		<s:hidden name="e.pid"/>
		<s:hidden name="e.verMajor"/>
		<s:hidden name="e.verMinor"/>
		<s:hidden name="e.opType"/>
		<s:hidden name="e.patchNo"/>
		<s:hidden name="e.transactorId" />
		<s:hidden name="e.transactorName" />
		<s:hidden name="isExistContract"/>
		<!-- 
		<s:hidden name="e.transactor.id" />
		<s:hidden name="e.changerId1" />
		<s:hidden name="e.changerName1" />
		<s:hidden name="e.changerId2" />
		<s:hidden name="e.changerName2" />
		 -->
		<input type="hidden" name="e.logoutDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.logoutDate" />'/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>