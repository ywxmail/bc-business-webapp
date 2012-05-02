<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<ul class="conditions" style="min-width:15.3em;">
		<li class="condition">
			<div class="label">使用区域</div>
			<div class="value">
				<input type="text" class="bc-select ui-widget-content" readonly="readonly"
					data-maxHeight="150px"
					data-source='<s:property value="areas"/>'>
				<input type="hidden" data-condition='{"type":"string","ql":"s.area_name=?"}'>
				<ul class="inputIcons">
					<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
					<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
		</li>
		<li class="condition">
			<div class="label">户口类型</div>
			<div class="value">
				<input type="text" class="bc-select ui-widget-content" readonly="readonly"
					data-maxHeight="150px"
					data-source='<s:property value="houseTypes"/>'>
				<input type="hidden" data-condition='{"type":"string","ql":"s.house_type=?"}'>
				<ul class="inputIcons">
					<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
					<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
		</li>
		<li class="condition">
			<div class="label">年份</div>
			<div class="value">
				<div style="position: relative;display: inline-block;">
					<input type="text" class="ui-widget-content" data-validate="{'type':'number','min':'1000','max':'9999'}" 
						style="width:9em;" data-condition='{"type":"int","ql":"s.start_year>=?"}'>
					<ul class="inputIcons">
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div style="position: relative;display: inline-block;">
					<input type="text" class="ui-widget-content" data-validate="{'type':'number','min':'1000','max':'9999'}" 
						style="width:9em;" data-condition='{"type":"int","ql":"s.start_year<=?"}'>
					<ul class="inputIcons">
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		<li class="condition">
			<div class="label">月份</div>
			<div class="value">
				<div style="position: relative;display: inline-block;">
					<input type="text" class="ui-widget-content" data-validate="{'type':'number','min':'1','max':'12'}" 
						style="width:9em;"  data-condition='{"type":"int","ql":"s.start_month>=?"}'>
					<ul class="inputIcons">
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div style="position: relative;display: inline-block;">
					<input type="text" class="ui-widget-content" data-validate="{'type':'number','min':'1','max':'12'}" 
						style="width:9em;" data-condition='{"type":"int","ql":"s.start_month<=?"}'>
					<ul class="inputIcons">
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
		
	</ul>
</form>