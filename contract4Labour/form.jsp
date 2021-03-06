<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="contract4Labour.title"/> - v<s:property value="e.verMajor" />.<s:property value="e.verMinor" />' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/contract4Labour/save" />'
	data-js='js:editor,js:bc_identity,<s:url value="/bc/template/template.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/bc-business/contract4Labour/form.js" />,<s:url value="/bc/placeOrigin/placeOrigin.js"/>'
	data-initMethod='bc.contract4LabourForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow:hidden;">
	<s:form name="contract4LabourForm" theme="simple" cssClass="bc-form">
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset" 
			data-cfg="{height:403}" style="overflow: hidden;">
			<div class="tabsContainer">
           	 	<div class="slideContainer">
					<ul class="tabs ui-helper-reset">
						<li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">基本信息</a></li>
						<s:if test="!isReadonly()||isEntering()">
							<li class="tab ui-widget-content"><a href='#attachment' class="ui-state-default">合同附件</a></li>
							<li class="tab ui-widget-content"><a href="#contractContents" class="ui-state-default">合同内容</a></li>
						</s:if>
						<s:if test="!e.isNew()">
							<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/injurys/list?contractId=%{e.id}" />' class="ui-state-default">工伤</a></li>
						
						<!--  业务更改
							<s:if test="e.main == 0">
								<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/contract4Labours/list?contractId=%{(e.pid != null)?e.pid:0}&patchNo=%{e.patchNo}"/>' class="ui-state-default">历史版本</a></li>
							</s:if>
						-->
							<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/contract4Labours/list?contractId=0&driverId=%{driverId}"/>' class="ui-state-default">历史版本</a></li>
						</s:if>
					</ul>
				</div>
			</div>
			<div class="contentContainer ui-helper-reset ui-widget-content noBottomBorder">
				<div id="otherFormFields" class="content active" >
				<div style="width:720px">
					<table class="formFields" cellspacing="2" cellpadding="0">
						<tbody>
							<tr class="widthMarker">
								<td >&nbsp;</td>
								<td style="width: 200px;">&nbsp;</td>
								<td style="width: 80px;">&nbsp;</td>
								<td style="width: 200px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="value" colspan="4">
								    <fieldset class="ui-widget-content">
								    	<legend>合同信息</legend>
								        <table class="formFields" cellspacing="2" cellpadding="0">
											<tr class="widthMarker">
												<td >&nbsp;</td>
												<td style="width: 200px;">&nbsp;</td>
												<td style="width: 80px;">&nbsp;</td>
												<td style="width: 220px;">&nbsp;</td>
											</tr>
											<tr>
												<td class="label">*<s:text name="contract.code"/>:</td>
												<td class="value"><s:textfield name="e.code" data-validate="required" readonly="true" cssClass="ui-widget-content" /></td>
												<td class="label">*<s:text name="contract.deadline"/>:</td>
												<td class="value">
												<div style="position : relative; display: inline-block">
													&nbsp;从<input type="text" name="e.startDate" readonly="readonly" data-validate='{"type":"date","required":true}' 
														value='<s:date format="yyyy-MM-dd" name="e.startDate" />' 
														style="width: 7em;" class="bc-date ui-widget-content"/>
														<ul class="inputIcons" style="right : 0px;">
															<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.startDate' ></li>
														</ul>
												</div>
												<div style="position : relative; display: inline-block">
													&nbsp;到<input type="text" name="e.endDate" readonly="readonly" data-validate='{"type":"date","required":true}'
														value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
														style="width: 7em;" class="bc-date ui-widget-content"/>
														<ul class="inputIcons" style="right : 0px;">
															<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.endDate' ></li>
														</ul>
												</div>
												</td>
											</tr>
											<tr>
												<s:if test="%{e.status == 1}">
													<td class="label"><s:text name="contract4Charger.stopDate"/>:</td>
													<td class="value" style="position:relative;display: block;">
														<input type="text" name="e.stopDate" data-validate='{"type":"date","required":false}'
														value='<s:date format="yyyy-MM-dd" name="e.stopDate" />'
														class="bc-date ui-widget-content" />
														<ul class="inputIcons">
															<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.stopDate' ></li>
														</ul>
													</td>
												</s:if>
											</tr>
								        </table>
								   </fieldset>
								</td>
							</tr>
							<tr>
								<td class="value" colspan="4">
									<fieldset class="ui-widget-content">
						          		<legend>司机车辆信息</legend>
						          		<table class="formFields" cellspacing="2" cellpadding="0" >
											<tr class="widthMarker">
												<td >&nbsp;</td>
												<td style="width: 200px;">&nbsp;</td>
												<td style="width: 80px;">&nbsp;</td>
												<td style="width: 220px;">&nbsp;</td>
											</tr>
											<tr>
												<td class="label">*<s:text name="contract.car" />:</td>
												 <!--  <td class="value relative">
												 	<s:textfield name="e.ext_str1" data-validate="required" readonly="true" cssClass="ui-widget-content " />
												 	<ul class="inputIcons">
												 		<li class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="contract.title.click2selectCar"/>' id="selectCarPlate">
												 	</ul>
												 </td>-->
												<td class="value relative">
													<div class="input ui-widget-content" data-validate="required" ><span class="link showCar" data-cfg='<s:property value="carId" />' id="carInfo" ><s:property value="%{e.ext_str1}" /></span>
													</div>
											    <span id="selectCarPlate" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" style="margin: -8px 5px;" title='<s:text name="title.click2select"/>'></span>
											    </td> 
												 
												<td class="label"><s:text name="contract4Labour.registerDate"/>:</td>
												<td class="value">
													<input type="text" name="registerDate" class="ui-widget-content nostyle"
													value='<s:date format="yyyy-MM-dd" name="registerDate" />'  readonly="readonly" />
												</td>
											</tr>
											<tr>
												<td class="label">*<s:text name="contract4Labour.driver"/>:</td>
												<td class="value relative">
													<div style="position:relative;display: inline-block">
													    <!--
													 		<s:textfield name="e.ext_str2" data-validate="required" readonly="true" cssStyle="width:6.5em;" cssClass="ui-widget-content " />
															<ul class="inputIcons">
														 		<li class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="contract.title.click2selectCarMan"/>' id="selectDriverName">
														 	</ul>-->
													      <div style="width:6.5em;" class="input ui-widget-content" data-validate="required" ><span class="link showCarMan" data-cfg='<s:property value="driverId"/>' id="carManInfo" ><s:property value="%{e.ext_str2}" /></span>
													      </div>
													      <ul class="inputIcons">
													        <li  id="selectDriverName" class="selectButton inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>' data-cfg='e.driver.id=id,carManInfo=name|text'></li>
													      </ul>
														 	
													 	<!--
													 		<s:textfield name="e.ext_str2" data-validate="required" readonly="true" cssStyle="width:6.5em;" cssClass="ui-widget-content" />
													 	-->
													 </div>
													<s:radio name="e.sex" list="#{'1':'男','2':'女'}" 
													value="e.sex" cssStyle="width:auto;"/>
												</td>
												<td class="label" ><s:text name="contract4Labour.bsType"/>:</td>
												<td class="value" >
													<s:textfield name="bsType" readonly="true" cssClass="ui-widget-content nostyle" readonly="true" />
												</td>
											</tr>
											<tr>
												<td class="label"><s:text name="contract4Labour.certNo"/>:</td>
												<td class="value">
													<s:textfield name="certNo" data-validate="required" cssClass="ui-widget-content" readonly="true" />
												</td>
												<td class="label"><s:text name="contract4Labour.certIdentity"/>:</td>
												<td class="value">
												 	<s:textfield name="certIdentity" cssClass="ui-widget-content nostyle" readonly="true"/>
												</td>
											</tr>
											<tr>
												<td class="label" >*<s:text name="contract4Labour.houseType"/>:</td>
												<td class="value" >
													<s:select name="e.houseType" list="houseTypeList" listKey="value" listValue="value" headerKey="" headerValue="" headerValue="%{getText('label.please.choose')}" data-validate="required" cssClass="ui-widget-content "></s:select>
												</td>
												<td class="label"><s:text name="contract4Labour.birthDate"/>:</td>
												<td class="value" style="position:relative;display: block;">
													<input type="text" name="birthDate"value='<s:date format="yyyy-MM-dd" name="birthDate" />'
													 readonly="readonly" class="ui-widget-content nostyle"/>
												</td>
											</tr>
											<tr>
												<td class="label"><s:text name="contract4Labour.region"/>:</td>
												<td class="value"><s:select list="#{0:'',1:'本市',2:'本省',3:'外省'}" listKey="key" listValue="value"  cssClass="ui-widget-content" headerValue="" name="e.region" /></td>
												<td class="label"><s:text name="contract4Labour.origin"/>:</td>
												<td class="value">
												 	<s:textfield name="origin" cssClass="ui-widget-content nostyle" readonly="true"/>
												</td>	
											</tr>
											<tr>
												<td class="label" ><s:text name="contract4Labour.domicilePlace"/>:</td>
												<td class="value relative">
												 	<s:textfield name="e.domicilePlace"  cssClass="ui-widget-content " />
												 	<ul class="inputIcons">
												 		<li class="inputIcon ui-icon ui-icon-circle-plus" title='点击选择户口所在地' id="selectArea">
												 	</ul>
												</td>
												<td class="label"><s:text name="contract4Labour.culturalDegree"/>:</td>
												<td class="value">
													<s:select name="e.culturalDegree" list="culturalDegreeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content "></s:select>
												</td>											
											</tr>
											<tr>
												<td class="label"><s:text name="contract4Labour.maritalStatus"/>:</td>
												<td class="value">
													<s:select name="e.maritalStatus" list="maritalStatusList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content "></s:select>
												<td class="label"><s:text name="contract4Labour.leaveDate"/>:</td>
												<td class="value" style="position:relative;display: block;">
													<input type="text" name="e.leaveDate" data-validate='{"type":"date"}'
													value='<s:date format="yyyy-MM-dd" name="e.leaveDate" />'
													class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
													<ul class="inputIcons">
														<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.leaveDate' ></li>
													</ul>
												</td>
											</tr>
						        		</table>
						    		</fieldset>
						    	</td>
							</tr>
							<tr>
								<td class="value" colspan="4">
									<fieldset class="ui-widget-content">
						          		<legend>社保信息</legend>
						          		<table class="formFields" cellspacing="2" cellpadding="0">
											<tr class="widthMarker">
												<td >&nbsp;</td>
												<td style="width: 200px;">&nbsp;</td>
												<td style="width: 80px;">&nbsp;</td>
												<td style="width: 220px;">&nbsp;</td>
											</tr>
											<tr>
												<td class="label">*<s:text name="contract4Labour.insurCode"/>:</td>
												<td class="value relative">
												<s:if test="%{e.status == -1}"><!--草稿状态,社保号不用必填  -->
													<s:textfield name="e.insurCode" cssClass="ui-widget-content"/>
													<s:if test="isSupply == false">
														<ul class="inputIcons">
															<li class="inputIcon ui-icon ui-icon-lightbulb" title='<s:text name="点击查询此社保号是否被占用"/>' id="selectInsurCode">
														</ul>
													</s:if>
												</s:if>
												<s:else>
													<s:textfield name="e.insurCode" data-validate="required" cssClass="ui-widget-content"/>
													<s:if test="isSupply == false">
														<ul class="inputIcons">
															<li class="inputIcon ui-icon ui-icon-lightbulb" title='<s:text name="点击查询此社保号是否被占用"/>' id="selectInsurCode">
														</ul>
													</s:if>
												</s:else>
												</td>
												<td class="label">*<s:text name="contract4Labour.joinDate"/>:</td>
												<td class="value" style="position:relative;display: block;">
													<s:if test="%{e.status == -1}"><!--草稿状态,参保号不用必填  -->
														<input type="text" name="e.joinDate" data-validate='{"type":"date"}'
														value='<s:date format="yyyy-MM-dd" name="e.joinDate" />'
														class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
														<ul class="inputIcons">
															<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.joinDate' ></li>
														</ul>
													</s:if>
													<s:else>
														<input type="text" name="e.joinDate" data-validate='{"type":"date","required":true}'
														value='<s:date format="yyyy-MM-dd" name="e.joinDate" />'
														class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
														<ul class="inputIcons">
															<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.joinDate' ></li>
														</ul>
													</s:else>
												</td>
											</tr>
											<tr>
												<td class="label">*<s:text name="contract4Labour.insuranceType"/>:</td>
												<td class="value">
													<s:select name="e.insuranceType" list="insurancetypeList" data-validate="required" listKey="value" listValue="value" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" />
												</td>
												<td class="label"><s:text name="contract4Labour.stopDate"/>:</td>
												<td class="value" style="position:relative;display: block;">
													<input type="text" name="e.stopDate" data-validate='{"type":"date"}'
													value='<s:date format="yyyy-MM-dd" name="e.stopDate" />'
													class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
													<ul class="inputIcons">
														<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.stopDate' ></li>
													</ul>
												</td>
											</tr>
											<tr>
												<td class="label"><s:text name="contract4Labour.zizhu"/>:</td>
												<td class="value">
													<s:checkbox name="e.dole" cssStyle="width:1em;" />
													<s:text name="contract4Labour.dole"/>
													<s:checkbox name="e.funding" cssStyle="width:1em;"/>
													<s:text name="contract4Labour.funding"/>
												</td>
												<td class="label"><s:text name="contract4Labour.getDaedLine"/>:</td>
												<td class="value">
													<div style="position:relative;display: inline-block">
													&nbsp;从<input type="text" name="e.getStartDate" readonly="readonly" data-validate='{"type":"date"}' 
														value='<s:date format="yyyy-MM-dd" name="e.getStartDate" />' class="bc-date ui-widget-content"
														style="width: 7em;" />
														<ul class="inputIcons" style="right : 0px;">
															<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.getStartDate' ></li>
														</ul>
													</div>
													<div style="position:relative;display: inline-block">
													&nbsp;到<input type="text" name="e.getEndDate" readonly="readonly" data-validate='{"type":"date"}'
														value='<s:date format="yyyy-MM-dd" name="e.getEndDate" />' class="bc-date ui-widget-content"
														style="width: 7em;" />
														<ul class="inputIcons" style="right : 0px;">
															<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.getEndDate' ></li>
														</ul>
													</div>
												</td>
											</tr>
											<tr>
												<td class="label"><s:text name="contract4Labour.buyUnit"/>:</td>
												<td class="value">
													<s:select name="e.buyUnit" list="buyUnitList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
												</td>
											</tr>
											<tr>
												<td class="label"><s:text name="contract4Labour.certPay"/>:</td>
												<td class="value" colspan="3">
													<s:checkbox name="e.iqama" cssStyle="width:1em;" />
													<s:text name="contract4Labour.iqama"/>
													<s:checkbox name="e.accountBook" cssStyle="width:1em;"/>
													<s:text name="contract4Labour.accountBook"/>
													<s:checkbox name="e.identityCards" cssStyle="width:1em;"/>
													<s:text name="contract4Labour.identityCards"/>
													<s:checkbox name="e.fpc" cssStyle="width:1em;"/>
													<s:text name="contract4Labour.fpc"/>
													<s:checkbox name="e.unemployed" cssStyle="width:1em;"/>
													<s:text name="contract4Labour.unemployed"/>
													<s:checkbox name="e.healthForm" cssStyle="width:1em;"/>
													<s:text name="contract4Labour.healthForm"/>
													<s:checkbox name="e.photo" cssStyle="width:1em;"/>
													<s:text name="contract4Labour.photo"/>
												</td>
											</tr>
											<tr>
												<td class="label" style="vertical-align: top;"><s:text name="contract4Labour.remark"/>:</td>
												<td class="value" colspan="3"><s:textarea name="e.remark" rows="5" cssClass="ui-widget-content noresize" /></td>
											</tr>
											<tr>
												<td class="value" colspan="4">
													<fieldset class="ui-widget-content">
										          		<legend>生育险待遇</legend>
										          		<table class="formFields" cellspacing="2" cellpadding="0">
										          			<tr class="widthMarker">
																<td >&nbsp;</td>
																<td style="width: 200px;">&nbsp;</td>
																<td style="width: 80px;">&nbsp;</td>
																<td style="width: 220px;">&nbsp;</td>
															</tr>
										        			 <tr>
																<td class="label"><s:text name="contract4Labour.breedingDate"/>:</td>
																<td class="value" style="position:relative;display: block;">
																	<input type="text" name="e.breedingDate" data-validate='{"type":"date"}'
																	value='<s:date format="yyyy-MM-dd" name="e.breedingDate" />'
																	class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
																	<ul class="inputIcons">
																		<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.breedingDate' ></li>
																	</ul>
																</td>
																<td class="label"><s:text name="contract4Labour.insureDate"/>:</td>
																<td class="value" style="position:relative;display: block;">
																	<input type="text" name="e.insureDate" data-validate='{"type":"date"}'
																	value='<s:date format="yyyy-MM-dd" name="e.insureDate" />'
																	class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
																	<ul class="inputIcons">
																		<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.insureDate' ></li>
																	</ul>
																</td>
												        	</tr>
										        		</table>
											    	</fieldset>
										    	</td>
											</tr>
						        		</table>
						    		</fieldset>
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
				</div>
				</div>
				<div id="contractContents" class="content" >
					<div class="formEditor">
						<textarea name="e.content" id="textareaId" class="bc-editor ui-widget-content" style="width: 718px;height:313px" data-validate="required"
							 data-ptype="contract4Labour.editor" data-puid='${e.uid}' 
							 data-readonly='${readonly}'>
							 ${e.content} 
						</textarea>
					</div>
				</div>
				<div id="attachment"  class="content"style="width:720px;">
					<s:property value="%{attachsUI}" escapeHtml="false"/>
				</div>
			</div>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.uid"/>
		<s:hidden name="e.status"/>
		<s:hidden name="e.pid"/>
		<s:hidden name="e.type"/>
		<s:hidden name="e.verMajor"/>
		<s:hidden name="e.verMinor"/>
		<s:hidden name="e.opType"/>
		<s:hidden name="e.patchNo"/>
		<s:hidden name="e.main"/>
		<s:hidden name="driverId"/>
		<s:hidden name="carId"/>
		<s:hidden name="isMoreCar"/>
		<s:hidden name="isMoreCarMan"/>
		<s:hidden name="isNullCar"/>
		<s:hidden name="isNullCarMan"/>
		<s:hidden name="isExistContract"/>
		<s:hidden name="e.ext_str1"/>
		<s:hidden name="e.ext_str2"/>
		<s:hidden name="e.ext_str3"/>
		
		<!-- 是否补录 true为补录 -->
		<s:hidden name="isSupply"/> 
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		<!-- 保留字段 -->
		<input type="hidden" name="e.registerDate"  value='<s:date format="yyyy-MM-dd" name="e.registerDate" />'/>
		<input type="hidden" name="e.birthDate"  value='<s:date format="yyyy-MM-dd" name="e.birthDate" />'/>
		<s:hidden name="e.bsType" />
		<s:hidden name="e.certNo" />
		<s:hidden name="e.origin" />
		<s:hidden name="e.certIdentity" />
		<s:hidden name="e.age" />
		<s:hidden name="stopDate"/>
		
	</s:form>
</div>