<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<ul class="conditions" style="min-width:19.3em;">
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
				<div class="label">所属公司</div>
				<div class="value checkboxes" style="width: 120px;" data-condition='{"type":"string","key":"c.company"}' >
					<label><input type="checkbox" name="checkboxField1" value="宝城"><span>宝城</span></label>
					<label><input type="checkbox" name="checkboxField1" value="广发"><span>广发</span></label>
				</div>
				</div><div style="width:12px;display:inline-block;"></div><div class="bc-dateContainer">
					<div class="label">车辆产权</div>
					<div class="value bc-dateContainer">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width:9em;"
							data-condition='{"type":"string","ql":"o.owner_=?"}'
							data-source='<s:property value="owners"/>'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
					<div class="label">所属分公司</div>
					<div class="value bc-dateContainer">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width:9em;"
							data-source='<s:property value="units"/>'>
						<input type="hidden" data-condition='{"type":"long","ql":"bia.id=?"}'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div><div style="width:12px;display:inline-block;"></div><div class="bc-dateContainer">
					<div class="label">经营权性质</div>
					<div class="value bc-dateContainer">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width:9em;" 
							data-condition='{"type":"string","ql":"o.nature=?"}'
							data-source='<s:property value="natures"/>'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
					<div class="label">所属车队</div>
					<div class="value bc-dateContainer">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width:9em;"
							data-source='<s:property value="motorcades"/>'>
						<input type="hidden" data-condition='{"type":"long","ql":"m.id=?"}'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div><div style="width:12px;display:inline-block;"></div><div class="bc-dateContainer">
					<div class="label">权证抵押情况</div>
					<div class="value bc-dateContainer">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width:9em;"
							data-condition='{"type":"string","ql":"o.situation=?"}'
							data-source='<s:property value="situations"/>'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">车辆登记日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"c.register_date>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"c.register_date<=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<!-- <li class="condition">
			<div class="label">车辆报废日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"c.scrap_date>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"c.scrap_date<=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li> -->
	</ul>
</form>