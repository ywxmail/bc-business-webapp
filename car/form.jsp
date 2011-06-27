<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="car.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc/car/save" />'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carForm" theme="simple">
		<div class="formFields">
			<s:textfield name="e.name" data-validate="required" style="width:99%"/>
		</div>
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
	</s:form>
</div>