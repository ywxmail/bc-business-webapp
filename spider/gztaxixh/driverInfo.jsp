<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='广州市出租汽车协会 驾驶员信誉档案查询 http://www.gztaxixh.com' data-type='form'
	class="bc-page bs-czxh"
	data-js='<s:url value="/bc-business/spider/gztaxixh/driverInfo.css" />,<s:url value="/bc-business/spider/gztaxixh/driverInfo.js" />'
	data-initMethod='bs.gztaxixhDriverInfo.init'
	data-option='<s:property value="pageOption"/>' style="overflow: auto;">
	<div id="header" class="ui-widget-content">
		<div>请根据条件选择然后输入你想查询的驾驶员：</div>
		<div><s:select name="type" list="types" cssClass="ui-widget-content" cssStyle="width:9em;">
		</s:select><s:textfield name="value" id="value" cssClass="ui-widget-content" cssStyle="width:9em;height: 19px;padding:0"/>
		<input id="goBtn" type="button" value="确认"/><span id="waste"></span></div>
	</div>
	<div id="info" class="ui-widget-content"></div>
</div>