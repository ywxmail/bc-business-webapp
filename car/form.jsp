<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:property value="pageTitle"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/car/save" />'
	data-js='<s:url value="/bc-business/car/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.carForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow:hidden;">
	<s:form name="carForm" theme="simple" cssClass="bc-form" >
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset" data-cfg="{height:400}"
		 style="overflow: hidden;">
			<div class="tabsContainer">
           	 	<div class="slideContainer">
                <ul class="tabs ui-helper-reset">
					<s:if test="!e.isNew()">
				    <li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">车辆明细</a></li>
					<li class="tab ui-widget-content"><a href= "#otherFormFields2" class="ui-state-default">注销信息</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/carByDriverHistorys/list?carId=%{e.id}" />' class="ui-state-default">迁移记录</a></li>
					<!--<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/carByDrivers/list?carId=%{e.id}"/>' class="ui-state-default">营运司机</a></li>-->
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/contract4Chargers/list?carId=%{e.id}" />' class="ui-state-default">经济合同</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/contract4Labours/list?carId=%{e.id}" />' class="ui-state-default">劳动合同</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/policys/list?carId=%{e.id}" />' class="ui-state-default">保单</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/car4Cert/list?carId=%{e.id}" />' class="ui-state-default">证件</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/certLosts/list?carId=%{e.id}" />' class="ui-state-default">证件遗失</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/blacklists/list?carId=%{e.id}" />' class="ui-state-default">黑名单</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseTraffics/list?carId=%{e.id}" />' class="ui-state-default">交通违章</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseBusinesss/list?carId=%{e.id}" />' class="ui-state-default">营运违章</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseAccidents/list?carId=%{e.id}" />' class="ui-state-default">事故理赔</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseAdvices/list?carId=%{e.id}&type=2" />' class="ui-state-default">客管投诉</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseAdvices/list?carId=%{e.id}&type=6" />' class="ui-state-default">公司投诉</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/casePraises/list?carId=%{e.id}" />' class="ui-state-default">表扬</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseLosts/list?carId=%{e.id}" />' class="ui-state-default">报失</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/invoice4Sells/list?carId=%{e.id}" />' class="ui-state-default">发票销售</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">附属设施</a></li>
					<!-- <li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">费用</a></li> -->
					<li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">回场检</a></li>
					<!-- <li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">变更历史</a></li> -->
					</s:if>
					<s:else>
				    <li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">车辆明细</a></li>
					</s:else>
                </ul>
            	</div>
	        </div>
	        <div class="contentContainer ui-helper-reset ui-widget-content noBottomBorder">
