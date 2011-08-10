<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="car.title"/>' data-type='form' class="bc-page"
	data-namespace="/bc/bc-business/car"
	data-js='<s:url value="/bc-business/car/form.js" />'
	data-initMethod='bc.carForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:710px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label"><s:text name="car.code"/>:</td>
						<td class="value"><s:textfield name="e.code" data-validate="required"/></td>
						<td class="label"><s:text name="car.unit"/>:</td>
						<td class="value"><s:textfield name="e.unit.name" data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="car.plate"/>:</td>
						<td class="value"><s:textfield name="e.plateType" cssStyle="width:4em;"/><s:textfield name="e.plateNo" cssStyle="width:8em;"/></td>
						<td class="label"><s:text name="car.motorcade"/>:</td>
						<td class="value"><s:textfield name="e.motorcade.name"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="car.vin"/>:</td>
						<td class="value"><s:textfield name="e.vin" /></td>
						<td class="label"><s:text name="car.businessType"/>:</td>
						<td class="value"><s:textfield name="e.businessType"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="car.registerDate"/>:</td>
						<td class="value"><s:textfield name="e.registerDate" /></td>
						<td class="label"><s:text name="car.businessType"/>:</td>
						<td class="value"><s:textfield name="e.factoryDate"/></td>
					</tr>
					<tr>
						<td class="label" colspan="4">
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
		<div class="formTabs" id="formTabs">
			<ul>
				<li><a href='<s:url value="/bc/unit/list" />'>营运司机</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>合同</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>保险</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>证件</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>配件</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>费用</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>回场捡</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>事故</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>变更历史</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>操作日志</a></li>
				<li><a href="#otherFormFields">其他信息</a></li>
			</ul>
			<div id="otherFormFields" style="width:710px;">
				<table class="formFields" cellspacing="2" cellpadding="0" >
					<tbody>
						<tr>
							<td class="label"><s:text name="car.certNo1"/>:</td>
							<td class="value"><s:textfield name="e.certNo1"/></td>
							<td class="label"><s:text name="car.certNo2"/>:</td>
							<td class="value"><s:textfield name="e.certNo2"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.invoiceNo1"/>:</td>
							<td class="value"><s:textfield name="e.invoiceNo1"/></td>
							<td class="label"><s:text name="car.invoiceNo2"/>:</td>
							<td class="value"><s:textfield name="e.invoiceNo2"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>