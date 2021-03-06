<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<ul class="conditions" style="min-width:19.3em;">
		<li class="condition">
			<div class="label">所属分公司</div>
			<div class="value">
				<input type="text" class="bc-select ui-widget-content" readonly="readonly"
					data-maxHeight="150px"
					data-source='<s:property value="units"/>'>
				<input type="hidden" data-condition='{"type":"long","ql":"m.unit_id=?"}'>
				<ul class="inputIcons">
					<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
					<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
		</li>
		<li class="condition">
			<div class="label">所属车队</div>
			<div class="value">
				<input type="text" class="bc-select ui-widget-content" readonly="readonly"
					data-maxHeight="150px"
					data-source='<s:property value="motorcades"/>'>
				<input type="hidden" data-condition='{"type":"long","ql":"b.motorcade_id=?"}'>
				<ul class="inputIcons">
					<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
					<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
		</li>
		<li class="condition">
			<div class="label">事发日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"b.happen_date>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"b.happen_date<=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		
		<s:if test="!isReadonly()">
			<li class="condition">
				<div class="label">送保日期</div>
				<div class="value">
					<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"startDate","ql":"c.deliver_date>=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>～<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"endDate","ql":"c.deliver_date<=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</li>
			<li class="condition">
				<div class="label">延期日期至</div>
				<div class="value">
					<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"startDate","ql":"c.delay_date>=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>～<div class="bc-dateContainer">
						<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
							data-condition='{"type":"endDate","ql":"c.delay_date<=?"}'>
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</li>
			<li class="condition">
				<div style="position: relative;display: inline-block;">
					<div class="value checkboxes" data-condition='{"type":"string","ql":"c.claim_money is not null and c.pay_money is not null and c.claim_money>c.pay_money"}' >
						<label><input type="checkbox" name="checkboxField1" ><span>赔付不足</span></label>
					</div>
				</div>&nbsp;
				<div style="position: relative;display: inline-block;">
					<div class="value checkboxes" data-condition='{"type":"string","ql":"c.is_deliver is true"}' >
						<label><input type="checkbox" name="checkboxField1" ><span>已送保</span></label>
					</div>
				</div>
			</li>
		</s:if>
	</ul>
</form>