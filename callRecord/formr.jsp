<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="callRecord.title"/>' data-type='form' class="bc-page unselectable" unselectable="on"
	data-js='<s:url value="/bc-business/callRecord/formr.js" />' oncontextmenu="return false;"
	data-option='<s:property value="formPageOption"/>' style="overflow-y:auto;cursor: default;">
	<s:form name="callRecordFormr" theme="simple" style="margin:10px;">
	<div style='font-weight: normal;'>
	<s:property value="@cn.bc.docs.domain.Attach@DATA_REAL_PATH"/>/<s:property value="@cn.bc.business.callrecord.domain.CallRecord@DATA_SUB_PATH"/>/<s:property value="e.path"/>
	<br><audio controls="controls" 
	src='<s:url value="/bc/file/download?f=%{@cn.bc.business.callrecord.domain.CallRecord@DATA_SUB_PATH}"/>/<s:property value="e.path"/>' >
		Your browser does not support the audio tag.
	</audio>
	</div>
	</s:form>
</div>