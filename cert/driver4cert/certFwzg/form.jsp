<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="cert.select.fwzg"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/certFwzg/save" />'
	data-js='<s:url value="/bc-business/cert/driver4cert/certFwzg/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/ui-libs/xheditor/1.1.7/xheditor-zh-cn.min.js?ts=0" />'
	data-initMethod='bc.certFwzgForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="certFwzgForm" theme="simple">
		<div class="formFields ui-widget-content"  style="width:375px;">
			<fieldset style="width: 325px">
				<legend>正面</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr>
							<td class="label">*<s:text name="cert.carMan" /><s:text name="cert.name"/>:</td>
							<td class="value" >
								<s:if test="!e.isNew()">
									<s:textfield name="e.name" data-validate="required" disabled="true" />
								</s:if>
								<s:else>
									<s:textfield name="e.name" data-validate="required" title='%{getText("cert.title.click2selectCarMan")}' readonly="true" />
								</s:else>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.certCode"/>:</td>
							<td class="value">
								<s:textfield name="e.certCode" data-validate='{"type":"number","required":true}' />
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="cert.serviceUnit" />:</td>
							<td class="value" ><s:textfield name="e.serviceUnit"
							readonly="true"	title='%{getText("cert.title.click2selectBelong")}' />
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="cert.level"/>:</td>
							<td class="value">
								<s:textfield name="e.level" />
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.issueDate"/>:</td>
							<td class="value">
								<input type="text" name="e.issueDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.issueDate" />'
								class="bc-date" data-cfg='{changeYear:true}' />
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.licencer"/>:</td>
							<td class="value">
								<s:textfield name="e.licencer" />
							</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<fieldset style="width: 325px">
				<legend>复印件</legend>
				<s:property value="%{attachsUI}" escapeHtml="false" />
			</fieldset>
		</div>
		<table class="formFields" cellspacing="2" cellpadding="0">
			<tbody>
				<tr>
					<td class="label" colspan="2">
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
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.uid"/>
		<s:hidden name="e.type"/>
		<s:hidden name="carManId"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>