<!--------------------------------   基本资料     -------------------------------->
		        <div id="otherFormFields" class="content active">
		        <div style="width:742px">
					<table class="formFields" cellspacing="2" cellpadding="0">
						<tbody>
							<tr class="widthMarker">
									<td style="width: 115px;">&nbsp;</td>
									<td style="width: 240px;">&nbsp;</td>
									<td style="width: 120px;">&nbsp;</td>
									<td>&nbsp;</td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.plate"/>:</td>
								<td class="value" >
									<s:if test="!e.isNew()">
										<s:textfield name="e.plateType" readonly="true" cssStyle="width:30px;text-align:right;border-right-width:0;" data-validate="required" cssClass="ui-widget-content"/><s:textfield name="e.plateNo" readonly="true" cssStyle="width:203px;" data-validate='{"minLen": 5,"maxLen": 5,"required":true,"type":"string",msg:"必须填写正确格式的5位车牌号，如J1B23"}' cssClass="ui-widget-content"/>
									</s:if>
									<s:else>
										<s:textfield name="e.plateType" cssStyle="width:30px;text-align:right;border-right-width:0;" value='%{getText("car.plate.yue.A")}' data-validate="required" cssClass="ui-widget-content"/><s:textfield name="e.plateNo" cssStyle="width:203px;" data-validate='{"minLen": 5,"maxLen": 5,"required":true,"type":"string",msg:"必须填写正确格式的5位车牌号，如J1B23"}' cssClass="ui-widget-content"/>
									</s:else>
								</td>
								<td class="label" >*<s:text name="car.code"/>:</td>
								<td class="value" ><s:textfield name="e.code" data-validate="required" cssClass="ui-widget-content"/></td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.company2"/>:</td>
								<td class="value" >
									<s:select name="e.company" list="companyList" listKey="value" listValue="value" data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" disabled="%{!e.isNew()}"></s:select>
								</td>
								<td class="label" >*<s:text name="car.businessType"/>:</td>
								<td class="value" >
									<s:select name="e.businessType" list="businessTypeList" listKey="value" listValue="value" data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content"></s:select>
								</td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.motorcade"/>:</td>
								<td class="value" >
									<s:select name="e.motorcade.id" list="motorcadeList" listKey="key" listValue="value" value="e.motorcade.id" data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" disabled="%{!e.isNew()}"></s:select>
								</td>
								<td class="label" >*<s:text name="car.vin"/>:</td>
								<td class="value" >
									<s:textfield name="e.vin" data-validate="required" cssClass="ui-widget-content"/>
								</td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.registerDate"/>:</td>
								<td class="value relative">
									<input type="text" name="e.registerDate" data-validate='{"type":"date","required":true}'
									value='<s:date format="yyyy-MM-dd" name="e.registerDate" />'
									class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.registerDate'></li>
									</ul>
								</td>
								<td class="label" >*<s:text name="car.engineNo"/>:</td>
								<td class="value" ><s:textfield name="e.engineNo" cssClass="ui-widget-content" data-validate="required"/></td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.factoryDate"/>:</td>
								<td class="value relative" >
									<input type="text" name="e.factoryDate" data-validate='{"type":"date","required":true}'
									value='<s:date format="yyyy-MM-dd" name="e.factoryDate" />'
									class="bc-date ui-widget-content"  data-cfg='{changeYear:true}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.factoryDate'></li>
									</ul>
								</td>
								<td class="label" ><s:text name="car.level"/>:</td>
								<td class="value" >
									<s:select name="e.level" list="levelTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
								</td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.operateDate"/>:</td>
								<td class="value relative" >
									<input type="text" name="e.operateDate" data-validate='{"type":"date","required":true}'
									value='<s:date format="yyyy-MM-dd" name="e.operateDate" />'
									class="bc-date ui-widget-content"  data-cfg='{changeYear:true<s:if test="e.isNew()">,addYear: "5 0 -5|e.scrapDate"</s:if>}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.operateDate'></li>
									</ul>
								</td>
								<td class="label" ><s:text name="car.originNo"/>:</td>
								<td class="value relative" >
									<s:textfield name="e.originNo" cssClass="ui-widget-content"/>
									<ul class="inputIcons">
										<li class="inputIcon ui-icon ui-icon-lightbulb" title='<s:text name="car.title.click2selectoriginNo"/>' id="selectOriginNo">
									</ul>
								</td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.scrapDate"/>:</td>
								<td class="value relative" >
									<input type="text" name="e.scrapDate" data-validate='{"type":"date","required":true}'
									value='<s:date format="yyyy-MM-dd" name="e.scrapDate" />'
									class="bc-date ui-widget-content"  data-cfg='{changeYear:true}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.scrapDate'></li>
									</ul>
								</td>
								<td class="label" ><s:text name="car.tv.screen"/>:</td>
								<td class="value" >
									<s:if test="isReadonly()">
										<s:textfield name="e.carTvScreen" cssClass="ui-widget-content" cssStyle="width:250px;"/>
									</s:if>
									<s:else>
										<div class="bc-relativeContainer">
											<input type="text" name="e.carTvScreen" value='<s:property value="e.carTvScreen"/>' style="width:250px;"
												data-validate='{"type":"string"}' class="bc-select ui-widget-content"
												data-maxHeight="150px"
												data-source='<s:property value="carTvScreenList"/>'/>
											<ul class="inputIcons">
												<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
											</ul>
										</div>
									</s:else>
								</td>
							</tr>					
							<tr>
								<td class="label" colspan="4">
									<div class="formTopInfo">
										状态：<s:property value="%{statusesValue[e.status]}" />，
										<s:if test="%{e.author.name != null}">
										登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
										</s:if>
										<s:if test="%{e.modifier != null}">
										，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
										</s:if>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
