<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="piliangXiuGai.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/batchChange/save" />'
	data-js='<s:url value="/bc-business/ownership/piliangXiuGaiForm.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/bc-business/carByDriverHistory/form.js" />'
	data-initMethod='bc.business.piliangXiuGaiForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carByDriverForm" theme="simple" >
		<div class="formFields ui-widget-content" style="width:510px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
				    <tr class="widthMarker">
		                <td style="width:230px;">&nbsp;</td>
		                <td >&nbsp;</td>
	                </tr>
					<tr>
					    <td style="font-weight: normal;"><s:checkbox name="isNature" cssStyle="width:1em;" />*<s:text name="ownership.nature"/>:</td>
					    <td style="font-weight: normal;"><s:text name="car"/>: 
							<ul class="inputIcons" style="margin: -18px 0;position: relative;left: 230px;">
								<li id="addCar" class="inputIcon ui-icon ui-icon-circle-plus"
									title='<s:text name="certLost.title.click2addLine"/>'></li>
								<li id="deleteCar" class="inputIcon ui-icon ui-icon-circle-close"
									title='<s:text name="certLost.title.click2deleteLine"/>'></li>
							</ul>
					    </td>
				    </tr>
				    <tr>
						<td class="value" ><s:select list="natures" listKey="value" listValue="value" data-validate="required" 
						 	headerKey="" headerValue="%{getText('label.please.choose')}" name="natureValue" cssClass="ui-widget-content"></s:select>
				 		</td>
					    <td class="value" rowspan="7">
						    <table style="width:98%;height: 100%;" style="margin:0;padding:0;" cellspacing="0" cellpadding="0" >
							    <tr>
								    <td><s:select name="vehicles" list="cars" listKey="key" listValue="value" theme="simple"
								     	multiple="true" cssStyle="width:100%;height:17em;" cssClass="ui-widget-content" />
							     	</td>
							    </tr>
						    </table>
					    <td>
					</tr>
					<tr>
						<td style="font-weight: normal;"><s:checkbox name="isSituation" cssStyle="width:1em;" />*<s:text name="ownership.situation"/>:</td>
					</tr>
					<tr>
						<td class="value" ><s:select list="situations" listKey="value" listValue="value" data-validate="required" 
							headerKey="" headerValue="%{getText('label.please.choose')}" name="situationValue" cssClass="ui-widget-content"></s:select>
						</td>
					</tr>
					<tr>
						<td style="font-weight: normal;"><s:checkbox name="isOwner" cssStyle="width:1em;" /><s:text name="ownership.owner"/>:</td>
					</tr>
					<tr>
						<td class="value" ><s:select list="owners" listKey="value" listValue="value" headerKey="" 
							headerValue="" name="ownerValue" cssClass="ui-widget-content"></s:select>
						</td>
					</tr>
					<tr>
						<td style="font-weight: normal;"><s:text name="ownership.description"/>:</td>
					</tr>
					<tr>
						<td class="value"><s:textarea name="e.description" rows="5" cssClass="ui-widget-content noresize"/></td>
					</tr>
					<tr>
						<td class="label" colspan="2">
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
		</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.modifier.id"/>
		<s:hidden name="vehicles"/>
		<s:hidden name="isNature"/>
		<s:hidden name="isSituation"/>
		<s:hidden name="isOwner"/>
		<s:hidden name="natureValue"/>
		<s:hidden name="situationValue"/>
		<s:hidden name="ownerValue"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>