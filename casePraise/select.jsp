<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="bc-page" title='<s:text name="runcase.complain.title"/>' 
	data-type='dialog' data-initMethod='bc.selectSubject.init'
	data-js='<s:url value="/bc-business/casePraise/select.js" />'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectSubject.clickOk"}],
		"width":300,"modal":true
	}' >
	<div style="margin:4px;">
	<s:select list="#{1:getText('runcase.case7'),2:getText('runcase.case8'),3:getText('runcase.case9')}" 
		theme="simple" size="10" cssStyle="width:100%;height:100%;" value="selected" name="selectSubject"
		multiple="%{multiple}"></s:select>
	</div>
</div>