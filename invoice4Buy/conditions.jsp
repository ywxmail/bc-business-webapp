<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<ul class="conditions" style="min-width:19.3em;">
		<li class="condition">
			<div class="label">公司</div>
			<div class="value">
				<input type="text" class="bc-select ui-widget-content" readonly="readonly"
					data-maxHeight="150px"
					data-source='<s:property value="companies"/>'>
				<input type="hidden" data-condition='{"type":"string","ql":"b.company=?"}'>
				<ul class="inputIcons">
					<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
					<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
		</li>
		<li class="condition">
			<div class="label">发票代码</div>
			<div class="value">
				<input type="text" class="ui-widget-content" data-condition='{"type":"string","ql":"b.code=?"}'>
				<ul class="inputIcons">
					<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">发票编码</div>
			<div class="value">
				<input type="text" class="ui-widget-content" data-condition='{"type":"string","ql":"(b.start_no<=? and b.end_no>=?)"}'>
				<ul class="inputIcons">
					<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">入库日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"b.buy_date>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div><div style="width:12px;display:inline-block;">～</div><div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"b.buy_date<=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
	</ul>
</form>