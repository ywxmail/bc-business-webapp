<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="fee.batchInit.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/batchInit/save" />'
	data-js='<s:url value="/bc-business/fee/batchInitForm.js" />,<s:url value="/bc-business/bs.js" />,<s:url value="/bc-business/carByDriverHistory/form.js" />'
	data-initMethod='bs.batchInitForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="batchInitForm" theme="simple" >
		<table class="formFields" cellspacing="2" cellpadding="0">
			<tbody>
				<tr>
					<td class="value">
						&nbsp;<s:textfield name="feeYear" data-validate='{required:true,type:"digits"}' cssStyle="width:3em;" cssClass="ui-widget-content"/> 年
						&nbsp;<s:select name="feeMonth" data-validate='{required:true,type:"digits"}' cssStyle="width:4em;" list="feeMonths" listKey="key" listValue="value" headerKey="" headerValue="" cssClass="ui-widget-content"/> 月
					</td>
				</tr>
				<tr>
				    <td class="value" style="font-weight: normal;">
				    	<div style="position : relative; display: inline-block">
					    	&nbsp;需要初始化的车辆:
							<ul class="inputIcons" style="margin: -14px 0;position: relative;left: 325px;">
								<li id="addAllCar" class="inputIcon ui-icon ui-icon-info"
									title="添加所有在案车辆"></li>
								<li id="addCar" class="inputIcon ui-icon ui-icon-circle-plus"
									title="添加车辆"></li>
								<li id="deleteCar" class="inputIcon ui-icon ui-icon-circle-close"
									title="删除车辆"></li>
							</ul>
						</div>
				    </td>
			    </tr>
				<tr>
				    <td style="text-align: center;" class="value">
						<s:select name="vehiclesView" list="carList" listKey="key" listValue="value" headerKey="-1" theme="simple"
				     	multiple="true" cssStyle="width:98%;height:16em;" cssClass="ui-widget-content" />
				    </td>
				</tr>
			</tbody>
		</table>
		
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.modifier.id"/>
		<s:hidden name="vehicles"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>