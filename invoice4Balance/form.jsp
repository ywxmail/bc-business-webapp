<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="invoice4Balance.title"/>' data-type='form' class="bc-page"
	data-js='<s:url value="/bc-business/invoice4Balance/form.js" />'
	data-initMethod='bs.invoice4BalanceForm.init'
	data-option='<s:property value="pageOption"/>'
	style="overflow: auto;">
		<div class="formFields ui-widget-content"  >
			<table class="formFields"  cellpadding="0" style="width:22em;">
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
							<s:select theme="simple" name="company" list="companyList" listKey="value" listValue="value"
								headerKey="" headerValue="" cssClass="ui-widget-content"  />
						</td>
					</tr>
					<!-- 发票类型 -->
					<tr>
						<td class="label">*发票类型:</td>
						<td class="value">
							<s:select theme="simple" name="type" list="typeList" listKey="key" listValue="value" cssClass="ui-widget-content" />
						</td>
					</tr>
					<!-- 期初数量 -->
					<tr>
						<td class="label" >期初数量:</td>
						<td class="value" ><s:textfield theme="simple" name="startCount" readonly="true" cssClass="ui-widget-content" cssStyle="border-style:none"
							  />
						</td>
					</tr>
					<!-- 收入数量-->
					<tr>
						<td class="label" >收入数量:</td>
						<td class="value" ><input type="text" name="buyCount" class="ui-widget-content" readonly="readonly" style="border-style:none"
							value="0"
						/></td>
					</tr>
					<!-- 发出数量 -->
					<tr>
						<td class="label" >发出数量:</td>
						<td class="value" ><input type="text" name="sellCount" class="ui-widget-content" readonly="readonly" style="border-style:none"
							value="0"
						/></td>
					</tr>
					<!-- 剩余数量 -->
					<tr>
						<td class="label" >剩余数量:</td>
						<td class="value" ><s:textfield theme="simple" name="endCount" readonly="true" cssClass="ui-widget-content" cssStyle="border-style:none" 
							  />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
</div>