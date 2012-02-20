<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="ic.title"/>' data-type='form'
	class="bc-page ic"
	data-js='<s:url value="/bc-business/infoCenter/main.css" />,<s:url value="/bc-business/infoCenter/main.js" />'
	data-initMethod='bs.infoCenter.init'
	data-option='<s:property value="pageOption"/>'
	style="overflow: hidden;">

	<!-- 左侧导航区 -->
	<div id="left" class="left ui-widget-content">
		<div class="block">
			<div class="header ui-widget-header" style="border-top-width: 0;">查找</div>
			<div class="content" style="padding: 0;">
				<div class="content">
					<input type="text" id="searchTypeLabel" class="bc-select ui-widget-content"
						data-source='<s:property value="searchTypes"/>'
						value="车牌" readonly="readonly"> 
					<input type="hidden" id="searchTypeValue">
					<ul class="inputIcons">
						<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s"
							title='<s:text name="title.click2select"/>'></li>
					</ul>
				</div>
				<div class="content">
					<input type="text" id="searchText" class="ui-widget-content"> 
				</div>
				<div class="content">
					<button type="button" id="searchBtn" class="bc-button ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary"
						data-click="bs.infoCenter.doSearch">
						<span class="ui-button-icon-primary ui-icon ui-icon-search"></span>
						<span class="ui-button-text">查询</span>
					</button>
					<div class="hexiao"><label><input type="checkbox"/><span>核销</span></label></div>
				</div>
			</div>
		</div>
		<div class="block">
			<div class="header ui-widget-header">分公司</div>
			<div class="content">
				<input type="text" id="unitName" class="bc-select ui-widget-content"
					data-source='<s:property value="units"/>'> 
				<input type="hidden" id="unitId">
				<ul class="inputIcons">
					<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s"
						title='<s:text name="title.click2select"/>'></li>
					<li class="clearSelect inputIcon ui-icon ui-icon-close"
						title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
		</div>
		<div class="block">
			<div class="header ui-widget-header">车队</div>
			<div class="content">
				<input type="text" id="motorcadeName" class="bc-select ui-widget-content"
					data-maxHeight="250px"
					data-source='<s:property value="motorcades"/>'> 
				<input type="hidden" id="motorcadeId">
				<ul class="inputIcons">
					<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s"
						title='<s:text name="title.click2select"/>'></li>
					<li class="clearSelect inputIcon ui-icon ui-icon-close"
						title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
		</div>
		<div id="last" class="block header ui-widget-header">车辆</div>
		<ul id="results" class="content results">
			<li class=""><span>[1111]粤A.XXXX1</span></li>
			<li class=""><span>[1111]粤A.XXXX2</span></li>
			<li class=""><span>[1111]粤A.XXXX3</span></li>
			<li class="active ui-state-highlight"><span>[1111]粤A.XXXX4</span></li>
			<li class=""><span>[1111]粤A.XXXX5</span></li>
			<li class=""><span>[1111]粤A.XXXX6</span></li>
			<li class=""><span>[1111]粤A.XXXX7</span></li>
			<li class=""><span>[1111]粤A.XXXX8</span></li>
		</ul>
	</div>

	<!-- 中间分隔区 -->
	<div class="splitter ui-widget-content"><div class="ui-icon ui-icon-grip-dotted-vertical"></div></div>

	<!-- 右侧信息区 -->
	<div class="right ui-widget-content">
		<div class="block main">
			<div class="header ui-widget-header" style="border-top-width: 0;">粤A.XXXX4</div>
			<div class="content" style="padding: 0 2px;">
				<table cellspacing="2" cellpadding="0" style="width:100%;">
					<tr class="widthMarker">
						<td style="width: 60px;">&nbsp;</td>
						<td style="width: 180px;">&nbsp;</td>
						<td style="width: 100px;">&nbsp;</td>
						<td style="width: 180px;">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td class="label">自编号:</td>
						<td class="value"><input type="text" name="main.code" class="ui-widget-content" value="LSVJN133442233596"/></td>
						<td class="label">营运性质:</td>
						<td class="value"><input type="text" name="main.businessType" class="ui-widget-content"/></td>
						<td rowspan="3"><textarea name="main.desc" class="ui-widget-content noresize" style="width:98%;height:100%;">AA</textarea></td>
					</tr>
					<tr>
						<td class="label">所属公司:</td>
						<td class="value"><input type="text" name="main.company" class="ui-widget-content"/></td>
						<td class="label">有效合同期限:</td>
						<td class="value"><input type="text" name="main.businessType" class="ui-widget-content" value="2007-08-14~2012-12-19"/></td>
					</tr>
					<tr>
						<td class="label">车队:</td>
						<td class="value"><input type="text" name="main.motorcade" class="ui-widget-content"/></td>
						<td class="label"><div class="little">行驶证登记日期</div>:</td>
						<td class="value"><input type="text" name="main.registeDate" class="ui-widget-content"/></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>