<!--------------------------------   票号证号     -------------------------------->
					<fieldset style="margin: 6px;" class="ui-widget-content">
						<legend>票号证号</legend>
						<table class="formFields" cellspacing="2" cellpadding="0">
							<tbody>
								<tr class="widthMarker">
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 240px;">&nbsp;</td>
									<td style="width: 120px;">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.registerNo"/>:</td>
									<td class="value" ><s:textfield name="e.registerNo"  cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.certNo2"/>:</td>
									<td class="value" ><s:textfield name="e.certNo2" cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.certNo1" />:</td>
									<td class="value" ><s:textfield name="e.certNo1" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.invoiceNo2"/>:</td>
									<td class="value" ><s:textfield name="e.invoiceNo2" cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.invoiceNo1" />:</td>
									<td class="value" ><s:textfield name="e.invoiceNo1" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.certNo4"/>:</td>
									<td class="value" ><s:textfield name="e.certNo4"  cssClass="ui-widget-content"/></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
<!--------------------------------   计价器     -------------------------------->
					<fieldset style="margin: 6px;" class="ui-widget-content">
						<legend>计价器</legend>
						<table class="formFields" cellspacing="2" cellpadding="0" >
							<tbody>
								<tr class="widthMarker">
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 240px;">&nbsp;</td>
									<td style="width: 120px;">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.taximeterFactory" />:</td>
									<td class="value" >
										<s:select name="e.taximeterFactory" list="taximeterFactoryTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
									</td>
									<td class="label" ><s:text name="car.taximeterType"/>:</td>
									<td class="value relative">
										<s:if test="isReadonly()">
											<s:textfield name="e.taximeterType" cssClass="ui-widget-content" />
										</s:if>
										<s:else>
											<input type="text" name="e.taximeterType" value='<s:property value="e.taximeterType"/>'
												class="bc-select ui-widget-content"
												data-maxHeight="150px"
												data-source='<s:property value="taximeterTypes"/>'/>
											<ul class="inputIcons">
												<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
											</ul>
										</s:else>
									</td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.certNo3"/>:</td>
									<td class="value" ><s:textfield name="e.certNo3"  cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.taximeterNo" />:</td>
									<td class="value" ><s:textfield name="e.taximeterNo"  cssClass="ui-widget-content"/></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
