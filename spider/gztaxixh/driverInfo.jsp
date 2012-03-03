<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='广州市出租汽车协会 驾驶员信誉档案查询 http://www.gztaxixh.com' data-type='form'
	class="bc-page bs-czxh"
	data-js='<s:url value="/bc-business/spider/gztaxixh/driverInfo.css" />,<s:url value="/bc-business/spider/gztaxixh/driverInfo.js" />'
	data-initMethod='bs.gztaxixhDriverInfo.init'
	data-option='<s:property value="pageOption"/>' style="overflow: auto;">
	<div id="header" class="ui-widget-content">
		服务资格证：
		<s:textfield name="v" id="v"/>
		<input id="goBtn" type="button" value="查询" /><span id="waste"></span>
	</div>
	<div id="info" class="ui-widget-content"></div>
</div>