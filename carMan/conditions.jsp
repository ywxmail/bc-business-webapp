<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<ul class="conditions" style="min-width:19.3em;">
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
					<div class="label">所属公司</div>
					<div class="value checkboxes" data-condition='{"type":"string","key":"c.company"}' style="width: 9em;">
						<label><input type="checkbox" name="checkboxField1" value="宝城"><span>宝城</span></label>
						<label><input type="checkbox" name="checkboxField1" value="广发"><span>广发</span></label>
					</div>
				</div><div style="width:12px;display:inline-block;"></div><div class="bc-dateContainer">
					<div class="label">所属分公司</div>
					<div class="value bc-dateContainer">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width:9em;"
							data-source='<s:property value="units"/>'>
						<input type="hidden" data-condition='{"type":"long","ql":"mo.unit_id=?"}'>
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
						<input type="hidden" data-condition='{"type":"long","ql":"c.motorcade_id=?"}'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div><div style="width:12px;display:inline-block;"></div><div class="bc-dateContainer">
				<div class="label">迁移类型类</div>
					<div class="value bc-dateContainer">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width:9em;"
							data-source='<s:property value="moveTypes"/>'>
						<input type="hidden" data-condition='{"type":"long","ql":"m.move_type=?"}'>
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
			<div class="label">分类</div>
			<div class="value checkboxes" data-condition='{"type":"int","key":"m.type_"}' >
				<label><input type="checkbox" name="checkboxField1" value="0,2"><span>司机</span></label>
				<label><input type="checkbox" name="checkboxField1" value="1,2"><span>责任人</span></label>
				<label><input type="checkbox" name="checkboxField1" value="3"><span>非编</span></label><br>
				<label><input type="checkbox" name="checkboxField1" value="0"><span>仅司机</span></label>
				<label><input type="checkbox" name="checkboxField1" value="1"><span>仅责任人</span></label>
				<label><input type="checkbox" name="checkboxField1" value="2"><span>司机责任人</span></label>
			</div>
		</li>
		
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
					<div class="label">驾驶状态</div>
					<div class="value checkboxes"  data-condition='{"type":"int","key":"m.classes"}' >
						<label><input type="checkbox" name="checkboxField1" value="1"><span>正班</span></label>
						<label><input type="checkbox" name="checkboxField1" value="2"><span>副班</span></label>
						<label><input type="checkbox" name="checkboxField1" value="3,4"><span>顶班</span></label>
						<label><input type="checkbox" name="checkboxField1" value="0"><span>无</span></label>
					</div>
				</div><div style="width:8px;display:inline-block;"></div><div class="bc-dateContainer">
				<div class="label">性别</div>
					<div class="value checkboxes" data-condition='{"type":"int","key":"m.sex"}' >
						<label><input type="checkbox" name="checkboxField2" value="1"><span>男</span></label>
						<label><input type="checkbox" name="checkboxField2" value="2"><span>女</span></label>
					</div>
				</div>
			</div>
		</li>
		
		
		<!--  <li class="condition">
			<div class="label">驾驶状态</div>
			<div class="value checkboxes"  data-condition='{"type":"int","key":"m.classes"}' >
				<label><input type="checkbox" name="checkboxField1" value="1"><span>正班</span></label>
				<label><input type="checkbox" name="checkboxField1" value="2"><span>副班</span></label>
				<label><input type="checkbox" name="checkboxField1" value="3,4"><span>顶班</span></label>
				<label><input type="checkbox" name="checkboxField1" value="0"><span>无</span></label>
			</div>
		</li>-->
		<!--  <li class="condition">
			<div class="label">迁移类型类</div>
			<div class="value">
				<input type="text" class="bc-select ui-widget-content" readonly="readonly"
					data-maxHeight="150px"
					data-source='<s:property value="moveTypes"/>'>
				<input type="hidden" data-condition='{"type":"long","ql":"m.move_type=?"}'>
				<ul class="inputIcons">
					<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
					<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
		</li>
		<li class="condition">
			<div class="label">性别</div>
			<div class="value checkboxes" data-condition='{"type":"int","key":"m.sex"}' >
				<label><input type="checkbox" name="checkboxField2" value="1"><span>男</span></label>
				<label><input type="checkbox" name="checkboxField2" value="2"><span>女</span></label>
			</div>
		</li>-->
		
		<!--  <li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
				<div class="label">迁移类型类</div>
					<div class="value bc-dateContainer">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width:12em;"
							data-source='<s:property value="moveTypes"/>'>
						<input type="hidden" data-condition='{"type":"long","ql":"m.move_type=?"}'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div><div style="width:8px;display:inline-block;"></div><div class="bc-dateContainer">
				<div class="label">性别</div>
					<div class="value checkboxes" data-condition='{"type":"int","key":"m.sex"}' >
						<label><input type="checkbox" name="checkboxField2" value="1"><span>男</span></label>
						<label><input type="checkbox" name="checkboxField2" value="2"><span>女</span></label>
					</div>
				</div>
			</div>
		</li>-->
		 
		<li class="condition">
			<div class="label">入职日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"m.work_date>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"m.work_date<=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">出生日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"m.birthdate>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"m.birthdate<=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">初次领驾驶证日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"m.cert_driving_first_date>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"m.cert_driving_first_date<=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">最新迁移日期(顶班合同开始日期)</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"m.move_date>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"m.move_date<=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">最新顶班合同结束日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"m.shiftwork_end_date>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"m.shiftwork_end_date<=?"}'>
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