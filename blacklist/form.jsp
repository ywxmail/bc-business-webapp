<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="blacklist.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/blacklist/save" />'
	data-js='<s:url value="/bc-business/blacklist/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/carMan/select.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.business.blacklistForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="blacklistForm" theme="simple">
		<div class="formFields ui-widget-content" >
			<table class="formFields" cellspacing="2" cellpadding="0"  >
				<tbody>
					<tr>
						<td class="label">*<s:text name="blacklist.subject"/>:</td>
						<td class="value " colspan="3"><s:textfield name="e.subject"  data-validate="required" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
					   <td class="label">*<s:text name="blacklist.car.plateNo"/>:</td>
					<s:if test="%{carManId != null || carId !=null }">
						<td class="value"><s:textfield name="plate" value="%{e.car.plateType+'.'+e.car.plateNo }" readonly="true" cssClass="ui-widget-content ui-state-disabled"/></td>
					    </s:if><s:else>
						<td class="value" style="position:relative;display: block;"><s:textfield name="plate" value="%{e.car.plateType+'.'+e.car.plateNo }"
					    data-validate="required" cssClass="ui-widget-content" readonly="true" />
					    <span id="selectCar" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></span>
					    </td>
					    </s:else>
					    <td class="label"><s:text name="blacklist.motorcade.name"/>:</td>
						<td class="value"><s:textfield name="e.car.motorcade.name" readonly="true" data-validate="required" cssClass="ui-widget-content ui-state-disabled" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="blacklist.driver"/>:</td>
					<s:if test="%{carManId != null}">
						<td class="value"><s:textfield name="e.driver.name" readonly="true"  data-validate="required" cssClass="ui-widget-content ui-state-disabled" /></td>
					</s:if><s:else>
					    <td class="value"><s:textfield name="e.driver.name"  id="driverName" readonly="true" data-validate="required" cssClass="ui-widget-content ui-state-disabled" /></td>
					</s:else>
						<td class="label"><s:text name="blacklist.code"/>:</td>
						<td class="value"><s:textfield name="e.code" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="blacklist.type"/>:</td>
						<td class="value" ><s:select list="blackTypeList" listKey="value" listValue="value" headerKey="" headerValue="%{getText('label.please.choose')}" name="e.type" style="width:267px" 
						data-validate="required" cssClass="ui-widget-content"></s:select></td>
						<td class="label"><s:text name="blacklist.unit"/>:</td>
						<td class="value"><s:textfield name="e.oldUnitName" readonly="true"  cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="blacklist.level"/>:</td>
						<td class="value" ><s:select list="blackLevelList" listKey="value" listValue="value" headerKey="" headerValue="" name="e.level" style="width:267px" cssClass="ui-widget-content"></s:select></td>
					</tr>
					<tr>
						<td class="label" colspan="2" style="text-align:left;">
						    <fieldset style="width:320px">
						          <legend>锁定信息</legend>
						          <table class="formFields" cellspacing="2" cellpadding="0" style="height:200px">
						              <tr>
					                      <td class="label"><s:text name="blacklist.locker.name"/>:</td>
					                      <td><s:property value="e.locker.name" />(<s:date name="e.lockDate" format="yyyy-MM-dd HH:mm:ss"/>)</td>
					                  </tr>
					                   <tr>
						                   <td class="label">*<s:text name="blacklist.lockReason"/>:</td>
						                   <td class="value"  rowspan="10"><s:textarea name="e.lockReason" rows="10" data-validate="required" cssClass="ui-widget-content"/></td>
					                   </tr>
						          </table>
						   </fieldset>
						</td>
						<td class="value" colspan="2" >
						    <fieldset style="width:320px">
						          <legend>解锁信息</legend>
						          <table class="formFields" cellspacing="2" cellpadding="0" style="height:200px" >
 						          <s:if test="e.isNew()" >
 						          <tr>
					                        <td class="label" style="height:19px"></td>
					                     </tr>
					                     <tr>
						                    <td class="label"><s:text name="blacklist.unlockReason"/>:</td>
						                    <td class="value" rowspan="10" ><s:textarea name="e.unlockReason" rows="10" cssClass="ui-widget-content"/></td>
					                      </tr>
					               </s:if><s:else >
					                      <tr>
					                      <td class="label"><s:text name="blacklist.unlocker.name"/>:</td>
					                      <td><s:property value="e.unlocker.name" />(<s:date name="e.unlockDate" format="yyyy-MM-dd HH:mm:ss"/>)</td>
					                   </tr>
					                   <tr>
						                    <td class="label">*<s:text name="blacklist.unlockReason"/>:</td>
						                    <td class="value" rowspan="10" ><s:textarea name="e.unlockReason" rows="10" cssClass="ui-widget-content" data-validate="required"/></td>
					                      </tr>
					                     </s:else>
						        </table>
						    </fieldset>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="formTopInfo">
			        <s:if test="%{e.isNew()}">
			               状态：新建
			        </s:if><s:else>
			               状态：<s:property value="%{statusesValue[e.status]}" /> ,
			               </s:else>
					登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
					<s:if test="%{e.modifier != null}">
					最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
					</s:if>
		   </div>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.locker.id" />
		<s:hidden name="e.unlocker.id" />
		<s:hidden name="e.car.id" />
		<s:hidden name="e.driver.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.motorcade.id" />
		<s:hidden name="e.modifier.id"/>
		<s:hidden name="e.status"/>
		<s:hidden name="isNullCarMan" />
		<s:hidden name="isNullCar" />
		<s:hidden name="isMoreCar" />
		<s:hidden name="isMoreCarMan" />
		<s:hidden name="carManId" />
		<s:hidden name="carId" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		<input type="hidden" name="e.lockDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.lockDate" />'/>
		<input type="hidden" name="e.unlockDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.unlockDate" />'/>
	</s:form>
</div>