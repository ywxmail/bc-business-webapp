<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="createMotorcade.title"/>-<s:property value="e.name" />' data-type='form' class="bc-page"
    data-js='<s:url value="/bc-business/motorcade/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/charger/select.js" />'
    data-initMethod='bc.business.motorcadeForm.init'
	data-saveUrl='<s:url value="/bc-business/motorcade/save" />'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="motorcadeForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:600px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label">*<s:text name="motorcade.unit"/>:</td>
						<td class="value relative"><s:textfield name="e.unit.name" data-validate="required" cssClass="ui-widget-content"
							readonly="true"/>
							<ul class="inputIcons">
								<li class="selectUnit inputIcon ui-icon ui-icon-circle-plus" 
									data-cfg='{"valueField":"e.unit.id","mapping":"e.unit.id=id,e.unit.name=name"}'
									title='<s:text name="title.click2select"/>'></li>
								<li class="clearSelect inputIcon ui-icon ui-icon-circle-close" 
									data-cfg='e.unit.id,e.unit.name'
									title='<s:text name="title.click2clear"/>'></li>
							</ul>
						</td>
						<td class="label"><s:text name="motorcade.paymentDate"/>:</td>
						<td class="value">
							<s:select name="e.paymentDate" cssClass="ui-widget-content" list="paymentDates" listKey="key" listValue="value"></s:select>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="motorcade.name"/>:</td>
						<td class="value"><s:textfield name="e.name" cssClass="ui-widget-content" data-validate='required'/></td>
						<td class="label"><s:text name="label.phone"/>:</td>
						<td class="value"><s:textfield name="e.phone" cssClass="ui-widget-content" data-validate='{required:false,type:"phone"}' /></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="motorcade.principal"/>:</td>
						<td class="value relative"><s:textfield name="e.principalName" cssClass="ui-widget-content" data-validate='required'
							readonly="true"/>
							<ul class="inputIcons">
								<li class="selectUser inputIcon ui-icon ui-icon-circle-plus" 
									data-cfg='{"valueField":"e.principalId","mapping":"e.principalId=id,e.principalName=name"}'
									title='<s:text name="title.click2select"/>'></li>
								<li class="clearSelect inputIcon ui-icon ui-icon-circle-close" 
									data-cfg='e.principalId,e.principalName'
									title='<s:text name="title.click2clear"/>'></li>
							</ul>
						</td>
						<td class="label"><s:text name="motorcade.fax"/>:</td>
						<td class="value"><s:textfield name="e.fax" cssClass="ui-widget-content"  data-validate='{required:false,type:"phone"}'/></td>
					</tr>
					<tr>
						<td class="label"> <s:text name="motorcade.colour"/>:</td>
						<td class="value"><s:textfield name="e.color" cssClass="ui-widget-content"/></td>
						<td class="label"><s:text name="motorcade.address"/>:</td>
						<td class="value"><s:textfield name="e.address" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="label.order"/>:</td>
						<td class="value"><s:textfield name="e.code" cssClass="ui-widget-content" data-validate="required"/></td>
						<td class="label"><s:text name="label.status"/>:</td>
						<td class="value"><s:radio name="e.status" cssClass="ui-widget-content" list="#{'0':'正常','1':'禁用'}" 
							value="e.status" cssStyle="width:auto;"/></td>
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="motorcade.description"/>:</td>
						<td class="value" colspan="3"><s:textarea name="e.description" cssClass="ui-widget-content" rows="5"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	    <div class="formTopInfo" style="width:600px;">
	    	登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
			<s:if test="%{e.modifier != null}">
			，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
			</s:if>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.uid" />
		<s:hidden name="e.type" />
		<s:hidden name="e.unit.id" />
		<s:hidden name="e.principalId" />
		<s:hidden name="e.parent.id" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		<s:hidden name="e.modifier.id"/>
		<input type="hidden" name="e.modifiedDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.modifiedDate" />'/>
	</s:form>
</div>