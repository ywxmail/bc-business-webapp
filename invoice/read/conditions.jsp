<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<ul class="conditions" style="min-width:19.3em;">
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
					<div class="label">公司</div>
					<div class="value bc-dateContainer">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width:9em;"
							data-source='<s:property value="companies"/>'>
						<input type="hidden" data-condition='{"type":"string","ql":"s.company=?"}'>
						<ul class="inputIcons">
							<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</div>
				</div><div style="width:12px;display:inline-block;"></div><div class="bc-dateContainer">
					<div class="label">类型</div>
					<div class="value checkboxes" data-condition='{"type":"int","key":"d.type_"}' >
						<label><input type="checkbox" name="checkboxField1" value="1"><span>实销</span></label>
						<label><input type="checkbox" name="checkboxField1" value="2"><span>退票</span></label>
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
					<div class="label">分公司</div>
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
				</div><div style="width:12px;display:inline-block;"></div><div class="bc-dateContainer">
					<div class="label">车队</div>
					<div class="value bc-dateContainer">
						<input type="text" class="bc-select ui-widget-content" readonly="readonly"
							data-maxHeight="150px" style="width:9em;"
							data-source='<s:property value="motorcades"/>'>
						<input type="hidden" data-condition='{"type":"long","ql":"s.motorcade_id=?"}'>
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
			<div class="label">发票编码(开始号≤输入值≤结束号)</div>
			<div class="value">
				<input type="text" class="ui-widget-content" data-condition='{"type":"string","ql":"(d.start_no<=? and d.end_no>=?)"}'>
				<ul class="inputIcons">
					<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">销售/退票日期</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"startDate","ql":"s.sell_date>=?"}'>
					<ul class="inputIcons">
						<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div><div style="width:12px;display:inline-block;">～</div><div class="bc-dateContainer">
					<input type="text" class="bc-date ui-widget-content" data-validate="date" style="width:9em;"
						data-condition='{"type":"endDate","ql":"s.sell_date<=?"}'>
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
					<input type="text" class="ui-widget-content" data-condition='{"type":"int","ql":"d.count_>=?"}' 
						style="width:9em;" data-validate="number">
					<ul class="inputIcons">
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div><div style="width:12px;display:inline-block;">～</div><div class="bc-dateContainer">
					<input type="text" class="ui-widget-content" data-condition='{"type":"int","ql":"d.count_<=?"}' 
						style="width:9em;" data-validate="number">
					<ul class="inputIcons">
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="value checkboxes" data-condition='{"type":"string","ql":"checkI4SellDetailCount(d.count_,d.start_no,d.end_no)>0"}' >
				<label><input type="checkbox" name="checkboxField1" ><span>开始号、结束号、数量异常的销售单</span></label>
			</div>
		</li>
	</ul>
</form>