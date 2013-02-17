<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="carManRisk.title" />' 
	data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/carManRisk/save" />'
	data-js='<s:url value="/bc-business/carManRisk/form.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.carManRiskForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseAdviceForm" theme="simple" cssStyle="width:710px;padding:8px;max-height:600px;">
		<div class="ui-widget-content item" style="margin-bottom:4px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >基本信息:</span>
				<ul class="inputIcons">
					<li class="showItem inputIcon ui-icon ui-icon-carat-1-n toggle"		title='点击隐藏内容' data-show-status="1"></li>
				</ul>
			</div>
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td style="width: 9em;">&nbsp;</td>
						<td style="width: 17em;">&nbsp;</td>
						<td style="width: 8em;">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="carManRisk.company"/>:</td>
						<td class="value relative">
							<input type="text" name="e.company" value='<s:property value="e.company"/>' style="width:17em;" 
								data-validate='required' class="bc-select ui-widget-content"
								data-maxHeight="150px"
								data-source='["中国人寿","中国平安"]'/>
							<ul class="inputIcons">
								<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							</ul>
						</td>
						<td class="label">*<s:text name="carManRisk.code"/>:</td>
						<td class="value"><s:textfield name="e.code" cssClass="ui-widget-content" data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="carManRisk.buyType"/>:</td>
						<td class="value">
							<s:select list="#{'':'',1:'是',2:'否'}" listKey="key" listValue="value" cssClass="ui-widget-content" headerValue="" name="e.buyType" data-validate="required"></s:select>
						</td>
						<td class="label"><s:text name="carManRisk.holder"/>:</td>
						<td class="value"><s:textfield name="e.holder" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="carManRisk.startDate"/>:</td>
						<td class="value relative">
							<input type="text" name="e.startDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.startDate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.startDate'></li>
							</ul>
						</td>
						<td class="label">*<s:text name="carManRisk.endDate"/>:</td>
						<td class="value  relative">
							<input type="text" name="e.endDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true}' />
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.endDate'></li>
							</ul>
						</td>
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
		
		<div class="ui-widget-content item" data-item-name='司机' data-item-type='carman' style="margin-bottom:4px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >参保司机:</span>
				<ul class="inputIcons">
					<li class="upItem inputIcon ui-icon ui-icon-circle-arrow-n" 		title='上移选中司机'></li>
					<li class="downItem inputIcon ui-icon ui-icon-circle-arrow-s" 		title='下移选中司机'></li>
					<li class="addItem inputIcon ui-icon ui-icon-circle-plus"			title='添加司机'></li>
					<li class="deleteItem inputIcon ui-icon ui-icon-circle-close"		title='删除司机'></li>
					<li class="showItem inputIcon ui-icon ui-icon-carat-1-n toggle"		title='点击隐藏内容' data-show-status="1"></li>
				</ul>
			</div>
	    	<div  class="bc-grid header">
				<table class="table" id="insurantsTable" cellspacing="0" cellpadding="0" style="width: 100%">
					<tr class="ui-state-default">
						<td class="first" style="width: 1em;">&nbsp;</td>
						<td class="middle" style="width: 6em;">姓名</td>
						<td class="middle" style="width: 6em;">状态</td>
						<td class="middle" style="width: 14em;">身份证号</td>
						<td class="last" >&nbsp;</td>
					</tr>
					<s:iterator var="carman" value="e.insurants">
					<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
						<td class="id first" style="padding:0 0 0 2px"><span class="ui-icon"></span></td>
						<td class="middle" style="padding:0 0 0 2px;">
							<a class="carManName" href="#"><s:property value="name"/></a>
						</td>
						<td class="middle" style="padding:0 0 0 2px;">
							<s:if test="%{status == 0}">
								在案
							</s:if><s:elseif test="%{status == 1}">
								注销
							</s:elseif><s:elseif test="%{status == -1}">
								草稿
							</s:elseif>
						</td>
						<td class="middle" style="padding:0 0 0 2px;">
							<s:property value="cert4Indentity"/>
						</td>
						<td class="last"></td>
					</tr>
					</s:iterator>
				</table>
			</div>
		</div>
		
		<div class="ui-widget-content item" data-item-name='险种' data-item-type='item' style="margin-bottom:2px;">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >险种:</span>
				<ul class="inputIcons">
					<li class="upItem inputIcon ui-icon ui-icon-circle-arrow-n" 		title='上移选中险种'></li>
					<li class="downItem inputIcon ui-icon ui-icon-circle-arrow-s" 		title='下移选中险种'></li>
					<li class="addItem inputIcon ui-icon ui-icon-circle-plus"			title='添加险种'></li>
					<li class="deleteItem inputIcon ui-icon ui-icon-circle-close"		title='删除险种'></li>
					<li class="showItem inputIcon ui-icon ui-icon-carat-1-n toggle"		title='点击隐藏内容' data-show-status="1"></li>
				</ul>
			</div>
	    	<div class="bc-grid header">
				<table class="table" id="itemsTable" cellspacing="0" cellpadding="0" style="width:100%;">
					<tr class="ui-state-default">
						<td class="first" style="width: 1em;">&nbsp;</td>
						<td class="middle" style="width: 8em;">*险种名称</td>
						<td class="middle" style="width: 6em;">*保额</td>
						<td class="middle" style="width: 6em;">*保费</td>
						<td class="last" >备注</td>
					</tr>
					<s:iterator var="item" value="e.items">
						<tr class="ui-widget-content row" data-id='<s:property value="id"/>' >
							<td class="id first" style="padding:0 0 0 2px;"><span class="ui-icon"></span></td>
							<td class="middle" style="padding:0 0 0 2px;">
								<input type="text" style="width:100%;height:100%;padding:0;margin:0;border:none;background:none;" 
									   value='<s:property value="name"/>' data-validate="required" />
							</td>
							<td class="middle" style="padding:0 0 0 2px;">
								<input type="text" style="width:100%;height:100%;padding:0;margin:0;border:none;background:none;" 
									   value='<s:property value="coverage"/>' data-validate="required"/>
							</td>
							<td class="middle" style="padding:0 0 0 2px;">
								<input type="text" style="width:100%;height:100%;padding:0;margin:0;border:none;background:none;" 
									   value='<s:property value="premium"/>' data-validate="required"/>
							</td>
							<td class="last" style="padding:0 0 0 2px;">
								<input type="text" style="width:100%;height:100%;padding:0;margin:0;border:none;background:none;" 
									   value='<s:property value="description"/>' />	
							</td>
						</tr>
					</s:iterator>
				</table>
			</div>
		</div>
	
	<s:hidden name="e.id" />
	<s:hidden name="e.status" />
	<s:hidden name="e.uid" />
	<s:hidden name="e.author.id" />
	<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	<input type="hidden" name="items"/>
	<input type="hidden" name="insurants"/>
	</s:form>
</div>