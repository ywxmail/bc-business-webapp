<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="carMan.title"/>' data-type='form' class="bc-page"
	data-namespace="/bc/bc-business/carMan"
	data-js='<s:url value="/bc-business/carMan/form.js" />'
	data-initMethod='bc.carManForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carManForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:710px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label"><s:text name="carMan.name"/>:</td>
						<td class="value"><s:textfield name="e.name" cssStyle="width:8em;" data-validate="required"/><s:radio name="e.sex" list="#{'1':'男','2':'女'}" 
							value="e.sex" cssStyle="width:auto;"/></td>
						<td class="label"><s:text name="carMan.type"/>:</td>
						<td class="value" colspan="3"><s:radio name="e.type" list="#{'0':'司机','1':'责任人','2':'司机和责任人'}" 
							value="e.sex" cssStyle="width:auto;"/></td>
						<td rowspan="3" style="text-align: right;width:110px;">
							<div style="overfloat:hidden;width:110px;height:140px;background: url(<s:url value="%{portrait}" />) no-repeat;" 
								title="点击更改照片"></div>
						</td>
					</tr>
					<tr>
						<td class="label"><s:text name="carMan.origin"/>:</td>
						<td class="value"><s:textfield name="e.origin"/></td>
						<td class="label"><s:text name="carMan.houseType"/>:</td>
						<td class="value"><s:textfield name="e.houseType"/></td>
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
		<div class="formTabs" id="formTabs">
			<ul>
				<li><a href='<s:url value="/bc/unit/list" />'>营运车辆</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>合同</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>保险</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>证件</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>违法违章</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>表扬与投诉</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>迁移历史</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>安全学习</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>黑名单历史</a></li>
				<li><a href="#otherFormFields">其他信息</a></li>
			</ul>
			<div id="otherFormFields" style="width:710px;">
				<table class="formFields" cellspacing="2" cellpadding="0" >
					<tbody>
						<tr>
							<td class="label"><s:text name="carMan.phone"/>:</td>
							<td class="value"><s:textfield name="e.phone"/></td>
							<td class="label"><s:text name="carMan.phone1"/>:</td>
							<td class="value"><s:textfield name="e.phone1"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.model"/>:</td>
							<td class="value"><s:textfield name="e.model"/></td>
							<td class="label"><s:text name="carMan.extFZJG"/>:</td>
							<td class="value"><s:textfield name="e.extFZJG"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>