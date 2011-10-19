<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="cert.select.identity"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/certIdentity/save" />'
	data-js='<s:url value="/bc-business/cert/driver4cert/certIdentity/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/ui-libs/xheditor/1.1.7/xheditor-zh-cn.min.js?ts=0" />'
	data-initMethod='bc.certIdentityForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="certIdentityForm" theme="simple">
		<div class="formFields ui-widget-content"  style="width:750px;">
			<fieldset style="width: 700px">
				<legend>正面</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr>
							<td class="label">*<s:text name="cert.carMan" /><s:text name="cert.name"/>:</td>
							<td class="value" style="width: 17em;">
								<s:if test="!e.isNew()">
									<s:textfield name="e.name" data-validate="required" cssStyle="max-width: 10em;" disabled="true" />
								</s:if>
								<s:else>
									<s:textfield name="e.name" data-validate="required" cssStyle="max-width: 10em;" title='%{getText("cert.title.click2selectCarMan")}' readonly="true" />
								</s:else>
								<s:radio name="e.sex" list="#{'1':'男','2':'女'}" 
								value="e.sex" cssStyle="width:auto;"/>
							</td>
							<td class="label">*<s:text name="cert.birthdate"/>:</td>
							<td class="value">
								<input type="text" name="e.birthdate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.birthdate" />'
								class="bc-date" data-cfg='{changeYear:true}' />
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.certCode"/>:</td>
							<td class="value">
								<s:textfield name="e.certCode" data-validate='{"type":"number","required":true}' />
							</td>
							<td class="label">*<s:text name="cert.nation"/>:</td>
							<td class="value">
								<s:textfield name="e.nation" data-validate="required"/>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="cert.address"/>:</td>
							<td class="value" colspan="3">
								<s:textfield name="e.address" cssStyle="width:46em;"/>
							</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<fieldset style="width: 700px">
				<legend>反面</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr>
							<td class="label">*<s:text name="cert.licencer"/>:</td>
							<td class="value" style="width: 17em;">
								<s:textfield name="e.licencer" data-validate="required" />
							</td>
							<td class="label">*<s:text name="cert.effectiveDate"/>:</td>
							<td class="value">
								&nbsp;从
								<input type="text" name="e.startDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.startDate" />'
								style="max-width: 9.25em;" />
								&nbsp;到
								<input type="text" name="e.endDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
								style="max-width: 9.25em;" />
							</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<fieldset style="width: 700px">
				<legend>复印件</legend>
				<s:property value="%{attachsUI}" escapeHtml="false" />
			</fieldset>
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
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.uid"/>
		<s:hidden name="e.type"/>
		<s:hidden name="carManId"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>