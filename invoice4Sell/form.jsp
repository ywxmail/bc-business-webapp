<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="invoice4Sell.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/invoice4Sell/save" />'
	data-js='<s:url value="/bc-business/invoice4Sell/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bs.invoice4SellForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="invoice4SellForm" theme="simple">
		<div class="formFields ui-widget-content"  style="width:750px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td style="width: 80px;"></td>
						<td style="width: 280px;">&nbsp;</td>
						<td style="width: 80px;">&nbsp;</td>
						<td >&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="invoice.carPlate"/>:</td>
							<s:if test="%{buyerId != null || carId !=null }">
								<td class="value">
									<s:textfield name="e.carPlate"  readonly="true" cssClass="ui-widget-content" data-validate="required"/>
								</td>
						    </s:if>
						    <s:else>
								<td class="value relative">
									<s:textfield name="e.carPlate" 
									    data-validate="required" cssClass="ui-widget-content" readonly="true" />
								    <span id="selectCar" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" 
								    	title='<s:text name="title.click2select"/>'>
								    </span>
							    </td>
						    </s:else>
						<td class="label">*<s:text name="invoice4Sell.selldate"/>:</td>
						<td class="value relative">
							<input type="text" name="e.sellDate" data-validate='{"type":"date","required":true}' 
							value='<s:date format="yyyy-MM-dd" name="e.sellDate" />'
							class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.sellDate'></li>
							</ul>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="invoice4Sell.buyer"/>:</td>
							<s:if test="%{buyerId != null || carId !=null}">
								<td class="value">
										<s:textfield name="e.buyerName"  readonly="true" cssClass="ui-widget-content" data-validate="required" />
								</td>
						    </s:if>
						    <s:else>
								<td class="value relative">
									<s:textfield name="e.buyerName"  readonly="true" cssClass="ui-widget-content" data-validate="required"/>
									<span id="selectBuyer" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" 
							    		title='<s:text name="title.click2select"/>'>
							    	</span>
							    </td>
						     </s:else>
						<td class="label">*<s:text name="invoice4Sell.cashier"/>:</td>
						<td class="value relative">
							<s:textfield name="e.cashierId.name" cssClass="ui-widget-content" readonly="true" data-validate="required" />
							<ul class="inputIcons">
								 <li id="selectCashier" class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
							</ul>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="invoice.company"/>:</td>
						<td class="value ">
							<s:select name="e.company" list="companyList" listKey="value" listValue="value" data-validate="required" 
								 headerKey="" headerValue="" cssClass="ui-widget-content" />
						</td>
						
					</tr>
					<tr>
					    <td class="label">*<s:text name="invoice.motorcade"/>:</td>
						<td class="value"><s:select name="e.motorcadeId.id" list="motorcadeList" listKey="key" data-validate="required"
										listValue="value"  headerKey="" headerValue="" cssClass="ui-widget-content"/>
					    </td>
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
								，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			
			<!-- 销售明细 -->
			<div class="ui-widget-content" style="border-width:1px 0 0 0;margin-bottom:8px;">
				<div class="ui-widget-header" style="position:relative;border-width: 0;padding: 0.25em;">
					<span class="text"><s:text name="invoice4Sell.detail"/>：</span>
					<ul class="inputIcons">
						<li id="addLine" class="inputIcon ui-icon ui-icon-circle-plus"
							title='<s:text name="invoice4Sell.title.click2addLine"/>'></li>
						<li id="deleteLine" class="inputIcon ui-icon ui-icon-circle-close"
							title='<s:text name="invoice4Sell.title.click2deleteLine"/>'></li>
					</ul>
				</div>
		    	<div class="bc-grid header">
				<table class="table" id="sellDetailTables" cellspacing="0" cellpadding="0" style="width: 100%;">
					<tr class="ui-state-default header row">
						<td class="first" style="width: 15px;">&nbsp;</td>
						<td class="middle" style="width: 18em;">采购单发票代码</td>
						<td class="middle" style="width: 8em;"><s:text name="invoice.startNo"/></td>
						<td class="middle" style="width: 8em;"><s:text name="invoice.endNo"/></td>
						<td class="middle" style="width: 5em;"><s:text name="invoice.count"/></td>
						<td class="middle" style="width: 6em;"><s:text name="invoice4Sell.price"/>(元)</td>
						<td class="last" style="min-width: 4em;"><s:text name="invoice.amount"/>(元)</td>
					</tr>
					<!-- 新建时 -->
					<s:if test="%{e.isNew()}">
					<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
						<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
						</td>
						<!-- 发票代码 -->
						<td class="middle" style="padding:0;text-align:left;">
							<s:select name="code" list="codeList" listValue="value" listKey="key" headerValue="" headerKey="" 
								theme="simple" data-validate="required" cssClass="ui-widget-content" 
									cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 10px 0 2px"/>
							<!-- 销售明细状态 -->
							<input id="status" type="hidden"  value='<s:property value="status"/>'/>
						</td>
						<!-- 开始号 -->
						<td class="middle" style="padding:0;text-align:left;">
							<input id="startNo" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
								data-validate="required" value='<s:property value="startNo"/>'/>
						</td>
						<!-- 结束号 -->
						<td class="middle" style="padding:0;text-align:left;">
							<input id="endNo" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
								data-validate="required" value='<s:property value="endNo"/>' />
						</td>
						<!-- 数量 -->
						<td class="middle" style="padding:0;text-align:left;">
							<input id="count" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
								data-validate="required" value='<s:property value="count"/>'/>
							<input id="eachCount" type="hidden"  value='<s:property value="eachCount"/>'/>
						</td>
						<!-- 单价 -->
						<td class="middle" style="padding:0;text-align:left;">
							<input id="price" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
								data-validate="required" value='<s:property value="price"/>'/>
						</td>
						<!-- 合计 -->
						<td class="last" style="padding:0;text-align:left;">
							<input id="amount" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content"
								 value='<s:property value="amount"/>'/>
						</td>
					</tr>
					</s:if>
					<s:iterator var="b" value="e.invoice4SellDetail">
					<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
						<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
						</td>
						<!-- 发票代码 -->
						<td class="middle" style="padding:0;text-align:left;">
							<s:select name="buyId" list="codeList" listValue="value" listKey="key"
								theme="simple" data-validate="required" cssClass="ui-widget-content" 
									cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 10px 0 2px"/>
							<!-- 销售明细状态 -->
							<input id="status" type="hidden"  value='<s:property value="status"/>'/>
						</td>
						<!-- 开始号 -->
						<td class="middle" style="padding:0;text-align:left;">
							<input id="startNo" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
								value='<s:property value="startNo"/>'/>
						</td>
						<!-- 结束号 -->
						<td class="middle" style="padding:0;text-align:left;">	
							<input id="endNo" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
								 value='<s:property value="endNo"/>'/>
						</td>
						<!-- 数量 -->
						<td class="middle" style="padding:0;text-align:left;">
							<input id="count" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
								 value='<s:property value="count"/>'/>
						</td>
						<!-- 价格 -->
						<td class="middle" style="padding:0;text-align:left;">
							<input id="price" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
								 value='<s:property value="price"/>'/>
						</td>
						<!-- 合计 -->
						<td class="last" style="padding:0;text-align:left;">
							<input id="amount" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
								 value='<s:property value="count*price"/>'/>
						</td>
					</tr>
					</s:iterator>
				</table>
			</div>
			</div>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.carId" />
		<s:hidden name="e.buyerId" />
		<s:hidden name="e.cashierId.id" />
		<s:hidden name="e.payType" />
		<s:hidden name="e.bankCode" />
		<s:hidden name="isMoreCar"/>
		<s:hidden name="isMoreBuyer"/>
		<s:hidden name="isNullCar"/>
		<s:hidden name="isNullBuyer"/>
		<!-- 销售明细隐藏信息 -->
		<s:hidden name="sellDetails"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>