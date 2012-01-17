<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:property value="title"/>' data-type='form'
	class="bc-page"
	data-js='<s:url value="/bc-business/contract4Charger/selectDateAndCharger.js" />'
	data-initMethod='bc.selectDateAndChargerForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectDateAndChargerForm.clickOk"}],
		"width":330,height:250,modal:true
	}'
	style="overflow-y: hidden;">
	<s:form name="selectDateAndChargerForm" theme="simple"
		cssStyle="">
		<div class="ui-widget-header" style="border-width:0;padding: 0.25em;">
			<span style="text">请选择新的合同期限：</span>
		</div>
		<div style="position: relative; display: inline-block;margin:4px 0;">
			&nbsp;从<input type="text" name="startDate"
				data-validate='{"type":"date","required":true}'
				data-cfg='{"changeYear":true}'
				value='<s:date format="yyyy-MM-dd" name="startDate" />'
				style="width: 10em;" class="bc-date ui-widget-content" />
			<ul class="inputIcons" style="right: 0px;">
				<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"
					data-cfg='startDate'></li>
			</ul>
		</div>
		<div style="position: relative; display: inline-block">
			&nbsp;到<input type="text" name="endDate"
				data-validate='{"type":"date","required":true}'
				data-cfg='{"changeYear":true}'
				value='<s:date format="yyyy-MM-dd" name="endDate" />'
				style="width: 10em;" class="bc-date ui-widget-content" />
			<ul class="inputIcons" style="right: 0px;">
				<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"
					data-cfg='endDate'></li>
			</ul>
		</div>
		<div>
			<label for="takebackOrigin" style="margin:4px;">
			<s:checkbox id="takebackOrigin" name="takebackOrigin" cssStyle="margin:2px 0;_margin:0;"/>
			<span style="margin:0 4px;_margin:0 2px;"><s:text name="contract4Charger.takebackOrigin"/></span>
			</label>
		</div>
		<!-- 责任人信息 -->
		<div id="assignChargers" class="ui-widget-content" style="border-width:0;margin-top:8px;"
			data-removeTitle='<s:text name="title.click2remove" />'>
			<div class="ui-widget-header" style="position:relative;border:0;padding: 0.25em;">
				<span class="text">请选择新的责任人：</span>
				<span id="addChargers" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="contract.title.click2selectCharger"/>'></span>
			</div>
		</div>
		<s:hidden name="carId"/>
	</s:form>
</div>