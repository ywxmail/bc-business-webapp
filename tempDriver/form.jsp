<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="tempDriver.title"/>' 
	data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/tempDriver/save" />'
	data-js='<s:url value="/bc-business/tempDriver/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/bc-business/spider/gztaxixh/driverInfo.css" />'
	data-initMethod='bs.tempDriverForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="tempDriverForm" theme="simple" cssClass="bc-form" >
		<div style="width:750px";>
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 4em;"></td>
							<td style="width: 16em;">&nbsp;</td>
							<td style="width: 6em;">&nbsp;</td>
							<td >&nbsp;</td>
							<td rowspan="9" style="text-align:center;vertical-align: top;width:16em;">
								<div style="position:relative;width:110px;height:140px;" >
									<img id="portrait" style="width:110px;height:140px;cursor: pointer;" title='<s:text name="image.click2change"/>'
									src='<s:url value="/bc/image/download?ptype=portrait"><s:param name='puid' value='e.uid'/><s:param name='ts' value='ts'/></s:url>'/>
								</div>
							</td>
						</tr>
						<!-- 姓名-->
						<tr>
							<td class="label">*<s:text name="tempDriver.name"/>:</td>
							<td class="value">
								<s:textfield name="e.name"  data-validate='{"required":true,"type":"string","msg":"必须填写姓名"}' cssClass="ui-widget-content"/>
							</td>
							<td class="label"><s:text name="tempDriver.birthdate"/>:</td>
							<td class="value relative">
								<input type="text" name="e.birthdate" data-validate='{"type":"date","required":false}'
								value='<s:date format="yyyy-MM-dd" name="e.birthdate" />'
								class="bc-date ui-widget-content"  />
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.birthdate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="tempDriver.region"/>:</td>
							<td class="value">
								<s:select list="#{'':'',1:'本市',2:'本省',3:'外省'}" listKey="key" listValue="value" cssClass="ui-widget-content" headerValue="" name="e.region" data-validate="required" ></s:select>
							</td>
							<td class="label"><s:text name="tempDriver.origin"/>:</td>
							<td class="value"><s:textfield name="e.origin" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="tempDriver.phone"/>:</td>
							<td class="value"><s:textfield name="e.phone" cssClass="ui-widget-content"/></td>
							<td class="label">*<s:text name="tempDriver.certIdentity"/>:</td>
							<td class="value"><s:textfield name="e.certIdentity" cssClass="ui-widget-content" data-validate="required"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="tempDriver.address"/>:</td>
							<td class="value" colspan="3"><s:textfield name="e.address" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="tempDriver.newAddress"/>:</td>
							<td class="value" colspan="3"><s:textfield name="e.newAddress" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="tempDriver.fwzg"/>:</td>
							<td class="value relative"><s:textfield name="e.certFWZG" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="tempDriver.cyzg"/>:</td>
							<td class="value relative"><s:textfield name="e.certCYZG" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="tempDriver.education"/>:</td>
							<td class="value"><s:textfield name="e.education" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="tempDriver.nation"/>:</td>
							<td class="value"><s:textfield name="e.nation" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="tempDriver.marry"/>:</td>
							<td class="value"><s:textfield name="e.marry" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label">*<s:text name="tempDriver.sex"/>:</td>
							<td class="value">
								<s:radio name="e.sex" list="#{'1':'男','2':'女'}" value="e.sex" cssStyle="width:auto;"/>
							</td>
							<td class="label">*状态:</td>
							<td class="value">
								<s:radio name="e.status" list="#{'0':'待聘','1':'审批中','2':'聘用','3':'弃用'}" 
									value="e.status" cssStyle="width:auto;"/>
							</td>
						</tr>
						<tr>
							<td class="label">过往一年:</td>
							<td colspan="4" class="value">
									交通违法<s:textfield name="e.caseTraffic" style="width: 2em;" 
										data-validate='{"type":"number"}' data-type="Long"/>宗，
									服务投诉<s:textfield name="e.casePraise" style="width: 2em;" 
										data-validate='{"type":"number"}' data-type="Long"/>宗，
									营运违章<s:textfield name="e.caseBusiness" style="width: 2em;" 
										data-validate='{"type":"number"}' data-type="Long"/>宗，
									事故<s:textfield name="e.caseAccident" style="width: 2em;" 
										data-validate='{"type":"number"}' data-type="Long"/>宗，
									获表扬 <s:textfield name="e.caseAdvice" style="width: 2em;" 
										data-validate='{"type":"number"}' data-type="Long"/>次。</td>
						</tr>
						<tr>
							<td class="topLabel" ><s:text name="tempDriver.desc"/>:</td>
							<td class="value" colspan="4"><s:textarea name="e.desc" rows="3" cssClass="ui-widget-content noresize"/></td>
						</tr>
						<tr >
							<td class="label" colspan="5">
								<div class="formTopInfo">
									登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
									<s:if test="%{e.modifier != null}">
									，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
									</s:if>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				
				
				
				<div  class="formTable2 ui-widget-content bs-tempDriver-containers"  style="width:740px;">
					<div class="ui-widget-header title" style="position:relative;">
						<span class="text" >工作经历:</span>
						<span class="bs-tempDriver-showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='<s:text name="展开"/>'></span>
						<span class="bs-tempDriver-hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="隐藏"/>'></span>
					</div>
					<div class="bs-tempDriver-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
						<table id="wes" class="table bc-grid" cellspacing="0" cellpadding="0" style="width:100%;" >
							<tr class="header row">
								<td class="first" style="width: 1em;">&nbsp;</td>
								<td class="middle" style="width: 15em;">起止日期</td>
								<td class="middle" style="width: 15em;">工作单位</td>
								<td class="middle" style="width: 6em;">证明人</td>
								<td class="last" style="min-width: 0.001em;position:relative;">
									电话
									<ul class="inputIcons">
										<li id="upLine_we" class="inputIcon ui-icon ui-icon-circle-arrow-n" title='上移选中项'></li>
										<li id="downLine_we" class="inputIcon ui-icon ui-icon-circle-arrow-s" title='下移选中项'></li>
										<li id="addLine_we" class="inputIcon ui-icon ui-icon-circle-plus" title='添加一条工作经历'></li>
										<li id="deleteLine_we" class="inputIcon ui-icon ui-icon-circle-close" title='删除一条工作经历'></li>
									</ul>
								</td>
							</tr>
							<s:iterator var="we" value="list_WorkExperience">
								<tr class="ui-widget-content row" >
									<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
									</td>
									<td class="middle"  style="padding:0;text-align:left;">
										<div class="relative" style="display:inline;">
											<input type="text" data-validate='{"type":"date"}' 
												style="width:7em;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" 
												class="bc-date ui-widget-content" value='<s:property value="startDate"/>' />
											<ul class="inputIcons">
												<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
											</ul>
										</div>
										<div style="width:1em;display:inline;">~</div>
										<div class="relative" style="display:inline;">
											<input type="text" data-validate='{"type":"date"}' 
												style="width:7em;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" 
												class="bc-date ui-widget-content" value='<s:property value="endDate"/>' />
											<ul class="inputIcons">
												<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
											</ul>
										</div>
									</td>
									<td class="middle" style="padding:0;text-align:left;">
										<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
											value='<s:property value="unit"/>'/>
									</td>
									<td class="middle" style="padding:0;text-align:left;">	
										<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
											 value='<s:property value="certifier"/>'/>
									</td>
									<td class="last" style="padding:0;text-align:left;">
										<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
											 value='<s:property value="phone"/>' />
									</td>
								</tr>
							</s:iterator>
						</table>
					</div>
				</div>
				
				<div  class="formTable2 ui-widget-content bs-tempDriver-containers"  style="width:740px;">
					<div class="ui-widget-header title" style="position:relative;">
						<span class="text" >家庭成员:</span>
						<span class="bs-tempDriver-showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='<s:text name="展开"/>'></span>
						<span class="bs-tempDriver-hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="隐藏"/>'></span>
					</div>
					<div class="bs-tempDriver-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
						<table id="fms" class="table bc-grid" cellspacing="0" cellpadding="0" style="width:100%;">
							<tr class="header row">
								<td class="first" style="width: 1em;">&nbsp;</td>
								<td class="middle" style="width: 15em;">姓名</td>
								<td class="middle" style="width: 15em;">关系</td>
								<td class="middle" style="width: 10em;">电话</td>
								<td class="last" style="position:relative;min-width: 0.001em;">备注
									<ul class="inputIcons">
										<li id="upLine_fm" class="inputIcon ui-icon ui-icon-circle-arrow-n" title='上移选中项'></li>
										<li id="downLine_fm" class="inputIcon ui-icon ui-icon-circle-arrow-s" title='下移选中项'></li>
										<li id="addLine_fm" class="inputIcon ui-icon ui-icon-circle-plus" title='添加一条家庭成员信息'></li>
										<li id="deleteLine_fm" class="inputIcon ui-icon ui-icon-circle-close" title='删除一条家庭成员信息'></li>
									</ul>
								</td>
							</tr>
							<s:iterator var="fm" value="list_Family">
								<tr class="ui-widget-content row" >
									<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
									</td>
									<td class="middle"  style="padding:0;text-align:left;">
										<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
											value='<s:property value="name"/>'/>
									</td>
									<td class="middle" style="padding:0;text-align:left;">
										<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
											value='<s:property value="relation"/>'/>
									</td>
									<td class="middle" style="padding:0;text-align:left;">	
										<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"  type="text" class="ui-widget-content"
											 value='<s:property value="phone"/>'/>
									</td>
									<td class="last" style="padding:0;text-align:left;">
										<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content"
											 value='<s:property value="desc"/>' />
									</td>
								</tr>
							</s:iterator>
						</table>
					</div>
				</div>
				
				<div  class="formTable2 ui-widget-content bs-tempDriver-containers"  style="width:740px;">
					<div class="ui-widget-header title" style="position:relative;">
						<span class="text" >入职流程信息区:</span>
						<span class="bs-tempDriver-showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='<s:text name="展开"/>'></span>
						<span class="bs-tempDriver-hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="隐藏"/>'></span>
					</div>
					<div class="bs-tempDriver-Groups" style="border-width:1px 1px 0 0;margin-bottom:8px;">
						<table id="tdwfs" class="table bc-grid" cellspacing="0" cellpadding="0" style="width:100%;">
							<tr class="header row">
								<td class="first" style="width: 16.5em;">发起时间</td>
								<td class="middle" style="width: 10em;"><s:text name="tempDriverWorkFlow.offerStatus"/></td>
								<td class="last" style="position:relative;min-width: 0.001em;">
									<ul class="inputIcons">
										<li id="startWorkFlow"  class="inputIcon ui-icon ui-icon-play" title='点击发起入职流程'></li>
									</ul>
								</td>
							</tr>
							<s:iterator var="tdf" value="e.tempDriverWorkFlowList">
								<tr class="ui-widget-content row bs-tempDriver-workFlow" >
									<td class="first"  style="padding:0;text-align:left;">
										<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 5px;background:none;" type="text" class="ui-widget-content" 
											readonly="readonly" value='<s:date format="yyyy-MM-dd HH:mm" name="startTime" />' />
										<input type="hidden" class="bs-tempDriver-workFlow-procInstId" value='<s:property value="procInstId"/>' />
									</td>
									<td class="middle" style="padding:0;text-align:left;padding-left:5px;">	
										<s:if test="%{offerStatus == 0}"><s:text name="tempDriverWorkFlow.offerStatus.check"/></s:if>
										<s:elseif test="%{offerStatus == 1}"><s:text name="tempDriverWorkFlow.offerStatus.pass"/></s:elseif>
										<s:elseif test="%{offerStatus == 2}"><s:text name="tempDriverWorkFlow.offerStatus.noPass"/></s:elseif>
									</td>
									<td class="last" style="padding:0;text-align:left;">
									</td>
								</tr>
							</s:iterator>
						</table>
					</div>
				</div>
				
				<div class="formTable2 ui-widget-content bs-tempDriver-containers"  style="width:740px;">
					<div class="ui-widget-header title" style="position:relative;">
						<span class="text" >信誉档案:</span>
						<span class="bs-tempDriver-showGroups verticalMiddle ui-icon ui-icon-carat-1-s" style="display:none;" title='<s:text name="展开"/>'></span>
						<span class="bs-tempDriver-hiddenGroups verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="隐藏"/>'></span>
					</div>
					<div class="bs-tempDriver-Groups bs-czxh" style="border-width:1px 1px 0 0;margin-bottom:8px;">
						<div id="header" style="position:relative;border-bottom:1px solid #CCC;" >
							&nbsp;<span id="waste"></span>
							<ul class="inputIcons" >
								 <li class="inputIcon ui-icon ui-icon-note toTaxiNet"
								  title="点击按钮，根据姓名更新信誉档案" id="selectCarManToTaxiNet4Name" ></li>
								 <li class="inputIcon ui-icon ui-icon-note toTaxiNet"
									title="点击按钮，根据服务资格证更新信誉档案" id="selectCarManToTaxiNet4FWZG" ></li>
								 <li class="inputIcon ui-icon ui-icon-note toTaxiNet"
									title="点击按钮，根据从业资格证更新信誉档案" id="selectCarManToTaxiNet4CYZG" ></li>
							</ul>
						</div>
						<div id="info" >
							 <s:if test="%{e.credit == null || e.credit == ''}">
							 	没有或未更新信誉档案信息。
							 </s:if><s:else>
							 	${e.credit}
							 </s:else>
						</div>
					</div>
				</div>
				
				<div style="height: 10px;">
				</div>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.uid" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.listWorkExperience" />
		<s:hidden name="e.listFamily" />
		<s:hidden name="e.picPath" />
		<s:hidden name="e.credit" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>