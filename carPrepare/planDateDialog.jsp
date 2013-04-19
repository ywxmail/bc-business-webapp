<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="bc-page" title='<s:text name="carPrepare.createAnnualPlan"/>' 
	data-type='dialog' 
	data-js='<s:url value="/bc/identity/identity.js" />'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bs.carPrepareView.createAnnualPlan"}],
		"width":300,"modal":true
	}' >
	<s:form name="carPrepareForm" theme="simple">
		<table class="formFields" cellspacing="2" cellpadding="0">
			<tbody>
				<tr class="widthMarker">
					<td style="width: 4em;"></td>
					<td >&nbsp;</td>
				</tr>
				<tr>
					<td style="text-align: right;vertical-align: middle;font-weight: normal;">*年份：</td>
					<td class="value "><s:textfield name="year" data-validate='{"required":true,"type":"digits","max":9999,"min":1000,msg:"年份必须填写1000~9999！"}' cssClass="ui-widget-content"/></td>
				</tr>
				<tr>
					<td style="text-align: right;vertical-align: middle;font-weight: normal;">月份：</td>
					<td class="value "><s:textfield name="month" data-validate='{"required":false,"type":"digits","max":12,"min":1,msg:"年份必须填写1~12！"}' cssClass="ui-widget-content"/></td>
				</tr>
			</tbody>
		</table>
		<p class="formComment">备注：若月份为空则生成的为年度更新计划。</p>
	</s:form>
</div>