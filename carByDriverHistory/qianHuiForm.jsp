<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:property value="%{e.driver.name}" /> <s:text name="carByDriverHistory.title"/>' data-type='form' class="bc-page"
    data-saveUrl='<s:url value="/bc-business/carByDriverHistory/save" />'
	data-js='<s:url value="/bc/libs/select.js" />,<s:url value="/bc-business/carByDriverHistory/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.business.carByDriverHistoryForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carByDriverHistoryForm" theme="simple">
			<table class="formFields" cellspacing="2" cellpadding="0"  >
				<tbody>
					<tr class="widthMarker">
		                <td style="width: 80px;">&nbsp;</td>
		                <td style="width: 280px;">&nbsp;</td>
		                <td style="width: 80px;">&nbsp;</td>
		                <td >&nbsp;</td>
	                </tr> 
					<tr>
						<td class="label" style="min-width: 5em;width: 5em;">*<s:text name="carByDriverHistory.driver"/>:</td>
					<s:if test="%{carManId != null || !isNewest}">
						<td class="value"><s:textfield name="e.driver.name" readonly="true" data-validate="required" cssClass="ui-widget-content" /></td>
					</s:if><s:else>
					    <td class="value relative"><s:textfield name="e.driver.name" readonly="true" data-validate="required" cssClass="ui-widget-content" />
					        <ul class="inputIcons">
                               <li id="driverName"class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
                               <li class="clearSelect inputIcon ui-icon ui-icon-circle-close" data-cfg="e.driver.name" title='<s:text name="title.click2clear"/>'></li>
                            </ul>
					    </td>
					</s:else>
						<td class="label" style="min-width: 5em;width: 5em;"><s:text name="carByDriverHistory.moveType"/>:</td>
						<td class="value"><s:textfield name="moveTypeValue"  value="%{moveTypeValueList[e.moveType]}" readonly="true" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
					  <td class="label" style="min-width: 5em;width: 5em;">*<s:text name="carByDriverHistory.moveDate"/>:</td>
						<td class="value relative">
							<input type="text" name="e.moveDate" data-validate='{"type":"date","required":true}'
							value='<s:date format="yyyy-MM-dd" name="e.moveDate" />'
							class="bc-date ui-widget-content" />
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.moveDate'></li>
							</ul>
						</td>
					</tr>
					<tr>
					<td class="value" colspan="4" >
						    <fieldset  class="ui-widget-content">
						          <legend>迁自</legend>
						          <table class="formFields" cellspacing="2" cellpadding="0" >
									  <tr class="widthMarker">
							                <td style="width:5em;">&nbsp;</td>
							                <td >&nbsp;</td>
						               </tr>
							          <tr><td class="label" style="min-width: 5em;width: 5em;"><s:text name="carByDriverHistory.fromUnit"/>:</td>
						                  <td class="value relative">
											<s:if test="isReadonly()">
												<s:textfield name="e.fromUnit" cssClass="ui-widget-content" cssStyle="width: 274px;"/>
											</s:if>
											<s:else>
												<div class="bc-relativeContainer">
													<input type="text" name="e.fromUnit" value='<s:property value="e.fromUnit"/>' style="width:256px;text-align:left;padding-right:18px;" 
														class="bc-select ui-widget-content"
														data-maxHeight="150px"
														data-source='<s:property value="companyNames"/>'/>
													<ul class="inputIcons">
														<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
													</ul>
												</div>
											</s:else>
				                  		  </td>
						              </tr>
						        </table>
						    </fieldset>
						</td>
					</tr>
					<tr>
						<td class="value" colspan="4" >
						    <fieldset  class="ui-widget-content">
						          <legend>迁往</legend>
						          <table class="formFields" cellspacing="2" cellpadding="0">
									   <tr class="widthMarker">
							                <td style="width: 5em;">&nbsp;</td>
							                <td style="width: 280px;">&nbsp;</td>
							                <td style="width: 80px;">&nbsp;</td>
							                <td >&nbsp;</td>
						                </tr>
						               <tr><td class="label" style="min-width: 5em;width: 5em;">*<s:text name="carByDriverHistory.car"/>:</td>
						                   <td class="value relative" style="position:relative;display: block;"><s:textfield name="toCarPlate" value="%{e.toCar.plateType+'.'+e.toCar.plateNo }"
					                        data-validate="required" cssClass="ui-widget-content" readonly="true" />
					                        <s:if test="isNewest">
					                           <ul class="inputIcons">
                                                   <li id="selectNewCar" class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
                                                   <li class="clearSelect inputIcon ui-icon ui-icon-circle-close" data-cfg="toCarPlate" title='<s:text name="title.click2clear"/>'></li>
                                               </ul>
                                             </s:if>
                                            </td>
    							            <td class="label" style="min-width: 5em;width: 5em;"><s:text name="carByDriverHistory.unit"/>:</td>
						                    <td class="value"><s:textfield name="e.toUnit" cssClass="ui-widget-content"/></td>
					                  </tr>
						              <tr>
                                            <td class="label" style="min-width: 5em;width: 5em;"><s:text name="carByDriverHistory.motorcade"/>:</td>
						                    <td class="value"> <s:select name="e.toMotorcadeId" list="motorcadeList" listKey="key" listValue="value" value="e.toMotorcadeId" 
						                        headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
					                        </td>
						              		<td class="label" style="min-width: 5em;width: 5em;">*<s:text name="carByDriverHistory.classes"/>:</td>
						                 	<td class="value"><s:select name="e.toClasses" list="classes" headerKey="" headerValue="%{getText('label.please.choose')}" 
							              		listKey="key" listValue="value" data-validate="required" cssClass="ui-widget-content"/>
						              		</td>
							         </tr>
						        </table>
						    </fieldset>
						</td>
					</tr>
					<tr>
						<td colspan="4">
					 		<fieldset class="ui-widget-content">
					          <legend>备注</legend>
					          	<table style="width: 100%;">
						          	<tr>
									   <td class="value"><s:textarea name="e.description" rows="4" cssStyle="width: 100%;"
									       cssClass="ui-widget-content noresize"/></td>
							        </tr>
					       		</table>
					 		</fieldset>
						</td>
			       </tr>
				</tbody>
			</table>
			<div class="formTopInfo">
					状态：<s:property value="%{statusesValue[e.status]}" />&nbsp;&nbsp;&nbsp;&nbsp;登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
					<s:if test="%{e.modifier != null}">
					最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
					</s:if>
		   </div>
		<s:hidden name="e.id" />
		<s:hidden name="e.status" />
		<s:hidden name="e.moveType" />
		<s:hidden name="e.driver.id" />
		<s:hidden id="header" value="%{e.driver.name}"/>
		<s:hidden name="e.author.id" />
		<s:hidden name="e.modifier.id"/>
		<s:hidden name="e.fromMotorcadeId"/>
		<s:hidden name="e.fromCar.id"/>
		<s:hidden name="e.toCar.id"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>