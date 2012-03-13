<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='更新联系电话信息' data-type='form' class="bc-page"
	data-namespace="<s:url value="/bc-business/carMan" />"
	data-js='<s:url value="/bc-business/carMan/updatePhone.js" />'
	data-initMethod='bc.updataCarManPhone.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:hidden;">
	<s:form name="updataCarManPhone" theme="simple" cssClass="bc-form" >
		<s:property value="error"/>
	</s:form>
</div>