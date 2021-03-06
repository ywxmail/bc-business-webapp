<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="ic.title"/>' data-type='form'
	class="bc-page ic"
	data-js='<s:url value="/bc-business/infoCenter/main.css" />,<s:url value="/bc-business/infoCenter/main.js" />'
	data-initMethod='bs.infoCenter.init'
	data-option='<s:property value="pageOption"/>'
	style="overflow: hidden;">

	<!-- 左侧导航区 -->
	<div id="left" class="left">
	<div class="full ui-widget-content">
		<div class="block">
			<div class="header ui-widget-header" style="border-top-width: 0;">查找</div>
			<div class="content ui-state-default" style="padding: 0;">
				<div class="content">
					<input type="text" id="searchTypeLabel" class="bc-select ui-widget-content"
						data-source='<s:property value="searchTypes"/>'
						value="车牌" readonly="readonly"> 
					<input type="hidden" id="searchTypeValue" value="plate">
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
			<div class="content ui-state-default">
				<input type="text" id="unitName" class="bc-select ui-widget-content"
					data-source='<s:property value="units"/>' data-cfg='{"callback":"bs.infoCenter.doSearchByUnitAndMotorcade"}'> 
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
			<div class="content ui-state-default">
				<input type="text" id="motorcadeName" class="bc-select ui-widget-content"
					data-maxHeight="250px"
					data-source='<s:property value="motorcades"/>' data-cfg='{"callback":"bs.infoCenter.doSearchByUnitAndMotorcade"}'> 
				<input type="hidden" id="motorcadeId">
				<ul class="inputIcons">
					<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s"
						title='<s:text name="title.click2select"/>'></li>
					<li class="clearSelect inputIcon ui-icon ui-icon-close"
						title='<s:text name="title.click2clear"/>'></li>
				</ul>
			</div>
		</div>
		<div id="last" class="block header ui-widget-header">车辆<span id="count"> (0)</span></div>
		<ul id="results" class="content results">
			<li class="empty">(无匹配项)</li>
			<!-- 
			<li class="">[<span class="code ellipsis"></span>]<span class="plate">粤A.XXXX1</span></li>
			<li class="active ui-state-highlight">[<span class="code ellipsis">1234</span>]<span class="plate">粤A.XXXX1</span></li>
			 -->
		</ul>
	</div>
	</div>

	<!-- 中间分隔区 -->
	<div class="splitter"><div class="full ui-widget-content ui-state-default"><div class="ui-icon ui-icon-grip-dotted-vertical"></div></div></div>

	<!-- 右侧信息区 -->
	<div id="right" class="right">
	<div class="full ui-widget-content">
		<div id="main" class="block main">
			<div id="carHeader" class="header ui-widget-header" style="border-top-width: 0;"><span id='loading'></span><span id='carTitle'>车辆信息</span><span id='wasteTime' class='wasteTime'></span>
				<ul class="inputIcons">
					<li id="seeMore" class="inputIcon" title='点击打开车辆详细信息表单'>更多</li>
					<li class="toggleShow inputIcon ui-icon ui-icon-triangle-1-s" title='点击折叠'></li>
				</ul>
			</div>
			<div id="carContent" class="content ui-state-default" style="padding:0;">
				<table class="contentTable" cellspacing="2" cellpadding="0">
					<tr>
						<td class="label" style="width: 5em;">管理号:</td>
						<td class="value" style="width: 13.5em;"><input type="text" name="main.manageNo" class="ui-widget-content" value="" readonly="readonly" style="width: 4.5em;"/>
							<span style="width: 2.5em;">自编号:</span><input type="text" name="main.code" class="ui-widget-content" value="" readonly="readonly" style="width: 5.3em;"/></td>
						<td class="label" style="width: 7em;">营运性质:</td>
						<td class="value" style="width: 13.5em;"><input type="text" name="main.businessType" class="ui-widget-content" readonly="readonly"/></td>
						<td rowspan="9" id="specalTD" class="desc-webkit"><textarea name="main.desc" class="ui-widget-content noresize" readonly="readonly"></textarea></td>
					</tr>
					<tr>
						<td class="label">所属公司:</td>
						<td class="value"><input type="text" name="main.company" class="ui-widget-content" readonly="readonly"/></td>
						<td class="label">有效合同期限:</td>
						<td class="value"><input type="text" name="main.contract4ChargerDate" class="ui-widget-content" value="" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="label">分公司:</td>
						<td class="value"><input type="text" name="main.unitName" class="ui-widget-content" readonly="readonly"/></td>
						<td class="label">缴费日:</td>
						<td class="value">
							<input type="text" name="main.paymentDate" class="ui-widget-content" readonly="readonly" style="width:3.5em" value=""/>
							<input type="checkbox" name="main.includeCost" class="ui-widget-content" disabled="disabled" style="width:auto;margin:0 2px 0 8px;" />含检审
							<input type="checkbox" name="main.zb" class="ui-widget-content" disabled="disabled" style="width:auto;margin:0 2px 0 8px;"/>ZB
						</td>
					</tr>
					<tr>
						<td class="label">车队:</td>
						<td class="value"><input type="text" name="main.motorcadeName" class="ui-widget-content" readonly="readonly"/></td>
						<td class="label"><div class="little" style="text-align: right;">行驶证登记日期:</div></td>
						<td class="value"><input type="text" name="main.registeDate" class="ui-widget-content" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="label">车辆品牌:</td>
						<td class="value"><input type="text" name="main.factoryType" class="ui-widget-content" readonly="readonly"/></td>
						<td class="label">投产日期:</td>
						<td class="value"><input type="text" name="main.operateDate" class="ui-widget-content" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="label">车辆型号:</td>
						<td class="value"><input type="text" name="main.factoryModel" class="ui-widget-content" readonly="readonly"/></td>
						<td class="label">道路运输证号:</td>
						<td class="value"><input type="text" name="main.certNo4" class="ui-widget-content" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="label">发动机号:</td>
						<td class="value"><input type="text" name="main.engineNo" class="ui-widget-content" readonly="readonly"/></td>
						<td class="label">计价器:</td>
						<td class="value"><input type="text" name="main.taximeter" class="ui-widget-content" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="label">车架号:</td>
						<td class="value"><input type="text" name="main.vin" class="ui-widget-content" readonly="readonly"/></td>
						<td class="label">LPG设备:</td>
						<td class="value"><input type="text" name="main.lpg" class="ui-widget-content" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="label">车辆包修:</td>
						<td class="value"><input type="text" name="main.Carmaintain" class="ui-widget-content" readonly="readonly"/></td>
						<td class="label">车载电视屏:</td>
						<td class="value"><input type="text" name="main.tv" class="ui-widget-content" readonly="readonly"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div id="messages" class="block message empty">
			<div class="header ui-widget-header"><span>提醒信息</span></div>
			<div class="content" style="padding:0;">
				<table class="contentTable0" cellspacing="0" cellpadding="0" style="width:auto;">
					<tbody id="msgsBody" >
						<tr class="first header">
							<td class="first ui-widget-content" style="min-width: 4em">类别</td>
							<td class="middle ui-widget-content" style="min-width: 6em">限制项目</td>
							<td class="middle ui-widget-content" style="min-width: 4em">关系人</td>
							<td class="middle ui-widget-content" >内容</td>
							<td class="middle ui-widget-content" style="min-width: 6em">相关日期</td>
							<td class="last ui-widget-content" style="min-width: 4em">相关部门</td>
						</tr>
						<!-- 
						<tr class="middle odd">
							<td class="first ui-widget-content">黑名单</td>
							<td class="middle ui-widget-content">停办一切业务</td>
							<td class="middle ui-widget-content">【司机姓名】</td>
							<td class="middle ui-widget-content">不可退押金;JN245司机杨龙江迁出，未交回2份副班合同</td>
							<td class="last ui-widget-content">2011-01-01</td>
						</tr>
						<tr class="middle even">
							<td class="first ui-widget-content">黑名单</td>
							<td class="middle ui-widget-content">停办一切业务</td>
							<td class="middle ui-widget-content">【司机姓名】</td>
							<td class="middle ui-widget-content">不可退押金;JN245司机杨龙江迁出</td>
							<td class="last ui-widget-content">2011-01-01</td>
						</tr>
						<tr class="last odd">
							<td class="first ui-widget-content">黑名单</td>
							<td class="middle ui-widget-content">停办一切业务</td>
							<td class="middle ui-widget-content">【司机姓名】</td>
							<td class="middle ui-widget-content">不可退押金;JN245司机杨龙江迁出</td>
							<td class="last ui-widget-content">2011-01-01</td>
						</tr> -->
					</tbody>
				</table>
			</div>
		</div>
		<div id="mans" class="block mans empty">
			<div id="mansHeader" class="header ui-widget-header" style="border-top-width: 0;"><span>联系信息</span>
				<ul class="inputIcons">
					<li id="includeLogout" class="inputIcon">
						<label><input type="checkbox" class="ui-widget-content" style="width:auto;margin:2px 2px 0 8px;" /><span style="margin:0;" >包含注销司机</span><span id="disabledManCount" style="margin:0;" ></span></label>
					</li>
					<li class="toggleShow inputIcon ui-icon ui-icon-triangle-1-s" title='点击折叠'></li>
				</ul>
			</div>
			<div class="content ui-widget-content unshowDisabled ui-state-default" style="padding:0;">
				<table class="title contentTable0" cellspacing="0" cellpadding="0">
					<tbody id="mansBody">
						<!-- 
						<tr class="active top header first">
							<td class="first aright ui-widget-content" style="width: 7em">司机和责任人:</td>
							<td class="middle aleft ui-widget-content" style="width: 7em">张三(男)</td>
							<td class="middle aright ui-widget-content" style="width: 3em">电话:</td>
							<td class="last aleft ui-widget-content" style="width: 15em">13611112222,13611112222</td>
							<td class="middle aright ui-widget-content" style="width: 3em">状态:</td>
							<td class="last aleft ui-widget-content">新入职 (2012-01-01)</td>
						</tr>
						<tr class="active detail">
							<td colspan="6" style="padding:0;">
								<table class="contentTable" cellspacing="2" cellpadding="0" style="height: auto;">
									<tr>
										<td rowspan="6" style="width: 87px;"><img id="portrait" style="width:86.4px;cursor: pointer;" 
											src="/bs/bc/image/download?ptype=portrait&amp;puid=carMan.uid.4&ts=1329753139367"></td>
										<td class="label" style="width: 6em;">身份证号码:</td>
										<td class="value" style="width: 18em;"><input type="text" name="man.identity" class="ui-widget-content" 
											value=""/></td>
										<td rowspan="6" style="position: relative;"><textarea name="main.desc" class="ui-widget-content noresize" 
											style="position:absolute;left:0;right:0;bottom:-2px;top:-2px;" readonly="readonly"></textarea></td>
									</tr>
									<tr>
										<td class="label">身份证地址:</td>
										<td class="value"><input type="text" name="man.address1" class="ui-widget-content" readonly="readonly"
											value=""/></td>
									</tr>
									<tr>
										<td class="label">暂住地址:</td>
										<td class="value"><input type="text" name="man.address2" class="ui-widget-content" readonly="readonly"/></td>
									</tr>
									<tr>
										<td class="label">籍贯:</td>
										<td class="value"><input type="text" name="man.region" class="ui-widget-content" readonly="readonly"/></td>
									</tr>
									<tr>
										<td class="label">资格证号:</td>
										<td class="value"><input type="text" name="man.cert4fwzg" class="ui-widget-content" 
											readonly="readonly" style="width:5em"/>&nbsp;&nbsp;户口性质:&nbsp;<input 
											type="text" name="man.houseType" class="ui-widget-content" readonly="readonly" style="width:5em"/></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr class="disabled top header ui-state-disabled">
							<td class="first aright ui-widget-content" style="width: 7em">司机和责任人:</td>
							<td class="middle aleft ui-widget-content" style="width: 7em">张三(男)</td>
							<td class="middle aright ui-widget-content" style="width: 3em">电话:</td>
							<td class="last aleft ui-widget-content" style="width: 15em">13611112222,13611112222</td>
							<td class="middle aright ui-widget-content" style="width: 3em">状态:</td>
							<td class="last aleft ui-widget-content">新入职 (2011-01-01)</td>
						</tr> -->
					</tbody>
				</table>
			</div>
		</div>
	</div>
	</div>
</div>