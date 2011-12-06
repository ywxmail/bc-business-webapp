<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="injury.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/injury/save" />'
	data-js='<s:url value="/bc-business/injury/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.injuryForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="injuryForm" theme="simple">
		<div class="formFields ui-widget-content"  style="width:710px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td >&nbsp;</td>
						<td style="width: 200px;">&nbsp;</td>
						<td style="width: 60px;">&nbsp;</td>
						<td style="width: 220px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="injury.code"/>:</td>
						<td class="value "><s:textfield name="e.code" data-validate="required" readonly="true"  cssClass="ui-widget-content"/></td>
						<td class="label">*<s:text name="injury.happenDate"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
							value='<s:date format="yyyy-MM-dd HH:mm" name="e.happenDate" />'
							class="bc-datetime ui-widget-content" data-cfg='{changeYear:true}'/>
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.happenDate' ></li>
							</ul>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="injury.compensation"/>:</td>
						<td class="value ">
							<s:textfield name="e.compensation" data-validate="required" cssClass="ui-widget-content"/>
						</td>
						<td class="label">*<s:text name="injury.confirmDate"/>:</td>
						<td class="value" style="position:relative;display: block;">
							<input type="text" name="e.confirmDate" data-validate='{"type":"date","required":true}'
							value='<s:date format="yyyy-MM-dd" name="e.confirmDate" />'
							class="bc-date ui-widget-content" data-cfg='{changeYear:true}'/>
							<ul class="inputIcons">
								<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.confirmDate' ></li>
							</ul>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="injury.money"/>:</td>
						<td class="value ">
							<s:textfield name="e.money" data-validate='{"type" : "number" , "required":true,max:5000000}' cssClass="ui-widget-content"/>
						</td>
						<td class="label">*<s:text name="injury.startDate"/>:</td>
						<td class="value">
							<div style="position : relative; display: inline-block">
							&nbsp;从<input type="text" name="e.startDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.startDate" />'
								style="width: 8.5em;" readonly="readonly" class="bc-date ui-widget-content" />
								<ul class="inputIcons" style="right : 0px;">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.startDate' ></li>
								</ul>
							</div>
							<div style="position : relative; display: inline-block">
							&nbsp;到<input type="text" name="e.endDate" data-validate='{"type":"date","required":true}'
								value='<s:date format="yyyy-MM-dd" name="e.endDate" />'
								style="width: 8.5em;" readonly="readonly" class="bc-date ui-widget-content" />
								<ul class="inputIcons" style="right : 0px;">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.endDate' ></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label" style="vertical-align: top;"><s:text name="injury.description"/>:</td>
						<td class="value" colspan="3"><s:textarea name="e.description" rows="5" cssClass="ui-widget-content" cssStyle="width: 46.8em;" /></td>
					</tr>			
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td colspan="6" class="label" style="text-align: right;">
							<s:checkbox name="e.oAS" cssStyle="width:1em;" />
							<s:text name="injury.oAS"/>
							<s:checkbox name="e.inHospital" cssStyle="width:1em;"/>
							<s:text name="injury.inHospital"/>
							<s:checkbox name="e.li" cssStyle="width:1em;" />
							<s:text name="injury.li"/>
						</td>
					</tr>
					<tr>
						<td class="label" colspan="4">
							<div class="formTopInfo">
								状态：<s:property value="%{statusesValue[e.status]}" />，
								<s:if test="%{e.author.name != null}">
								登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
								<s:if test="%{e.modifier != null}">
								，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
								</s:if>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.uid"/>
		<s:hidden name="e.status"/>
		<s:hidden name="e.contractId"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>