<!--------------------------------   硬件参数     -------------------------------->
					<fieldset style="margin: 6px;" class="ui-widget-content">
						<legend>硬件参数</legend>
						<table class="formFields" cellspacing="2" cellpadding="0" >
							<tbody>
								<tr class="widthMarker">
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 240px;">&nbsp;</td>
									<td style="width: 120px;">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.factoryModel"/>:</td>
									<!-- <td class="value" ><s:textfield name="e.factoryModel" cssClass="ui-widget-content"/> -->
									<td class="value" ><s:select name="e.factoryModel" id="carModels" list="carModelList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select></td>
									<td class="label" ><s:text name="car.factoryType"/>:</td>
									<td class="value" >
										<s:select name="e.factoryType" list="factoryTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
									</td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.fuelType"/>:</td>
									<td class="value" >
										<s:select name="e.fuelType" list="fuelTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
									</td>
									<td class="label" ><s:text name="car.color"/>:</td>
									<td class="value" >
										<s:select name="e.color" list="colorTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
									</td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.engineType"/>:</td>
									<td class="value" ><s:textfield name="e.engineType" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.displacement"/>/<s:text name="car.power"/>:</td>
									<td class="value" ><s:textfield name="e.displacement" data-validate='{"type" : "digits"}'  cssStyle="width:5em;" cssClass="ui-widget-content"/>&nbsp;ml&nbsp;&nbsp;<s:textfield name="e.power" value="%{getText('bs.format.number',{e.power})}" data-validate='{"type" : "number"}' cssStyle="width:5em;" cssClass="ui-widget-content"/>&nbsp;kw</td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.tireDistance" />:</td>
									<td class="value" >
										<s:textfield name="e.tireFrontDistance"  data-validate='{"type" : "digits"}' cssStyle="width:5em;"  cssClass="ui-widget-content"/>&nbsp;前&nbsp;&nbsp;
										<s:textfield name="e.tireBehindDistance" data-validate='{"type" : "digits"}' cssStyle="width:5em;"  cssClass="ui-widget-content"/>&nbsp;后
									</td>
									<td class="label" ><s:text name="car.turnType"/>:</td>
									<td class="value" ><s:textfield name="e.turnType" cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.tireStandard" />:</td>
									<td class="value" ><s:textfield name="e.tireStandard" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.tireCount"/>:</td>
									<td class="value" ><s:textfield name="e.tireCount" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.axisDistance"/>:</td>
									<td class="value" ><s:textfield name="e.axisDistance" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.axisCount" />:</td>
									<td class="value" ><s:textfield name="e.axisCount" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label"  >
										<s:text name="car.dim" />:
									</td>
									<td class="value" >
										<s:text name="car.dimLen" />
										<s:textfield name="e.dimLen" data-validate='{"type" : "digits"}'  cssStyle="width:3em;" cssClass="ui-widget-content"/>
										<s:text name="car.dimWidth"/>
										<s:textfield name="e.dimWidth" data-validate='{"type" : "digits"}'  cssStyle="width:3em;" cssClass="ui-widget-content"/>
										<s:text name="car.dimHeight" />
										<s:textfield name="e.dimHeight" data-validate='{"type" : "digits"}'   cssStyle="width:3em;" cssClass="ui-widget-content"/>&nbsp;mm
									</td>
									<td class="label" ><s:text name="car.pieceCount"/>:</td>
									<td class="value" ><s:textfield name="e.pieceCount" data-validate='{"type" : "digits"}'cssClass="ui-widget-content"/></td>
								<tr>
									<td class="label" ><s:text name="car.totalWeight"/>:</td>
									<td class="value" ><s:textfield name="e.totalWeight" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.accessWeight" />:</td>
									<td class="value" ><s:textfield name="e.accessWeight" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.accessCount"/>:</td>
									<td class="value" ><s:textfield name="e.accessCount" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
