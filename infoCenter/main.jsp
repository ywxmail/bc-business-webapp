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
			<div class="content" style="padding:0;">
				<table class="contentTable" cellspacing="2" cellpadding="0">
					<tr>
						<td class="label" style="width: 65px;">自编号:</td>
						<td class="value" style="width: 180px;"><input type="text" name="main.code" class="ui-widget-content" value="LSVJN133442233596"/></td>
						<td class="label" style="width: 100px;">营运性质:</td>
						<td class="value" style="width: 180px;"><input type="text" name="main.businessType" class="ui-widget-content"/></td>
						<td rowspan="9" style="position: relative;"><textarea name="main.desc" class="ui-widget-content noresize" 
							style="position:absolute;left:0;right:0;bottom:-2px;top:-2px;">AA</textarea></td>
					</tr>
					<tr>
						<td class="label">所属公司:</td>
						<td class="value"><input type="text" name="main.company" class="ui-widget-content"/></td>
						<td class="label">有效合同期限:</td>
						<td class="value"><input type="text" name="main.businessType" class="ui-widget-content" value="2007-08-14~2012-12-19"/></td>
					</tr>
					<tr>
						<td class="label">分公司:</td>
						<td class="value"><input type="text" name="main.unit" class="ui-widget-content"/></td>
						<td class="label">缴费日:</td>
						<td class="value"><input type="text" name="main.paymentDate" class="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">车队:</td>
						<td class="value"><input type="text" name="main.motorcade" class="ui-widget-content"/></td>
						<td class="label"><div class="little">行驶证登记日期</div>:</td>
						<td class="value"><input type="text" name="main.registeDate" class="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">厂牌:</td>
						<td class="value"><input type="text" name="main." class="ui-widget-content"/></td>
						<td class="label">投产日期:</td>
						<td class="value"><input type="text" name="main." class="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">车辆型号:</td>
						<td class="value"><input type="text" name="main." class="ui-widget-content"/></td>
						<td class="label">营运证号:</td>
						<td class="value"><input type="text" name="main." class="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">发动机号:</td>
						<td class="value"><input type="text" name="main." class="ui-widget-content"/></td>
						<td class="label">计价器:</td>
						<td class="value"><input type="text" name="main." class="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">车架号:</td>
						<td class="value"><input type="text" name="main." class="ui-widget-content"/></td>
						<td class="label">LPG设备:</td>
						<td class="value"><input type="text" name="main." class="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">车辆颜色:</td>
						<td class="value"><input type="text" name="main." class="ui-widget-content"/></td>
						<td class="label">电视广告屏:</td>
						<td class="value"><input type="text" name="main." class="ui-widget-content"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="block message">
			<div class="header ui-widget-header">提醒信息</div>
			<div class="content" style="padding:0;">
				<table class="contentTable" cellspacing="0" cellpadding="0">
					<tbody>
						<tr class="ui-widget-content row header">
							<td class="first" style="width: 50px">类别</td>
							<td class="middle" style="width: 150px">关系人</td>
							<td class="middle" >内容</td>
							<td class="last" style="width: 85px">相关日期</td>
						</tr>
						<tr class="ui-widget-content row odd">
							<td class="first">黑名单</td>
							<td class="middle">【司机姓名】</td>
							<td class="middle">不可退押金;JN245司机杨龙江迁出，未交回2份副班合同</td>
							<td class="last">2011-01-01</td>
						</tr>
						<tr class="ui-widget-content row even">
							<td class="first">黑名单</td>
							<td class="middle">【司机姓名】</td>
							<td class="middle">不可退押金;JN245司机杨龙江迁出</td>
							<td class="last">2011-01-01</td>
						</tr>
						<tr class="ui-widget-content row odd">
							<td class="first">黑名单</td>
							<td class="middle">【司机姓名】</td>
							<td class="middle">不可退押金;JN245司机杨龙江迁出</td>
							<td class="last">2011-01-01</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="block mans">
			<div class="header ui-widget-header">联系信息</div>
			<div class="content ui-widget-content" style="padding:0;">
				<table class="title contentTable0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr class="ui-state-default row header">
							<td class="first aright" style="width: 90px">司机和责任人:</td>
							<td class="middle aleft" style="width: 80px">张三(男)</td>
							<td class="middle aright" style="width: 40px">电话:</td>
							<td class="last aleft" style="width: 190px">13611112222,13611112222</td>
							<td class="middle aright" style="width: 40px">状态:</td>
							<td class="last aleft">新入职 (2011-01-01)</td>
						</tr>
					</tbody>
				</table>
				<table class="detail contentTable" cellspacing="2" cellpadding="0" style="height: auto;">
					<tr>
						<td rowspan="6" style="width: 87px;"><img id="portrait" style="width:86.4px;height:110px;cursor: pointer;" 
							src="/bs/bc/image/download?ptype=portrait&amp;puid=carMan.uid.4&ts=1329753139367"></td>
						<td class="label" style="width: 80px;">身份证号码:</td>
						<td class="value" style="width: 359px;"><input type="text" name="man.identity" class="ui-widget-content" 
							value="440000201201012222"/></td>
						<td rowspan="6" style="position: relative;"><textarea name="main.desc" class="ui-widget-content noresize" 
							style="position:absolute;left:0;right:0;bottom:-2px;top:-2px;">AA</textarea></td>
					</tr>
					<tr>
						<td class="label">身份证地址:</td>
						<td class="value"><input type="text" name="man.address1" class="ui-widget-content" 
							value="河南省扶沟县练寺镇董王村"/></td>
					</tr>
					<tr>
						<td class="label">暂住地址:</td>
						<td class="value"><input type="text" name="man.address2" class="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">籍贯:</td>
						<td class="value"><input type="text" name="man.region" class="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">资格证号:</td>
						<td class="value"><input type="text" name="man.cert4fwzg" class="ui-widget-content"/></td>
					</tr>
				</table>
			</div>
			<div class="content ui-widget-content" style="padding:0;">
				<table class="title contentTable0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr class="ui-state-default row header">
							<td class="first aright" style="width: 90px">司机:</td>
							<td class="middle aleft" style="width: 80px">张三(男)</td>
							<td class="middle aright" style="width: 40px">电话:</td>
							<td class="last aleft" style="width: 190px">13611112222,13611112222</td>
							<td class="middle aright" style="width: 40px">状态:</td>
							<td class="last aleft">新入职 (2011-01-01)</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>