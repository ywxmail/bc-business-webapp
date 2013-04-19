<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="carPrepare.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/carPrepare/save" />'
	data-js='<s:url value="/bc-business/carPrepare/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bs.carPrepareForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carPrepareForm" theme="simple">
		<div class="formTable ui-widget-content bs-carPrepare-containers" style="width:668px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >旧车信息:</span>
				<ul class="inputIcons">
					<li class="updateCarInfo inputIcon ui-icon ui-icon-shuffle" title='更新车辆相关信息'></li>
					<li class="showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='展开'></li>
					<li class="hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='隐藏'></li>
				</ul>
			</div>
			<div class="bs-carPrepare-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 15%;"></td>
							<td style="width: 35%;">&nbsp;</td>
							<td style="width: 15%;">&nbsp;</td>
							<td style="width: 35%;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carPrepare.plate"/>:</td>
							<td class="value"><s:textfield name="e.C1PlateType" cssStyle="width:18%;text-align:right;border-right-width:0;padding-right:2px;" data-validate="required" cssClass="ui-widget-content"/>
								<s:textfield name="e.C1PlateNo" cssStyle="width:81%;padding-left:2px;margin-left:-4px;" data-validate='{"minLen": 5,"maxLen": 5,"required":true,"type":"string",msg:"必须填写正确格式的5位车牌号，如J1B23"}' cssClass="ui-widget-content"/>
							</td>
							<td class="label"><s:text name="carPrepare.C1BsType"/>:</td>
							<td class="value">
								<s:select name="e.C1BsType" list="businessTypeList" listKey="value" listValue="value" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carPrepare.code"/>:</td>
							<td class="value relative">
									<s:textfield name="e.code" cssClass="ui-widget-content" readonly="true"/>
									<ul class="inputIcons">
										<li id="selectCertNo2" class="inputIcon ui-icon ui-icon-circle-plus" title='点击选择经营权证' >
									</ul>
							<!--<s:textfield name="e.code" data-validate="required" cssClass="ui-widget-content"/>-->
							</td>
							<td class="label"><s:text name="carPrepare.C1Scrapto"/>:</td>
							<td class="value ">
								<s:select name="e.C1Scrapto" list="scrapToList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
							</td>
						</tr>
						<tr>
							<td style="font-size: 80%;" class="label">*<s:text name="carPrepare.planDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.planDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.planDate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.planDate'></li>
								</ul>
							</td>
							<td class="label"><s:text name="carPrepare.C1RegisterDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.C1RegisterDate" data-validate='{"type":"date","required":false}'
								value='<s:date format="yyyy-MM-dd" name="e.C1RegisterDate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.C1RegisterDate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carPrepare.company"/>:</td>
							<td class="value relative">
								<div>
									<input type="text" name="e.C1Company" value='<s:property value="e.C1Company"/>' style="text-align:left;" 
										class="ui-widget-content" data-validate="required"
										data-maxHeight="150px"
										data-source='<s:property value="companyNames"/>'/>
									<ul class="inputIcons">
										<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
									</ul>
								</div>
							</td>
							<td class="label"><s:text name="carPrepare.C1ContractEndDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.C1ContractEndDate" data-validate='{"type":"date","required":false}'
								value='<s:date format="yyyy-MM-dd" name="e.C1ContractEndDate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.C1ContractEndDate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="carPrepare.motorcade"/>:</td>
							<td class="value ">
								<s:select name="e.C1Motorcade" list="motorcadeList" listKey="key" listValue="value" value="e.C1Motorcade" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content"></s:select>
							</td>
							<td class="label"><s:text name="carPrepare.C1GreenslipEndDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.C1GreenslipEndDate" data-validate='{"type":"date","required":false}'
								value='<s:date format="yyyy-MM-dd" name="e.C1GreenslipEndDate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.C1GreenslipEndDate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="carPrepare.status" />:</td>
							<td><s:radio name="e.status" list="#{'0':'待更新','1':'更新中','2':'已完成'}" value="e.status" cssStyle="width:auto;"/></td>
							<td class="label"><s:text name="carPrepare.C1CommeriaEndDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.C1CommeriaEndDate" data-validate='{"type":"date","required":false}'
								value='<s:date format="yyyy-MM-dd" name="e.C1CommeriaEndDate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.C1CommeriaEndDate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label" colspan="4">
								<div class="formTopInfo">
									<s:if test="%{e.author != null}">
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
			</div>
		</div>
		<div class="formTable ui-widget-content bs-carPrepare-containers" style="width:668px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >新车安排:</span>
				<ul class="inputIcons">
					<!--<li id="createDraftCar" class="inputIcon ui-icon ui-icon-document" title='<s:text name="title.createDraftCar"/>'></li>-->
					<li id="startCarActive" class="inputIcon ui-icon ui-icon-circle-triangle-e" title='<s:text name="title.startCarActive"/>'></li>
					<li class="showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='展开'></li>
					<li class="hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='隐藏'></li>
				</ul>
			</div>
			<div class="bs-carPrepare-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 15%;"></td>
							<td style="width: 35%;">&nbsp;</td>
							<td style="width: 15%;">&nbsp;</td>
							<td style="width: 35%;">&nbsp;</td>
						</tr>
						<tr>
							<td class="label"><s:text name="carPrepare.plate"/>:</td>
							<td class="value"><s:textfield name="e.C2PlateType" cssStyle="width:18%;text-align:right;border-right-width:0;padding-right:2px;" data-validate="required" cssClass="ui-widget-content"/>
								<s:textfield name="e.C2PlateNo" cssStyle="width:81%;padding-left:2px;margin-left:-4px;" data-validate='{"minLen": 5,"maxLen": 5,"required":true,"type":"string",msg:"必须填写正确格式的5位车牌号，如J1B23"}' cssClass="ui-widget-content"/>
							</td>
							<td class="label"><s:text name="carPrepare.C2Indicator"/>:</td>
							<td class="value "><s:textfield name="e.C2Indicator" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carPrepare.company"/>:</td>
							<td class="value">
								<s:select name="e.C2Company" list="companyList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" data-validate="required"></s:select>
							</td>
							<td class="label"><s:text name="car.vin"/>:</td>
							<td class="value ">
									<s:select name="e.C2CarId" list="carVinList" listKey="key" listValue="value" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" data-validate="required"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="carPrepare.branch"/>:</td>
							<td class="value">
								<s:select name="e.C2Branch" list="unitsList" listKey="id" listValue="name" headerKey="" headerValue="" cssClass="ui-widget-content" data-validate="required"></s:select>
							</td>
							<td class="label"><s:text name="car.code"/>:</td>
							<td class="value"><s:textfield name="e.C2CarCode" cssClass="ui-widget-content" data-validate="required"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carPrepare.motorcade"/>:</td>
							<td class="value ">
								<s:select name="e.C2Motorcade" list="motorcadeList" listKey="key" listValue="value" value="e.C2Motorcade" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" data-validate="required"></s:select>
							</td>
							<td class="label"><s:text name="car.manageNo"/>:</td>
							<td class="value"><s:textfield name="e.C2ManageNo" data-validate='{"required":true,"type":"digits","max":4599,"min":1101,msg:"管理号必须填写1101~4599！"}' cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.bstype"/>:</td>
							<td class="value ">
									<s:select name="e.C2BsType" list="businessTypeList" listKey="value" listValue="value" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" data-validate="required"></s:select>
							</td>
							<td class="label"><s:text name="carPrepare.carActiveType"/>:</td>
							<td class="value ">
								<s:select name="e.C2CarActiveType" list="{'','新车','重发包','变更','迁入'}" cssClass="ui-widget-content" data-validate="required"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="carPrepare.C2Driver1"/>:</td>
							<td class="value ">
								<div style="position:relative;">
									<s:textfield name="e.C2Driver1" readonly="readonly" cssClass="ui-widget-content" data-validate="required"/>
									<ul class="inputIcons">
										<li id="addC2Driver1" style="position:absolute;top:50%;width:16px;height:16px;right:15px;cursor:pointer;" class="inputIcon ui-icon ui-icon-circle-plus" title='选择司机'/>
									</ul>
									<ul class="inputIcons">
										<li id="clearC2Driver1" class="inputIcon ui-icon ui-icon-circle-close" title='删除司机'/>
									</ul>
								</div>
							</td>
							<td class="label"><s:text name="carPrepare.C2Driver2"/>:</td>
							<td class="value ">
								<div style="position:relative;">
									<s:textfield name="e.C2Driver2" readonly="readonly" cssClass="ui-widget-content" data-validate="required"/>
									<ul class="inputIcons">
										<li id="addC2Driver2" style="position:absolute;top:50%;width:16px;height:16px;right:15px;cursor:pointer;" class="inputIcon ui-icon ui-icon-circle-plus" title='选择司机'/>
									</ul>
									<ul class="inputIcons">
										<li id="clearC2Driver2" class="inputIcon ui-icon ui-icon-circle-close" title='删除司机'/>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="carPrepare.C2CertFWZG4Driver"/>:</td>
							<td class="value"><s:textfield name="e.C2CertFWZG4Driver1" data-validate='{"minLen": 6,"maxLen": 7,"required":true,"type":"string"}' cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="carPrepare.C2CertFWZG4Driver"/>:</td>
							<td class="value"><s:textfield name="e.C2CertFWZG4Driver2" data-validate='{"minLen": 6,"maxLen": 7,"required":true,"type":"string"}' cssClass="ui-widget-content" /></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carPrepare.C2Nature4Driver"/>:</td>
							<td class="value ">
								<s:select name="e.C2Nature4Driver1" list="{'责任人','非责任人'}" cssClass="ui-widget-content" data-validate="required"></s:select>
							</td>
							<td class="label"><s:text name="carPrepare.C2Nature4Driver"/>:</td>
							<td class="value ">
								<s:select name="e.C2Nature4Driver2" list="{'责任人','非责任人'}" cssClass="ui-widget-content" data-validate="required"></s:select>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 更新进度信息 -->
		<div class="formTable2 ui-widget-content bs-carPrepare-containers" style="border-width:1px 1px 0 1px;margin-bottom:8px;width: 668px;">
			<div class="ui-widget-header title" style="position:relative;border-width:0!important;">
				<span class="text">更新进度信息：</span>
				<ul class="inputIcons">
					<li id="upCarPrepareItem" class="inputIcon ui-icon ui-icon-circle-arrow-n"
						title='<s:text name="title.upCarPrepareItem"/>'></li>
					<li id="downCarPrepareItem" class="inputIcon ui-icon ui-icon-circle-arrow-s"
						title='<s:text name="title.downCarPrepareItem"/>'></li>
					<li id="addCarPrepareItem" class="inputIcon ui-icon ui-icon-circle-plus"
						title='<s:text name="title.addCarPrepareItem"/>'></li>
					<li id="deleteCarPrepareItem" class="inputIcon ui-icon ui-icon-circle-close"
						title='<s:text name="title.deleteCarPrepareItem"/>'></li>
					<li class="showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='展开'></li>
					<li class="hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='隐藏'></li>
				</ul>
			</div>
			<div class="bs-carPrepare-Groups bc-grid header">
			<table class="table" id="carPrepareItemTables" cellspacing="0" cellpadding="0" style="width: 100%">
				<tr class="widthMarker" style="height: 0;line-height:0;font-size: 0;border: none;margin: 0;padding: 0;">
					<td class="first" style="width: 15px;">&nbsp;</td>
					<td class="middle" style="width: 130px;text-align: center;">&nbsp;</td>
					<td class="middle" style="width: 110px;text-align: center;">&nbsp;</td>
					<td class="middle" style="width: 150px;text-align: center;">&nbsp;</td>
					<td class="last"style="text-align: center;">&nbsp;</td>
				</tr>
				<tr class="ui-state-default row">
					<td class="first" style="width: 15px;height: 20px;padding:0;text-align:left;" title="点击全选!"><span class="ui-icon ui-icon-notice"></span></td>
					<td class="middle" style="width: 130px;text-align: center;">项目</td>
					<td class="middle" style="width: 105px;text-align: center;">更新日期</td>
					<td class="middle" style="width: 50px;text-align: center;">状态</td>
					<td class="last"style="text-align: center;">备注</td>
				</tr>
				<s:iterator var="b" value="e.carPrepareItem">
				<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
					<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span></td>
					<td class="middle" style="padding:0;text-align:left;width: 130px;">
						<input name="name" style="width:90%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" readonly="readonly" 
							type="text" class="ui-widget-content" value='<s:property value="name"/>'/>
					</td>
					<td class="middle" style="padding:0;text-align:left;border-right: 1px ;width: 100px;">
						<div class="relative">
							<input type="text" name="date" data-validate='{"type":"date","required":false}' style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;"
							value='<s:date format="yyyy-MM-dd" name="date" />'
							class="bc-date ui-widget-content" />
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							</ul>
						</div>
					</td>
					<td class="middle" style="padding:0;text-align:left;width: 105px;">
						<s:radio name="%{'status'+order}" list="#{'0':'未完成','1':'已完成'}" value="status" cssStyle="width:auto;"/>					
					</td>
					<td class="last" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;"type="text" class="ui-widget-content"
							 value='<s:property value="desc"/>'/>
					</td>
				</tr>
				</s:iterator>
			</table>
			</div>
		</div>
		<!--<s:if test="%{!isReadonly()}">-->
			<div class="formTable2 ui-widget-content bs-carPrepare-containers"  style="width:668px;">
				<div class="ui-widget-header title" style="position:relative;">
					<span class="text" >流程信息区:</span>
					<ul class="inputIcons">
						<li class="showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='展开'></li>
						<li class="hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='隐藏'></li>
					</ul>
				</div>
				<div class="bs-carPrepare-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
					<table class="table bc-grid" cellspacing="0" cellpadding="0" style="width:100%;">
						<tr class="header row">
							<td class="first" style="width: 12em;">名称</td>
							<td class="middle" style="width: 10em;">主题</td>
							<td class="middle" style="width: 9em;">发起时间</td>
							<td class="middle" style="width: 9em;">结束时间</td>
							<td class="last" style="min-width: 0.001em;">流程状态</td>
						</tr>
						<s:iterator var="wr" value="workflowModuleRelations">
							<tr class="ui-widget-content row" >
								<td class="first"  style="padding:0 0 0 4px;text-align:left;">
									<a class="bs-caseTraffic-workFlow-processName" href="#"><s:property value="name"/></a>
									<input type="hidden" class="bs-caseTraffic-workFlow-procInstId" value='<s:property value="pid"/>' />
								</td>
								<td class="middle"  style="padding:0 0 0 4px;text-align:left;" title='<s:property value="subject"/>'>
									<s:property value="subject"/>
								</td>
								<td class="middle"  style="padding:0 0 0 4px;text-align:left;">
									<s:property value="startTime"/>
								</td>
								<td class="middle"  style="padding:0 0 0 4px;text-align:left;">
									<s:property value="endTime"/>
								</td>
								<td class="last" style="padding:0 0 0 4px;text-align:left;">	
									<s:if test="%{status == 1}">流转中</s:if>
									<s:elseif test="%{status == 2}">已暂停</s:elseif>
									<s:elseif test="%{status == 3}">已结束</s:elseif>
								</td>
							</tr>
						</s:iterator>
					</table>
				</div>
			</div>
<!--  		</s:if>-->
		<%-- 
		<div  class="formTable ui-widget-content bs-caseTraffic-containers" style="width:668px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >附件:</span>
				<ul class="inputIcons">
					<li class="showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='展开'></li>
					<li class="hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='隐藏'></li>
				</ul>
			</div>
			<div class="bs-caseTraffic-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
				<s:property value="%{attachsUI}" escapeHtml="false"/>
			</div>
		</div>
		--%>
		<s:hidden name="e.id" />
		<s:hidden name="e.C2Driver1Id" />
		<s:hidden name="e.C2Driver2Id" />
		<s:hidden name="e.uid" />
		<s:hidden name="e.C2Vin" />
		<s:hidden name="e.author.id" />
		<s:hidden name="carPrepareItems" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>