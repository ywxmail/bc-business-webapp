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
						<td class="value " colspan="3"><s:textfield name="e.subject"  data-validate="required" /></td>
					</tr>
					<tr>
					<td class="label">*<s:text name="blacklist.driver"/>:</td>
					<s:if test="%{carManId != null}">
						<td class="value"><s:textfield name="e.driver.name" readonly="true"  data-validate="required"/></td>
					</s:if><s:else>
					<td class="value"><s:textfield name="e.driver.name"  title='%{getText("blacklist.title.click2selectCarMan")}' id="driverName" data-validate="required"/></td>
					</s:else>
					    <td class="label">*<s:text name="blacklist.unit"/>:</td>
						<td class="value"><s:textfield name="e.car.unit.name"   readonly="true" data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label"> *<s:text name="blacklist.car.plateNo"/>:</td>
						<td class="value "><s:textfield name="plate"  value="%{e.car.plateType+e.car.plateNo }" readonly="true" data-validate="required"/></td>
						<td class="label">*<s:text name="blacklist.motorcade.name"/>:</td>
						<td class="value"><s:textfield name="e.car.motorcade.name" readonly="true" data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="blacklist.type"/>:</td>
						<td class="value" ><s:select list="blackTypeList" listKey="value" listValue="value"   headerKey="" headerValue="%{getText('label.please.choose')}" name="e.type" style="width:267px" data-validate="required"></s:select></td>
						<td class="label"><s:text name="blacklist.code"/>:</td>
						<td class="value"><s:textfield name="e.code"  /></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="blacklist.level"/>:</td>
						<td class="value" ><s:select list="blackLevelList" listKey="value" listValue="value"   headerKey="" headerValue="%{getText('label.please.choose')}" name="e.level" style="width:267px" ></s:select></td>
					</tr>
					<tr>
						<td class="label" colspan="2">
						    <fieldset style="width:320px">
						          <legend>锁定信息</legend>
						          <table class="formFields" cellspacing="2" cellpadding="0" style="height:200px">
						               <tr>
						                   <td class="label" >*<s:text name="blacklist.lockDate"/>:</td>
						                   <td class="value"><input type="text" name="e.lockDate"  class="bc-date" title='<s:text name="title.click2selectDate"/>'
						                    value='<s:date format="yyyy-MM-dd" name="e.lockDate" />' data-validate="required"/></td>
					                   </tr>
					                   <tr>
						                   <td class="label">*<s:text name="blacklist.locker.name"/>:</td>
						                   <td class="value" ><s:textfield name="e.locker.name" title='%{getText("blacklist.title.click2selectlocker")}' data-validate="required"/></td>
					                   </tr>
					                   <tr>
						                   <td class="label"><s:text name="blacklist.lockReason"/>:</td>
						                   <td class="value"  rowspan="10"><s:textarea name="e.lockReason" rows="10"/></td>
					                   </tr>
						          </table>
						   </fieldset>
						</td>
						<td class="value" colspan="2">
						    <fieldset style="width:320px">
						          <legend>解锁信息</legend>
						          <table class="formFields" cellspacing="2" cellpadding="0" style="height:200px">
						              <tr>
						                  <td class="label" ><s:text name="blacklist.unlockDate"/>:</td>
						                  <td class="value"><input type="text" name="e.unlockDate"  class="bc-date" title='<s:text name="title.click2selectDate"/>'
						                   value='<s:date format="yyyy-MM-dd" name="e.unlockDate" />'/></td>
					                  </tr>
					                  <tr>
						                  <td class="label"><s:text name="blacklist.unlocker.name"/>:</td>
						                  <td class="value" ><s:textfield name="e.unlocker.name" title='%{getText("blacklist.title.click2selectunlocker")}' /></td>
					                  </tr>
					                  <tr>
						                  <td class="label"><s:text name="blacklist.unlockReason"/>:</td>
						                  <td class="value" rowspan="10" ><s:textarea name="e.unlockReason" rows="10" cols=""/></td>
					                  </tr>
						        </table>
						    </fieldset>
						</td>
					</tr>
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
		<s:hidden name="e.locker.id" />
		<s:hidden name="e.unlocker.id" />
		<s:hidden name="e.car.id" />
		<s:hidden name="e.driver.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.unit.id" />
		<s:hidden name="e.motorcade.id" />
		<s:hidden name="e.modifier.id"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>