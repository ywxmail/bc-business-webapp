<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="carMan.title"/>:<s:property value="e.name"/>' data-type='form' class="bc-page"
	data-namespace="<s:url value="/bc-business/carMan" />"
	data-js='<s:url value="/bc-business/carMan/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.carManForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carManForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:710px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label">*<s:text name="carMan.name"/>:</td>
						<td class="value"><s:textfield name="e.name" cssStyle="width:8em;" data-validate="required"/><s:radio name="e.sex" list="#{'1':'男','2':'女'}" 
							value="e.sex" cssStyle="width:auto;"/></td>
						<td class="label"><s:text name="carMan.type"/>:</td>
						<td class="value" colspan="3"><s:radio name="e.type" list="#{'0':'司机','1':'责任人','2':'司机和责任人'}" cssStyle="width:auto;"/></td>
						<td rowspan="7" style="text-align:right;width:110px;" title='点击更改照片'>
							<img id="carMan_photo" style='overfloat:hidden;width:110px;height:160px;background: url("<s:url value="%{portrait}" />") no-repeat;' />
						</td>
					</tr>
					<tr>
						<td class="label"><s:text name="carMan.origin"/>:</td>
						<td class="value"><s:textfield name="e.origin"/></td>
						<td class="label"><s:text name="carMan.houseType"/>:</td>
						<td class="value"><s:select list="{'本地城镇','本地农村','外地城镇','外地农村','花都','番禺'}" name="e.houseType" headerKey="00" headerValue="未定义"></s:select></td>
					</tr>
					<tr>
						<td class="label"><s:text name="carMan.region"/>:</td>
						<td class="value"><s:select list="{'本省','外省','本市'}" name="e.region" headerKey="00" headerValue="未定义"></s:select></td>
						<td class="label"><s:text name="carMan.birthdate"/>:</td>
						<td class="value"><input type="text" name="e.birthdate"  
						class="bc-date" title='<s:text name="title.click2selectDate"/>'
						value='<s:date format="yyyy-MM-dd" name="e.birthdate" />'/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="carMan.phone"/>:</td>
						<td class="value"><s:textfield name="e.phone" data-validate='{required:false,type:"phone"}' /></td>
						<td class="label"><s:text name="carMan.workDate"/>:</td>
						<td class="value"><input type="text" name="e.workDate"  
						class="bc-date" title='<s:text name="title.click2selectDate"/>'
						value='<s:date format="yyyy-MM-dd" name="e.workDate" />'/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="carMan.phone1"/>:</td>
						<td class="value"><s:textfield name="e.phone1" data-validate='{required:false,type:"phone"}' /></td>
						<td class="label"><s:text name="carMan.formerUnit"/>:</td>
						<td class="value"><s:textfield name="e.formerUnit"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="carMan.address"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.address" cssStyle="width:506px"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="carMan.address1"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.address1" cssStyle="width:506px"/></td>
					</tr>
					<tr>
						<td class="label" colspan="4">
							<div class="formTopInfo">
								状态：<s:property value="%{statusesValue[e.status]}" />&nbsp;&nbsp;&nbsp;&nbsp;登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
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
			<s:if test="!e.isNew()">
			    <li><a href="#otherFormFields">其他信息</a></li>
				<li><a href='<s:url value="/bc/unit/list" />'>营运车辆</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>合同</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>保险</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>证件</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>违法违章</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>表扬与投诉</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>迁移历史</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>安全学习</a></li>
				<li><a href='<s:url value="/bc-businsess/contract/list" />'>黑名单历史</a></li>
				</s:if><s:else>
				<li><a href="#otherFormFields">其他信息</a></li>
				</s:else>
			</ul>
			<div id="otherFormFields" style="width:710px;">
				<table class="formFields" cellspacing="2" cellpadding="0" >
					<tbody>
						<tr>
							<td class="label w80"><s:text name="carMan.model"/>:</td>
							<td class="value"><s:select list="{'A牌','B牌','C牌'}" name="e.model" headerKey="00" headerValue=""></s:select></td>
							<td class="label"><s:text name="carMan.extFZJG"/>:</td>
							<td class="value"><s:textfield name="e.extFZJG"
						readonly="true" title='%{getText("carMan.title.click2selectBelong")}'/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.orderNo"/>:</td>
							<td class="value"><s:textfield name="e.orderNo" /></td>
							<td class="label"><s:text name="carMan.cert4Driving"/>:</td>
							<td class="value"><s:textfield name="e.cert4Driving"/></td>
						</tr>
						<tr>
							<td class="label" style="width:140px"><s:text name="carMan.cert4DrivingFirstDate"/>:</td>
							<td class="value"><input type="text" name="e.cert4DrivingFirstDate"  
						class="bc-date" title='<s:text name="title.click2selectDate"/>'
						value='<s:date format="yyyy-MM-dd" name="e.cert4DrivingFirstDate" />'/></td>
							<td class="label"style="width:140px"><s:text name="carMan.cert4DrivingStartDate"/>:</td>
							<td class="value"><input type="text" name="e.cert4DrivingStartDate"  
						class="bc-date" title='<s:text name="title.click2selectDate"/>'
						value='<s:date format="yyyy-MM-dd" name="e.cert4DrivingStartDate" />'/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.cert4DrivingEndDate"/>:</td>
							<td class="value"><input type="text" name="e.cert4DrivingEndDate"  
						class="bc-date" title='<s:text name="title.click2selectDate"/>'
						value='<s:date format="yyyy-MM-dd" name="e.cert4DrivingEndDate" />'/></td>
							<td class="label"style="width:140px"><s:text name="carMan.cert4DrivingArchive"/>:</td>
							<td class="value"><s:textfield name="e.cert4DrivingArchive"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.cert4FWZG"/>:</td>
							<td class="value"><s:textfield name="e.cert4FWZG"/></td>
							<td class="label"style="width:140px"><s:text name="carMan.cert4CYZG"/>:</td>
							<td class="value"><s:textfield name="e.cert4CYZG"/></td>
						</tr>
						<tr>
							<td class="label "><s:text name="carMan.cert4Indentity"/>:</td>
							<td class="value" ><s:textfield name="e.cert4Indentity"/></td>
							<td class="label "><s:text name="carMan.level"/>:</td>
							<td class="value" ><s:select list="{'未有等级','一级','二级','三级'}" name="e.level" headerKey="00" headerValue=""></s:select></td>
						</tr>
						<tr>
							<td class="label w80"><s:text name="carMan.gz"/>:</td>
							<td class="value"><s:radio name="e.gz" list="#{'true':'是','false':'否'}" 
							value="e.gz" cssStyle="width:auto;"/></td>
							<td class="label"><s:text name="carMan.accessCerts"/>:</td>
							<td class="value"><s:textfield name="e.accessCerts"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.drivingStatus"/>:</td>
							<td class="value"><s:select list="{'正班','副班','顶班'}" name="e.drivingStatus" headerKey="00" headerValue="请选择"></s:select></td>
							<td class="label"><s:text name="carMan.extZRR"/>:</td>
							<td class="value"><s:textfield name="e.extZRR"/></td>
						</tr>
						<tr>
						<td class="label"><s:text name="carMan.description"/>:</td>
						<td class="value" colspan="4" rowspan="3"><s:textarea name="e.description" /></td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
		<s:hidden name="e.uid" />
		<s:hidden name="e.status"/>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>