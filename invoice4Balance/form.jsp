<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="invoice4Balance.title"/>' data-type='form' class="bc-page"
	data-js='<s:url value="/bc-business/invoice4Balance/form.js" />'
	data-initMethod='bs.invoice4BalanceForm.init'
	data-option='<s:property value="pageOption"/>'
	style="overflow: auto;">
		<s:form name="invoice4BalanceForm" theme="simple">
			<table class="formFields ui-widget-content"  cellpadding="0" cellpadding="0" style="width:30em;">
				<tbody>
					<tr class="widthMarker">
						<td style="width:7.2em;">&nbsp;</td>
						<td >&nbsp;</td>
					</tr>
					<!-- 起始日期 -->
					<tr>
						<td class="label" >*起始日期:</td>
						<td class="value relative">
							<input type="text" name="startDate" data-validate='{"type":"date"}'
							value='<s:date  format="yyyy-MM-dd" name="startDate" />'
							class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
							</ul>
						</td>
					</tr>
					<!-- 终止日期 -->
					<tr>
						<td class="label" >*终止日期:</td>
						<td class="value relative">
							<input type="text" name="endDate" data-validate='{"type":"date"}'
							value='<s:date  format="yyyy-MM-dd" name="endDate" />'
							class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" ></li>
							</ul>
						</td>
					</tr>
					<!-- 公司 -->
					<tr>
						<td class="label" >公司:</td>
						<td class="value" >
							<s:select name="company" list="companyList" listKey="value" listValue="value"
								headerKey="" headerValue="" cssClass="ui-widget-content"  />
						</td>
					</tr>
					<!-- 发票类型 -->
					<tr>
						<td class="label">*发票类型:</td>
						<td class="value">
							<s:select name="type" list="typeList" listKey="key" listValue="value" cssClass="ui-widget-content" />
						</td>
					</tr>
					<!-- 期初数量 -->
					<tr>
						<td class="label" >期初数量:</td>
						<td class="value" ><s:textfield  name="startCount" readonly="true" cssClass="ui-widget-content" cssStyle="border-style:none"
							  />
						</td>
					</tr>
					<!-- 收入数量-->
					<tr>
						<td class="label" >收入数量:</td>
						<td class="value" ><s:textfield  name="buyCount" readonly="true" cssClass="ui-widget-content" cssStyle="border-style:none"
							  />
						</td>
					</tr>
					<!-- 发出数量 -->
					<tr>
						<td class="label" >发出数量:</td>
						<td class="value" ><s:textfield  name="sellCount" readonly="true" cssClass="ui-widget-content" cssStyle="border-style:none"
							  />
						</td>
					</tr>
					<!-- 剩余数量 -->
					<tr>
						<td class="label" >剩余数量:</td>
						<td class="value" ><s:textfield  name="endCount" readonly="true" cssClass="ui-widget-content" cssStyle="border-style:none" 
							  />
						</td>
					</tr>
					<tr>
						<td class="label" ></td>
						<td class="value" >
						</td>
					</tr>
				</tbody>
			</table>
			<p class="formComment">说明:<br>
										1.期初数量，起始日期前（不包括当天）的采购总数减去销售总数.<br>
										2.收入数量，起始日期到终止日期的采购数量。<br>
										3.发出数量，起始日期到终止日期的销售数量。<br>
										4.剩余数量，终止日期（包括当天）的采购总数减去销售总数。</p>
		</s:form>
</div>