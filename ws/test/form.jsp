<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='WebService接口测试' data-type='form' class="bc-page"
	data-namespace="<s:url value="/bc-business/ws/test" />"
	data-js='<s:url value="/bc-business/ws/test/form.js" />'
	data-initMethod='bc.wstest.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.wstest.doOK"}],
		"width":700,"minWidth":250,"minHeight":250,"modal":false
	}' style="overflow: auto;"">
	<s:form name="carManForm" theme="simple">
		<div class="formFields ui-widget-content">
			<table class="formFields" cellspacing="2" cellpadding="0" >
				<tbody>
					<tr>
						<td class="label">idKey:</td>
						<td class="value"><s:textfield name="idKey"/></td>
						<td class="label">处理方式:</td>
						<td class="value"><s:radio name="raw" list="#{'0':'XML','1':'DataSet'}" 
							value="0" cssStyle="width:auto;"/></td>
					</tr>
					<tr>
						<td class="label">soapAction:</td>
						<td class="value" colspan="3"><s:textfield name="soapAction"/></td>
					</tr>
					<tr>
						<td class="label top">bodyXml:</td>
						<td class="value" colspan="3"><s:textarea name="bodyXml" rows="8"/></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="respone" style="overflow: auto;">
		</div>
	</s:form>
</div>