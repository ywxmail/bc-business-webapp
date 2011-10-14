<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='BS选择相关' data-type='form' class="bc-page"
	data-js='<s:url value="/bc-business/bs.js" />,<s:url value="/bc-business/demo/select.js" />'
	data-initMethod='bs.selectTest.init'
	data-option='{"width":500,"minWidth":250,"minHeight":100,"modal":false}'
	style="overflow-y: auto;">
	<fieldset>
		<legend>选择车辆</legend>
		<input id="selectPageCar" type="button" value="选择车辆(分页单选)">
		<input id="selectPageCars" type="button" value="选择车辆(分页多选)"><br/>
		<input id="selectCar" type="button" value="选择车辆(单选)">
		<input id="selectCars" type="button" value="选择车辆(多选)">
	</fieldset>
	<fieldset>
		<legend>选择司机</legend>
		<input id="selectPageDriver" type="button" value="选择司机(分页单选)">
		<input id="selectPageDrivers" type="button" value="选择司机(分页多选)"><br/>
		<input id="selectDriver" type="button" value="选择司机(单选)">
		<input id="selectDrivers" type="button" value="选择司机(多选)">
	</fieldset>
	<fieldset>
		<legend>选择责任人</legend>
		<input id="selectPageCharger" type="button" value="选择责任人(分页单选)">
		<input id="selectPageChargers" type="button" value="选择责任人(分页多选)"><br/>
		<input id="selectCharger" type="button" value="选择司机(单选)">
		<input id="selectChargers" type="button" value="选择司机(多选)">
	</fieldset>
	<fieldset>
		<legend>选择司机+责任人</legend>
		<input id="selectPageCarman" type="button" value="选择司机+责任人(分页单选)">
		<input id="selectPageCarmans" type="button" value="选择司机+责任人(分页多选)"><br/>
		<input id="selectCarman" type="button" value="选择司机+责任人(单选)">
		<input id="selectCarmans" type="button" value="选择司机+责任人(多选)">
	</fieldset>
</div>