<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<ul class="conditions" style="min-width:19.3em;">
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
					<div class="label">营运状态</div>
					<div class="value checkboxes"  data-condition='{"type":"int","key":"d.status_"}' >
						<label><input type="checkbox" name="checkboxField1" value="0"><span>在案</span></label>
						<label><input type="checkbox" name="checkboxField1" value="-1"><span>草稿</span></label>
						<label><input type="checkbox" name="checkboxField1" value="1"><span>注销</span></label>
					</div>
				</div>
			</div>
		</li>
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
					<div class="label">区域</div>
					<div class="value checkboxes"  data-condition='{"type":"int","key":"t.region_"}' >
						<label><input type="checkbox" name="checkboxField2" value="1"><span>本市</span></label>
						<label><input type="checkbox" name="checkboxField2" value="2"><span>本省</span></label>
						<label><input type="checkbox" name="checkboxField2" value="3"><span>外省</span></label>
						<label><input type="checkbox" name="checkboxField2" value="0"><span>空</span></label>
					</div>
				</div>
			</div>
		</li>
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
					<div class="label">性别</div>
					<div class="value checkboxes" data-condition='{"type":"int","key":"t.sex"}' >
						<label><input type="checkbox" name="checkboxField3" value="1"><span>男</span></label>
						<label><input type="checkbox" name="checkboxField3 value="2"><span>女</span></label>
					</div>
				</div>
			</div>
		</li>
		<li class="condition">
			<div class="label">出生日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"t.birthdate>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"t.birthdate<=?"}'>
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