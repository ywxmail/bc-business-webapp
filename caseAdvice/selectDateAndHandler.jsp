<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='核准操作' data-type='form'
	class="bc-page"
	data-js='<s:url value="/bc-business/caseAdvice/selectDateAndHandler.js" />'
	data-initMethod='bc.selectDateAndHandlerForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectDateAndHandlerForm.clickOk"}],
		"width":500,height:220,modal:true
	}'
	style="overflow-y: hidden;">
	<s:form name="selectDateAndHandlerForm" theme="simple">
		<div style="position: relative; display: inline-block;margin:2px 0;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td>&nbsp;</td>
						<td style="width: 165px;">&nbsp;</td>
						<td style="width: 85px;">&nbsp;</td>
						<td style="width: 165px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.handlerName"/>:</td>
						<td class="value relative">
							<s:textfield name="handlerName" cssClass="ui-widget-content" data-validate="required" readonly="true"/>
							<ul class="inputIcons">
						 		<li class="inputIcon ui-icon ui-icon-circle-plus" id="selectHandlerName">
						 	</ul>
						</td>
						<td class="label">*<s:text name="runcase.handleDate"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<input type="text" name="handleDate" data-validate='{"type":"datetime","required":true}'
							value='<s:date format="yyyy-MM-dd HH:mm:ss" name="handleDate" />'
							class="bc-datetime ui-widget-content" data-cfg='{changeYear:true,timeFormat:"hh:mm:ss",showSecond:true}'/>
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='handleDate'></li>
							</ul>
						</td>
					</tr>
					<tr>
						<td class="topLabel"><s:text name="runcase.handleOpinion"/>:</td>
						<td class="value" colspan="3"><s:textarea name="handleOpinion" rows="4" cssClass="ui-widget-content noresize"/></td>
					</tr>
				</tbody>
			</table>
		</div>
		<s:hidden name="handlerId"/>
	</s:form>
</div>