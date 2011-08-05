<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="createCharger.title"/>-<s:property value="e.name" />' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/charger/save" />'
	data-js='<s:url value=" /bc-business/charger/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.business.chargerForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","action":"save"}],
		"width":680,"minWidth":250,"minHeight":250,"modal":false}' style="overflow-y:auto;">
	<s:form name="chargerForm" theme="simple">
	    <div class="formTopInfo">
			<s:property value="e.authorName" />(<s:property value="e.authorDepartName" />) 创建于  <s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>
		</div>
		<div class="formFields ui-widget-content">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label">* <s:text name="charger.name"/>:</td>
						<td class="value "><s:textfield name="e.name"  data-validate="required"/></td>
						<td class="label"><s:text name="charger.sex"/>:</td>
						<td class="value"><s:radio name="e.sex" list="{'男','女','不设置'}" 
						value="e.sex" cssStyle="width:auto;"/></td>
						<td class="value" ><s:text name="charger.photo"/>:</td>
					</tr>
					<tr>
						<td class="label"> <s:text name="charger.TWIC"/>:</td>
						<td class="value"><s:textfield name="e.TWIC" /></td>
						<td class="label" ><s:text name="charger.brithdate"/>:</td>
						<td class="value"><input type="text" name="e.brithdate"  
						class="bc-date" title='<s:text name="title.click2selectDate"/>'
						value='<s:date format="yyyy-MM-dd" name="e.brithdate" />'/></td>
						<td class="value" rowspan="4"colspan="2"><div style="width: 160px;height: 125px;margin: 0 auto;"><img alt="" src="" name="charger.photo" ></div>
					</tr>
					<tr>
						<td class="label"> <s:text name="label.phone"/>:</td>
						<td class="value"><s:textfield name="e.phone" data-validate='{required:false,type:"phone"}' /></td>
						<td class="label"><s:text name="charger.unit"/>:</td>
						<td class="value"><s:textfield name="e.unit"
						readonly="true" title='%{getText("charger.title.click2selectBelong")}'/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="charger.nativePlace"/>:</td>
						<td class="value"><s:textfield name="e.nativePlace" /></td>
						<td class="label"><s:text name="charger.area"/>:</td>
						<td class="value"><s:textfield name="e.area"  /></td>
					</tr>
					<tr>
						<td class="label"> <s:text name="charger.card"/>:</td>
						<td class="value" ><s:textfield name="e.card" /></td>
						<td class="label"><s:text name="charger.orderId"/>:</td>
						<td class="value"><s:textfield name="e.orderId"  data-validate='{required:false,type:"number"}'  /></td>
					</tr>
					<tr>
						<td class="label"> <s:text name="charger.idAddress"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.idAddress" /></td>
						<td align="center">上传头像</td>
					</tr>
					<tr>
						<td class="label"><s:text name="charger.temporaryAddress"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.temporaryAddress" /></td>
						<td align="center">修改头像</td>
					</tr>
					<tr>
					<td class="label w80"  ><s:text name="charger.modifiedDate"/>:</td>
						<td class="value" ><s:date format="yyyy-MM-dd HH:mm:ss" name="e.modifiedDate" /></td>
						<td class="value"><s:property value="e.modifierName" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="charger.description"/>:</td>
						<td class="value" colspan="4" rowspan="2"><s:textarea name="e.description" /></td>
					</tr>
				</tbody>
			</table>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.modifierName" />
		<s:hidden name="e.uid" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.author.name" />
		<s:hidden name="e.authorDepartId" />
		<s:hidden name="e.authorDepartName" />
		<s:hidden name="e.authorUnitId" />
		<s:hidden name="e.authorUnitName" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		<input type="hidden" name="e.modifiedDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.modifiedDate" />'/>
	</s:form>
</div>