<!--------------------------------   LPG     -------------------------------->
					<fieldset style="margin: 6px;" class="ui-widget-content">
						<legend>LPG</legend>
						<table class="formFields" cellspacing="2" cellpadding="0" >
							<tbody>
								<tr class="widthMarker">
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 240px;">&nbsp;</td>
									<td style="width: 140px;">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<!-- car.lpg.name				=专用装置供应商
									car.lpg.model				=专用装置品牌型号
									car.lpg.gpmodel				=钢瓶品牌型号
									car.lpg.gpid				=钢瓶编号
									car.lpg.gpdate				=钢瓶出厂日期
									car.lpg.jcfmodel			=集成阀品牌型号
									car.lpg.qhqmodel			=汽化器品牌型号
									car.lpg.psqmodel			=混合/喷射器品牌型号
									car.lpg.refit.factory		=改装厂
									car.lpg.refit.date			=改装出厂日期
									car.lpg.insuranceid			=LPG保单号
									car.lpg.insurance.startdate	=LPG保单开始日期
									car.lpg.insurance.enddate	=LPG保单结束日期 -->	
								<tr>
									<td class="label" ><s:text name="car.lpg.name"/>:</td>
									<td class="value" >
										<s:if test="isReadonly()">
											<s:textfield name="e.lpgName" cssClass="ui-widget-content" cssStyle="width:235px;"/>
										</s:if>
										<s:else>
											<div class="bc-relativeContainer" style="position : relative; display: inline-block">
												<input type="text" id="carLPGs" name="e.lpgName" value='<s:property value="e.lpgName"/>' style="width:235px;" 
													data-validate='{"maxLen": 50,"type":"string"}' class="bc-select ui-widget-content"
													data-maxHeight="150px" data-cfg='{"callback":"bc.carForm.autoLoadLpgInfo"}'
													data-source='<s:property value="carLPGList"/>'/>
												<ul class="inputIcons">
													<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
												</ul>
											</div>
										</s:else>
									</td>
									<td class="label" ><s:text name="car.lpg.model"/>:</td>
									<td class="value" ><s:textfield name="e.lpgModel" cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.lpg.gpmodel"/>:</td>
									<td class="value" ><s:textfield name="e.lpgGpModel" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.lpg.gpid"/>:</td>
									<td class="value" ><s:textfield name="e.lpgGpId" cssClass="ui-widget-content"/></td>
								</tr>	
								<tr>
									<td class="label" ><s:text name="car.lpg.gpdate"/>:</td>
									<td class="value relative" >
										<input type="text" name="e.lpgGpDate" data-validate='{"type":"date"}'
											value='<s:date format="yyyy-MM-dd" name="e.lpgGpDate" />'
											class="bc-date ui-widget-content" />
										<ul class="inputIcons">
											<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.lpgGpDate'></li>
										</ul>
									</td>
									<td class="label" ><s:text name="car.lpg.jcfmodel"/>:</td>
									<td class="value" ><s:textfield name="e.lpgJcfModel" cssClass="ui-widget-content"/></td>
								</tr>	
								<tr>
									<td class="label" ><s:text name="car.lpg.qhqmodel"/>:</td>
									<td class="value" ><s:textfield name="e.lpgQhqModel" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.lpg.psqmodel"/>:</td>
									<td class="value" ><s:textfield name="e.lpgPsqModel" cssClass="ui-widget-content"/></td>
								</tr>	
								<tr>
									<td class="label" ><s:text name="car.lpg.insuranceid"/>:</td>
									<td class="value" ><s:textfield name="e.lpgInsuranceId" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.lpg.refit.factory"/>:</td>
									<td class="value" ><s:textfield name="e.lpgRefitFactory" cssClass="ui-widget-content"/></td>
									
								</tr>	
								<tr>
									<td class="label" ><s:text name="car.lpg.insurance.date"/>:</td>
									<td class="value" >
										<div style="position : relative; display: inline-block">
											&nbsp;从<input type="text" name="e.lpgInsuranceStartDate" 
				                            data-validate='{type:"date"}'class="bc-date ui-widget-content" title='<s:text name="title.click2selectDate"/>'
			                                value='<s:date format="yyyy-MM-dd" name="e.lpgInsuranceStartDate" />' style="width: 90px;"/>
			                                <ul class="inputIcons" style="right : 0px;">
												<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.lpgInsuranceStartDate' ></li>
										    </ul>
										</div>
										<div style="position : relative; display: inline-block">
											&nbsp;到<input type="text" name="e.lpgInsuranceEndDate" 
				                            data-validate='{type:"date"}'class="bc-date ui-widget-content" title='<s:text name="title.click2selectDate"/>'
			                                value='<s:date format="yyyy-MM-dd" name="e.lpgInsuranceEndDate" />' style="width: 90px;"/>
			                                <ul class="inputIcons" style="right : 0px;">
												<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.lpgInsuranceEndDate' ></li>
										    </ul>
										</div>
									</td>
									<td class="label" ><s:text name="car.lpg.refit.date"/>:</td>
									<td class="value relative" >
										<input type="text" name="e.lpgRefitDate" data-validate='{"type":"date"}'
											value='<s:date format="yyyy-MM-dd" name="e.lpgRefitDate" />'
											class="bc-date ui-widget-content" />
										<ul class="inputIcons">
											<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.lpgRefitDate'></li>
										</ul>
									</td>
								</tr>						
							</tbody>
						</table>
					</fieldset>
