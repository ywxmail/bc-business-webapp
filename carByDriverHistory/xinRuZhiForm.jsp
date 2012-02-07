<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:property value="%{e.driver.name}" />  <s:text name="carByDriverHistory.title"/>' data-type='form' class="bc-page"
    data-saveUrl='<s:url value="/bc-business/carByDriverHistory/save" />'
	data-js='<s:url value="/bc/libs/select.js" />,<s:url value="/bc-business/carByDriverHistory/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.business.carByDriverHistoryForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carByDriverHistoryForm" theme="simple">
		<div class="formFields ui-widget-content" >
			<table class="formFields" cellspacing="2" cellpadding="0"  >
				<tbody>
					<tr class="widthMarker">
		                <td style="width: 96px;">&nbsp;</td>
		                <td style="width: 220px;">&nbsp;</td>
		                <td style="width: 80px;">&nbsp;</td>
		                <td >&nbsp;</td>
	                </tr>
					<tr>
						<td class="label">*<s:text name="carByDriverHistory.driver"/>:</td>
					<s:if test="%{carManId != null}">
						<td class="value"><s:textfield name="e.driver.name" readonly="true"  data-validate="required" cssClass="ui-widget-content" /></td>
					</s:if><s:else>
					    <td class="value relative"><s:textfield name="e.driver.name"  data-validate="required" cssClass="ui-widget-content" />
					        <ul class="inputIcons">
                               <li id="driverName" class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
                               <li class="clearSelect inputIcon ui-icon ui-icon-circle-close" data-cfg="e.driver.name" title='<s:text name="title.click2clear"/>'></li>
                            </ul>
					    </td>
					</s:else>
						<td class="label"><s:text name="carByDriverHistory.moveType"/>:</td>
						<td class="value"><s:textfield name="moveTypeValue"  value="%{moveTypeValueList[e.moveType]}" readonly="true" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
					  <td class="label">*<s:text name="carByDriverHistory.moveDate"/>:</td>
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
					<td class="label" colspan="4" style="text-align:left;">
						    <fieldset style="width:680px" class="ui-corner-all ui-widget-content">
						          <legend>迁自</legend>
						          <table class="formFields" cellspacing="2" cellpadding="0">
			          				 <tr class="widthMarker">
						                <td style="width: 80px;">&nbsp;</td>
						                <td >&nbsp;</td>
	               					  </tr>
						              <tr><td class="label" style="height:19px"><s:text name="carByDriverHistory.fromUnit"/>:</td>
						                  <td class="value"><s:textfield name="e.fromUnit" cssClass="ui-widget-content"/></td>
						              </tr>
						          </table>
						   </fieldset>
						</td>
					</tr>
					<tr>
						<td class="value" colspan="4" >
						    <fieldset style="width:680px" class="ui-corner-all ui-widget-content">
						          <legend>迁往</legend>
						          <table class="formFields" cellspacing="2" cellpadding="0">
						          	<tr class="widthMarker">
						                <td style="width: 80px;">&nbsp;</td>
						                <td style="width: 220px;">&nbsp;</td>
						                <td style="width: 80px;">&nbsp;</td>
						                <td >&nbsp;</td>
	               					 </tr>
						             <tr><td class="label" style="height:19px">*<s:text name="carByDriverHistory.car"/>:</td>
						                   <td class="value relative" style="position:relative;display: block;"><s:textfield name="toCarPlate" value="%{e.toCar.plateType+e.toCar.plateNo }"
					                        data-validate="required" cssClass="ui-widget-content" readonly="true" />
					                           <ul class="inputIcons">
                                                   <li id="selectNewCar" class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
                                                   <li class="clearSelect inputIcon ui-icon ui-icon-circle-close" data-cfg="toCarPlate" title='<s:text name="title.click2clear"/>'></li>
                                               </ul>
                                            </td>
								            <td class="label" style="height:19px"><s:text name="carByDriverHistory.toUnit"/>:</td>
							                <td class="value"><s:textfield name="e.toUnit" cssClass="ui-widget-content"/></td>
					                  </tr>
						              <tr>
                                            <td class="label"><s:text name="carByDriverHistory.motorcade"/>:</td>
						                    <td class="value"> <s:select name="e.toMotorcadeId" list="motorcadeList" listKey="key" listValue="value" value="e.toMotorcadeId" 
						                         headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
					                        </td>
						             		<td class="label"><s:text name="carByDriverHistory.classes"/>:</td>
						                 	<td class="value" ><s:select name="e.toClasses" list="#{0:'',1:'正班',2:'副班'}" 
							              		listKey="key" listValue="value" data-validate="required" cssClass="ui-widget-content"/>
						              		</td>
							         </tr>
						        </table>
						    </fieldset>
						</td>
					</tr>
					<tr>
					   <td class="label"><s:text name="carByDriverHistory.description"/>:</td>
					   <td class="value" colspan="4" rowspan="3"><s:textarea name="e.description" rows="4"  
					       cssClass="ui-widget-content"/></td></tr>
				</tbody>
			</table>
			<div class="formTopInfo">
					登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
					<s:if test="%{e.modifier != null}">
					最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
					</s:if>
		   </div>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.moveType" />
		<s:hidden name="e.driver.id" />
		<s:hidden id="header" value="%{e.driver.name}"/>
		<s:hidden name="e.author.id" />
		<s:hidden name="e.modifier.id"/>
		<s:hidden name="e.fromMotorcadedId"/>
		<s:hidden name="e.fromCar.id"/>
		<s:hidden name="e.toCar.id"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>