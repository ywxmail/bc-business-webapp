<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="contract.labour.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/contractLabour/save" />'
	data-js='<s:url value="/bc-business/contractLabour/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/ui-libs/xheditor/1.1.7/xheditor-zh-cn.min.js?ts=0" />'
	data-initMethod='bc.contractLabourForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="contractLabourForm" theme="simple">
		<div class="formFields ui-widget-content"  style="width:710px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label">*<s:text name="contract.code"/>:</td>
						<td class="value "><s:textfield name="e.code" data-validate="required" /></td>
						<td class="label">*<s:text name="contract.signDate"/>:</td>
						<td class="value">
							<input type="text" name="e.signDate" data-validate='{"type":"date","required":true}'
							value='<s:date format="yyyy-MM-dd" name="e.signDate" />'
							class="bc-date" data-cfg='{changeYear:true}'/>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="contract.labour.driver"/>:</td>
						<td class="value ">
						<!--
							<s:if test="!e.isNew()">
								<s:textfield name="ext_str2_temp" value="%{e.ext_str2}" data-validate="required" disabled="true" />
								<s:hidden name="e.ext_str2" />
							</s:if>
							<s:else>
								<s:textfield name="e.ext_str2" data-validate="required" title='%{getText("cert.title.click2selectCar")}' readonly="true" />
							</s:else>
						 -->
						 	<s:textfield name="e.ext_str2" data-validate="required" title='%{getText("contract.title.click2selectCarMan")}' readonly="true" />
						</td>
						<td class="label">*<s:text name="contract.deadline"/>:</td>
						<td class="value">
							&nbsp;从
							<input type="text" name="e.startDate" data-validate='{"type":"date","required":true}' 
							value='<s:date format="yyyy-MM-dd" name="e.startDate" />'
							style="max-width: 6.5em;" />
							&nbsp;到
							<input type="text" name="e.endDate" data-validate='{"type":"date","required":true}'
							value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
							style="max-width: 6.5em;" />
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="contract.car" />:</td>
						<td class="value ">
							<s:textfield name="e.ext_str1" data-validate="required" readonly="true" title='%{getText("contract.title.click2selectCar")}' />
						</td>
						<td class="label">*<s:text name="contract.transactor"/>:</td>
						<td class="value ">
							<s:textfield name="e.transactorName" data-validate="required" readonly="true"	
							title='%{getText("contract.select.transactor")}' />
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="contract.labour.certNo"/>:</td>
						<td class="value "><s:textfield name="e.certNo" data-validate="required"/></td>
						<td class="label"><s:text name="contract.wordNo"/>:</td>
						<td class="value "><s:textfield name="e.wordNo" /></td>
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
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset" data-cfg="{height:300}"
			style="height:300px;width:710px;overflow: hidden;">
			<div class="tabsContainer">
           	 	<div class="slideContainer">
					<ul class="tabs ui-helper-reset">
						<li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">其他信息</a></li>
						<li class="tab ui-widget-content"><a href="#contractContents" class="ui-state-default">合同内容</a></li>
						<li class="tab ui-widget-content"><a href='#attachment' class="ui-state-default">附件</a></li>
					</ul>
				</div>
			</div>
			<div class="contentContainer ui-helper-reset ui-widget-content">
				<div id="otherFormFields" class="content active" style="width:710px;">
					<table class="formFields" cellspacing="2" cellpadding="0" >
						<tbody>
							<tr style="height: 1px;">
								<td style="width: 100px;">&nbsp;</td>
								<td style="width: 300px;">&nbsp;</td>
								<td >&nbsp;</td>
		
							</tr>
							<tr>
								<td class="label"><s:text name="contract.labour.preIndustryName"/>:</td>
								<td class="value" colspan="2"><s:textfield name="e.preIndustryName" cssStyle="width:43em;" /></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td class="label"><s:text name="contract.labour.preIndustryType"/>:</td>
								<td class="value"><s:radio name="e.preIndustryType" list="#{false:getText('contract.labour.preIndustryType.not'),true:getText('contract.labour.preIndustryType.yes')}" cssStyle="width:auto;" /></td>
								<td  colspan="5" class="label" style="text-align: left;">
									<s:checkbox name="e.additionProtocol" cssStyle="width:1em;" />
									<s:text name="contract.labour.additionProtocol"/>
									<s:checkbox name="e.filing" cssStyle="width:1em;"/>
									<s:text name="contract.labour.filing"/>
									<s:checkbox name="e.dole" cssStyle="width:1em;" />
									<s:text name="contract.labour.dole"/>
								</td>
			
							</tr>
							<tr>
								<td class="label"><s:text name="contract.labour.hiringProcedure"/>:</td>
								<td class="value"><s:radio name="e.hiringProcedure" list="#{false:getText('contract.labour.hiringProcedure.not')+'&nbsp;&nbsp;&nbsp;',true:getText('contract.labour.hiringProcedure.yes')}" cssStyle="width:auto;"/></td>
								<td>&nbsp;</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="contractContents" class="content" style="width:710px;">
					<div class="formEditor">
						<s:textarea name="e.content" cssClass="bc-editor" cssStyle="width: 680px;height:280px" data-validate="required"
							 data-ptype="contractLabour.editor" data-puid='${e.uid}' 
							 data-readonly='${e.id == null ? "false" : "true"}'
							 >
						</s:textarea>
					</div>
				</div>
				<div id="attachment"  class="content"style="width:710px;">
					<s:property value="%{attachsUI}" escapeHtml="false"/>
				</div>
			</div>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.transactorId" />
		<s:hidden name="e.uid"/>
		<s:hidden name="e.type"/>
		<s:hidden name="carManId"/>
		<s:hidden name="carId"/>
		<s:hidden name="oldCarManId"/>
		<s:hidden name="oldCarId"/>
		<s:hidden name="isMoreCar"/>
		<s:hidden name="isMoreCarMan"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>