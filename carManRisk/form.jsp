<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div 
	<s:if test="%{e.type == 2}">
		title='<s:text name="caseAdvice1.title"/>' 
	</s:if>
	<s:elseif test="%{e.type == 6}">
		title='<s:text name="caseAdvice2.title"/>' 
	</s:elseif>
	data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/caseAdvice/save" />'
	data-js='<s:url value="/bc-business/carManRisk/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.carManRiskForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseAdviceForm" theme="simple" cssStyle="width:710px;padding:8px;">
		<div class="ui-widget-content">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >基本信息:</span>
				<span class="toggle verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="runcase.title.click2HiddenGroups"/>'></span>
			</div>
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td style="width: 100px;">&nbsp;</td>
						<td style="width: 260px;">&nbsp;</td>
						<td style="width: 90px;">&nbsp;</td>
						<td style="width: 260px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label"><s:text name="carManRisk.company"/>:</td>
						<td class="value"><s:textfield name="e.company" cssClass="ui-widget-content"/></td>
						<td class="label" ><s:text name="carManRisk.code"/>:</td>
						<td class="value">&nbsp;</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="ui-widget-content">
			<div class="formTopInfo">
				登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
				<s:if test="%{e.modifier != null}">
				，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
				</s:if>
			</div>
		</div>
		<div class="ui-widget-content">
			<div class="ui-widget-header title" style="position:relative;">
				<span class="text" >参保司机:</span>
				<span class="toggle verticalMiddle ui-icon ui-icon-carat-1-n" title='<s:text name="runcase.title.click2HiddenGroups"/>'></span>
			</div>
			<div class="bc-grid header">
				<table class="table carMans" cellspacing="0" cellpadding="0" style="width:100%">
					<tbody>
					<tr class="widthMarker" style="height: 0;line-height:0;font-size: 0;border: none;margin: 0;padding: 0;">
								<td class="first" style="width: 15px;">&nbsp;</td>
								<td class="middle" style="width: 130px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 105px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 50px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 85px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 100px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 15px;text-align: center;">&nbsp;</td>
								<td class="middle" style="width: 100px;text-align: center;">&nbsp;</td>
								<td class="last" style="text-align: center;">&nbsp;</td>
					</tr>
					<tr class="ui-state-default row">
						<td class="first" style="width: 15px;height: 20px;padding:0;text-align:left;" title="点击全选!"><span class="ui-icon ui-icon-notice"></span></td>
						<td class="middle" style="width: 130px;text-align: center;">项目</td>
						<td class="middle" style="width: 105px;text-align: center;">金额(元)</td>
						<td class="middle" style="width: 50px;text-align: center;">数量</td>
						<td class="middle" style="width: 85px;text-align: center;">收费方式</td>
						<td class="middle" style="border-right: 1px ;text-align: center;width: 215px;" colspan="3">收费期限</td>
						<td class="last" style="text-align: center;">备注</td>
					</tr>
					<tr class="ui-widget-content row" data-id="10298854">
						<td class="id first" style="padding:0;text-align:left;" data-code="CC.JCBHT.AQHZJ" data-spec="{&quot;isByDriver&quot;:true}"><span class="ui-icon"></span></td>
						<td class="middle" style="padding:0;text-align:left;width: 130px;">
						<label id="open_" style="width:90%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" class="class java.util.HashMap" type="text" readonly="readonly">安全互助金</label>
						</td>
						<td class="middle" style="padding:0;text-align:left;width: 105px;">
							<label style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content">
								2,000
							</label>
						</td>
						<td class="middle" style="padding:0;text-align:left;width: 50px;">
							<label id="open_" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" class="class java.util.HashMap" type="text">2</label>
						</td>
						<td class="middle" style="padding:0;text-align:left;width: 85px;">
								一次性
						</td>
						<td class="middle" style="padding:0;text-align:left;border-right: 1px ;width: 100px;">
						</td>
						<td class="middle" style="padding:0;text-align:left;border-right: 1px ;border-left: 1px;width: 15px;">~</td>
						<td class="middle" style="padding:0;text-align:right;border-left: 1px;width: 100px;">
						</td>
						<td class="last" style="padding:0;text-align:left;">
							<label id="open_" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" class="class java.util.HashMap" type="text"></label>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
	<s:hidden name="e.id" />
	<s:hidden name="e.status" />
	<s:hidden name="e.uid" />
	<s:hidden name="e.author.id" />
	<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>