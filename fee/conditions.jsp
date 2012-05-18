<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight" data-js='<s:url value="/bc-business/bs.js" />' >
	<ul class="conditions" style="min-width:19.3em;">
		<li class="condition">
			<div class="label">所属公司</div>
			<div class="value checkboxes" data-condition='{"type":"string","key":"f.company"}' >
				<label><input type="checkbox" name="checkboxField1" value="宝城"><span>宝城</span></label>
				<label><input type="checkbox" name="checkboxField1" value="广发"><span>广发</span></label>
			</div>
		</li>
		<li class="condition">
			<div class="value">
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
				</div><div style="width:12px;display:inline-block;"></div><div class="bc-dateContainer">
						<div class="label">所属车队</div>
						<div class="value bc-dateContainer">
							<input type="text" class="bc-select ui-widget-content" readonly="readonly"
								data-maxHeight="150px" style="width:9em;"
								data-source='<s:property value="motorcades"/>'>
							<input type="hidden" data-condition='{"type":"long","ql":"f.motorcade_id=?"}'>
							<ul class="inputIcons">
								<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
								<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
							</ul>
						</div>
					</div>
			</div>
		</li>
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
					<div class="label">收费年份</div>
						<div class="value bc-dateContainer">
							<input type="text" class="ui-widget-content" data-validate="number" data-condition='{"type":"int","ql":"f.fee_year=?"}'
								data-maxHeight="150px" style="width:9em;"/>
							<ul class="inputIcons">
								<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
							</ul>
						</div>
				</div><div style="width:12px;display:inline-block;"></div><div class="bc-dateContainer">
						<div class="label">收费月份</div>
						<div class="value bc-dateContainer">
							<input type="text" class="bc-select ui-widget-content" readonly="readonly"
								data-maxHeight="150px" style="width:9em;"
								data-source='<s:property value="feeMonths"/>'>
							<input type="hidden" data-condition='{"type":"int","ql":"f.fee_month=?"}'>
							<ul class="inputIcons">
								<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
								<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
							</ul>
						</div>
					</div>
			</div>
		</li>
		<li class="condition">
			<div class="label">车辆</div>
			<div class="value">
				<input type="text" name="car_plate" class="ui-widget-content" readonly="readonly"/>
				<ul class="inputIcons">
		        	<li class="selectCar inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>' 
		        		data-cfg='{"mapping":"car_id=id,car_plate=plate"}'>
		        	</li>
		        	<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
				</ul>
				<input type="hidden" name="car_id" data-condition='{"type":"long","ql":"f.car_id=?"}'>
			</div>
		</li>
		<li class="condition">
			<div class="value">
				<div class="bc-dateContainer">
					<div class="value checkboxes" data-condition='{"type":"string","ql":"f.o_total > 0"}' >
						<label><input type="checkbox" name="checkboxField1" ><span>有欠费的车</span></label>
					</div>
				</div>
				<div class="bc-dateContainer">
					<div class="value checkboxes" data-condition='{"type":"string","ql":"f.o_total = 0"}' >
						<label><input type="checkbox" name="checkboxField1" ><span>无欠费的车</span></label>
					</div>
				</div>
			</div>
		</li>
	</ul>
</form>