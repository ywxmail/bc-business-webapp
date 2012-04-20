<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="cn.bc.web.ui.html.toolbar.*"%>
<form class="bc-conditionsForm draggable ui-widget-content ui-state-highlight">
	<ul class="conditions" style="min-width:15.3em;">
		<li class="condition">
			<div class="label">类型</div>
			<div class="value checkboxes" data-condition='{"type":"int","key":"a.type_"}' >
			<div class="value">
				<div>
					<div style="width:60px;display:inline-block;">
						<label><input type="checkbox" name="checkboxField1" value="1"><span>费用</span></label>
					</div><div style="width:30px;display:inline-block;"></div><div style="width:80px;display:inline-block;">
						<label><input type="checkbox" name="checkboxField1" value="0"><span>模板</span></label>
					</div>
				</div>
			</div>
			</div>
		</li>
		<li class="condition">
			<div class="label">收费方式</div>
			<div class="value checkboxes" data-condition='{"type":"int","key":"a.pay_type"}' >
			<div class="value">
				<div>
					<div style="width:60px;display:inline-block;">
						<label><input type="checkbox" name="checkboxField1" value="1"><span>每月</span></label>
					</div><div style="width:30px;display:inline-block;"></div><div style="width:80px;display:inline-block;">
						<label><input type="checkbox" name="checkboxField1" value="2"><span>每季</span></label>
					</div>
				</div>
				<div>
					<div style="width:60px;display:inline-block;">
						<label><input type="checkbox" name="checkboxField1" value="3"><span>每年</span></label>
					</div><div style="width:30px;display:inline-block;"></div><div style="width:80px;display:inline-block;">
						<label><input type="checkbox" name="checkboxField1" value="4"><span>一次性</span></label>
					</div>
				</div>
			</div>
			</div>
		</li>
	</ul>
</form>