<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="contract.labour.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/contractLabour/save" />'
	data-js='<s:url value="/bc-business/contractLabour/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/ui-libs/xheditor/1.1.7/xheditor-zh-cn.min.js?ts=0" />'
	data-initMethod='bc.contractLabourForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="contractLabourForm" theme="simple">
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset" data-cfg="{height:680}"
			style="width:710px;overflow: hidden;">
			<div class="tabsContainer">
           	 	<div class="slideContainer">
					<ul class="tabs ui-helper-reset">
						<li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">基本信息</a></li>
						<li class="tab ui-widget-content"><a href="#contractContents" class="ui-state-default">合同内容</a></li>
						<li class="tab ui-widget-content"><a href='#attachment' class="ui-state-default">附件</a></li>
						<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/contractLabours/list?contractId=%{(e.pid != null)?e.pid:0}"/>' class="ui-state-default">历史版本</a></li>
						<s:if test="!e.isNew()">
							<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/injury/list?contractId=%{e.id}" />' class="ui-state-default">工伤</a></li>
						</s:if>
					</ul>
				</div>
			</div>
			<div class="contentContainer ui-helper-reset ui-widget-content">
				<div id="otherFormFields" class="content active" >
					<table class="formFields" cellspacing="2" cellpadding="0">
						<tbody>
							<tr class="widthMarker">
								<td >&nbsp;</td>
								<td style="width: 200px;">&nbsp;</td>
								<td style="width: 80px;">&nbsp;</td>
								<td style="width: 200px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="label">
									<div class="formTopInfo" id="showVer" style="text-align: left;">
										<s:text name="contract.labour.ver"/>:&nbsp;<s:property value="e.verMajor" />.<s:property value="e.verMinor" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="value" colspan="4">
								    <fieldset>
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
								        </table>
								   </fieldset>
								</td>
							</tr>
							<tr>
								<td class="value" colspan="4">
									<fieldset>
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
												<!--
												<td class="value" style="position:relative;display: block;">
													<s:textfield name="e.ext_str1" data-validate="required" readonly="true" title='%{getText("contract.title.click2selectCar")}' cssClass="ui-widget-content ui-state-disabled" />
													<span class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" id="selectCarPlate"></span>
												</td>
												 -->
												 <td class="value relative">
												 	<s:textfield name="e.ext_str1" data-validate="required" readonly="true" cssClass="ui-widget-content ui-state-disabled" />
												 	<ul class="inputIcons">
												 		<li class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="contract.title.click2selectCar"/>' id="selectCarPlate">
												 	</ul>
												 </td>
												<td class="label"><s:text name="contract.labour.registerDate"/>:</td>
												<td class="value" style="position:relative;display: block;">
													<input type="text" name="e.registerDate" data-validate='{"type":"date"}'
													value='<s:date format="yyyy-MM-dd" name="e.registerDate" />'
													class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
													<ul class="inputIcons">
														<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.registerDate'></li>
													</ul>
												</td>
											</tr>
											<tr>
												<td class="label">*<s:text name="contract.labour.driver"/>:</td>
												<td class="value">
													<div style="position:relative;display: inline-block">
												 		<s:textfield name="e.ext_str2" data-validate="required" readonly="true" cssStyle="width:6.5em;" cssClass="ui-widget-content ui-state-disabled" />
														<ul class="inputIcons">
													 		<li class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="contract.title.click2selectCarMan"/>' id="selectDriverName">
													 	</ul>
													 </div>
													<s:text name="contract.labour.certNo"/>&nbsp;<s:textfield name="e.certNo" data-validate="required" cssStyle="width:6em;" cssClass="ui-widget-content" />
												</td>
												<td class="label" >*<s:text name="contract.labour.bsType"/>:</td>
												<td class="value" >
													<s:select name="e.bsType" list="businessTypeList" listKey="value" listValue="value"  data-validate="required" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" ></s:select>
												</td>
											</tr>
											<tr>
												<td class="label">*<s:text name="contract.labour.age"/>:</td>
												<td class="value">
												 	<s:textfield name="e.age" data-validate="required" cssStyle="width:6.5em;" cssClass="ui-widget-content" />
													&nbsp;&nbsp;&nbsp;<s:text name="contract.labour.sex"/>
													<s:radio name="e.sex" list="#{'1':'男','2':'女'}" 
													value="e.sex" cssStyle="width:auto;"/>
												</td>
												<td class="label"><s:text name="contract.labour.birthDate"/>:</td>
												<td class="value" style="position:relative;display: block;">
													<input type="text" name="e.birthDate" data-validate='{"type":"date"}'
													value='<s:date format="yyyy-MM-dd" name="e.birthDate" />'
													class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
													<ul class="inputIcons">
														<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.birthDate' ></li>
													</ul>
												</td>
											</tr>
											<tr>
												<td class="label"><s:text name="contract.labour.origin"/>:</td>
												<td class="value">
												 	<s:textfield name="e.origin" cssClass="ui-widget-content" />
												</td>
												<td class="label" ><s:text name="contract.labour.houseType"/>:</td>
												<td class="value" >
													<s:select name="e.houseType" list="houseTypeList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
												</td>
											</tr>
											<tr>
												<td class="label"><s:text name="contract.labour.certIdentity"/>:</td>
												<td class="value">
												 	<s:textfield name="e.certIdentity" cssClass="ui-widget-content" />
												</td>
												<td class="label"></td>
												<td class="value">
												</td>
											</tr>
						        		</table>
						    		</fieldset>
						    	</td>
							</tr>
							<tr>
								<td class="value" colspan="4">
									<fieldset>
						          		<legend>社保信息</legend>
						          		<table class="formFields" cellspacing="2" cellpadding="0">
											<tr class="widthMarker">
												<td >&nbsp;</td>
												<td style="width: 200px;">&nbsp;</td>
												<td style="width: 80px;">&nbsp;</td>
												<td style="width: 220px;">&nbsp;</td>
											</tr>
											<tr>
												<td class="label">*<s:text name="contract.labour.insurCode"/>:</td>
												<td class="value"><s:textfield name="e.insurCode" data-validate="required" cssClass="ui-widget-content"/></td>
												<td class="label">*<s:text name="contract.labour.joinDate"/>:</td>
												<td class="value" style="position:relative;display: block;">
													<input type="text" name="e.joinDate" data-validate='{"type":"date","required":true}'
													value='<s:date format="yyyy-MM-dd" name="e.joinDate" />'
													class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
													<ul class="inputIcons">
														<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.joinDate' ></li>
													</ul>
												</td>
											</tr>
											<tr>
												<td class="label">*<s:text name="contract.labour.insuranceType"/>:</td>
												<td class="value">
													<s:select name="e.insuranceType" list="insurancetypeList" data-validate="required" listKey="value" listValue="value" headerKey="" headerValue="%{getText('label.please.choose')}" cssClass="ui-widget-content" />
												</td>
												<td class="label"><s:text name="contract.labour.buyUnit"/>:</td>
												<td class="value">
													<s:select name="e.buyUnit" list="buyUnitList" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content" ></s:select>
												</td>
											</tr>
											<tr>
												<td class="label"><s:text name="contract.labour.zizhu"/>:</td>
												<td class="value">
													<s:checkbox name="e.dole" cssStyle="width:1em;" />
													<s:text name="contract.labour.dole"/>
													<s:checkbox name="e.funding" cssStyle="width:1em;"/>
													<s:text name="contract.labour.funding"/>
												</td>
												<td class="label"><s:text name="contract.labour.getDaedLine"/>:</td>
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
												<td class="label"><s:text name="contract.labour.certPay"/>:</td>
												<td class="value" colspan="4">
													<s:checkbox name="e.iQMA" cssStyle="width:1em;" />
													<s:text name="contract.labour.iQMA"/>
													<s:checkbox name="e.accountBook" cssStyle="width:1em;"/>
													<s:text name="contract.labour.accountBook"/>
													<s:checkbox name="e.identityCards" cssStyle="width:1em;"/>
													<s:text name="contract.labour.identityCards"/>
													<s:checkbox name="e.fPC" cssStyle="width:1em;"/>
													<s:text name="contract.labour.fPC"/>
													<s:checkbox name="e.unemployed" cssStyle="width:1em;"/>
													<s:text name="contract.labour.unemployed"/>
													<s:checkbox name="e.healthForm" cssStyle="width:1em;"/>
													<s:text name="contract.labour.healthForm"/>
													<s:checkbox name="e.photo" cssStyle="width:1em;"/>
													<s:text name="contract.labour.photo"/>
												</td>
											</tr>
											<tr>
												<td class="label" style="vertical-align: top;"><s:text name="contract.labour.remark"/>:</td>
												<td class="value" colspan="3"><s:textarea name="e.remark" rows="5" cssClass="ui-widget-content" /></td>
											</tr>
											<tr>
												<td class="value" colspan="4">
													<fieldset>
										          		<legend>生育险待遇</legend>
										          		<table class="formFields" cellspacing="2" cellpadding="0" style="height:40px;">
										          			<tr class="widthMarker">
																<td >&nbsp;</td>
																<td style="width: 200px;">&nbsp;</td>
																<td style="width: 80px;">&nbsp;</td>
																<td style="width: 220px;">&nbsp;</td>
															</tr>
										        			 <tr>
																<td class="label"><s:text name="contract.labour.breedingDate"/>:</td>
																<td class="value" style="position:relative;display: block;">
																	<input type="text" name="e.breedingDate" data-validate='{"type":"date"}'
																	value='<s:date format="yyyy-MM-dd" name="e.breedingDate" />'
																	class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
																	<ul class="inputIcons">
																		<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.breedingDate' ></li>
																	</ul>
																</td>
																<td class="label"><s:text name="contract.labour.insureDate"/>:</td>
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
				<div id="contractContents" class="content" >
					<div class="formEditor">
						<textarea name="e.content" id="textareaId" class="bc-editor ui-widget-content" style="width: 690px;height:590px" data-validate="required"
							 data-ptype="contractLabour.editor" data-puid='${e.uid}' 
							 data-readonly='${readonly}'>
							 ${e.content} 
						</textarea>
					</div>
				</div>
				<div id="attachment"  class="content"style="width:710px;">
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
		<s:hidden name="carManId"/>
		<s:hidden name="carId"/>
		<s:hidden name="oldCarManId"/>
		<s:hidden name="oldCarId"/>
		<s:hidden name="isMoreCar"/>
		<s:hidden name="isMoreCarMan"/>
		<s:hidden name="isNullCar"/>
		<s:hidden name="isNullCarMan"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>