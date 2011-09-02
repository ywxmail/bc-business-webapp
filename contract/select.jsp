<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="bc-page" title='<s:text name="contract.select.title"/>' 
	data-type='dialog' data-initMethod='bc.selectContract.init'
	data-js='<s:url value="/bc-business/contract/select.js" />,<s:url value="/bc/identity/identity.js" />'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectContract.clickOk"}],
		"width":300,"modal":true
	}' >
	<div style="margin:4px;">
	<s:select list="#{1:getText('contract.select.labour'),2:getText('contract.select.charger')}" theme="simple"
		size="10" cssStyle="width:100%;height:100%;" value="selected"
		multiple="%{multiple}"></s:select>
	</div>
</div>