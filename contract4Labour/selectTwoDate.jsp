<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='离职操作' data-type='form'
	class="bc-page"
	data-js='<s:url value="/bc-business/contract4Labour/selectTwoDate.js" />'
	data-initMethod='bc.selectTwoDate4contractLabourForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectTwoDate4contractLabourForm.clickOk"}],
		"width":200,height:195,modal:true
	}'
	style="overflow-y: hidden;">
	<s:form name="selectTwoDateFrom" theme="simple">
		<div class="ui-widget-header" style="border-width:0;padding: 0.25em;_margin:2px 0;">
			<span style="text">请输入离职日期：</span>
		</div>
		<div style="position: relative; display: inline-block;margin:2px 0;">
			<input type="text" name="resignDate"
				data-validate='{"type":"date","required":true}'
				data-cfg='{"changeYear":true}'
				value='<s:date format="yyyy-MM-dd" name="resignDate" />'
				style="width: 100%;" class='bc-date ui-widget-content' 
			/>
			<ul class="inputIcons" style="right: 0px;">
			<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"
				data-cfg='resignDate'></li>
			</ul>
		</div>
		<div class="ui-widget-header" style="border-width:0;padding: 0.25em;_margin: 2px 0;">
			<span style="text">请输入停保日期：</span>
		</div>
		<div style="position: relative; display: inline-block;margin:2px 0;">
			<input type="text" name="stopDate"
				data-validate='{"type":"date","required":true}'
				data-cfg='{"changeYear":true}'
				value='<s:date format="yyyy-MM-dd" name="stopDate" />'
				style="width: 100%;" class='bc-date ui-widget-content'
			 />
			<ul class="inputIcons" style="right: 0px;">
			<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"
				data-cfg='stopDate'></li>
			</ul>
		</div>
	</s:form>
</div>