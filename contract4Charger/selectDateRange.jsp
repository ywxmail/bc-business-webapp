<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='续约操作' data-type='form'
	class="bc-page"
	data-js='<s:url value="/bc-business/contract4Charger/selectDateRange.js" />'
	data-initMethod='bc.selectDateRangeFrom4contractCharger.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectDateRangeFrom4contractCharger.clickOk"}],
		"width":330,height:195,modal:true
	}'
	style="overflow-y: hidden;">
	<s:form name="selectDateRangeFrom" theme="simple">
		<div class="ui-widget-header" style="border-width:0;padding: 0.25em;_margin:2px 0;">
			<span style="text">请选择新的合同期限：</span>
		</div>
		<div style="position: relative; display: inline-block;margin:2px 0;">
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
		<div style="position: relative; display: inline-block;margin:2px 0;">
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
		<div class="ui-widget-header" style="border-width:0;padding: 0.25em;_margin: 1px 0;">
			<span style="text">请输入合同编号：</span>
		</div>
		<div>
			<s:text name="contract.code"/>:<s:textfield name="code" data-validate="required" 
				cssStyle="margin:2px 0 2px 0;_margin:0;" cssClass="ui-widget-content" 
				data-validate='{"required":true,"method":"bc.contract4ChargerForm.validateCode","msg":"请输入正确的经济合同编号格式：<br/>CLHT+[4位年份]+[2位月份]+[2位流水号]"}'/>
		</div>
	</s:form>
</div>