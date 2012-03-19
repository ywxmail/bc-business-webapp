<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='更新联系电话信息' data-type='form' class="bc-page"
	data-namespace="<s:url value="/bc-business/carMan" />"
	data-js='<s:url value="/bc-business/carMan/updatePhone.js" />'
	data-initMethod='bc.updataCarManPhone.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","click":"bc.updataCarManPhone.save"}]}' style="overflow-y:auto;">
	<s:form name="updataCarManPhone" theme="simple" cssClass="bc-form" >
		<s:if test="error != null">
			<s:property value="error"/>
		</s:if>
		<s:else>
			<table class="formFields" style="width:300px">
				<tbody>
					<tr>
						<td class="label" style="min-width: 3em;width: 3em;"><s:text name="carMan.phone1"/>:</td>
						<td class="value"><s:textfield name="phone1" value="%{phone1}" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" style="min-width: 3em;width: 3em;"><s:text name="carMan.phone2"/>:</td>
						<td class="value"><s:textfield name="phone2" value="%{phone2}" cssClass="ui-widget-content"/></td>
					</tr>
				</tbody>
			</table>
		</s:else>
		<s:hidden name="id" value="%{id}"/>
	</s:form>
</div>