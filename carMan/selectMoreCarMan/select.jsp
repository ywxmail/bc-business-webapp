<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="bc-page" title='<s:text name="carMans.title.select"/>'
	data-type='dialog' data-initMethod='bs.selectMoreCarMan.init'
	data-js='<s:url value="/bc-business/carMan/selectMoreCarMan/select.js" />'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bs.selectMoreCarMan.clickOk"}],
		"width":300,"modal":true
	}'>
	<div style="margin:4px;">
	<s:select name="carMans" list="carMans" listKey="id+','+cert4FWZG+','+region+','+drivingStatus" listValue="name" theme="simple"
		size="10" cssStyle="width:100%;height:100%;" value="selected"
		multiple="%{multiple}"></s:select>
	</div>
</div>