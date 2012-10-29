<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:property value="typeDesc"/>' data-type='form' class="bc-page"
	data-js='js:redactor_css,<s:url value="/bc-business/info/formr.js" />'
	data-initMethod='bs.infoFormr.init'
	data-option='<s:property value="formPageOption"/>' style="overflow-y:auto;">
	<s:form name="infoFormr" theme="simple" style="margin:10px;">
	<div class="info-subject" style='text-align:center;font-size:30px;outline:0;' tabIndex="0"><s:if 
		test="%{e.status == 1}"><strike><s:property value="e.subject" escapeHtml="false"/></strike></s:if>
		<s:else><s:property value="e.subject" escapeHtml="false"/></s:else></div>
	<div class="info-history" style="text-align:center;font-weight:normal;"><s:property value="typeDesc" /> <s:date 
		format="yyyy年MM月dd日" name="e.sendDate" /> <s:property value="e.source"/><s:if test="%{e.status != 0}"> [<s:property value="statusDesc"/>]</s:if></div>
	<s:if test="%{e.content.length() > 0}">
	<div class="ui-widget-content" style="border-width: 0 0 1px 0;height:1px;"></div>
	<div class="info-content redactor_editor" style="font-weight: normal;"><s:property value="e.content" escapeHtml="false"/></div>
	</s:if>
	<div class="ui-widget-content " style="border-width: 0 0 1px 0;height:1px;"></div>
	<s:property value="attachsUI" escapeHtml="false"/>
	</s:form>
</div>