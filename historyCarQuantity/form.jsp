<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title1='<s:property value="e.motorcade.name" />' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/historyCarQuantity/save" />'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","action":"save"}],
		"width":300,"minWidth":320,"minHeight":200,"modal":false}' style="overflow-y:auto;">
	<s:form name="historyCarQuantityForm" theme="simple">
	 <div class="formTopInfo">
			<s:property value="e.authorName" />(<s:property value="e.authorDepartName" />) 创建于  <s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>
		</div>
	<div class="formFields ui-widget-content">
		<table class="formFields" cellspacing="2" cellpadding="0">
			<tbody>
				<tr>
					<td class="label w80">* <s:text name="historyCarQuantity.year"/>:</td>
					<td class="value"><s:textfield name="e.year" data-validate='{"required":true,"type":"digits","max":9999,"min":1970}'/></td>
				</tr>
				<tr>
					<td class="label">* <s:text name="historyCarQuantity.month"/>:</td>
					<td class="value"><s:textfield name="e.month" data-validate='{"required":true,"type":"digits","max":12,"min":1}'/></td>
				</tr>
				<tr>
					<td class="label">* <s:text name="historyCarQuantity.carquantity"/>:</td>
					<td class="value"><s:textfield name="e.quantity" data-validate='{"required":true,"type":"digits","max":2147483647,"min":1}'/></td>
				</tr>
		   </tbody>
		</table>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.motorcade.id" />
		<s:hidden name="e.motorcade.name" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.author.name" />
		<s:hidden name="e.authorDepartId" />
		<s:hidden name="e.authorDepartName" />
		<s:hidden name="e.authorUnitId" />
		<s:hidden name="e.authorUnitName" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>