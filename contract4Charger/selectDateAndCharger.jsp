<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='过户操作' data-type='form'
	class="bc-page"
	data-js='<s:url value="/bc-business/contract4Charger/selectDateAndCharger.js" />'
	data-initMethod='bc.selectDateAndChargerForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectDateAndChargerForm.clickOk"}],
		"width":330,height:250,modal:true
	}'
	style="overflow-y: hidden;">
	<s:form name="selectDateAndChargerForm" theme="simple">
		<div class="ui-widget-header" style="border-width:0;padding: 0.25em;">
			<span style="text">请选择新的合同期限：</span>
		</div>
		<div style="position: relative; display: inline-block;margin:4px 0;">
			&nbsp;从<input type="text" name="startDate"
				data-validate='{"type":"date","required":true}'
				data-cfg='{"changeYear":true}'
				value='<s:date format="yyyy-MM-dd" name="startDate" />'
				style="width: 9em;" class="bc-date ui-widget-content" />
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
				style="width: 9em;" class="bc-date ui-widget-content" />
			<ul class="inputIcons" style="right: 0px;">
				<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"
					data-cfg='endDate'></li>
			</ul>
		</div>
		<!--  合同编号 -->
		<div>
			<s:text name="contract.code"/>:<s:textfield name="code" data-validate="required" 
				cssClass="ui-widget-content" 
				data-validate='{"required":true,"method":"bc.contract4ChargerForm.validateCode","msg":"请输入正确的经济合同编号格式：<br/>CLHT+[4位年份]+[2位月份]+[2位流水号]"}'/>
			<s:checkbox id="takebackOrigin" name="takebackOrigin" cssStyle="margin:2px 0;_margin:0;"/>
			<label for="takebackOrigin" style="margin:4px;">
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