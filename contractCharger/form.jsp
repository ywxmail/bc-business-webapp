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
					<tr>
						<td class="label">*<s:text name="contract.code"/>:</td>
						<td class="value "><s:textfield name="e.code" data-validate="required" /></td>
						<td class="label">*<s:text name="contract.signDate"/>:</td>
						<td class="value">
							<input type="text" name="e.signDate" data-validate="date"
							value='<s:date format="yyyy-MM-dd" name="e.signDate" />'
							class="bc-date"/>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="contract.charger.signType"/>:</td>
						<td class="value ">
							<s:select name="e.signType" list="signTypeList" listKey="value" listValue="value"  data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" ></s:select>
						</td>
						<td class="label">*<s:text name="contract.deadline"/>:</td>
						<td class="value">
							&nbsp;从
							<input type="text" name="e.startDate" data-validate="date"
							value='<s:date format="yyyy-MM-dd" name="e.startDate" />'
							style="max-width: 6.5em;" readonly="readonly" />
							&nbsp;到
							<input type="text" name="e.endDate" data-validate="date"
							value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
							style="max-width: 6.5em;" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td class="label" >*<s:text name="contract.charger.businessType"/>:</td>
						<td class="value" >
							<s:select name="e.businessType" list="businessTypeList" listKey="value" listValue="value"  data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" ></s:select>
						</td>
						<td class="label">*<s:text name="contract.transactor"/>:</td>
						<td class="value ">
							<s:textfield name="e.transactor.name" data-validate="required" readonly="true"	
							title='%{getText("contract.select.transactor")}' />
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="contract.car"/>:</td>
						<td class="value ">
							<s:textfield name="plate" data-validate="required" readonly="true" value="%{e.car.plateType+e.car.plateNo }"/>
						</td>
						<td class="label"><s:text name="contract.wordNo"/>:</td>
						<td class="value "><s:textfield name="e.wordNo" /></td>
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
				</tbody>
			</table>
		</div>
		<!-- 责任人信息 -->
		<div id="assignChargers" style="width:710px;" class="formTable2 ui-widget-content" 
			data-removeTitle='<s:text name="title.click2remove" />'>
			<div class="ui-state-active title" style="position:relative;">
				<span class="text"><s:text name="contract.charger.charger"/>：
					<s:if test="%{e.chargers == null || e.chargers.isEmpty()}"><s:text name="label.empty"/></s:if>
				</span>
				<span id="addChargers" class="verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="contract.title.click2selectCharger"/>'></span>
			</div>
			<s:if test="%{e.chargers != null && !e.chargers.isEmpty()}">
			<ul class="horizontal">
			<s:iterator value="e.chargers">
				<li class="horizontal ui-widget-content ui-corner-all" data-id='<s:property value="id" />'>
					<span class="text"><s:property value="name" /></span>
					<span class="click2remove verticalMiddle ui-icon ui-icon-close" title='<s:text name="title.click2remove"/>'></span>
				</li>
			</s:iterator>
			</ul>
			</s:if>	
		</div>
		<div class="formTabs" id="formTabs">
			<ul>
				<li><a href='#contractContents'>合同内容</a></li>
				<li><a href="#contractOldContents">旧合同内容</a></li>
				<li><a href='#attachment'>附件</a></li>
			</ul>
			<div id="contractContents" style="width:710px;">
				<div class="formEditor">
					<s:textarea name="e.content" cssClass="bc-editor" data-validate="required"
						 data-ptype="contractCharger.editor" data-puid='${e.uid}' 
						 data-readonly='${e.id == null ? "false" : "true"}'
						 >
					</s:textarea>
				</div>
			</div>
			<div id="contractOldContents" style="width:710px;">
				<div class="formEditor">
					<s:textarea name="e.oldContent" cssClass="bc-editor" data-validate="required"
						 data-ptype="contractCharger.editor" data-puid='${e.uid}' 
						 data-readonly='${e.id == null ? "false" : "true"}'
						 >
					</s:textarea>
				</div>
			</div>
			<div id="attachment" style="width:710px;">
				<s:property value="%{attachsUI}" escapeHtml="false"/>
			</div>
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
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
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.car.id" />
		<s:hidden name="e.transactor.id" />
		<s:hidden name="e.uid"/>
		<s:hidden name="e.type"/>
		<s:hidden name="assignChargerIds" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>