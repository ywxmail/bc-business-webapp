<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<ul class="conditions" style="min-width:19.3em;">
		<li class="condition">
			<div class="bc-relativeContainer">
				<div class="label">分公司</div>
				<div class="value bc-relativeContainer ">
					<input type="text" class="bc-select ui-widget-content" readonly="readonly"
						data-maxHeight="150px" style="width: 9em;"
						data-source='<s:property value="units"/>'>
					<input type="hidden" data-condition='{"type":"long","ql":"m.unit_id=?"}'>
					<ul class="inputIcons">
						<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div><div style="width:12px;display:inline-block;"></div><div class="bc-relativeContainer">
				<div class="label">车队</div>
				<div class="value bc-relativeContainer">
					<input type="text" class="bc-select ui-widget-content" readonly="readonly"
						data-maxHeight="150px" style="width:9em;"
						data-source='<s:property value="motorcades"/>'>
					<input type="hidden" data-condition='{"type":"long","ql":"m.id=?"}'>
					<ul class="inputIcons">
						<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
		</li>
		<li class="condition">
			<div class="label">年份</div>
			<div class="value">
				<div class="bc-dateContainer">
					<input type="text" class="ui-widget-content" data-validate="digits" style="width:9em;"
						data-condition='{"type":"int","ql":"q.year_>=?"}'>
					<ul class="inputIcons">
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>～<div class="bc-dateContainer">
					<input type="text" class="ui-widget-content" data-validate="digits" style="width:9em;"
						data-condition='{"type":"int","ql":"q.year_<=?"}'>
					<ul class="inputIcons">
						<li class="clearSelect inputIcon ui-icon ui-icon-close" title='<s:text name="title.click2clear"/>'></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</li>
	</ul>
</form>