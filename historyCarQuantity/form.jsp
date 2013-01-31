<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='
	<s:if test="%{e.motorcade==null}">
		<s:text name="createHistoryCarQuantity.title"/>
	</s:if><s:else>
		<s:text name="e.motorcade.name"/><s:property value="e.year" />-<s:property value="e.month" />-<s:property value="e.day" />车辆数
	</s:else>'
	data-type='form' class="bc-page"
    data-js='<s:url value="/bc-business/historyCarQuantity/form.js" />,<s:url value="/bc-business/bs.js" />'	
    data-initMethod='bs.historyCarQuantityForm.init'
	data-saveUrl='<s:url value="/bc-business/historyCarQuantity/save" />'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="historyCarQuantityForm" theme="simple">
		<div class="formFields" style="width:440px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label">*<s:text name="motorcade.name"/>:</td>
						<td class="value relative">
							<s:select name="e.motorcade.id" list="motorcadeList" listKey="key" data-validate="required"
										listValue="value"  headerKey="" headerValue="" cssClass="ui-widget-content"/>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="historyCarQuantity.year"/>:</td>
						<td class="value">
							<s:textfield name="e.year" cssClass="ui-wedget-content" data-validate="{'required':true,'type':'number','min':1900,'max':3000}" />
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="historyCarQuantity.month"/>:</td>
						<td class="value">
							<s:textfield name="e.month" cssClass="ui-wedget-content" data-validate="{'required':true,'type':'number','min':1,'max':12}" />
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="historyCarQuantity.day"/>:</td>
						<td class="value">
							<s:textfield name="e.day" cssClass="ui-wedget-content" data-validate="{'required':true,'type':'number','min':1,'max':31}" />
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="historyCarQuantity.carquantity"/>:</td>
						<td class="value">
							<s:textfield name="e.quantity" cssClass="ui-wedget-content" data-validate="{'required':true,'type':'number','min':0,'max':1000000}" />
						</td>
					</tr>
					<tr>
						<td class="label" colspan="2">
							<div class="formTopInfo">
								登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
								<s:if test="%{e.modifier != null}">
								，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		<s:hidden name="e.modifier.id"/>
		<input type="hidden" name="e.modifiedDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.modifiedDate" />'/>
	</s:form>
</div>