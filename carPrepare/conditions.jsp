<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<fieldset class="ui-widget-content">
		<legend>未完成的计划项目查询</legend>
		<ul class="conditions" style="min-width:19.3em;">
			<li class="condition">
				<div class="label">计划日期</div>
				<div class="value">
					<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"startDate","name":"startPlanDate","ql":"p.id in(select pid from bs_car_prepare_item where date_>=? and status_=0)"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>～<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"endDate","name":"endPlanDate","ql":"p.id in(select pid from bs_car_prepare_item where date_<=? and status_=0)"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</li>
		</ul>
	</fieldset>
	<fieldset class="ui-widget-content">
		<legend>旧车</legend>
		<ul class="conditions" style="min-width:19.3em;">
			<li class="condition">
				<div class="label">实际交车日期</div>
				<div class="value">
					<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"startDate","name":"startReturnCarDate","ql":"p.plan_date>=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>～<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"endDate","name":"endReturnCarDate","ql":"p.plan_date<=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</li>
			<li class="condition">
				<div class="label">预计交车日期</div>
				<div class="value">
					<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"startDate","ql":"p.plan_date>=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>～<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"endDate","ql":"p.plan_date<=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</li>
			<li class="condition">
				<div class="bc-relativeContainer">
					<div class="label">所属公司</div>
					<div class="value checkboxes" data-condition='{"type":"string","key":"p.c1_company"}' style="width: 9em;">
						<label><input type="checkbox" name="checkboxField1" value="宝城"><span>宝城</span></label>
						<label><input type="checkbox" name="checkboxField1" value="广发"><span>广发</span></label>
					</div>
				</div><div style="width:12px;display:inline-block;"></div>
				<div class="bc-relativeContainer">
					<div class="label">所属分公司</div>
					<div class="value bc-relativeContainer ">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width: 9em;"
							data-source='<s:property value="units"/>'>
						<input type="hidden" data-condition='{"type":"long","ql":"m1.unit_id=?"}'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
			</li>
			<li class="condition">
				<div class="bc-relativeContainer">
					<div class="label">所属车队</div>
					<div class="value bc-relativeContainer ">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width: 9em;"
							data-source='<s:property value="motorcades"/>'>
						<input type="hidden" data-condition='{"type":"long","ql":"p.c1_motorcade=?"}'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div><div style="width:12px;display:inline-block;"></div><div class="bc-relativeContainer">
					<div class="label">营运性质</div>
					<div class="value bc-relativeContainer">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width:9em;"
							data-source='<s:property value="businessTypes"/>'>
						<input type="hidden" data-condition='{"type":"string","ql":"p.c1_bs_type=?"}'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
			</li>
		</ul>
	</fieldset>
	<fieldset class="ui-widget-content">
		<legend>新车</legend>
		<ul class="conditions" style="min-width:19.3em;">
			<li class="condition">
				<div class="bc-relativeContainer">
					<div class="label">所属公司</div>
					<div class="value checkboxes" data-condition='{"type":"string","key":"p.c2_company"}' style="width: 9em;">
						<label><input type="checkbox" name="checkboxField1" value="宝城"><span>宝城</span></label>
						<label><input type="checkbox" name="checkboxField1" value="广发"><span>广发</span></label>
					</div>
				</div><div style="width:12px;display:inline-block;"></div>
				<div class="bc-relativeContainer">
					<div class="label">所属分公司</div>
					<div class="value bc-relativeContainer ">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width: 9em;"
							data-source='<s:property value="units"/>'>
						<input type="hidden" data-condition='{"type":"long","ql":"p.c2_branch=?"}'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
			</li>
			<li class="condition">
				<div class="bc-relativeContainer">
					<div class="label">所属车队</div>
					<div class="value bc-relativeContainer ">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width: 9em;"
							data-source='<s:property value="motorcades"/>'>
						<input type="hidden" data-condition='{"type":"long","ql":"p.c2_motorcade=?"}'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div><div style="width:12px;display:inline-block;"></div>
				<div class="bc-relativeContainer">
					<div class="label">指标编号</div>
					<div class="value bc-relativeContainer">
						<input type="text" class="ui-widget-content" style="width:9em;" data-condition='{"type":"string","ql":"p.c2_indicator like ?","likeType":"left"}'>
						<ul class="inputIcons">
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
			</li>
		</ul>
	</fieldset>
</form>