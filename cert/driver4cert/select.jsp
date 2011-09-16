<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="bc-page" title='<s:text name="cert.type"/>' 
	data-type='dialog' data-initMethod='bc.selectCert.init'
	data-js='<s:url value="/bc-business/cert/driver4cert/select.js" />,<s:url value="/bc/identity/identity.js" />'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectCert.clickOk"}],
		"width":300,"modal":true
	}' >
	<div style="margin:4px;">
	<s:select list="#{1:getText('cert.select.identity'),2:getText('cert.select.driving'),3:getText('cert.select.cyzg'),
		4:getText('cert.select.fwzg'),5:getText('cert.select.jspx')}" theme="simple"
		size="10" cssStyle="width:100%;height:100%;" value="selected"
		multiple="%{multiple}"></s:select>
	</div>
</div>