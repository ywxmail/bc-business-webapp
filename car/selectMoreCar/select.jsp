<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="bc-page" title='<s:text name="cars.title.select"/>'
	data-type='dialog' data-initMethod='bs.selectMoreCar.init'
	data-js='<s:url value="/bc-business/car/selectMoreCar/select.js" />'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bs.selectMoreCar.clickOk"}],
		"width":300,"modal":true
	}'>
	<div style="margin:4px;">
	<s:select name="cars" list="cars" listKey="id+','+motorcade.id+','+motorcade.name" listValue="plateType+'.'+plateNo" theme="simple"
		size="10" cssStyle="width:100%;height:100%;" value="selected"
		multiple="%{multiple}"></s:select>
	</div>
</div>