<!--------------------------------   其他    -------------------------------->
					<fieldset style="margin: 6px;" class="ui-widget-content">
						<legend>其它</legend>
						<table class="formFields" cellspacing="2" cellpadding="0" >
							<tbody>
								<tr class="widthMarker">
									<td style="width: 40px;">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td class="topLabel"  style="width: 40px;min-width: 40px;"><s:text name="car.desc1"/>:</td>
									<td class="value"><s:textarea name="e.desc1" rows="3" cssClass="ui-widget-content noresize" cssStyle="width: 99.5%;"/></td>
								</tr>
								<tr>
								    <td class="topLabel" style="width: 40px;min-width: 40px;"><s:text name="car.desc2"/>:</td>
									<td class="value"><s:textarea name="e.desc2" rows="3" cssClass="ui-widget-content noresize" cssStyle="width: 99.5%;"/></td>
								</tr>
								<tr>
									<td class="topLabel"  style="width: 40px;min-width: 40px;"><s:text name="car.desc3"/>:</td>
									<td class="value"><s:textarea name="e.desc3" rows="3" cssClass="ui-widget-content noresize" cssStyle="width: 99.5%;"/></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
				</div>
				</div>
				<div id="otherFormFields2" class="content">
				<div style="width:742px">
					<fieldset style="margin: 6px;" class="ui-widget-content">
						<legend>
							<s:checkbox name="e.logout" cssStyle="width:1em;" />
							<s:text name="car.logout"/>
						</legend>
						<table class="formFields" cellspacing="2" cellpadding="0">
							<tbody>
								<tr class="widthMarker">
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 240px;">&nbsp;</td>
									<td style="width: 120px;">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td class="label" >*<s:text name="car.returnDate"/>:</td>
									<td class="value relative">
										<input type="text" name="e.returnDate" data-validate='{"type":"date"}'
										value='<s:date format="yyyy-MM-dd" name="e.returnDate" />'
										class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
										<ul class="inputIcons">
											<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.returnDate'></li>
										</ul>
									</td>
									<td class="label" ><s:text name="car.logoutReason"/>:</td>
									<td class="value">
										<s:select name="e.logoutReason" list="logoutReasonList" listKey="key" listValue="value" headerKey="0" headerValue="" cssClass="ui-widget-content"></s:select>
									</td>
								</tr>
								<tr>
									<td class="label"><s:text name="car.distanceScrapMonth"/>:</td>
									<td class="value"><s:textfield name="e.distanceScrapMonth" cssClass="ui-widget-content"/></td>
									<td style="text-align: left">月</td>
									<td></td>
								<tr>
								<tr>
									<td class="label" style="vertical-align: top;"><s:text name="car.logoutRemark"/>:</td>
									<td class="value" colspan="3"><s:textarea name="e.logoutRemark" rows="5" cssClass="ui-widget-content noresize" /></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
					<fieldset style="margin: 6px;" class="ui-widget-content">
						<legend>
							<s:checkbox name="e.verify" cssStyle="width:1em;" />
							<s:text name="car.verify"/>
						</legend>
						<table class="formFields" cellspacing="2" cellpadding="0">
							<tbody>
								<tr class="widthMarker">
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 240px;">&nbsp;</td>
									<td style="width: 120px;">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.verifyDate"/>:</td>
									<td class="value relative">
										<input type="text" name="e.verifyDate" data-validate='{"type":"date"}'
										value='<s:date format="yyyy-MM-dd" name="e.verifyDate" />'
										class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
										<ul class="inputIcons">
											<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.verifyDate'></li>
										</ul>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
				</div>
			</div>
			</div>
		</div>
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.driver"/>
		<s:hidden name="e.charger"/>
		<s:hidden name="e.originalValue"/>
		<s:hidden name="e.rentNo"/>
		<s:if test="!e.isNew()">
		<s:hidden name="e.company"/>
		<s:hidden name="e.motorcade.id"/>
		</s:if>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>