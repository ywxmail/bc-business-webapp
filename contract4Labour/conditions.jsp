<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<ul class="conditions" style="min-width:19.3em;">
		<li class="condition">
			<div class="label">所属公司</div>
			<div class="value checkboxes" data-condition='{"type":"string","key":"car.company"}' >
				<label><input type="checkbox" name="checkboxField1" value="宝城"><span>宝城</span></label>
				<label><input type="checkbox" name="checkboxField1" value="广发"><span>广发</span></label>
			</div>
		</li>
		<li class="condition">
			<div class="bc-dateContainer">
				<div class="label">所属分公司</div>
				<div class="value bc-dateContainer">
					<input type="text" class="bc-select ui-widget-content" readonly="readonly"
						data-maxHeight="150px" style="width:9em;"
						data-source='<s:property value="units"/>'>
					<input type="hidden" data-condition='{"type":"long","ql":"m.unit_id=?"}'>
					<ul class="inputIcons">
						<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="bc-dateContainer">
				<div class="label">所属车队</div>
				<div class="value bc-dateContainer">
					<input type="text" class="bc-select ui-widget-content" readonly="readonly"
						data-maxHeight="150px" style="width:9em;"
						data-source='<s:property value="motorcades"/>'>
					<input type="hidden" data-condition='{"type":"long","ql":"car.motorcade_id=?"}'>
					<ul class="inputIcons">
						<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
		</li>
		<li class="condition">
			<div class="label">合同期限(开始日期)</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"c.start_date>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"c.start_date<=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">合同期限(结束日期)</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"c.end_date>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"c.end_date<=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<!-- 
			<li class="condition">
				<div class="label">社保申领期限(开始日期)</div>
				<div class="value">
					<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"startDate","ql":"cl.get_startDate>=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>～<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"endDate","ql":"cl.get_startDate<=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</li>
			<li class="condition">
				<div class="label">社保申领期限(结束日期)</div>
				<div class="value">
					<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"startDate","ql":"cl.get_endDate>=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>～<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"endDate","ql":"cl.get_endDate<=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</li>
		 -->
		<li class="condition">
			<div class="label">参保日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"cl.joinDate>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"cl.joinDate<=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">停保日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"cl.stopDate>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"cl.stopDate<=?"}'>
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