<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="createMotorcade.title"/>-<s:property value="e.name" />' data-type='form' class="bc-page"
    data-js='<s:url value="/bc-business/motorcade/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/charger/select.js" />'
    data-initMethod='bc.business.motorcadeForm.init'
	data-saveUrl='<s:url value="/bc-business/motorcade/save" />'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="motorcadeForm" theme="simple">
		<div class="formFields ui-widget-content">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label">* <s:text name="label.code"/>:</td>
						<td class="value w200"><s:textfield name="e.code" data-validate="required"/></td>
						<td class="label"><s:text name="motorcade.principal"/>:</td>
						<td class="value"><s:textfield name="e.principal"/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="motorcade.name"/>:</td>
						<td class="value"><s:textfield name="e.name" data-validate='required'/></td>
						<td class="label"><s:text name="label.phone"/>:</td>
						<td class="value"><s:textfield name="e.phone" data-validate='{required:false,type:"phone"}' /></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="motorcade.company"/>:</td>
						<td class="value"><s:textfield name="e.company" data-validate="required"
							readonly="true" title='%{getText("motorcade.title.click2selectCompany")}'/></td>
						<td class="label"><s:text name="motorcade.fax"/>:</td>
						<td class="value"><s:textfield name="e.fax"  data-validate='{required:false,type:"phone"}'/></td>
					</tr>
					<tr>
						<td class="label"> <s:text name="motorcade.colour"/>:</td>
						<td class="value"><s:textfield name="e.color" /></td>
						<td class="label"><s:text name="motorcade.address"/>:</td>
						<td class="value"><s:textfield name="e.address" /></td>
					</tr>
					<tr>
						<td class="label">* <s:text name="label.status"/>:</td>
						<td class="value" colspan="3"><s:radio name="e.status" list="#{'0':'正常','1':'已禁用','2':'已删除'}" 
							value="e.status" cssStyle="width:auto;"/></td>
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="motorcade.description"/>:</td>
						<td class="value" colspan="3"><s:textarea name="e.description" rows="5"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	    <div class="formTopInfo">
	    	登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
			<s:if test="%{e.modifier != null}">
			，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
			</s:if>
		</div>
		<s:hidden name="e.paymentDate" />
		<s:hidden name="e.fullName" />
		
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		<s:hidden name="e.modifier.id"/>
		<input type="hidden" name="e.modifiedDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.modifiedDate" />'/>
	</s:form>
</div>