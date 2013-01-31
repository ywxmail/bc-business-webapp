<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="contract4Charger.title"/> - v<s:property value="e.verMajor" />.<s:property value="e.verMinor" />' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/contract4Charger/save" />'
	data-js='js:editor,js:bc_identity,<s:url value="/bc/template/template.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/bc-business/contract4Charger/form.js" />'
	data-initMethod='bc.contract4ChargerForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow: hidden;">
	<s:form name="contract4ChargerForm" theme="simple" cssClass="bc-form">
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset"
			data-cfg="{height:400}" style="overflow: hidden;">
			<div class="tabsContainer">
           	 	<div class="slideContainer">
					<ul class="tabs ui-helper-reset">
						<li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">基本信息</a></li>
						<s:if test="!isReadonly()||isEntering()">
							<li class="tab ui-widget-content"><a href='#attachment' class="ui-state-default">合同附件</a></li>
							<li class="tab ui-widget-content"><a href="#contractContents" class="ui-state-default">合同内容</a></li>
							<li class="tab ui-widget-content"><a href="#contractOldContents" class="ui-state-default">旧合同内容</a></li>
						</s:if>
						<s:if test="!e.isNew()">
							<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/contract4Chargers/list?contractId=0&carId=%{carId}"/>' class="ui-state-default">历史版本</a></li>
						</s:if>
					</ul>
				</div>
			</div>
			<div class="contentContainer ui-helper-reset ui-widget-content">
				<div id="otherFormFields" class="content active" >
				<div style="width:720px">
					<table class="formFields" cellspacing="2" cellpadding="0">
						<tbody>
							<tr class="widthMarker">
								<td >&nbsp;</td>
								<td style="width: 250px;">&nbsp;</td>
								<td style="width: 60px;">&nbsp;</td>
								<td style="width: 250px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="label">*<s:text name="contract.code"/>:</td>
								<td class="value ">
									<s:textfield name="e.code" cssClass="ui-widget-content" data-validate="required" />
								</td>
								<td class="label">*<s:text name="contract4Charger.signType"/>:</td>
								<td class="value">
									<s:select name="e.signType" list="signTypeList" listKey="value" listValue="value"  data-validate="required" headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
								</td>
							</tr>
							<tr>
								<td class="label">*<s:text name="contract.car"/>:</td>
								<!--  <td class="value relative">
									<s:textfield name="e.ext_str1" data-validate="required" cssClass="ui-widget-content" />
									
										<ul class="inputIcons">
											<li class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="contract.title.click2selectCar"/>' id="selectCarPlate">
										</ul>
									
								</td>-->
								<td class="value relative">
									<div class="input ui-widget-content" data-validate="required" ><span class="link showCar" data-cfg='<s:property value="carId" />' id="carInfo" ><s:property value="%{e.ext_str1}" /></span>
									</div>
									<s:if test="e.isNew()">
							    		<span id="selectCarPlate" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" style="margin: -8px 5px;" title='<s:text name="title.click2select"/>'></span>
						    		</s:if>
							    </td> 
								
								<td class="label" >*<s:text name="contract4Charger.businessType"/>:</td>
								<td class="value" >
									<s:select name="e.businessType" list="businessTypeList" listKey="value" listValue="value"  data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content"></s:select>
								</td>
							</tr>
							<tr>
