<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="caseBusiness.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/caseBusiness/save" />'
	data-js='<s:url value="/bc-business/caseBusiness/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.caseBusinessForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="caseBusinessForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:800px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td style="height: 1px;"></td>
						<td style="width: 350px;">&nbsp;</td>
						<td style="width: 60px;">&nbsp;</td>
						<td style="width: 350px;">&nbsp;</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.subject"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.subject	" cssStyle="width:53.7em;" data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.address"/>:</td>
						<td class="value "><s:textfield name="e.address"  data-validate="required" /></td>
						<td class="label">*<s:text name="runcase.caseNo2"/>:</td>
						<td class="value "><s:textfield name="e.caseNo" data-validate="required" /></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="runcase.motorcadeName"/>:</td>
						<td class="value" >
							<s:select name="e.motorcadeId" list="motorcadeList" listKey="id" listValue="name" value="e.motorcadeId" headerKey="" headerValue=""  ></s:select>
						</td>
						<td class="label">*<s:text name="runcase.happenDate"/>:</td>
						<td class="value">
							<input type="text" name="e.happenDate" data-validate='{"type":"datetime","required":true}'
							value='<s:date format="yyyy-MM-dd HH:mm" name="e.happenDate" />'
							class="bc-datetime" data-cfg='{changeYear:true}'/>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.carPlate"/>:</td>
						<td class="value ">
							<s:textfield name="e.carPlate" data-validate="required" readonly="true" />
						</td>
						<td class="label" ><s:text name="runcase.receiveDate1"/>:</td>
						<td class="value ">
								<input type="text" name="e.receiveDate" data-validate='{"type": "date"}'
								value='<s:date format="yyyy-MM-dd" name="e.receiveDate" />'
								class="bc-date" data-cfg='{changeYear:true}'/>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="runcase.driverName" />:</td>
						<td>
							<s:textfield name="e.driverName" cssStyle="width:5em;" data-validate="required"/>&nbsp;&nbsp;<s:text name="runcase.driverCert" /><s:textfield name="e.driverCert" cssStyle="width:14.4em;" data-validate="required" />
						</td>
						<td class="label"><s:text name="runcase.receiverName1"/>:</td>
						<td class="value "><s:textfield name="e.receiverName" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.chargerName"/>:</td>
						<td class="value "><s:textfield name="e.chargerName" /></td>
						<td class="label" ><s:text name="runcase.duty"/>:</td>
						<td class="value" >
							<s:select name="e.duty" list="dutyList" listKey="value" listValue="value"  headerKey="" headerValue="" ></s:select>
						</td>
					</tr>
					<tr>
						<td class="label" ><s:text name="runcase.sort"/>:</td>
						<td class="value" >
							<s:select name="e.sort" list="properitesList" listKey="value" listValue="value" headerKey="" headerValue="" ></s:select>
						</td>
						<td class="label">*<s:text name="runcase.code" />:</td>
						<td class="value "><s:textfield name="e.code" data-validate='{"required":true,"type":"number"}'/></td>					
					</tr>
					<tr>
						<td class="label"><s:text name="runcase.extent"/></td>
						<td class="value">
						<s:select name="e.extent" list="degreeList" listKey="value" listValue="value" headerKey="" headerValue="" ></s:select>
						</td>
						<td class="label" ><s:text name="runcase.source"/>:</td>
						<td class="value" >
							<s:select name="e.source" list="sourcesValue" listKey="key" listValue="value" value="e.source"  headerKey="" headerValue=""  ></s:select>
						</td>
					</tr>
					<tr>
						<td class="label">
							<div id="divTitle" style="
								<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
									visibility: visible;
								</s:if>
								<s:else>
									visibility: hidden;
								</s:else>
								">
								<s:text name="runcase.closeDate"/>:
							</div>
						</td>
						<td class="value">
							<div id="divValue" style="
								<s:if test="%{e.status != null && statusesValue[e.status] != null && e.status == 1}">
									visibility: visible;
								</s:if>
								<s:else>
									visibility: hidden;
								</s:else>
								">
								<input type="text" name="e.closeDate" data-validate='{"type": "date"}'
								value='<s:date format="yyyy-MM-dd" name="e.closeDate" />'
								class="bc-date" data-cfg='{changeYear:true}'/>
							</div>
						</td>	
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td class="label" colspan="4">
							<div class="formTopInfo">
								<s:if test="%{e.status != null && statusesValue[e.status] != null}">
								状态：<s:property value="%{statusesValue[e.status]}" />，
								</s:if>
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
		<div class="formTabs" id="formTabs" style="height:250px;width:800px;overflow: hidden;">
			<ul>
			    <li><a href="#otherFormFieldsOne">扣罚信息</a></li>
				<li><a href="">具体内容</a></li>
				<li><a href="">处理意见</a></li>
			</ul>
			<div id="otherFormFieldsOne">
				<table class="formFields" cellspacing="2" cellpadding="0" >
					<tbody>
						<tr>
							<td class="label" colspan="1"><s:text name="runcase.chargerName"/>:<s:textfield name="e.chargerName" /></td>
							<td class="value "></td>
							<td class="label" ><s:text name="runcase.receipt"/>:</td>
							<td class="value" ><s:textfield name="e.receipt" /></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.motorcadeName" />
		<s:hidden name="e.carId" />
		<s:hidden name="e.driverId" />
		<s:hidden name="e.chargerId" />
		<s:hidden name="e.closerId" />
		<s:hidden name="e.status" />
		<s:hidden name="e.receiverId" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>