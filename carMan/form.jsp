<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="carMan.title"/>:<s:property value="e.name"/>' data-type='form' class="bc-page"
	data-namespace="<s:url value="/bc-business/carMan" />"
	data-js='<s:url value="/bc-business/carMan/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.carManForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carManForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:794px;">
			<table class="formFields" cellspacing="2" cellpadding="0" >
				<tbody>
					<tr>
						<td class="label">*<s:text name="carMan.name"/>:</td>
						<td class="value"><s:textfield name="e.name" cssStyle="width:8em;" data-validate="required"/><s:radio name="e.sex" list="#{'0':'男','1':'女'}" 
							value="e.sex" cssStyle="width:auto;"/></td>
						<td class="label"><s:text name="carMan.type"/>:</td>
						<td class="value" colspan="3"><s:radio name="e.type" list="#{'0':'司机','1':'责任人','2':'司机和责任人'}" cssStyle="width:auto;"/></td>
						<td rowspan="7" style="text-align:center;vertical-align: top;width:110px;" title='点击更改照片'>
							<img id="portrait" style="width:110px;height:140px;cursor: pointer;" title='<s:text name="image.click2change"/>'
								src='<s:url value="/bc/image/download"><s:param name='puid' value='e.uid'/><s:param name='ptype' value='%{"portrait"}'/><s:param name='ts' value='ts'/></s:url>'/>
						</td>
					</tr>
					<tr>
						<td class="label"><s:text name="carMan.origin"/>:</td>
						<td class="value"><s:textfield name="e.origin"/></td>
						<td class="label"><s:text name="carMan.houseType"/>:</td>
						<td class="value"><s:select list="carManHouseTypeList" listKey="value" listValue="value"   headerKey="" headerValue="" name="e.houseType" style="width:231px"></s:select></td>
					</tr>
					<tr>
						<td class="label"><s:text name="carMan.region"/>:</td>
						<td class="value"><s:select list="#{0:'',1:'本市',2:'本省',3:'外省'}" listKey="key" listValue="value"    headerValue="" name="e.region" style="width:196px"></s:select></td>
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
						<td class="value" colspan="3"><s:textfield name="e.address" cssStyle="width:590px"/></td>
					</tr>
					<tr>
						<td class="label"><s:text name="carMan.address1"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.address1" cssStyle="width:590px" /></td>
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
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset"
			data-cfg="{height:300}" style="height:300px;width:794px;overflow: hidden;">
	        <div class="tabsContainer">
           	 	<div class="slideContainer">
                <ul class="tabs ui-helper-reset">
					<s:if test="!e.isNew()">
				    <li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">其他信息</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/carByDriver/list?carManId=%{e.id}"/>' class="ui-state-default">营运车辆</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/contract/list?carManId=%{e.id}" />' class="ui-state-default">合同</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/driver4cert/list?carManId=%{e.id}" />' class="ui-state-default">证件</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseTraffic/list?carManId=%{e.id}" />' class="ui-state-default">交通违章</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseBusiness/list?carManId=%{e.id}" />' class="ui-state-default">营运违章</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseAccident/list?carManId=%{e.id}" />' class="ui-state-default">事故理赔</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseAdvice/list?carManId=%{e.id}" />' class="ui-state-default">投诉</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/casePraise/list?carManId=%{e.id}" />' class="ui-state-default">表扬</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/blacklist/list?carManId=%{e.id}" />' class="ui-state-default">黑名单</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">迁移历史</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">保险</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">安全学习</a></li>
					</s:if>
					<s:else>
				    <li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">其他信息</a></li>
					</s:else>
                </ul>
            	</div>
	        </div>
	        <div class="contentContainer ui-helper-reset ui-widget-content">
			<div id="otherFormFields" class="content active">
				<table class="formFields" cellspacing="2" cellpadding="0" >
					<tbody>
						<tr>
							<td class="label w80"><s:text name="carMan.model"/>:</td>
							<td class="value"><s:select list="carManModelList" listKey="value" listValue="value" headerKey="" headerValue="" name="e.model" style="width:208px"></s:select></td>
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
							<td class="label" style="width:140px"><s:text name="carMan.cert4DrivingStartDate"/>:</td>
							<td class="value"><input type="text" name="e.cert4DrivingStartDate"  
						class="bc-date" title='<s:text name="title.click2selectDate"/>'
						value='<s:date format="yyyy-MM-dd" name="e.cert4DrivingStartDate" />'/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.cert4DrivingEndDate"/>:</td>
							<td class="value"><input type="text" name="e.cert4DrivingEndDate"  
						class="bc-date" title='<s:text name="title.click2selectDate"/>'
						value='<s:date format="yyyy-MM-dd" name="e.cert4DrivingEndDate" />'/></td>
							<td class="label" style="width:140px"><s:text name="carMan.cert4DrivingArchive"/>:</td>
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
							<td class="value" ><s:select list="carManLevelList" listKey="value" listValue="value" headerKey="" headerValue="" name="e.level" style="width:208px" ></s:select></td>
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
							<td class="value"><s:select list="#{0:'',1:'正班',2:'副班',3:'顶班'}" listKey="key" listValue="value" headerKey="" name="e.drivingStatus" style="width:208px" ></s:select></td>
							<td class="label"><s:text name="carMan.extZRR"/>:</td>
							<td class="value"><s:textfield name="e.extZRR"/></td>
						</tr>
						<tr>
						<td class="label"><s:text name="carMan.description"/>:</td>
						<td class="value" colspan="4" rowspan="5"><s:textarea name="e.description"  rows="5"/></td>
					</tr>
					</tbody>
				</table>
			</div>
			</div>
		</div>
		<s:hidden name="e.uid" />
		<s:hidden name="e.status"/>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		<s:hidden name="e.modifier.id"/>
		<input type="hidden" name="e.modifiedDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.modifiedDate" />'/>
	</s:form>
</div>