<!-- -   ----------------------------------   责任人                                         -->
								<td class="label">*<s:text name="contract4Charger.charger"/>:</td>
								<td class="value relative">
									<!--<s:textfield name="drivers" cssClass="ui-widget-content" readonly="true"/>
									<ul class="inputIcons">
										<li id="selectdriverName" class="inputIcon ui-icon ui-icon-circle-plus" title='点击选择司机'></li>
										<li class="clearSelect inputIcon ui-icon ui-icon-circle-close" data-cfg="drivers,e.drivers" title='点击清除司机'></li>
									</ul>-->
									<div id="assignChargers" style="position:relative;margin: 0;padding: 0;" class="input ui-widget-content" 
										data-removeTitle='<s:text name="title.click2remove" />'>
										<span id="addChargers" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" style="" title='<s:text name="contract4Charger.title.click2selectCarMan"/>'></span>
										<s:if test="%{chargersInfoList != null && !chargersInfoList.isEmpty()}">
											<ul class="horizontal" style="padding: 0;overflow:hidden;">
											<s:iterator value="chargersInfoList">
											<li class="horizontal" style="position: relative;margin:0 2px;float: left;padding: 0;"
												data-id=<s:property value="['id']" /> >
											<span class="text"><a href="#" style="color: #1F1F1F;"><s:property value="['name']" /></a></span>
											<s:if test="!isReadonly()">
												<span class="click2remove verticalMiddle ui-icon ui-icon-close" style="margin: -8px -2px;" title='<s:text name="title.click2remove"/>'></span>
											</s:if>
											</li>
											</s:iterator>
											</ul>
										</s:if>	
									</div>
								</td>

