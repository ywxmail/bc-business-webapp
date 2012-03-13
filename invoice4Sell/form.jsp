<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="invoice4Sell.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/invoice4Sell/save" />'
	data-js='<s:url value="/bc-business/invoice4Sell/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bs.invoice4SellForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="invoice4SellForm" theme="simple">
		<div class="formFields ui-widget-content" >
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td style="width: 100px;"></td>
						<td style="width: 300px;">&nbsp;</td>
						<td style="width: 100px;">&nbsp;</td>
						<td >&nbsp;</td>
					</tr>
					<tr>
					    <td class="label">*<s:text name="invoice4Sell.selldate"/>:</td>
						<td class="value relative">
							<input type="text" name="e.buyDate" data-validate='{"type":"date","required":true}'
							value='<s:date format="yyyy-MM-dd" name="e.sellDate" />'
							class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.sellDate'></li>
							</ul>
						</td>
						<td class="label">*<s:text name="invoice.company"/>:</td>
						<td class="value ">
							<s:select name="e.company" list="companyList" listKey="value" listValue="value" data-validate="required" 
								 cssClass="ui-widget-content" />
						</td>
					</tr>
					<!-- 车辆 		车队 -->
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
					    <td class="label">*<s:text name="invoice.motorcade"/>:</td>
						<td class="value"><s:select name="e.motorcadeId" list="motorcadeList" listKey="key" data-validate="required"
										listValue="value" value="e.motorcadeId" headerKey="" headerValue="" cssClass="ui-widget-content"/>
					    </td>
					</tr>
					<!-- 购买人	收银员 -->
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
							<s:textfield name="cashier" cssClass="ui-widget-content" readonly="true" data-validate="required" />
							<ul class="inputIcons">
								 <li id="selectCashier" class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></li>
							</ul>
						</td>
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
			<!-- 销售明细 -->
			<div class="ui-widget-content" style="border-width:1px 0 0 0;margin-bottom:8px;">
				<div class="ui-widget-header" style="position:relative;border-width: 0;padding: 0.25em;">
					<span class="text"><s:text name="invoice4Sell.detail"/>：</span>
					<ul class="inputIcons">
						<li id="addLine" class="inputIcon ui-icon ui-icon-circle-plus"
							title='<s:text name="certLost.title.click2addLine"/>'></li>
						<li id="deleteLine" class="inputIcon ui-icon ui-icon-circle-close"
							title='<s:text name="certLost.title.click2deleteLine"/>'></li>
					</ul>
				</div>
		    	<div class="bc-grid header">
				<table class="table" id="certTables" cellspacing="0" cellpadding="0" style="width: 100%;">
					<tr class="ui-state-default header row">
						<td class="first" style="width: 15px;">&nbsp;</td>
						<td class="middle" style="width: 16em;"><s:text name="invoice.code"/></td>
						<td class="middle" style="width: 8em;"><s:text name="invoice.type"/></td>
						<td class="middle" style="width: 8em;"><s:text name="invoice.startNo"/></td>
						<td class="middle" style="width: 8em;"><s:text name="invoice.endNo"/></td>
						<td class="middle" style="width: 5em;"><s:text name="invoice.count"/></td>
						<td class="middle" style="width: 6em;"><s:text name="invoice4Sell.price"/>(元)</td>
						<td class="last" style="min-width: 4em;"><s:text name="invoice.amount"/></td>
					</tr>
					<!-- 新建时 -->
					<s:if test="%{e.isNew()}">
					<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
						<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
						</td>
							<s:select name="code" list="codeList" theme="simple" data-validate="required" cssClass="ui-widget-content" 
									cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"/>
						</td>
						<td class="middle" style="padding:0;text-align:left;">
							<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
								value='<s:property value=""/>' />
						</td>
						<td class="middle" style="padding:0;text-align:left;">
							<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
								value='<s:property value=""/>'/>
						</td>
						<td class="middle" style="padding:0;text-align:left;">
							<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
								value='<s:property value=""/>' />
						</td>
						<td class="middle" style="padding:0;text-align:left;">
							<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
								value='<s:property value=""/>'/>
						</td>
						<td class="middle" style="padding:0;text-align:left;">
							<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
								value='<s:property value=""/>' />
						</td>
						<td class="last" style="padding:0;text-align:left;">
							<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content"
								 value='<s:property value=""/>'/>
						</td>
					</tr>
					</s:if>
					
					
					<%-- <s:iterator var="b" value="e.certLostItem">
					<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
						<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
						</td>
						<td class="middle" style="padding:0;text-align:left;">
							<s:if test="isReadonly()">
								<s:textfield name="certName" cssClass="ui-widget-content" cssStyle="width:99%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;"/>
							</s:if>
							<s:else>
							<div class="bc-relativeContainer">
								<input type="text" name="certName" value='<s:property value="certName"/>' style="width:99%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" 
									class="bc-select ui-widget-content" data-validate="required" 
									data-maxHeight="150px"
									data-source='<s:property value="certNames"/>'/>
								<ul class="inputIcons">
									<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
								</ul>
							</div>
							</s:else>
						</td>
						<td class="middle" style="padding:0;text-align:left;">
							<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
								value='<s:property value="certNo"/>'/>
						</td>
						<td class="middle" style="padding:0;text-align:left;">	
							<s:select name="reason" list="{'掉失','被盗','损坏','其它'}" theme="simple" data-validate="required" cssClass="ui-widget-content" 
										cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"/>
						</td>
						<td class="middle" style="padding:0;text-align:left;">
							<s:select name="remains" list="#{'false':'无','true':'有'}" listKey="key" listValue="value" data-validate="required" cssClass="ui-widget-content" 
										cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"/>
						</td>
						<td class="middle" style="padding:0;text-align:left;">
							<s:select name="replace" list="#{false:'未补办',true:'补办'}" listKey="key" listValue="value" data-validate="required" cssClass="ui-widget-content" 
										cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"/>
						</td>
						<td class="middle" style="padding:0;text-align:left;">
						<div class="relative">
							<input type="text" name="replaceDate" data-validate='{"type":"date","required":false}' style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"
							value='<s:date format="yyyy-MM-dd" name="replaceDate" />'
							class="bc-date ui-widget-content" />
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='replaceDate'></li>
							</ul>
						</div>
						</td>
						<td class="middle" style="padding:0;text-align:left;">
							<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
								value='<s:property value="newCertNo"/>'/>
						</td>
						<td class="middle" style="padding:0;text-align:left;">
							<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
								value='<s:property value="lostAddress"/>'/>
						</td>
						<td class="last" style="padding:0;text-align:left;">
							<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
								 value='<s:property value="description"/>'/>
						</td>
					</tr>
					</s:iterator> --%>
				</table>
			</div>
			</div>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.carId" />
		<s:hidden name="e.buyerId" />
		<s:hidden name="e.cashierId" />
		<s:hidden name="e.payType" />
		<s:hidden name="e.bankCode" />
		<s:hidden name="isMoreCar"/>
		<s:hidden name="isMoreCarMan"/>
		<s:hidden name="isNullCar"/>
		<s:hidden name="isNullCarMan"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>