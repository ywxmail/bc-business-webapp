<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="carPrepare.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/carPrepare/save" />'
	data-js='<s:url value="/bc-business/carPrepare/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.carPrepareForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carPrepareForm" theme="simple">
		<div class="formTable ui-widget-content bs-carPrepare-containers" style="width:668px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >旧车信息:</span>
				<ul class="inputIcons">
					<li class="showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='展开'></li>
					<li class="hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='隐藏'></li>
				</ul>
			</div>
			<div class="bs-carPrepare-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 9em;"></td>
							<td style="width: 16em;">&nbsp;</td>
							<td style="width: 9em;">&nbsp;</td>
							<td >&nbsp;</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carPrepare.plate"/>:</td>
							<td class="value"><s:textfield name="e.C1PlateType" cssStyle="width:18%;text-align:right;border-right-width:0;padding-right:2px;" data-validate="required" cssClass="ui-widget-content"/>
								<s:textfield name="e.C1PlateNo" cssStyle="width:81%;padding-left:2px;margin-left:-4px;" data-validate='{"minLen": 5,"maxLen": 5,"required":true,"type":"string",msg:"必须填写正确格式的5位车牌号，如J1B23"}' cssClass="ui-widget-content"/>
							</td>
							<td class="label">*<s:text name="carPrepare.C1BsType"/>:</td>
							<td class="value">
								<s:select name="e.C1BsType" list="businessTypeList" listKey="value" listValue="value" data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carPrepare.code"/>:</td>
							<td class="value "><s:textfield name="e.code" data-validate="required" cssClass="ui-widget-content"/></td>
							<td class="label">*<s:text name="carPrepare.C1Scrapto"/>:</td>
							<td class="value ">
								<s:select name="e.C1Scrapto" list="scrapToList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carPrepare.planDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.planDate" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.planDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.planDate'></li>
								</ul>
							</td>
							<td class="label">*<s:text name="carPrepare.C1RegisterDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.C1RegisterDate" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.C1RegisterDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.C1RegisterDate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carPrepare.company"/>:</td>
							<td class="value">
								<s:select name="e.C1Company" list="companyList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
							</td>
							<td class="label">*<s:text name="carPrepare.C1ContractEndDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.C1ContractEndDate" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.C1ContractEndDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.C1ContractEndDate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carPrepare.motorcade"/>:</td>
							<td class="value ">
								<s:select name="e.C1Motorcade" list="motorcadeList" listKey="key" listValue="value" value="e.motorcade.id" data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" disabled="%{!e.isNew()&&e.status!=-1}"></s:select>
							</td>
							<td class="label">*<s:text name="carPrepare.C1GreenslipEndDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.C1GreenslipEndDate" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.C1GreenslipEndDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.C1GreenslipEndDate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="carPrepare.status" />:</td>
							<td><s:radio name="e.status" list="#{'0':'待更新','1':'更新中','2':'已完成'}" value="e.status" cssStyle="width:auto;"/></td>
							<td class="label">*<s:text name="carPrepare.C1CommeriaEndDate"/>:</td>
							<td class="value" style="position:relative;display: block;">
								<input type="text" name="e.C1CommeriaEndDate" data-validate='{"type":"datetime","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.C1CommeriaEndDate" />'
								class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
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
					<li class="showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='展开'></li>
					<li class="hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='隐藏'></li>
				</ul>
			</div>
			<div class="bs-carPrepare-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 9em;"></td>
							<td style="width: 16em;">&nbsp;</td>
							<td style="width: 9em;">&nbsp;</td>
							<td >&nbsp;</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carPrepare.C2Indicator"/>:</td>
							<td class="value "><s:textfield name="e.C2Indicator" data-validate="required" cssClass="ui-widget-content"/></td>
							<td class="label">*<s:text name="carPrepare.company"/>:</td>
							<td class="value">
								<s:select name="e.C2Company" list="companyList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carPrepare.plate"/>:</td>
							<td class="value"><s:textfield name="e.C2PlateType" cssStyle="width:18%;text-align:right;border-right-width:0;padding-right:2px;" data-validate="required" cssClass="ui-widget-content"/>
								<s:textfield name="e.C2PlateNo" cssStyle="width:81%;padding-left:2px;margin-left:-4px;" data-validate='{"minLen": 5,"maxLen": 5,"required":true,"type":"string",msg:"必须填写正确格式的5位车牌号，如J1B23"}' cssClass="ui-widget-content"/>
							</td>
							<td class="label">*<s:text name="carPrepare.branch"/>:</td>
							<td class="value">
								<s:select name="e.C2Branch" list="unitsList" listKey="name" listValue="name" headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
							</td>
						</tr>
						<tr>
							<td class="label">&nbsp;</td>
							<td class="value">&nbsp;</td>
							<td class="label">*<s:text name="carPrepare.motorcade"/>:</td>
							<td class="value ">
								<s:select name="e.C2Motorcade" list="motorcadeList" listKey="key" listValue="value" value="e.motorcade.id" data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" disabled="%{!e.isNew()&&e.status!=-1}"></s:select>
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
		</div>
		<s:if test="%{!isReadonly()}">
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
						<s:iterator var="wr" value="carTrafficHandleFlowList">
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
		</s:if>
		
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
		
		
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.motorcadeName" />
		<s:hidden name="e.carId" />
		<s:hidden name="e.driverId" />
		<s:hidden name="e.closerId" />
		<s:hidden name="e.closerName" />
		<s:hidden name="e.status" />
		<s:hidden name="e.syncUid" />
		<s:hidden name="e.syncId" />
		<s:hidden name="isMoreCar" />
		<s:hidden name="isMoreCarMan" />
		<s:hidden name="carId" />
		<s:hidden name="carManId" />
		<s:hidden name="isNullCarMan" />
		<s:hidden name="isNullCar" />
		<s:hidden name="isSync" />
		<s:hidden name="syncId" />
		<s:hidden name="e.source"/>
		<s:hidden name="e.charger"/>
		<s:hidden name="e.company"/>
		<!-- <s:hidden name="isExist" /> -->
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>