<!-- ---------------------------------------------------------------------------------- -->							
							
								<td class="label">*<s:text name="contract.signDate"/>:</td>
								<td class="value" style="position:relative;display: block;">
									<input type="text" name="e.signDate" data-validate='{"type":"date","required":true}'
									value='<s:date format="yyyy-MM-dd" name="e.signDate" />'
									class="bc-date ui-widget-content" data-cfg='{changeYear:true,addYear: "0 0 0|e.startDate"}'/>
									<ul class="inputIcons">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.signDate' ></li>
									</ul>
								</td>
								<!-- 经办人
									<td class="label">*<s:text name="contract.transactor"/>:</td>
									<td class="value" style="position:relative;display: block;">
										<s:textfield name="e.transactorName" data-validate="required" readonly="true"	
										title='%{getText("contract.select.transactor")}' cssClass="ui-widget-content " />
										<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectTransactorName" ></span>
									</td>
								 -->
							</tr>
							<tr>
								<td class="label"><s:text name="contract.wordNo"/>:</td>
								<td class="value "><s:textfield name="e.wordNo" cssClass="ui-widget-content" /></td>
								<td class="label">*<s:text name="contract.deadline"/>:</td>
								<td class="value">
									<div style="position : relative; display: inline-block">
										&nbsp;从<input type="text" name="e.startDate" readonly="readonly" data-validate='{"type":"date","required":true}' 
											value='<s:date format="yyyy-MM-dd" name="e.startDate" />' 
											style="width: 7em;" class="bc-date ui-widget-content" />
											<ul class="inputIcons" style="right : 0px;">
												<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.startDate' ></li>
											</ul>
									</div>
									<div style="position : relative; display: inline-block">
										&nbsp;到<input type="text" name="e.endDate" readonly="readonly" data-validate='{"type":"date","required":true}'
											value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
											style="width: 7em;" class="bc-date ui-widget-content" />
											<ul class="inputIcons" style="right : 0px;">
												<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.endDate' ></li>
											</ul>
									</div>
								</td>
							</tr>
							<s:if test="%{e.status == 1}">
								<tr>
									<td class="label" ><s:text name="contract4Charger.contractVersionNo"/>:</td>
									<td class="value">
										<s:select name="e.contractVersionNo" list="contractVersionNoList" listKey="key" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
									</td>
									<td class="label"><s:text name="contract4Charger.stopDate"/>:</td>
									<td class="value" style="position:relative;display: block;">
										<input type="text" name="e.stopDate" data-validate='{"type":"date","required":false}'
										value='<s:date format="yyyy-MM-dd" name="e.stopDate" />'
										class="bc-date ui-widget-content" />
										<ul class="inputIcons">
											<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.stopDate' ></li>
										</ul>
									</td>
								</tr>
								<tr>
									<s:if test="%{scrapToPower}">
										<td class="label"><s:text name="contract4Charger.scrapTo"/>:</td>
										<td class="value">
											<s:select name="e.scrapTo" list="scrapToList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
										</td>
										<td class="label"><s:text name="contract4Charger.paymentDate"/>:</td>
										<td class="value">
											<s:select name="e.paymentDate" list="paymentDates" listKey="key" listValue="value" headerKey="" headerValue=""
											 cssClass="ui-widget-content"/>
										</td>
									</s:if>
									<s:else>
										<td class="label"><s:text name="contract4Charger.paymentDate"/>:</td>
										<td class="value">
											<s:select name="e.paymentDate" list="paymentDates" listKey="key" listValue="value" headerKey="" headerValue=""
											 cssClass="ui-widget-content"/>
										</td>
										<td></td>
										<td class="label" style="text-align: right;">
											<s:checkbox name="e.takebackOrigin" cssStyle="width:1em;"/>
											<s:text name="contract4Charger.takebackOrigin"/>
											<s:checkbox name="e.includeCost" cssStyle="width:1em;" />
											<s:text name="contract4Charger.includeCost"/>
										</td>
									</s:else>
								</tr>
								<tr>
								<s:if test="%{scrapToPower}">
									<td class="label">*<s:text name="contract4Charger.carMaintain"/>:</td>
									<td class="value">
										<s:select name="e.carMaintain" list="carMaintainList" listKey="value" listValue="value" 
											data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" ></s:select>
									</td>
									<td></td>
									<td class="label" style="text-align: right;">
										<s:checkbox name="e.takebackOrigin" cssStyle="width:1em;"/>
										<s:text name="contract4Charger.takebackOrigin"/>
										<s:checkbox name="e.includeCost" cssStyle="width:1em;" />
										<s:text name="contract4Charger.includeCost"/>
									</td>
								</s:if>
								<s:else>
									<td class="label">*<s:text name="contract4Charger.carMaintain"/>:</td>
									<td class="value">
										<s:select name="e.carMaintain" list="carMaintainList" listKey="value" listValue="value" 
											data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" ></s:select>
									</td>
								</s:else>
								</tr>
							</s:if>
							<s:else>
								<tr>
									<td class="label" ><s:text name="contract4Charger.contractVersionNo"/>:</td>
									<td class="value">
										<s:select name="e.contractVersionNo" list="contractVersionNoList" listKey="key" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
									</td>
									<td class="label"><s:text name="contract4Charger.paymentDate"/>:</td>
									<td class="value">
										<s:select name="e.paymentDate" list="paymentDates" listKey="key" listValue="value" headerKey="" headerValue=""
										 cssClass="ui-widget-content"/>
									</td>
								</tr>
								
								<tr>
									<s:if test="%{scrapToPower}">
										<td class="label"><s:text name="contract4Charger.scrapTo"/>:</td>
										<td class="value">
											<s:select name="e.scrapTo" list="scrapToList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
										</td>
									<td></td>
									<td class="label" style="text-align: right;">
										<s:checkbox name="e.takebackOrigin" cssStyle="width:1em;"/>
										<s:text name="contract4Charger.takebackOrigin"/>
										<s:checkbox name="e.includeCost" cssStyle="width:1em;" />
										<s:text name="contract4Charger.includeCost"/>
									</td>
									</s:if>
									<s:else>
									<td class="label">*<s:text name="contract4Charger.carMaintain"/>:</td>
									<td class="value">
										<s:select name="e.carMaintain" list="carMaintainList" listKey="value" listValue="value" 
											data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" ></s:select>
									</td>
									<td></td>
									<td class="label" style="text-align: right;">
										<s:checkbox name="e.takebackOrigin" cssStyle="width:1em;"/>
										<s:text name="contract4Charger.takebackOrigin"/>
										<s:checkbox name="e.includeCost" cssStyle="width:1em;" />
										<s:text name="contract4Charger.includeCost"/>
									</td>
									</s:else>
								</tr>
								<s:if test="%{scrapToPower}">
								<tr>
									<td class="label">*<s:text name="contract4Charger.carMaintain"/>:</td>
									<td class="value">
										<s:select name="e.carMaintain" list="carMaintainList" listKey="value" listValue="value" 
											data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" ></s:select>
									</td>
								</tr>
								</s:if>
							</s:else>
								<!--  <tr>
									<td class="label">*<s:text name="contract4Charger.carMaintain"/>:</td>
									<td class="value">
										<s:select name="e.carMaintain" list="carMaintainList" listKey="value" listValue="value" 
											data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" ></s:select>
									</td>
								</tr>-->
							<tr>
								<td class="label" colspan="4">
									<div class="formTopInfo">
										状态：<s:property value="%{statusesValue[e.status]}" />
										<s:if test="%{e.author.name != null}">
										，登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
										</s:if>
										<s:if test="%{e.modifier != null && e.status == 0}">
										，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
										</s:if>
										<s:if test="%{e.logoutId != null && e.status == 1}">
										，注销人：<s:property value="e.logoutId.name" />(<s:date name="e.logoutDate" format="yyyy-MM-dd HH:mm:ss"/>)
										</s:if>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 补充协议 -->
					<div class="formTable1 ui-widget-content"	style="width:100%;border-width:1px 1px 0 0;margin-bottom:8px;margin-bottom: 0;">
						<div class="ui-widget-header title" style="position:relative;border-width:0!important;">
							<span class="text" >补充协议:</span>
							<span id="showGroups1" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="runcase.title.click2HiddenGroups"/>'></span>
						</div>
						<div id="div1">
							<table class="formFields" cellspacing="2" cellpadding="0">
								<tbody>
									<tr class="widthMarker">
										<td >&nbsp;</td>
										<td style="width: 250px;">&nbsp;</td>
										<td style="width: 100px;">&nbsp;</td>
										<td style="width: 250px;">&nbsp;</td>
									</tr>
									<tr>
						    			<td class="label"><s:text name="contract4Charger.quitter"/>:</td>
										<td class="value">
											<s:select name="e.quitterId" list="quittersList" listKey="id" listValue="name" value="e.quitterId" 
												  headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
										</td>
										<td class="label"><s:text name="contract4Charger.agreement"/>:</td>
										<td class="value" style="position:relative;display: block;">
											<div style="position : relative; display: inline-block">
												&nbsp;从<input type="text" name="e.agreementStartDate" data-validate='{"type":"date","required":false}' 
													value='<s:date format="yyyy-MM-dd" name="e.agreementStartDate" />' 
													style="width: 7em;" class="bc-date ui-widget-content" />
													<ul class="inputIcons" style="right : 0px;">
														<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.agreementStartDate' ></li>
													</ul>
											</div>
											<div style="position : relative; display: inline-block">
												&nbsp;到<input type="text" name="e.agreementEndDate"  data-validate='{"type":"date","required":false}'
													value='<s:date format="yyyy-MM-dd" name="e.agreementEndDate" />'
													style="width: 7em;" class="bc-date ui-widget-content" />
													<ul class="inputIcons" style="right : 0px;">
														<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.agreementEndDate' ></li>
													</ul>
											</div>
										</td>
						    		</tr>
								</tbody>
							</table>
						</div>
					</div>

				<!-- 权限控制显示 -->
							
					<!-- 收费明细 -->
					<div class="ui-widget-content" style="border-width:1px 1px 0 0;margin-bottom:8px;width: 100%;">
						<div class="ui-widget-header title" style="position:relative;border-width:0!important;">
							<span class="text"><s:text name="contract.fee.detail"/>：</span>
							<ul class="inputIcons">
								<li id="upFeeTemplate" class="inputIcon ui-icon ui-icon-circle-arrow-n"
									title='<s:text name="title.up2selectFeeTemplate"/>'></li>
								<li id="downFeeTemplate" class="inputIcon ui-icon ui-icon-circle-arrow-s"
									title='<s:text name="title.down2selectFeeTemplate"/>'></li>
								<li id="selectFeeTemplate" class="inputIcon ui-icon ui-icon-circle-plus"
									title='<s:text name="title.click2selectFeeTemplate"/>'></li>
								<li id="deleteFeeTemplate" class="inputIcon ui-icon ui-icon-circle-close"
									title='<s:text name="title.click2deleteFeeTemplate"/>'></li>
							</ul>
						</div>
				    <!-- 经济合同管理员权限，经济合同收费明细查询、经济合同草稿录入权限 -->	
					<s:if test="%{!isReadonly()||isFeeDetailRead()||isEntering()}">
						<div class="bc-grid header">
						<table class="table" id="feeDetailTables" cellspacing="0" cellpadding="0" style="width: 100%">
							<tr class="widthMarker" style="height: 0;line-height:0;font-size: 0;border: none;margin: 0;padding: 0;">
								<td class="first" style="width: 15px;">&nbsp;</td>
								<td class="middle" style="width: 130px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 105px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 50px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 85px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 100px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 15px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 100px;text-align: center;">&nbsp;</td>
								<td class="last"style="text-align: center;">&nbsp;</td>
							</tr>
							<tr class="ui-state-default row">
								<td class="first" style="width: 15px;height: 20px;padding:0;text-align:left;" title="点击全选!"><span class="ui-icon ui-icon-notice"></span></td>
								<td class="middle" style="width: 130px;text-align: center;">项目</td>
								<td class="middle" style="width: 105px;text-align: center;">金额(元)</td>
								<td class="middle" style="width: 50px;text-align: center;">数量</td>
								<td class="middle" style="width: 85px;text-align: center;">收费方式</td>
								<td class="middle" style="border-right: 1px ;text-align: center;width: 215px;" colspan="3">收费期限</td>
								<td class="last"style="text-align: center;">备注</td>
							</tr>
							<s:iterator var="b" value="e.contractFeeDetail">
							<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
								<td class="id first" style="padding:0;text-align:left;" data-code='<s:property value="code"/>' data-spec='<s:property value="spec"/>'><span class="ui-icon"></span></td>
								<td class="middle" style="padding:0;text-align:left;width: 130px;">
								<s:if test="canCopy">
								<s:label style="width:90%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" readonly="readonly" 
										type="text" class="ui-widget-content" value='%{name}'/>
								</s:if>
								<s:else>
									<input style="width:90%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" readonly="readonly" 
										type="text" class="ui-widget-content" value='<s:property value="name"/>'/>
								</s:else>
								</td>
								<td class="middle" style="padding:0;text-align:left;width: 105px;">
								<s:if test="canCopy">
									<label style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" >
										<s:property value="%{getText('bs.format.numberRMB',{price})}"/>
									</label>
								</s:if>
								<s:else>
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;"type="text" class="ui-widget-content" 
										value='<s:property value="%{getText('bs.format.numberRMB',{price})}"/>' data-validate="required"/>
								</s:else>
								</td>
								<td class="middle" style="padding:0;text-align:left;width: 50px;">
								<s:if test="canCopy">
									<s:label style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
										value="%{getText(count)}"/>
								</s:if>
								<s:else>
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;"type="text" class="ui-widget-content" 
										value='<s:property value="%{getText(count)}"/>' data-validate='{"required":true,"type":"number","min":1}'/>
								</s:else>
								</td>
								<td class="middle" style="padding:0;text-align:left;width: 85px;">
								<s:if test="canCopy">
									<s:iterator value="payTypeList" id="item" >
										<s:if test="payType==key"><s:property value="value"/></s:if>
									</s:iterator>
								</s:if>
								<s:else>
									<s:select name="payType" list="payTypeList" listKey="key" listValue="value" data-validate="required"
										headerKey="" headerValue="" cssClass="ui-widget-content" cssStyle="border:none;"/>								</s:else>
								</td>
								<td class="middle" style="padding:0;text-align:left;border-right: 1px ;width: 100px;">
								<s:if test="canCopy"><s:date format="yyyy-MM-dd" name="startDate"/></s:if>
								<s:else>
									<div class="relative">
										<input type="text" name="startDate" data-validate='{"type":"date","required":false}' style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;"
										value='<s:date format="yyyy-MM-dd" name="startDate" />'
										class="bc-date ui-widget-content" />
										<ul class="inputIcons">
											<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
										</ul>
									</div>
								</s:else>
								</td>
								<td class="middle" style="padding:0;text-align:left;border-right: 1px ;border-left: 1px;width: 15px;">~</td>
								<td class="middle" style="padding:0;text-align:right;border-left: 1px;width: 100px;">
								<s:if test="canCopy"><s:date format="yyyy-MM-dd" name="endDate" /></s:if>
								<s:else>
									<div class="relative">
										<input type="text" name="endDate" data-validate='{"type":"date","required":false}' style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;"
										value='<s:date format="yyyy-MM-dd" name="endDate" />'
										class="bc-date ui-widget-content" />
										<ul class="inputIcons">
											<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
										</ul>
									</div>
								</s:else>
								</td>
								<td class="last" style="padding:0;text-align:left;">
								<s:if test="canCopy">
									<s:label style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
										 	value="%{description}"/>
								</s:if>
								<s:else>
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;"type="text" class="ui-widget-content"
										 value='<s:property value="description"/>'/>
								 </s:else>
								</td>
							</tr>
							</s:iterator>
						</table>
						</div>
					</s:if>
					<s:else>
						<div style="padding:0;margin:0;border-bottom:1px solid #CCC;">(无权限查看收费明细)</div>
					</s:else>
					</div>
				
					
					
				</div>
				</div>
				<div id="contractContents" class="content" >
					<div class="formEditor">
					<textarea name="e.content" class="bc-editor" style="width: 700px;height:230px"
						 data-ptype="contractCharger" data-puid='${e.uid}' 
						 data-readonly='${readonly}'>
						 ${e.content}
					</textarea>
					</div>
				</div>
				<div id="contractOldContents" class="content" >
					<div class="formEditor">
						<textarea name="e.oldContent" class="bc-editor" style="width: 700px;height:230px"
							 data-ptype="contractCharger" data-puid='${e.uid}' 
							 data-readonly='${readonly}'>
							 ${e.content}
						</textarea>
					</div>
				</div>
				<div id="attachment" class="content" >
					<s:property value="%{attachsUI}" escapeHtml="false"/>
				</div>
			</div>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.uid"/>
		<s:hidden name="e.type"/>
		<s:hidden name="carId" />
		<s:hidden name="assignChargerIds" />
		<s:hidden name="assignChargerNames" />
		<s:hidden name="e.status"/>
		<s:hidden name="e.pid"/>
		<s:hidden name="e.verMajor"/>
		<s:hidden name="e.verMinor"/>
		<s:hidden name="e.opType"/>
		<s:hidden name="e.patchNo"/>
		<s:hidden name="e.main"/>
		<s:hidden name="e.transactorId" />
		<s:hidden name="e.transactorName" />
		<s:hidden name="isExistContract"/>
		<s:hidden name="e.ext_str1"/>
		<s:hidden name="e.ext_str2"/>
		<s:hidden name="e.ext_str3"/>
		<s:hidden name="stopDate"/>
		<s:hidden name="feeDetails"/>
		<s:if test="%{!scrapToPower}">
			<s:hidden name="e.scrapTo"/>
		</s:if>
		<s:hidden name="isChange"/>
		<s:hidden name="oldContractId"/>
		<s:hidden name="contractFee4EndDate"/>
		<s:hidden name="contractFee4Price"/>
		<!-- 
		<s:hidden name="e.transactor.id" />
		<s:hidden name="e.changerId1" />
		<s:hidden name="e.changerName1" />
		<s:hidden name="e.changerId2" />
		<s:hidden name="e.changerName2" />
		 -->
		<input type="hidden" name="e.logoutDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.logoutDate" />'/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>