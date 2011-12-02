<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="contract.charger.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/contractCharger/save" />'
	data-js='<s:url value="/bc-business/contractCharger/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/ui-libs/xheditor/1.1.7/xheditor-zh-cn.min.js?ts=0" />'
	data-initMethod='bc.contractChargerForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="contractChargerForm" theme="simple">
		<div class="formFields ui-widget-content"  style="width:710px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td >&nbsp;</td>
						<td style="width: 200px;">&nbsp;</td>
						<td style="width: 60px;">&nbsp;</td>
						<td style="width: 220px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="contract.code"/>:</td>
						<td class="value "><s:textfield name="e.code" data-validate="required" readonly="true"  cssClass="ui-widget-content"/></td>
						<td class="label">*<s:text name="contract.signDate"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<input type="text" name="e.signDate" data-validate='{"type":"date","required":true}'
							value='<s:date format="yyyy-MM-dd" name="e.signDate" />'
							class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
							<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectSignDate"></span>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="contract.charger.signType"/>:</td>
						<td class="value ">
							<s:select name="e.signType" list="signTypeList" listKey="value" listValue="value"  data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" ></s:select>
						</td>
						<td class="label">*<s:text name="contract.deadline"/>:</td>
						<td class="value">
							<span style="position:relative;">
							&nbsp;从
								<input type="text" name="e.startDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.startDate" />'
								style="max-width: 7em;" readonly="readonly" class="ui-widget-content" />
								<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectStartDate"></span>
							</span>
							&nbsp;到
							<span style="position:relative;">
								<input type="text" name="e.endDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
								style="max-width: 7em;" readonly="readonly" class="ui-widget-content" />
								<span class="selectButton verticalMiddle ui-icon ui-icon-calendar" id="selectEndDate"></span>
							</span>
						</td>
					</tr>
					<tr>
						<td class="label" >*<s:text name="contract.charger.businessType"/>:</td>
						<td class="value" >
							<s:select name="e.businessType" list="businessTypeList" listKey="value" listValue="value"  data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content"></s:select>
						</td>
						<td class="label">*<s:text name="contract.transactor"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<s:textfield name="e.transactorName" data-validate="required" readonly="true"	
							title='%{getText("contract.select.transactor")}' cssClass="ui-widget-content ui-state-disabled" />
							<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectTransactorName" ></span>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="contract.car"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<!-- 
								<s:if test="!e.isNew()">
									<s:textfield name="ext_str1_temp" value="%{e.ext_str1}" data-validate="required" disabled="true" />
									<s:hidden name="e.ext_str1" />
								</s:if>
							 -->
							<s:textfield name="e.ext_str1" data-validate="required" title='%{getText("contract.title.click2selectCar")}' readonly="true" cssClass="ui-widget-content ui-state-disabled" />
							<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectCarPlate"></span>
						</td>
						<td class="label"><s:text name="contract.wordNo"/>:</td>
						<td class="value "><s:textfield name="e.wordNo" cssClass="ui-widget-content" /></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td colspan="6" class="label" style="text-align: right;">
							<s:checkbox name="e.logout" cssStyle="width:1em;" />
							<s:text name="contract.charger.logout"/>
							<s:checkbox name="e.takebackOrigin" cssStyle="width:1em;"/>
							<s:text name="contract.charger.takebackOrigin"/>
							<s:checkbox name="e.includeCost" cssStyle="width:1em;" />
							<s:text name="contract.charger.includeCost"/>
						</td>
					</tr>			
					<tr>
						<td class="label" colspan="4">
							<div class="formTopInfo">
								状态：<s:property value="%{statusesValue[e.status]}" />，
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
		<!-- 责任人信息 -->
		<div id="assignChargers" style="width:710px;" class="formTable2 ui-widget-content" 
			data-removeTitle='<s:text name="title.click2remove" />'>
			<div class="ui-state-active title" style="position:relative;">
				<span class="text"><s:text name="contract.charger.charger"/>：
					<s:if test="%{chargerInfoMap == null || chargerInfoMap.isEmpty()}"><s:text name="label.empty"/></s:if>
				</span>
				<span id="addChargers" class="verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="contract.title.click2selectCharger"/>'></span>
			</div>
			<s:if test="%{chargerInfoMap != null && !chargerInfoMap.isEmpty()}">
			<ul class="horizontal">
			<s:iterator value="chargerInfoMap">
				<li class="horizontal ui-widget-content ui-corner-all" data-id='<s:property value="key" />'>
					<span class="text"><s:property value="value" /></span>
					<span class="click2remove verticalMiddle ui-icon ui-icon-close" title='<s:text name="title.click2remove"/>'></span>
				</li>
			</s:iterator>
			</ul>
			</s:if>	
		</div>
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset" data-cfg="{height:300}"
			style="height:300px;width:710px;overflow: hidden;">
			<div class="tabsContainer">
           	 	<div class="slideContainer">
					<ul class="tabs ui-helper-reset">
						<li class="tab ui-widget-content first active"><a href="#contractContents" class="ui-state-default ui-state-active">合同内容</a></li>
						<li class="tab ui-widget-content"><a href="#contractOldContents" class="ui-state-default">旧合同内容</a></li>
						<li class="tab ui-widget-content"><a href='#attachment' class="ui-state-default">附件</a></li>
					</ul>
				</div>
			</div>
			<div class="contentContainer ui-helper-reset ui-widget-content">
				<div id="contractContents" class="content active" >
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
		<s:hidden name="oldCarId" />
		<s:hidden name="assignChargerIds" />
		<s:hidden name="assignChargerNames" />
		<s:hidden name="e.status"/>
		<s:hidden name="e.opType"/>
		<s:hidden name="e.patchNo"/>
		<!-- 
		<s:hidden name="e.transactorId" />
		<s:hidden name="e.changerId1" />
		<s:hidden name="e.changerName1" />
		<s:hidden name="e.changerId2" />
		<s:hidden name="e.changerName2" />
		<s:hidden name="e.transactor.id" />
		 -->
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>