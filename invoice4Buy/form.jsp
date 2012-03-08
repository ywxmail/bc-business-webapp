<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="invoice4Buy.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/invoice4Buy/save" />'
	data-js='<s:url value="/bc-business/invoice4Buy/form.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bs.invoice4BuyForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="invoice4BuyForm" theme="simple">
		<div class="formFields ui-widget-content" >
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td style="width: 100px;"></td>
						<td style="width: 150px;">&nbsp;</td>
						<td style="width: 100px;">&nbsp;</td>
						<td >&nbsp;</td>
					</tr>
					<tr>
					    <td class="label">*<s:text name="invoice4Buy.buydate"/>:</td>
						<td class="value relative">
							<input type="text" name="e.buyDate" data-validate='{"type":"date","required":true}'
							value='<s:date format="yyyy-MM-dd" name="e.buyDate" />'
							class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.buyDate'></li>
							</ul>
						</td>
						<td class="label">*<s:text name="invoice.company"/>:</td>
						<td class="value ">
							<s:select name="e.company" list="companyList" listKey="value" listValue="value" data-validate="required" 
								 cssClass="ui-widget-content" disabled="%{!e.isNew()}"/>
						</td>
					</tr>
					<tr>
					    <td class="label"><s:text name="invoice4Buy.buyer"/>:</td>
						<td class="value relative">
							<s:textfield name="buyer" cssClass="ui-widget-content" readonly="true"/>
							<ul class="inputIcons">
								 <li id="selectBuyer" class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
							</ul>
						</td>
						<td class="label">*<s:text name="invoice.code"/>:</td>
						<td class="value"><s:textfield name="e.code" cssClass="ui-widget-content" data-validate="required" /></td>
					</tr>
					<tr>
					    <td class="label">*<s:text name="invoice.startNo"/>:</td>
						<td class="value"><s:textfield name="e.startNo" cssClass="ui-widget-content" data-validate="required" /></td>
						<td class="label">*<s:text name="invoice.endNo"/>:</td>
						<td class="value"><s:textfield name="e.endNo" cssClass="ui-widget-content" data-validate="required" /></td>
					</tr>
					<tr>
					    <td class="label">*<s:text name="invoice4Buy.buyPrice"/>:</td>
						<td class="value"><s:textfield name="e.buyPrice" cssClass="ui-widget-content" data-validate="required" 
								value="%{getText('bs.format.numberRMB',{e.buyPrice})}" data-validate="money"/></td>
						<td class="label">*<s:text name="invoice4Buy.sellPrice"/>:</td>
						<td class="value"><s:textfield name="e.sellPrice" cssClass="ui-widget-content" data-validate="required" 
								value="%{getText('bs.format.numberRMB',{e.sellPrice})}" data-validate="money"/></td>
					</tr>
					<tr>
					    <td class="label">*<s:text name="invoice.type"/>:</td>
						<td class="value">
							<s:select name="e.type" list="typeList" listKey="value" listValue="value" data-validate="required" 
									 cssClass="ui-widget-content" disabled="%{!e.isNew()}"/>
						</td>
						<td class="label">*<s:text name="invoice.count"/>:</td>
						<td class="value"><s:textfield name="e.count" cssClass="ui-widget-content" data-validate="required" /></td>
					</tr>
					<tr>
					    <td class="label">*<s:text name="invoice.unit"/>:</td>
						<td class="value">
							<s:select name="e.unit" list="unitList" listKey="value" listValue="value" data-validate="required" 
									 cssClass="ui-widget-content" disabled="%{!e.isNew()}"/></td>
						<td class="label"><s:text name="invoice.amount"/>:</td>
						<td class="value">
							<s:textfield name="amount" cssClass="ui-widget-content" readonly="true"/></td>
					</tr>
					<tr>
						<td class="label"></td>
						<td></td>
						<td class="label"><s:text name="invoice.status"/>:</td>
						<td><s:radio name="e.status" list="#{'0':'正常','1':'作废'}" cssStyle="width:auto;"/></td>
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="invoice.desc"/>:</td>
						<td class="value" colspan="3"><s:textarea name="e.desc" rows="3" cssClass="ui-widget-content noresize"/></td>
					</tr>
					<tr>
						<td class="label" colspan="4">
							<div class="formTopInfo">
								登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
								<s:if test="%{e.modifier != null}">
								<br/>最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.buyerId" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>