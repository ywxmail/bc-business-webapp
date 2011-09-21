<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="cert.select.driving"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/certDriving/save" />'
	data-js='<s:url value="/bc-business/cert/driver4cert/certDriving/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/ui-libs/xheditor/1.1.7/xheditor-zh-cn.min.js?ts=0" />'
	data-initMethod='bc.certDrivingForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="certDrivingForm" theme="simple">
		<div class="formFields ui-widget-content"  style="width:750px;">
			<fieldset style="width: 700px">
				<legend>正页</legend>
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
							<td class="label" style="width: 7em;">*<s:text name="cert.birthdate"/>:</td>
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
							<td class="label">*<s:text name="cert.model"/>:</td>
							<td class="value">
								<s:textfield name="e.model" data-validate="required"/>
							</td>
							<td class="label">*<s:text name="cert.receiveDate"/>:</td>
							<td class="value">
								<input type="text" name="e.receiveDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.receiveDate" />'
								class="bc-date" data-cfg='{changeYear:true}' />
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="cert.startDate2"/>:</td>
							<td class="value">
								<input type="text" name="e.startDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.startDate" />'
								class="bc-date" data-cfg='{changeYear:true}' />
							</td>
							<td class="label">*<s:text name="cert.validFor" />:</td>
							<td class="value" >
								<s:textfield name="e.validFor" data-validate='{"type":"number","required":true}'  cssStyle="width:3em;"/>
							</td>
						</tr>	
						<tr>
							<td class="label"><s:text name="cert.address"/>:</td>
							<td class="value" colspan="3">
								<s:textfield name="e.address" cssStyle="width:46em;"/>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="cert.licencer"/>:</td>
							<td class="value" colspan="3">
								<s:textfield name="e.licencer" cssStyle="width:46em;"/>
							</td>
						</tr>				
					</tbody>
				</table>
			</fieldset>
			<fieldset style="width: 700px">
				<legend>副面</legend>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr>
							<td class="label">*<s:text name="cert.archiveNo"/>:</td>
							<td class="value" colspan="3">
								<s:textfield name="e.archiveNo" data-validate="required" cssStyle="width:46em;"/>
							</td>
						</tr>
						<tr>
							<td class="label" style="text-align: left">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:text name="cert.record"/>:
							</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="value" colspan="4" style="text-align: right">
								<s:textarea name="e.record" cssStyle="width:46em;" />
							</td>
							<td></td>
							<td></td>
							<td></td>
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