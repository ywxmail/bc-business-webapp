<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="invoice4Balance.title"/>' data-type='form' class="bc-page"
	data-js='<s:url value="/bc-business/invoice/balance/form.js" />'
	data-initMethod='bs.invoice4BalanceForm.init'
	data-option='<s:property value="pageOption"/>'
	style="overflow:auto;">
		<s:form name="invoice4BalanceForm" theme="simple">
		<div style="width:560px">
		<table class="formFields ui-widget-content"  cellspacing="2" cellpadding="0" >
			<tbody>	
				<tr class="widthMarker">
					<td style="width:280px;">&nbsp;</td>
					<td >&nbsp;</td>
				</tr>
				<tr>
					<td style="vertical-align: top">
						<fieldset style="margin: 6px;hight:100%;" class="ui-widget-content"  >
							<legend>查询条件区</legend>
						<table class="formFields ui-widget-content"  cellspacing="2" cellpadding="0" >
							<tbody>
								<tr class="widthMarker">
									<td style="width:80px;">&nbsp;</td>
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
									<td class="label">发票类型:</td>
									<td class="value">
										<s:select name="type" list="typeList" listKey="key" listValue="value"
											headerKey="" headerValue="" cssClass="ui-widget-content"  />
									</td>
								</tr>
							</tbody>
						</table>
						</fieldset>
					</td>
					<td style="vertical-align: top">
						<fieldset style="margin: 6px;hight:100%;" class="ui-widget-content" >
								<legend>结果显示区</legend>
							<table class="formFields ui-widget-content"  cellspacing="2" cellpadding="0" >
								<tbody>
									<tr class="widthMarker">
										<td style="width:90px;">&nbsp;</td>
										<td >&nbsp;</td>
									</tr>
									<!-- 期初数量 -->
									<tr>
										<td class="label" >期初数量<span id="unitName"></span>:</td>
										<td class="value" ><input type="text" name="startCount"  readonly="readonly" class="ui-widget-content" style="border-style:none"
											  />
										</td>
									</tr>
									<!-- 收入数量-->
									<tr>
										<td class="label" >收入数量<span id="unitName"></span>:</td>
										<td class="value" ><input type="text" name="buyCount" readonly="readonly" class="ui-widget-content" style="border-style:none"
											  />
										</td>
									</tr>
									<!-- 发出数量 -->
									<tr style="hight:21px;">
										<td class="label" >发出数量<span id="unitName"></span>:</td>
										<td class="value" ><input type="text"  name="sellCount" readonly="readonly" class="ui-widget-content" style="border-style:none"
											  />
										</td>
									</tr>
									<!-- 剩余数量 -->
									<tr style="hight:21px;">
										<td class="label" >剩余数量<span id="unitName"></span>:</td>
										<td class="value" ><input type="text"  name="endCount" readonly="readonly" class="ui-widget-content" style="border-style:none" 
											  />
										</td>
									</tr>
								</tbody>
							</table>
						</fieldset>
					</td>
				</tr>
			</tbody>
		</table>
			<p class="formComment">说明：<br>
										1)期初数量：起始日期前（不包括当天）的采购总数减去销售总数。<br>
										2)收入数量：起始到终止日期的采购数量。<br>
										3)发出数量：起始到终止日期的销售数量。<br>
										4)剩余数量：终止日期前（包括当天）的采购总数减去销售总数。</p>
		</div>
		</s:form>
</div>