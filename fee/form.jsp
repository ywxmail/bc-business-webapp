<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div 
	title='<s:text name="fee.title"/>' 
	data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/fee/save" />'
	data-js='<s:url value="/bc-business/fee/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bs.feeForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="feeForm" theme="simple">
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >基本信息:</span>
				<span id="showGroups1" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="fee.title.click2HiddenGroups"/>'></span>
			</div>
			<div id="div1">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 90px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
						</tr>
						<tr class="value">
							<td class="label">*<s:text name="fee.feeDate"/>:</td>
							<td class="value relative">
								<s:if test="e.isNew()">
									<div style="display: inline-block">
										<s:textfield name="e.feeYear" data-validate='{required:true,type:"digits"}' cssStyle="width:3em;" cssClass="ui-widget-content"/> 年
									</div>
									<div style="display: inline-block">
										<s:select name="e.feeMonth" data-validate='{required:true,type:"digits"}' cssStyle="width:4em;" list="feeMonths" listKey="key" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"></s:select> 月
									</div>
								</s:if>
								<s:else>
									<div style="display: inline-block">
										<s:textfield name="e.feeYear" data-validate='{required:true,type:"digits"}' cssStyle="width:3em;" readonly="true" cssClass="ui-widget-content"/> 年
									</div>
									<div style="display: inline-block">
										<s:textfield name="e.feeMonth" data-validate='{required:true,type:"digits"}' cssStyle="width:4em;" readonly="true" cssClass="ui-widget-content"/> 月
									</div>
								</s:else>
								<div style="display: inline-block">
									<input type="text" name="e.feeDate" 
		                            data-validate='{required:true,type:"date"}'class="bc-date ui-widget-content" title='<s:text name="title.click2selectDate"/>'
	                                value='<s:date format="yyyy-MM-dd" name="e.feeDate" />' style="width:8em;"/>
	                                <ul class="inputIcons" style="right : 1em;">
										<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.feeDate' ></li>
								    </ul>
								</div>
							</td>
							<td class="label">*<s:text name="fee.company"/>:</td>
							<td class="value"><s:textfield name="e.company" cssClass="ui-widget-content" data-validate="required"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="fee.collectionWay"/>:</td>
							<td class="value"><s:textfield name="e.collectionWay" cssClass="ui-widget-content"/></td>
							<td class="label" >*<s:text name="fee.motorcade"/>:</td>
							<td class="value">
								<s:select name="e.motorcadeId" list="motorcadeList" listKey="key" listValue="value" value="e.motorcadeId" headerKey="" headerValue="" cssClass="ui-widget-content" data-validate="required"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label">*<s:text name="fee.car"/>:</td>
							<td class="value">
								<div style="position:relative;display:block" >
									<s:textfield name="e.carPlate" readonly="true" cssClass="ui-widget-content" data-validate="required"/>
									<s:if test="e.isNew()">
										<ul class="inputIcons">
									 		<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectCarPlate">
									 	</ul>
								 	</s:if>
							 	</div>
							</td>
		               		<td class="label">*<s:text name="fee.payerName"/>:</td>
							<td class="value">
								<div style="position:relative;display:block" >
									<s:textfield name="e.payerName" readonly="true" cssClass="ui-widget-content" data-validate="required"/>
									<ul class="inputIcons">
							 			<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectPayerName">
							 		</ul>
								</div>
							</td>
						</tr>
						<tr>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div style="width:710px;">
			<div class="formTopInfo">
				<s:if test="%{e.author.name != null}">
				登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
				</s:if>
				<s:if test="%{e.modifier != null}">
				，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
				</s:if>
			</div>
		</div>
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >前期欠费:</span>
				<span id="showGroups2" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="fee.title.click2HiddenGroups"/>'></span>
			</div>
			<div id="div2">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 90px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="value" colspan="4" style="text-align: center">
							&nbsp;&nbsp;&nbsp;<s:text name="fee.subtotal"/>:
								<s:textfield name="b4oweSubtotal" cssStyle="width:20%" value="%{getText('bs.format.number',{b4oweSubtotal})}" cssClass="ui-widget-content nostyle" readonly="true"/>
							&nbsp;&nbsp;&nbsp;<s:text name="fee.upkeep"/>:
								<s:textfield name="b4oweUpkeep" cssStyle="width:20%"  value="%{getText('bs.format.number',{b4oweUpkeep})}" cssClass="ui-widget-content nostyle" readonly="true"/>
							&nbsp;&nbsp;&nbsp;<s:text name="fee.total"/>:
								<s:textfield name="b4oweTotal" cssStyle="width:20%"  value="%{getText('bs.format.number',{b4oweTotal})}" cssClass="ui-widget-content nostyle" readonly="true"/>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="ui-widget-content" style="border-width:1px 0 0 0;margin-bottom:8px;width: 100%;">
					<div class="ui-widget-header" style="position:relative;border-width: 0;padding: 0.25em;">
						<span class="text">前期欠费明细:</span>
					</div>
				   	<div class="bc-grid header" style="overflow-x:scroll;">
						<table class="table" id="b4feeOweDetailTables" cellspacing="0" cellpadding="0">
							<tr class="ui-state-default header row">
								<td class="first" style="width: 2em">&nbsp;</td>
								<td class="middle" style="width: 15em;">费用名称</td>
								<td class="middle" style="width: 10em;">费用</td>
								<td class="last" colspan="1" style="width: 26.375em;">备注</td>
							</tr>
							<s:iterator var="b4o" value="b4feeOweDetail">
							<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
								<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
								</td>
								<td class="middle" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
										value='<s:property value="feeName"/>' readonly="readonly" />
								</td>
								<td class="middle" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
									  value='<s:property value="charge"/>' readonly="readonly"/>
								</td>
								<td class="middle" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
										 value='<s:property value="feeDescription"/>' readonly="readonly"/>
								</td>
								<td class="last" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="hidden" class="ui-widget-content"
									 value='<s:property value="feeType"/>' readonly="readonly"/>
								</td>
							</tr>
							</s:iterator>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >本期应收款:</span>
				<span id="showGroups3" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="fee.title.click2HiddenGroups"/>'></span>
			</div>
			<div id="div3" class="content">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 150px;">&nbsp;</td>
							<td style="width: 200px;">&nbsp;</td>
							<td style="width: 150px;">&nbsp;</td>
							<td style="width: 200px;">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2">
							    <fieldset class="ui-widget-content">
							    	<legend>本期应收</legend>
							        <table class="formFields" cellspacing="2" cellpadding="0" style="width: 100%;">
										<tr class="widthMarker">
											<td style="width: 100px;"></td>
											<td style="width: 200px;"></td>
											<td style="width: 200px;"></td>
											<td >&nbsp;</td>
										</tr>
										<tr>
							               	<td class="label">*<s:text name="fee.subtotal"/>:</td>
											<td class="value" colspan="3">
												<s:textfield name="e.shouldSubtotal" value="%{getText('bs.format.number',{e.shouldSubtotal})}" data-validate='{required:true,type:"number"}' cssClass="ui-widget-content "/>
											</td>
						               </tr>
						               <tr>
						               		<td class="label">*<s:text name="fee.upkeep"/>:</td>
											<td class="value" colspan="3">
												<s:textfield name="e.shouldUpkeep" value="%{getText('bs.format.number',{e.shouldUpkeep})}" data-validate='{required:true,type:"number"}' cssClass="ui-widget-content "/>
											</td>
					                   </tr>
					                   <tr>
					                   		<td class="label" ><s:text name="fee.total"/>:</td>
											<td class="value" colspan="3">
												<s:textfield name="e.shouldTotal" value="%{getText('bs.format.number',{e.shouldTotal})}" cssClass="ui-widget-content nostyle" readonly="true"/>
											</td>
					                   </tr>
							        </table>
							   </fieldset>
							</td>
							<td colspan="2">
								<fieldset class="ui-widget-content">
					          		<legend>本期调整</legend>
					          		<table class="formFields" cellspacing="2" cellpadding="0" style="width: 100%;">
							          	<tr class="widthMarker">
											<td style="width: 100px;"></td>
											<td style="width: 200px;"></td>
											<td style="width: 200px;"></td>
											<td >&nbsp;</td>
										</tr>
										<tr>
							               	<td class="label">*<s:text name="fee.subtotal"/>:</td>
											<td class="value" colspan="3">
												<s:textfield name="e.adjustSubtotal" value="%{getText('bs.format.number',{e.adjustSubtotal})}" data-validate='{required:true,type:"number"}' cssClass="ui-widget-content "/>
											</td>
						               </tr>
						               <tr>
						               		<td class="label">*<s:text name="fee.upkeep"/>:</td>
											<td class="value" colspan="3">
												<s:textfield name="e.adjustUpkeep" value="%{getText('bs.format.number',{e.adjustUpkeep})}" data-validate='{required:true,type:"number"}' cssClass="ui-widget-content "/>
											</td>
					                   </tr>
					                   <tr>
					                   		<td class="label" ><s:text name="fee.total"/>:</td>
											<td class="value" colspan="3">
												<s:textfield name="e.adjustTotal" value="%{getText('bs.format.number',{e.adjustTotal})}" cssClass="ui-widget-content nostyle" readonly="true"/>
											</td>
					                   </tr>
					        		</table>
					    		</fieldset>
					    	</td>
						</tr>
						<tr>
							<td class="label"><s:text name="fee.benqiyingshouheji"/>:</td>
							<td colspan="3">
								<s:textfield name="e.saTotal1" value="%{getText('bs.format.number',{e.saTotal1})}" cssClass="ui-widget-content nostyle" readonly="true"/>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="fee.qianqibenqiyingshouheji"/>:</td>
							<td colspan="3">
								<s:textfield name="e.saTotal2" value="%{getText('bs.format.number',{e.saTotal2})}" cssClass="ui-widget-content nostyle" readonly="true"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >本期实收:</span>
				<span id="showGroups4" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="fee.title.click2HiddenGroups"/>'></span>
			</div>
			<div id="div4" class="content">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 90px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="value" colspan="4" style="text-align: center">
							&nbsp;&nbsp;*<s:text name="fee.subtotal"/>:
								<s:textfield name="e.realSubtotal" cssStyle="width:20%" value="%{getText('bs.format.number',{e.realSubtotal})}" data-validate='{required:true,type:"number"}' cssClass="ui-widget-content "/>
							&nbsp;&nbsp;*<s:text name="fee.upkeep"/>:
								<s:textfield name="e.realUpkeep" cssStyle="width:20%"  value="%{getText('bs.format.number',{e.realUpkeep})}" data-validate='{required:true,type:"number"}' cssClass="ui-widget-content "/>
							&nbsp;&nbsp;*<s:text name="fee.total"/>:
								<s:textfield name="e.realTotal" cssStyle="width:20%"  value="%{getText('bs.format.number',{e.realTotal})}" data-validate='{required:true,type:"number"}' cssClass="ui-widget-content "/>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="ui-widget-content" style="border-width:1px 0 0 0;margin-bottom:8px;width: 100%;">
					<div class="ui-widget-header" style="position:relative;border-width: 0;padding: 0.25em;">
						<span class="text">本期实收明细:</span>
						<ul class="inputIcons">
							<li id="addLine" class="inputIcon ui-icon ui-icon-circle-plus"
								title='<s:text name="点击新增一行实收明细"/>'></li>
							<li id="deleteLine" class="inputIcon ui-icon ui-icon-circle-close"
								title='<s:text name="点击删除一行实收明细"/>'></li>
						</ul>
					</div>
				   	<div class="bc-grid header" style="overflow-x:scroll;">
						<table class="table" id="feeDetailTables" cellspacing="0" cellpadding="0">
							<tr class="ui-state-default header row">
								<td class="first" style="width: 2em">&nbsp;</td>
								<td class="middle" style="width: 15em;">费用名称</td>
								<td class="middle" style="width: 10em;">费用</td>
								<td class="last" colspan="1" style="width: 26.375em;">备注</td>
							</tr>
							<s:iterator var="r" value="e.feeRealDetail">
							<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
								<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
								</td>
								<td class="middle" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
										value='<s:property value="feeName"/>' data-validate="required" />
								</td>
								<td class="middle" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
									 data-validate='{"type":"number","required":true}' value='<s:property value="charge"/>'/>
								</td>
								<td class="middle" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
										 value='<s:property value="feeDescription"/>'/>
								</td>
								<td class="last" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="hidden" class="ui-widget-content"
									 value='<s:property value="feeType"/>'/>
								</td>
							</tr>
							</s:iterator>
							
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >本期欠费:</span>
				<span id="showGroups5" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="fee.title.click2HiddenGroups"/>'></span>
			</div>
			<div id="div5" class="content">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 90px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="value" colspan="4" style="text-align: center">
							&nbsp;&nbsp;&nbsp;<s:text name="fee.subtotal"/>:
								<s:textfield name="e.oweSubtotal" cssStyle="width:20%" value="%{getText('bs.format.number',{e.oweSubtotal})}" data-validate='{required:true,type:"digits"}' cssClass="ui-widget-content "/>
							&nbsp;&nbsp;&nbsp;<s:text name="fee.upkeep"/>:
								<s:textfield name="e.oweUpkeep" cssStyle="width:20%"  value="%{getText('bs.format.number',{e.oweUpkeep})}" data-validate='{required:true,type:"digits"}' cssClass="ui-widget-content "/>
							&nbsp;&nbsp;&nbsp;<s:text name="fee.total"/>:
								<s:textfield name="e.oweTotal" cssStyle="width:20%"  value="%{getText('bs.format.number',{e.oweTotal})}" data-validate='{required:true,type:"digits"}' cssClass="ui-widget-content "/>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="ui-widget-content" style="border-width:1px 0 0 0;margin-bottom:8px;width: 100%;">
					<div class="ui-widget-header" style="position:relative;border-width: 0;padding: 0.25em;">
						<span class="text">本期欠费明细:</span>
						<ul class="inputIcons">
							<li id="addOweLine" class="inputIcon ui-icon ui-icon-circle-plus"
								title='<s:text name="点击新增一行欠费明细"/>'></li>
							<li id="deleteOweLine" class="inputIcon ui-icon ui-icon-circle-close"
								title='<s:text name="点击删除一行欠费明细"/>'></li>
						</ul>
					</div>
				   	<div class="bc-grid header" style="overflow-x:scroll;">
						<table class="table" id="feeOweDetailTables" cellspacing="0" cellpadding="0">
							<tr class="ui-state-default header row">
								<td class="first" style="width: 2em">&nbsp;</td>
								<td class="middle" style="width: 15em;">费用名称</td>
								<td class="middle" style="width: 10em;">费用</td>
								<td class="last" colspan="1" style="width: 26.375em;">备注</td>
							</tr>
							<s:iterator var="o" value="e.feeOweDetail">
							<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
								<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
								</td>
								<td class="middle" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
										value='<s:property value="feeName"/>' data-validate="required" />
								</td>
								<td class="middle" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
									 data-validate='{"type":"number","required":true}' value='<s:property value="charge"/>'/>
								</td>
								<td class="middle" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
										 value='<s:property value="feeDescription"/>'/>
								</td>
								<td class="last" style="padding:0;text-align:left;">
									<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="hidden" class="ui-widget-content"
									 value='<s:property value="feeType"/>'/>
								</td>
							</tr>
							</s:iterator>
							
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="formTable2 ui-widget-content" style="width:710px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >备注:</span>
				<span id="showGroups6" class="verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="fee.title.click2HiddenGroups"/>'></span>
			</div>
			<div id="div6" class="content">
				<table class="formFields" cellspacing="2" cellpadding="0">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 90px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
						</tr>
						<tr>
							<td class="topLabel">
								<s:text name="fee.description"/>:
							</td>
							<td class="value" colspan="3"><s:textarea name="e.desc" rows="4" cssClass="ui-widget-content noresize"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	<s:hidden name="e.uid" />
	<s:hidden name="e.id" />
	<s:hidden name="e.author.id" />
	<s:hidden name="e.motorcadeName" />
	<s:hidden name="e.carId" />
	<s:hidden name="e.payerId" />
	<s:hidden name="e.status" />
	<s:hidden name="isMoreCar" />
	<s:hidden name="isMoreCarMan" />
	<s:hidden name="carId" />
	<s:hidden name="carManId" />
	<s:hidden name="isNullCarMan" />
	<s:hidden name="isNullCar" />
	<s:hidden name="feeDetails"/>
	<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	
	</s:form>
</div>