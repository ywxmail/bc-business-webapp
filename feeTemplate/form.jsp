<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="feeTemplate.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/feeTemplate/save" />'
	data-js='<s:url value="/bc-business/feeTemplate/form.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bs.feeTemplateForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="feeTemplateForm" theme="simple">
			<table class="formFields" cellspacing="2" cellpadding="0" style="width:370px;">
				<tbody>
					<tr>
						<td class="label"><s:text name="feeTemplate.type"/>:</td>
						<td><s:radio name="e.type" list="#{'1':'费用','0':'模板'}" cssStyle="width:auto;"/></td>
					</tr>
					<!-- 所属模板-->
					<tr class="feeInput" >
					    <td class="label"><s:text name="feeTemplate.ptempalte"/>:</td>
						<td class="value"><s:select name="e.pid" list="templateList" listKey="key" listValue="value" 
											headerKey="" headerValue="" cssClass="ui-widget-content" /></td>
					</tr>
					<!-- 所属模块-->
					<tr>
					    <td class="label">*<s:text name="feeTemplate.module"/>:</td>
						<td class="value "><s:textfield name="e.module" cssClass="ui-widget-content" data-validate="required"/></td>
					</tr>			
					<tr>
					    <td class="label">*<s:text name="feeTemplate.name"/>:</td>
						<td class="value "><s:textfield name="e.name" cssClass="ui-widget-content" data-validate="required"/></td>
					</tr>
					<tr class="feeInput">
					    <td class="label">*<s:text name="feeTemplate.price"/>:</td>
						<td class="value "><s:textfield name="e.price" cssClass="ui-widget-content"
							value="%{getText('bs.format.numberRMB',{e.price})}" data-validate='{required:true,type:"number"}'/></td>
					</tr>
					<tr class="feeInput">
					    <td class="label">*<s:text name="feeTemplate.count"/>:</td>
						<td class="value "><s:textfield name="e.count" cssClass="ui-widget-content" data-validate='{required:true,type:"number"}'/></td>
					</tr>
					<tr class="feeInput">
						<td class="label">*<s:text name="feeTemplate.payType"/>:</td>
						<td><s:select name="e.payType" list="payTypeList" listKey="key" listValue="value" data-validate="required"
								headerKey="" headerValue="" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="feeTemplate.order"/>:</td>
						<td class="value"><s:textfield name="e.order"cssClass="ui-widget-content" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="feeTemplate.spec"/>:</td>
						<td class="value"><s:textfield name="e.spec"cssClass="ui-widget-content" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="feeTemplate.status"/>:</td>
						<td><s:radio name="e.status" list="#{'0':'在案','1':'禁用'}" cssStyle="width:auto;"/></td>
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="feeTemplate.desc"/>:</td>
						<td class="value"><s:textarea name="e.desc" rows="5" cssClass="ui-widget-content noresize"/></td>
					</tr>
					<tr>
						<td class="label" colspan="2" rowspan="2">
							<div class="formTopInfo">
								创建：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
								<s:if test="%{e.modifier != null}">
								<br/>最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate"  value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>