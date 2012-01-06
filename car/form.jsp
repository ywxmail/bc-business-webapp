<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="car.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/car/save" />'
	data-js='<s:url value="/bc-business/car/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.carForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:hidden;">
	<s:form name="carForm" theme="simple">
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset" data-cfg="{height:400}"
		 style="overflow: hidden;">
			<div class="tabsContainer">
           	 	<div class="slideContainer">
                <ul class="tabs ui-helper-reset">
					<s:if test="!e.isNew()">
				    <li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">车辆明细</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/carByDrivers/list?carId=%{e.id}"/>' class="ui-state-default">营运司机</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/contracts/list?carId=%{e.id}" />' class="ui-state-default">合同</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">保单</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/car4Cert/list?carId=%{e.id}" />' class="ui-state-default">证件</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/blacklists/list?carId=%{e.id}" />' class="ui-state-default">黑名单</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseTraffics/list?carId=%{e.id}" />' class="ui-state-default">交通违章</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseBusinesss/list?carId=%{e.id}" />' class="ui-state-default">营运违章</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseAccidents/list?carId=%{e.id}" />' class="ui-state-default">事故理赔</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseAdvices/list?carId=%{e.id}" />' class="ui-state-default">投诉</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/casePraises/list?carId=%{e.id}" />' class="ui-state-default">表扬</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/carByDriverHistorys/list?carId=%{e.id}" />' class="ui-state-default">迁移历史</a></li>
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
	        <div class="contentContainer ui-helper-reset ui-widget-content">
		        <div id="otherFormFields" class="content active">
					<table class="formFields" cellspacing="2" cellpadding="0">
						<tbody>
							<tr style="line-height: 1px;">
								<td >&nbsp;</td>
								<td style="width: 200px;">&nbsp;</td>
								<td style="width: 100px;">&nbsp;</td>
								<td style="width: 200px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.plate"/>:</td>
								<td class="value" >
									<s:if test="!e.isNew()">
										<s:textfield name="e.plateType" cssStyle="width:4em;text-align:right;" data-validate="required" cssClass="ui-widget-content"/><s:textfield name="e.plateNo" cssStyle="width:8em;" data-validate="required" cssClass="ui-widget-content"/>
									</s:if>
									<s:else>
										<s:textfield name="e.plateType" cssStyle="width:4em;text-align:right;" value='%{getText("car.plate.yue.A")}' data-validate="required" cssClass="ui-widget-content"/><s:textfield name="e.plateNo" cssStyle="width:8em;" data-validate="required" cssClass="ui-widget-content"/>
									</s:else>
								</td>
								<td class="label" >*<s:text name="car.vin"/>:</td>
								<td class="value" ><s:textfield name="e.vin" data-validate="required" cssClass="ui-widget-content"/></td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.motorcade"/>:</td>
								<td class="value" >
									<s:select name="e.motorcade.id" list="motorcadeList" listKey="key" listValue="value" value="e.motorcade.id" data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}"  cssClass="ui-widget-content"></s:select>
								</td>
								<td class="label" ><s:text name="car.factoryType"/>:</td>
								<td class="value" >
									<s:select name="e.factoryType" list="factoryTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
								</td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.businessType"/>:</td>
								<td class="value" >
									<s:select name="e.businessType" list="businessTypeList" listKey="value" listValue="value"  data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content"></s:select>
								</td>
								<td class="label" ><s:text name="car.factoryModel"/>:</td>
								<td class="value" ><s:textfield name="e.factoryModel" cssClass="ui-widget-content"/></td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.registerDate"/>:</td>
								<td class="value relative">
									<input type="text" name="e.registerDate" data-validate='{"type":"date"}'
									value='<s:date format="yyyy-MM-dd" name="e.registerDate" />'
									class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.registerDate'></li>
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
									<input type="text" name="e.operateDate" data-validate='{"type":"date"}'
									value='<s:date format="yyyy-MM-dd" name="e.operateDate" />'
									class="bc-date ui-widget-content"  data-cfg='{changeYear:true}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.operateDate'></li>
									</ul>
								</td>
								<td class="label" ><s:text name="car.originNo"/>:</td>
								<td class="value" ><s:textfield name="e.originNo" cssClass="ui-widget-content"/></td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.factoryDate"/>:</td>
								<td class="value relative" >
									<input type="text" name="e.factoryDate" data-validate='{"type":"date"}'
									value='<s:date format="yyyy-MM-dd" name="e.factoryDate" />'
									class="bc-date ui-widget-content"  data-cfg='{changeYear:true}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.factoryDate'></li>
									</ul>
								</td>
								<td class="label" ><s:text name="car.code"/>:</td>
								<td class="value" ><s:textfield name="e.code" cssClass="ui-widget-content"/></td>
							</tr>
							<tr>
								<td class="label" >*<s:text name="car.scrapDate"/>:</td>
								<td class="value relative" >
									<input type="text" name="e.scrapDate" data-validate='{"type":"date"}'
									value='<s:date format="yyyy-MM-dd" name="e.scrapDate" />'
									class="bc-date ui-widget-content"  data-cfg='{changeYear:true}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.scrapDate'></li>
									</ul>
								</td>
								<td class="label" ><s:text name="car.unit"/>:</td>
								<td class="value" ><s:textfield name="e.oldUnitName" cssClass="ui-widget-content"/></td>
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
					<fieldset style="margin: 6px;" class="ui-corner-all ui-widget-content">
						<legend>票号证号</legend>
						<table class="formFields" cellspacing="2" cellpadding="0" >
							<tbody>
								<tr style="line-height: 1px;">
									<td >&nbsp;</td>
									<td style="width: 200px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 200px;">&nbsp;</td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.certNo1" />:</td>
									<td class="value" ><s:textfield name="e.certNo1" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.certNo2"/>:</td>
									<td class="value" ><s:textfield name="e.certNo2" cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.invoiceNo1" />:</td>
									<td class="value" ><s:textfield name="e.invoiceNo1" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.invoiceNo2"/>:</td>
									<td class="value" ><s:textfield name="e.invoiceNo2" cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.certNo3"/>:</td>
									<td class="value" ><s:textfield name="e.certNo3"  cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.originalValue"/>:</td>
									<td class="value" ><s:textfield name="e.originalValue" data-validate='{"type":"number"}' cssClass="ui-widget-content"/></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
					<fieldset style="margin: 6px;" class="ui-corner-all ui-widget-content">
						<legend>硬件参数</legend>
						<table class="formFields" cellspacing="2" cellpadding="0" >
							<tbody>
								<tr style="line-height: 1px;">
									<td >&nbsp;</td>
									<td style="width: 200px;">&nbsp;</td>
									<td style="width: 100px;">&nbsp;</td>
									<td style="width: 200px;">&nbsp;</td>
								</tr>
								<tr>
									<td class="label" >*<s:text name="car.engineNo"/>:</td>
									<td class="value" ><s:textfield name="e.engineNo" cssClass="ui-widget-content" data-validate="required"/></td>
									<td class="label" ><s:text name="car.fuelType"/>:</td>
									<td class="value" >
										<s:select name="e.fuelType" list="fuelTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
									</td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.color"/>:</td>
									<td class="value" >
										<s:select name="e.color" list="colorTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
									</td>
									<td class="label" ><s:text name="car.engineType"/>:</td>
									<td class="value" ><s:textfield name="e.engineType" cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.displacement"/>/<s:text name="car.power"/>:</td>
									<td class="value" ><s:textfield name="e.displacement" data-validate='{"type" : "digits"}'  cssStyle="width:5em;" cssClass="ui-widget-content"/>&nbsp;ml&nbsp;&nbsp;<s:textfield name="e.power" data-validate='{"type" : "number"}' cssStyle="width:5em;" cssClass="ui-widget-content"/>&nbsp;kw</td>
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
								</tr>
								<tr>
									<td class="label" ><s:text name="car.turnType"/>:</td>
									<td class="value" ><s:textfield name="e.turnType" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.tireCount"/>:</td>
									<td class="value" ><s:textfield name="e.tireCount" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.tireStandard" />:</td>
									<td class="value" ><s:textfield name="e.tireStandard" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.axisDistance"/>:</td>
									<td class="value" ><s:textfield name="e.axisDistance" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.axisCount" />:</td>
									<td class="value" ><s:textfield name="e.axisCount" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.pieceCount"/>:</td>
									<td class="value" ><s:textfield name="e.pieceCount" data-validate='{"type" : "digits"}'cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.totalWeight"/>:</td>
									<td class="value" ><s:textfield name="e.totalWeight" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.accessWeight" />:</td>
									<td class="value" ><s:textfield name="e.accessWeight" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.accessCount"/>:</td>
									<td class="value" ><s:textfield name="e.accessCount" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.taximeterFactory" />:</td>
									<td class="value" >
										<s:select name="e.taximeterFactory" list="taximeterFactoryTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
									</td>
								</tr>
								<tr>
									<td class="label" ><s:text name="car.taximeterType"/>:</td>
									<td class="value" ><s:textfield name="e.taximeterType" cssClass="ui-widget-content"/></td>
									<td class="label" ><s:text name="car.taximeterNo" />:</td>
									<td class="value" ><s:textfield name="e.taximeterNo"  cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
									<td class="topLabel" ><s:text name="car.desc1"/>:</td>
									<td class="value" colspan="3"><s:textarea name="e.desc1" rows="5" cssClass="ui-widget-content"/></td>
								</tr>
								<tr>
								    <td class="label" style="float:right;"><s:text name="car.desc2"/>:</td>
									<td class="value" ><s:textarea name="e.desc2" cssClass="ui-widget-content"/></td>
									<td class="label" style="float:right;"><s:text name="car.desc3"/>:</td>
									<td class="value" ><s:textarea name="e.desc3" cssClass="ui-widget-content"/></td>
								</tr>
							</tbody>
						</table>
					</fieldset>
				</div>
			</div>
		</div>
		<s:hidden name="e.uid" />

		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.driver"/>
		<s:hidden name="e.charger"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>