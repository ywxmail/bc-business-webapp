<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="socialSecurityRule.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/socialSecurityRule/save" />'
	data-js='<s:url value="/bc/libs/select.js" />,<s:url value="/bc-business/socialSecurityRule/form.js" />,<s:url value="/bc/placeOrigin/placeOrigin.js" />'
	data-initMethod='bc.socialSecurityRuleForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="socialSecurityRuleForm" theme="simple">	
		<table class="formFields" cellspacing="2" cellpadding="0" style="width: 43em">
			<tbody>
				<tr class="widthMarker">
	                <td style="width: 5em;">&nbsp;</td>
	                <td style="width: 16em;">&nbsp;</td>
	                <td style="width: 8em;">&nbsp;</td>
	                <td >&nbsp;</td>
				 </tr>
				<tr>
				    <td class="label">*<s:text name="socialSecurityRule.areaName"/>:</td>
					<td class="value" style="position:relative;display: block;">
						<s:textfield name="e.areaName" cssClass="ui-widget-content" data-validate="required" readonly="true"/>
						<span id="selectArea" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></span>
					</td>
					<td class="label">*<s:text name="socialSecurityRule.starDate"/>:</td>
					<td class="value">从
						<s:textfield name="e.startYear" cssClass="ui-widget-content"  cssStyle="width: 4em"
							data-validate="{'required':true,'type':'number','min':'1990','max':'9999'}"/>年
							
						<s:textfield name="e.startMonth" cssClass="ui-widget-content" cssStyle="width: 2em" 
							data-validate="{'required':true,'type':'number','min':'1','max':'12'}"/>月起</td>
				</tr>
				<tr>
					<td class="label">*<s:text name="socialSecurityRule.houseType"/>:</td>
					<td class="value" >
						<s:select name="e.houseType" list="houseTypeList" listKey="value" listValue="value" 
							headerKey="" headerValue="" headerValue="%{getText('label.please.choose')}" data-validate="required" 
								cssClass="ui-widget-content "></s:select>
					</td>
				</tr>
				<tr>
					<td class="label" colspan="4">
						<div class="formTopInfo">
							<s:if test="%{e.author.name != null}">
							创建：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
							</s:if>
							<s:if test="%{e.modifier != null}">
							，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
							</s:if>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- 保险明细 -->
		<div class="ui-widget-content" style="border-width:1px 0 0 0;margin-bottom:8px;width: 100%;">
			<div class="ui-widget-header" style="position:relative;border-width: 0;padding: 0.25em;">
				<span class="text"><s:text name="socialSecurityRuleDetail.d"/>：</span>
				<ul class="inputIcons">
					<li id="addLine" class="inputIcon ui-icon ui-icon-circle-plus"
						title='<s:text name="socialSecurityRule.title.click2addLine"/>'></li>
					<li id="deleteLine" class="inputIcon ui-icon ui-icon-circle-close"
						title='<s:text name="socialSecurityRule.title.click2deleteLine"/>'></li>
				</ul>
			</div>
	    	<div class="bc-grid header" >
			<table class="table" id="socialSecurityRuleTables" cellspacing="0" cellpadding="0" style="width: 100%">
				<tr class="ui-state-default header row">
					<td class="first" style="width: 15px;">&nbsp;</td>
					<td class="middle" style="width: 6em;">名称</td>
					<td class="middle" style="width: 7em;">单位缴率(%)</td>
					<td class="middle" style="width: 7em;">个人缴率(%)</td>
					<td class="middle" style="width: 8em;">基数(元)</td>
					<td class="last">备注</td>
				</tr>
				<s:if test="%{e.isNew()}">
				<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
					<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
					</td>
					<td class="middle" style="padding:0;text-align:left;position:relative;">
						<input type="text" name="name" value='<s:property value="name"/>' style="width:99%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" 
							class="bc-select ui-widget-content" data-validate="required" 
							data-maxHeight="150px"
							data-source='<s:property value="names"/>'/>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
						</ul>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
							data-validate="{'required':true,'type':'number'}" value="0"/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
							data-validate="{'required':true,'type':'number'}" value="0"/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
							data-validate="{'required':true,'type':'number'}" value="0"/>
					</td>
					<td class="last" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
							 value='<s:property value="desc"/>'/>
					</td>
				</tr>
				</s:if>
				<s:iterator var="b" value="e.socialSecurityRuleDetail" >
				<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
					<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
					</td>
					<td class="middle" style="padding:0;text-align:left;position:relative;">
						<input type="text" name="name" value='<s:property value="name"/>' style="width:99%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" 
							class="bc-select ui-widget-content" data-validate="required" 
							data-maxHeight="150px"
							data-source='<s:property value="names"/>'/>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
						</ul>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<s:textfield name="unitRate" cssClass="ui-widget-content" cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"
								value="%{getText('socialSecurityRuleDetail.money.format',{unitRate})}" data-validate="{'required':true,'type':'number'}" />
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<s:textfield name="personalRate" cssClass="ui-widget-content" cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"
								value="%{getText('socialSecurityRuleDetail.money.format',{personalRate})}" data-validate="{'required':true,'type':'number'}" />
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<s:textfield name="baseNumber" cssClass="ui-widget-content" cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"
								value="%{getText('socialSecurityRuleDetail.money.format',{baseNumber})}" data-validate="{'required':true,'type':'number'}" />
					</td>
					<td class="last" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
							 value='<s:property value="desc"/>'/>
					</td>
				</tr>
				</s:iterator>
			</table>
			</div>
		</div>
		<s:hidden name="e.id"/>
		<s:hidden name="e.areaId"/>
		<s:hidden name="e.author.id"/>
		<s:hidden name="e.modifier.id"/>
		<s:hidden name="details"/>
		<s:hidden name="nameLists" value="%{names}"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>