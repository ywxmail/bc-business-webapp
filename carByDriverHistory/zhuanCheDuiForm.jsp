<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="carByDriverHistory.title"/>' data-type='form' class="bc-page"
    data-saveUrl='<s:url value="/bc-business/carByDriverHistory/save" />'
	data-js='<s:url value="/bc-business/carByDriverHistory/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.business.carByDriverHistoryForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","action":"save"}],
		"width":725,"minWidth":320,"minHeight":200,"modal":false}' style="overflow-y:auto;">
	<s:form name="carByDriverHistoryForm" theme="simple">
		<div class="formFields ui-widget-content" >
			<table class="formFields" cellspacing="2" cellpadding="0"  >
				<tbody>
					<tr>
						<td class="label"><s:text name="carByDriverHistory.moveType"/>:</td>
						<td class="value"><s:textfield name="moveTypeValue"  value="%{moveTypeValueList[e.moveType]}"   cssClass="ui-widget-content ui-state-disabled"/></td>
						<td class="label">*<s:text name="carByDriverHistory.moveDate"/>:</td>
						<td class="value" style="position:relative;display: block;"><input type="text" name="e.moveDate" 
						data-validate="date"class="bc-date ui-widget-content" title='<s:text name="title.click2selectDate"/>'
					    value='<s:date format="yyyy-MM-dd" name="e.moveDate" />'/>
					    <span class="selectButton verticalMiddle ui-icon ui-icon-calendar"></span>
				        </td>
					</tr>
					<tr>
						<td class="label" colspan="4" style="text-align:left;">
						    <fieldset style="width:680px">
						          <legend>迁自</legend>
						          <table class="formFields" cellspacing="2" cellpadding="0" >
						              <tr><td class="label" >*<s:text name="carByDriverHistory.oldCar"/>:</td>
						                   <td class="value relative" style="position:relative;display: block;"><s:textfield name="e.fromCar.name" value="%{e.fromCar.plateType+e.fromCar.plateNo }"
					                        data-validate="required" cssClass="ui-widget-content" readonly="true"/>
					                           <ul class="inputIcons">
                                                   <li id="selectOldCar" class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
                                                   <li class="clearSelect inputIcon ui-icon ui-icon-circle-close" data-cfg="e.fromCar.name" title='<s:text name="title.click2clear"/>'></li>
                                               </ul>
                                            </td>
						                  <td class="label"><s:text name="carByDriverHistory.oldMotorcade"/>:</td>
						                  <td class="value"><s:textfield name="e.fromMotorcadeName" cssClass="ui-widget-content"/></td>
						            </tr>
						          </table>
						   </fieldset>
						</td>
					</tr>
					<tr>
					<td class="value" colspan="4" >
						    <fieldset style="width:680px" >
						          <legend>迁往</legend>
						          <table class="formFields" cellspacing="2" cellpadding="0" style="text-align:left;">
						              <tr><td class="label" style="width:20px"><s:text name="carByDriverHistory.newMotorcade"/>:</td>
						               <td class="value" >
							           <s:select name="e.toMotorcadeId" list="motorcadeList" listKey="key" listValue="value" 
							           value="e.toMotorcadeId" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
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
		<s:hidden name="e.driver.id" />
		<s:hidden name="e.moveType" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.modifier.id"/>
		<s:hidden name="e.fromMotorcadedId"/>
		<s:hidden name="e.fromCar.id"/>
		<s:hidden name="e.toCar.id"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>