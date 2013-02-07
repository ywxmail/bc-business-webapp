<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<ul class="conditions" style="min-width:19.3em;">
		<li class="condition">
			<div class="bc-relativeContainer">
				<div class="label">所属分公司</div>
				<div class="value bc-relativeContainer ">
					<input type="text" class="bc-select ui-widget-content" readonly="readonly"
						data-maxHeight="150px" style="width: 9em;"
						data-source='<s:property value="units"/>'>
					<input type="hidden" data-condition='{"type":"long","ql":"b.unit_id=?"}'>
					<ul class="inputIcons">
						<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div><div style="width:12px;display:inline-block;"></div><div class="bc-relativeContainer">
				<div class="label">所属车队</div>
				<div class="value bc-relativeContainer">
					<input type="text" class="bc-select ui-widget-content" readonly="readonly"
						data-maxHeight="150px" style="width:9em;"
						data-source='<s:property value="motorcades"/>'>
					<input type="hidden" data-condition='{"type":"long","ql":"a.motorcade_id=?"}'>
					<ul class="inputIcons">
						<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
		</li>
		<li class="condition">
			<div class="label">日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"to_date(concat(year_,&#39;-&#39;,month_,&#39;-&#39;,day_),&#39;YYYY-MM-DD&#39;) >= ?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"to_date(concat(year_,&#39;-&#39;,month_,&#39;-&#39;,day_),&#39;YYYY-MM-DD&#39;) <= ?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">数量</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="ui-widget-content" data-validate="digits" style="width:9em;"
						data-condition='{"type":"int","ql":"a.quantity>=?"}'>
					<ul class="inputIcons">
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="ui-widget-content" data-validate="digits" style="width:9em;"
						data-condition='{"type":"int","ql":"a.quantity<=?"}'>
					<ul class="inputIcons">
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
	</ul>
</form>