<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="car.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/car/save" />'
	data-js='<s:url value="/bc-business/car/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.carForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carForm" theme="simple">
		<div class="formFields ui-widget-content" style="width:710px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td class="label">*<s:text name="car.code"/>:</td>
						<td class="value"><s:textfield name="e.code" data-validate="required"/></td>
						<td class="label">*<s:text name="car.unit"/>:</td>
						<td class="value"><s:textfield name="e.unit.name"
							readonly="true"	title='%{getText("user.title.click2selectBelong")}' data-validate="required"/></td>
					</tr>
					<tr>
						<td class="label">*<s:text name="car.plate"/>:</td>
						<td class="value"><s:textfield name="e.plateType" cssStyle="width:4em;" data-validate="required"/><s:textfield name="e.plateNo" cssStyle="width:8em;" data-validate="required"/></td>
						<td class="label">*<s:text name="car.motorcade"/>:</td>
						<td class="value">
							<s:select name="e.motorcade.id" list="motorcadeList" listKey="id" listValue="name" value="e.motorcade.id" data-validate="required" headerKey="" headerValue="%{getText('car.please.choose')}"></s:select>
						</td>
					</tr>
					<tr>
						<td class="label">*<s:text name="car.vin"/>:</td>
						<td class="value"><s:textfield name="e.vin" data-validate="required"/></td>
						<td class="label">*<s:text name="car.businessType"/>:</td>
						<td class="value">
							<s:select name="e.businessType" list="businessTypeList" listKey="value" listValue="value"  data-validate="required" headerKey="" headerValue="%{getText('car.please.choose')}"></s:select>
						</td>
					</tr>
					<tr>
						<td class="label"><s:text name="car.factoryType"/>:</td>
						<td class="value">
							<s:select name="e.factoryType" list="factoryTypeList" listKey="value" listValue="value" headerKey="" headerValue="%{getText('car.please.choose')}"></s:select>
						</td>
						<td class="label"><s:text name="car.factoryModel"/>:</td>
						<td class="value"><s:textfield name="e.factoryModel" /></td>
					</tr>
					<tr>
						<td class="label"><s:text name="car.registerDate"/>:</td>
						<td class="value">
							<input type="text" name="e.registerDate" data-validate="date"
							value='<s:date format="yyyy-MM-dd" name="e.registerDate" />'
							class="bc-date"/>
						</td>
						<td class="label"><s:text name="car.factoryDate"/>:</td>
						<td class="value">
							<input type="text" name="e.factoryDate" data-validate="date"
							value='<s:date format="yyyy-MM-dd" name="e.factoryDate" />'
							class="bc-date"/>
						</td>
					</tr>
					<tr>
						<td class="label"><s:text name="car.operateDate"/>:</td>
						<td class="value">
							<input type="text" name="e.operateDate" data-validate="date"
							value='<s:date format="yyyy-MM-dd" name="e.operateDate" />'
							class="bc-date"/>
						</td>
						<td class="label"><s:text name="car.scrapDate"/>:</td>
						<td class="value">
							<input type="text" name="e.scrapDate" data-validate="date"
							value='<s:date format="yyyy-MM-dd" name="e.scrapDate" />'
							class="bc-date"/>
						</td>
					</tr>
					<tr>
					</tr>
					<tr>
						<td class="label"><s:text name="car.originNo"/>:</td>
						<td class="value"><s:textfield name="e.originNo" /></td>
						<td class="label"><s:text name="car.level"/>:</td>
						<td class="value">
							<s:select name="e.level" list="levelTypeList" listKey="value" listValue="value" headerKey="" headerValue="%{getText('car.please.choose')}"></s:select>
						</td>
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
		<div class="formTabs" id="formTabs">
			<ul>
				<li><a href='<s:url value="/bc/carMan/list" />'>营运司机</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>合同</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>保险</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>证件</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>配件</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>费用</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>回场捡</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>事故</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>变更历史</a></li>
				<li><a href='<s:url value="/bc/error/todo" />'>操作日志</a></li>
				<li><a href="#otherFormFields">其他信息</a></li>
			</ul>
			<div id="otherFormFields" style="width:710px;">
				<table class="formFields" cellspacing="2" cellpadding="0" >
					<tbody>
						<tr>
							<td class="label"><s:text name="car.certNo1"/>:</td>
							<td class="value"><s:textfield name="e.certNo1"/></td>
							<td class="label"><s:text name="car.certNo2"/>:</td>
							<td class="value"><s:textfield name="e.certNo2"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.invoiceNo1"/>:</td>
							<td class="value"><s:textfield name="e.invoiceNo1"/></td>
							<td class="label"><s:text name="car.invoiceNo2"/>:</td>
							<td class="value"><s:textfield name="e.invoiceNo2"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.certNo3"/>:</td>
							<td class="value"><s:textfield name="e.certNo3"/></td>
							<td class="label"><s:text name="car.originalValue"/>:</td>
							<td class="value"><s:textfield name="e.originalValue" data-validate="number"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.color"/>:</td>
							<td class="value">
								<s:select name="e.color" list="colorTypeList" listKey="value" listValue="value" headerKey="" headerValue="%{getText('car.please.choose')}" ></s:select>
							</td>
							<td class="label"><s:text name="car.fuelType"/>:</td>
							<td class="value">
								<s:select name="e.fuelType" list="fuelTypeList" listKey="value" listValue="value" headerKey="" headerValue="%{getText('car.please.choose')}"></s:select>
							</td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.engineNo"/>:</td>
							<td class="value"><s:textfield name="e.engineNo"/></td>
							<td class="label"><s:text name="car.engineType"/>:</td>
							<td class="value"><s:textfield name="e.engineType" /></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.displacement"/>:</td>
							<td class="value"><s:textfield name="e.displacement" data-validate="digits"/></td>
							<td class="label"><s:text name="car.power"/>:</td>
							<td class="value"><s:textfield name="e.power" data-validate="number"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.turnType"/>:</td>
							<td class="value"><s:textfield name="e.turnType"/></td>
							<td class="label"><s:text name="car.tireCount"/>:</td>
							<td class="value"><s:textfield name="e.tireCount" data-validate="digits"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.tireStandard" />:</td>
							<td class="value"><s:textfield name="e.tireStandard"/></td>
							<td class="label"><s:text name="car.axisDistance"/>:</td>
							<td class="value"><s:textfield name="e.axisDistance" data-validate="digits"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.axisCount" />:</td>
							<td class="value"><s:textfield name="e.axisCount" data-validate="digits"/></td>
							<td class="label"><s:text name="car.pieceCount"/>:</td>
							<td class="value"><s:textfield name="e.pieceCount" data-validate="digits"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.dimLen" />:</td>
							<td class="value"><s:textfield name="e.dimLen" data-validate="digits"/></td>
							<td class="label"><s:text name="car.dimWidth"/>:</td>
							<td class="value"><s:textfield name="e.dimWidth" data-validate="digits"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.dimHeight" />:</td>
							<td class="value"><s:textfield name="e.dimHeight" data-validate="digits"/></td>
							<td class="label"><s:text name="car.totalWeight"/>:</td>
							<td class="value"><s:textfield name="e.totalWeight" data-validate="digits"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.accessWeight" />:</td>
							<td class="value"><s:textfield name="e.accessWeight" data-validate="digits"/></td>
							<td class="label"><s:text name="car.accessCount"/>:</td>
							<td class="value"><s:textfield name="e.accessCount" data-validate="digits"/></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.taximeterFactory" />:</td>
							<td class="value">
								<s:select name="e.taximeterFactory" list="taximeterFactoryTypeList" listKey="value" listValue="value" headerKey="" headerValue="%{getText('car.please.choose')}"></s:select>
							</td>
							<td class="label"><s:text name="car.taximeterType"/>:</td>
							<td class="value"><s:textfield name="e.taximeterType" /></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.taximeterNo" />:</td>
							<td class="value"><s:textfield name="e.taximeterNo"/></td>
							<td class="label"><s:text name="car.desc1"/>:</td>
							<td class="value"><s:textfield name="e.desc1" /></td>
						</tr>
						<tr>
							<td class="label"><s:text name="car.desc2" />:</td>
							<td class="value"><s:textfield name="e.desc2"/></td>
							<td class="label"><s:text name="car.desc3"/>:</td>
							<td class="value"><s:textfield name="e.desc3" /></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.unit.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>