<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="carMan.title"/>:<s:property value="e.name"/>' data-type='form' class="bc-page"
	data-namespace="<s:url value="/bc-business/carMan" />"
	data-js='<s:url value="/bc-business/carMan/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.carManForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:hidden;">
	<s:form name="carManForm" theme="simple" cssClass="bc-form" >
		<div id="formTabs" class="formTabs bc-tabs layout-top ui-widget ui-helper-reset" data-cfg="{height:430}">
	        <div class="tabsContainer">
           	 	<div class="slideContainer">
                <ul class="tabs ui-helper-reset">
					<s:if test="!e.isNew()">
				    <li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">司机信息</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/carByDriverHistorys/list?carManId=%{e.id}" />' class="ui-state-default">迁移记录</a></li>
					<!--<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/carByDrivers/list?carManId=%{e.id}"/>' class="ui-state-default">营运车辆</a></li>-->
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/contract4Chargers/list?driverId=%{e.id}" />' class="ui-state-default">经济合同</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/contract4Labours/list?driverId=%{e.id}" />' class="ui-state-default">劳动合同</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/driver4cert/list?carManId=%{e.id}" />' class="ui-state-default">证件</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/blacklists/list?carManId=%{e.id}" />' class="ui-state-default">黑名单</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseTraffics/list?carManId=%{e.id}" />' class="ui-state-default">交通违章</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseBusinesss/list?carManId=%{e.id}" />' class="ui-state-default">营运违章</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseAccidents/list?carManId=%{e.id}" />' class="ui-state-default">事故理赔</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/caseAdvices/list?carManId=%{e.id}" />' class="ui-state-default">投诉</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc-business/casePraises/list?carManId=%{e.id}" />' class="ui-state-default">表扬</a></li>
					<li class="tab ui-widget-content"><a href='<s:url value="/bc/error/todo" />' class="ui-state-default">安全学习</a></li>
					</s:if>
					<s:else>
				    <li class="tab ui-widget-content first active"><a href="#otherFormFields" class="ui-state-default ui-state-active">其他信息</a></li>
					</s:else>
                </ul>
            	</div>
	        </div>
	        <div class="contentContainer ui-helper-reset ui-widget-content noBottomBorder">
	        <div id="otherFormFields" class="content active">
				<table class="formFields" cellspacing="2" cellpadding="0" style="width:740px">
					</tbody>
					    <tr class="widthMarker">
							<td style="width: 100px;">&nbsp;</td>
							<td style="width: 260px;">&nbsp;</td>
							<td style="width: 110px;">&nbsp;</td>
							<td style="">&nbsp;</td>
							<td rowspan="10" style="text-align:center;vertical-align: top;width:110px;" title='点击更改照片'>
								<img id="portrait" style="width:110px;height:140px;cursor: pointer;" title='<s:text name="image.click2change"/>'
									src='<s:url value="/bc/image/download?ptype=portrait"><s:param name='puid' value='e.uid'/><s:param name='ts' value='ts'/></s:url>'/>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.type"/>:</td>
							<td class="value"><!--<s:checkboxlist name="e.type" list="#{'0':'司机','1':'责任人','2':'司机和责任人'}" cssStyle="width:auto;"/>-->
							   <s:select name="e.type" list="#{'0':'司机','1':'责任人','2':'司机责任人','3':'非编'}" listKey="key" listValue="value" cssClass="ui-widget-content" headerValue="" /></td>
							<td class="label"><s:text name="carMan.region"/>:</td>
							<td class="value"><s:select list="#{0:'',1:'本市',2:'本省',3:'外省'}" listKey="key" listValue="value" cssClass="ui-widget-content" headerValue="" name="e.region"></s:select></td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carMan.name"/>:</td>
							<td class="value"><s:textfield name="e.name" cssStyle="width:8em;" data-validate='{"required":true,"type":"string","msg":"必须填写司机的姓名"}' cssClass="ui-widget-content"/><s:radio name="e.sex" list="#{'1':'男','2':'女'}" 
								value="e.sex" cssStyle="width:auto;"/></td>
							<td class="label"><s:text name="carMan.houseType"/>:</td>
							<td class="value"><s:textfield name="e.houseType" readonly="true" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.origin"/>:</td>
							<td class="value"><s:textfield name="e.origin" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="carMan.birthdate"/>:</td>
					        <td class="value relative">
								<input type="text" name="e.birthdate" data-validate='{"type":"date","required":false}'
								value='<s:date format="yyyy-MM-dd" name="e.birthdate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true,addYear: "5|e.scrapDate"}' />
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.birthdate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.phone1"/>:</td>
							<td class="value"><s:textfield name="e.phone" data-validate='{"required":false,"type":"phone"}' cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="carMan.workDate"/>:</td>
					        <td class="value relative">
								<input type="text" name="e.workDate" data-validate='{"type":"date","required":false}'
								value='<s:date format="yyyy-MM-dd" name="e.workDate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true,addYear: "5|e.scrapDate"}' />
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.workDate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.phone2"/>:</td>
							<td class="value"><s:textfield name="e.phone1" data-validate='{"required":false,"type":"phone"}' cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="carMan.formerUnit"/>:</td>
							<td class="value"><s:textfield name="e.formerUnit" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.address"/>:</td>
							<td class="value" colspan="3"><s:textfield name="e.address"  cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.address1"/>:</td>
							<td class="value" colspan="3"><s:textfield name="e.address1" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							
							
						</tr>
						<tr>
				            <td class="label">*<s:text name="carMan.cert4FWZG"/>:</td>
							<td class="value"><s:textfield name="e.cert4FWZG" cssClass="ui-widget-content" data-validate='{"minLen": 6,"maxLen": 7,"required":true,"type":"string"}' cssStyle="width:8em;"/>
								<s:text name="carMan.level"/>:
								<s:select list="carManLevelList" listKey="value" listValue="value" headerKey="" headerValue="未有等级" name="e.level" cssStyle="width:8em;" cssClass="ui-widget-content"/>
							</td>
							<td class="label"><s:text name="carMan.cert4CYZG"/>:</td>
							<td class="value" colspan="2"><s:textfield name="e.cert4CYZG" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label">*<s:text name="carMan.cert4Indentity"/>:</td>
							<td class="value"><s:textfield name="e.cert4Indentity" cssClass="ui-widget-content" data-validate='{"required":true,"method":"bc.carManForm.validateIndentity","msg":"必须为15位或18位身份证格式"}'/></td>
							<td class="label"><s:text name="carMan.model"/>:</td>
							<td class="value" colspan="2">
								<!--<s:select list="carManModelList" listKey="value" listValue="value" headerKey="" headerValue="" name="e.model"  cssClass="ui-widget-content"/>-->
								<s:textfield name="e.model" cssClass="ui-widget-content"/>
							</td>
						</tr>
						<tr>
				            <td class="label"><s:text name="carMan.cert4Driving"/>:</td>
							<td class="value"><s:textfield name="e.cert4Driving" cssClass="ui-widget-content"/></td>
							<td class="label"><s:text name="carMan.cert4DrivingArchive"/>:</td>
							<td class="value" colspan="2"><s:textfield name="e.cert4DrivingArchive" cssClass="ui-widget-content"/></td>
							<!--<td class="label"><s:text name="carMan.extFZJG"/>:</td>
							<td class="value" colspan="2"><s:textfield name="e.oldUnitName" cssClass="ui-widget-content"/></td>-->
						</tr>
						<tr>
							
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.cert4DrivingDeadline"/>:</td>
							<td class="value">
								<div class="bc-dateContainer">
									&nbsp;从<input type="text" name="e.cert4DrivingStartDate" <s:if test="e.isNew()">data-cfg='{"addYear":"6 0 -1"}'</s:if>
									  data-validate='{"type":"date","required":false}' 
										value='<s:date format="yyyy-MM-dd" name="e.cert4DrivingStartDate" />' 
										style="width: 8em;" class="bc-date ui-widget-content" />
										<ul class="inputIcons" style="right : 0px;">
											<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.cert4DrivingStartDate' ></li>
										</ul>
								</div>
					        	<div class="bc-dateContainer">
									&nbsp;到<input type="text" name="e.cert4DrivingEndDate"  data-validate='{"type":"date","required":false}'
										value='<s:date format="yyyy-MM-dd" name="e.cert4DrivingEndDate" />'
										style="width: 8em;" class="bc-date ui-widget-content" />
										<ul class="inputIcons" style="right : 0px;">
											<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.cert4DrivingEndDate' ></li>
										</ul>
								</div>
				            </td>
				            <td class="label"><s:text name="carMan.cert4DrivingFirstDate"/>:</td>
				             <td class="value relative"  colspan="2">
								<input type="text" name="e.cert4DrivingFirstDate" data-validate='{"type":"date","required":false}'
								value='<s:date format="yyyy-MM-dd" name="e.cert4DrivingFirstDate" />'
								class="bc-date ui-widget-content" data-cfg='{changeYear:true,addYear: "5|e.scrapDate"}' />
								<ul class="inputIcons">
									<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.cert4DrivingFirstDate'></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.accessCerts"/>:</td>
							<td class="value"><s:textfield name="e.accessCerts" cssClass="ui-widget-content"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="carMan.gz"/>:</td>
							<td class="value"><s:radio name="e.gz" list="#{'true':'是','false':'否'}"   value="e.gz" cssStyle="width:auto;"/></td>
							<td class="label"><s:text name="carMan.status"/>:</td>
						    <td class="value"><s:radio name="e.status" list="#{'0':'在案','1':'注销'}" cssStyle="width:auto;"/></td>
						</tr>
						<tr>
							<td class="topLabel"><s:text name="carMan.description"/>:</td>
							<td class="value" colspan="4"><s:textarea name="e.description"  rows="3" cssClass="ui-widget-content noresize"/></td>
						</tr>
						<tr>
							<td class="label" colspan="5">
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
			</div>
		</div>
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.drivingStatus" />
		<s:hidden name="e.charger" />
		<s:hidden name="e.moveType" />
		<s:hidden name="e.classes" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		<s:hidden name="e.modifier.id"/>
		<input type="hidden" name="e.modifiedDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.modifiedDate" />'/>
	</s:form>
</div>