<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="policy.title"/>-v<s:property value="e.verMajor"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/policy/save" />'
	data-js='<s:url value="/bc-business/policy/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/ui-libs/xheditor/1.1.7/xheditor-zh-cn.min.js?ts=0" />'
	data-initMethod='bc.policyForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:hidden;">
	<s:form name="policyForm" theme="simple">
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset" data-cfg="{height:420}"
			style="width:710px;overflow: hidden;">
			<div class="tabsContainer">
           	 	<div class="slideContainer">
                <ul class="tabs ui-helper-reset">
				    <li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">基本资料</a></li>
				    <li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">险种</a></li>
				    <li class="tab ui-widget-content"><a href="#otherFormFields4" class="ui-state-default">附件</a></li>
					<s:if test="!e.isNew()">
					<li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">历史版本</a></li>
					</s:if>
                </ul>
            	</div>
	        </div>
			<div class="contentContainer ui-helper-reset ui-widget-content" style="height: 400px;">
				<div id="otherFormFields" class="content active" >
					<table class="formFields" cellspacing="2" cellpadding="0">
						<tbody>
							<tr>
								<td class="value" colspan="4">
								    <fieldset>
								    	<legend>基本信息</legend>
								        <table class="formFields" cellspacing="2" cellpadding="0">
											<tr class="widthMarker">
								                <td style="width: 80px;">&nbsp;</td>
								                <td style="width: 260px;">&nbsp;</td>
								                <td style="width: 80px;">&nbsp;</td>
								                <td >&nbsp;</td>
							                </tr>
											<tr>
												<td class="label">*<s:text name="policy.carId"/>:</td>
					                               <td class="value relative">
												      <div class="input ui-widget-content" data-validate="required" ><span class="link showCar" data-cfg='<s:property value="e.car.id" />' id="carInfo" ><s:property value="%{e.car.plateType+e.car.plateNo }" /></span>
												      </div>
												      <ul class="inputIcons">
												        <li class="selectCar inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>' data-cfg='e.car.id=id,carInfo=plate|text,carInfo=id|attr'></li>
												      </ul>
					                                </td>
												
												<td class="label">*<s:text name="policy.liabilityNo"/>:</td>
												<td class="value"><s:textfield name="e.liabilityNo" cssClass="ui-widget-content"/></td>
											</tr>
											<tr>
											     <td class="label"><s:text name="policy.registerDate"/>:</td>
						                         <td class="value" style="position:relative;display: block;"><input type="text" name="e.registerDate" 
						                          data-validate='{required:false,type:"date"}'class="bc-date ui-widget-content" title='<s:text name="title.click2selectDate"/>'
					                              value='<s:date format="yyyy-MM-dd" name="e.registerDate" />'/>
					                              <span class="selectButton verticalMiddle ui-icon ui-icon-calendar"></span>
				                                 </td>
											</tr>
								        </table>
								   </fieldset>
								</td>
							</tr>
							<tr>
								<td class="value" colspan="4">
									<fieldset>
						          		<legend>商业险</legend>
						          		<table class="formFields" cellspacing="2" cellpadding="0" >
											<tr class="widthMarker">
								                <td style="width: 80px;">&nbsp;</td>
								                <td style="width: 260px;">&nbsp;</td>
								                <td style="width: 80px;">&nbsp;</td>
								                <td >&nbsp;</td>
							                </tr>
											<tr>
											    <td class="label">*<s:text name="policy.commerialNo"/>:</td>
												<td class="value"><s:textfield name="e.commerialNo" cssClass="ui-widget-content"/></td>
												<td class="label">*<s:text name="policy.assured"/>:</td>
												<td class="value"><s:textfield name="e.assured" cssClass="ui-widget-content"/></td>
											</tr>
											<tr>
											    <td class="label">*<s:text name="policy.Company"/>:</td>
							                    <td class="value "><s:select  list="companyList" listKey="value" listValue="value"  headerKey="" headerValue=""  name="e.commerialCompany"  data-validate="required" 
							                         cssStyle="width:20em;" cssClass="ui-widget-content"/></td>
							                    <td class="label">*<s:text name="policy.commerialDeadline"/>:</td>
												<td class="value">
												<div style="position : relative; display: inline-block">
													&nbsp;从<input type="text" name="e.commerialStartDate" 
						                            data-validate='{required:false,type:"date"}'class="bc-date ui-widget-content" title='<s:text name="title.click2selectDate"/>'
					                                value='<s:date format="yyyy-MM-dd" name="e.commerialStartDate" />' style="width: 7em;"/>
					                                <ul class="inputIcons" style="right : 0px;">
														<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.commerialStartDate' ></li>
												    </ul>
												</div>
												<div style="position : relative; display: inline-block">
													&nbsp;到<input type="text" name="e.commerialEndDate" 
						                            data-validate='{required:false,type:"date"}'class="bc-date ui-widget-content" title='<s:text name="title.click2selectDate"/>'
					                                value='<s:date format="yyyy-MM-dd" name="e.commerialEndDate" />' style="width: 7em;"/>
					                                <ul class="inputIcons" style="right : 0px;">
														<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.commerialEndDate' ></li>
												    </ul>
												</div>
												</td>
											</tr>
											<tr>
											    <td class="label"></td>
												<td class="value">
													<s:checkbox name="e.ownrisk" cssStyle="width:1em;" />
													<s:text name="policy.ownrisk"/>
													<s:checkbox name="e.greenslip" cssStyle="width:1em;"/>
													<s:text name="policy.greenslip"/>
												</td>
											</tr>
						        		</table>
						    		</fieldset>
						    	</td>
							</tr>
							<tr>
								<td class="value" colspan="4">
								     <div id="greenslipFieldset" style='<s:if test="%{e.greenslip==true}">
										  visibility: visible;
									      </s:if>
									      <s:else>
										  visibility: hidden;
									      </s:else>
									      '>
									        <fieldset>
						          		        <legend>强制险</legend>
						          		         <table class="formFields" cellspacing="2" cellpadding="0">
													<tr class="widthMarker">
										                <td style="width: 80px;">&nbsp;</td>
										                <td style="width: 260px;">&nbsp;</td>
										                <td style="width: 80px;">&nbsp;</td>
										                <td >&nbsp;</td>
									                </tr>
											         <tr>
											             <td class="label">*<s:text name="policy.greenslipNo"/>:</td>
												         <td class="value"><s:textfield name="e.greenslipNo" cssClass="ui-widget-content"/></td>
							                             <td class="label"></td>
												         <td class="value">
													       <s:checkbox name="e.greenslipSameDate" cssStyle="width:1em;" />
													       <s:text name="policy.greenslipSameDate"/>
												         </td>
											        </tr>
											        <tr>
											             <td class="label">*<s:text name="policy.Company"/>:</td>
							                             <td class="value" ><s:select  list="companyList" listKey="value" listValue="value"  headerKey="" headerValue=""  name="e.greenslipCompany"  
							                               cssStyle="width:20em;" cssClass="ui-widget-content"/></td>
											             <td class="label">
								                               <samp id="greenslipSameDateFieldset" style='<s:if test="%{e.greenslipSameDate==false || e.greenslip==true}">
										                         visibility: visible;
									                            </s:if>
									                            <s:else>
										                         visibility: hidden;
									                             </s:else>
									                             '>
									                             <s:text name="policy.commerialDeadline"/>:
								                                 </samp>
								                           </td>
								                           <td class="value" >
								                               <div id="greenslipSameDateFieldset" style='<s:if test="%{e.greenslipSameDate==false || e.greenslip==true}">
										                         visibility: visible;
									                            </s:if>
									                            <s:else>
										                         visibility: hidden;
									                             </s:else>
									                             '>
									                            <div style="position : relative; display: inline-block">
													               &nbsp;从<input type="text" name="e.greenslipStartDate" 
										                            data-validate='{required:false,type:"date"}'class="bc-date ui-widget-content" title='<s:text name="title.click2selectDate"/>'
									                                value='<s:date format="yyyy-MM-dd" name="e.greenslipStartDate" />' style="width: 7em;"/>
									                                <ul class="inputIcons" style="right : 0px;">
																		<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.greenslipStartDate' ></li>
																    </ul>
												                 </div>
												                 <div style="position : relative; display: inline-block">
													               &nbsp;到<input type="text" name="e.greenslipEndDate" 
										                            data-validate='{required:false,type:"date"}'class="bc-date ui-widget-content" title='<s:text name="title.click2selectDate"/>'
									                                value='<s:date format="yyyy-MM-dd" name="e.greenslipEndDate" />' style="width: 7em;"/>
									                                <ul class="inputIcons" style="right : 0px;">
																		<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.greenslipEndDate' ></li>
																    </ul>
												                 </div>
								                                </div>
								                           </td>
											          </tr>
						        		        </table>
						    		        </fieldset>
								       </div>
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
					<!-- 购买的险种 -->
					<div class="ui-widget-content" style="border-left-width:0;border-right-width:0;">
						<div class="ui-state-active title" style="position:relative;">
							<span class="text"><s:text name="policy.insuranceType"/>：</span>
							<ul class="inputIcons">
								<li id="selectInsuranceType" class="inputIcon ui-icon ui-icon-circle-plus"
									title='<s:text name="title.click2selectInsuranceType"/>'></li>
								<li id="selectTemplate" class="inputIcon ui-icon ui-icon-circle-check"
									title='<s:text name="title.click2selectTemplate"/>'></li>
								<li id="deleteInsuranceType" class="inputIcon ui-icon ui-icon-circle-close"
									title='<s:text name="title.click2deleteInsuranceType"/>'></li>
							</ul>
						</div>
				    	<div class="bc-grid header">
						<table class="table" id="buyPlantTables" cellspacing="0" cellpadding="0" style="width: 100%">
							<tr class="ui-state-default row">
								<td class="first" style="width: 250px;height: 20px;">险种名称</td>
								<td class="middle" style="width: 105px;">保额</td>
								<td class="middle" style="width: 105px;">保费</td>
								<td class="last">备注</td>
							</tr>
							<s:iterator var="b" value="e.buyPlants">
							<tr class="ui-state-default row" data-id='<s:property value="id"/>'>
								<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
									<input style="width:90%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" readonly="readonly""text" class="ui-widget-content" value='<s:property value="name"/>'/></td>
								<td class="middle" style="padding:0;text-align:left;"><input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" value='<s:property value="coverage"/>'/></td>
								<td class="middle" style="padding:0;text-align:left;"><input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" value='<s:property value="premium"/>'/></td>
								<td class="last" style="padding:0;text-align:left;"><input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" value='<s:property value="description"/>'/></td>
							</tr>
							</s:iterator>
						</table>
						</div>
					</div>
				</div>
				<div id="otherFormFields4" class="content" style="width:800px;">
	                 <s:property value="%{attachsUI}" escapeHtml="false"/>
	            </div>
			</div>
			<div>*<s:text name="policy.amount"/>:<s:textfield name="e.amount" size="10" cssClass="ui-widget-content"/>元</div>	
		</div>
		<s:hidden name="e.id"/>
		<s:hidden name="e.car.id"/>
		<s:hidden name="e.author.id"/>
		<s:hidden name="e.uid"/>
		<s:hidden name="e.status"/>
		<s:hidden name="e.patchNo"/>
		<s:hidden name="e.opType"/>
		<s:hidden name="e.verMajor"/>
		<s:hidden name="e.pid"/>
		<s:hidden name="buyPlants"/>
		
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>