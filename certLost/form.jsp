<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="certLost.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/certLost/save" />'
	data-js='<s:url value="/bc/libs/select.js" />,<s:url value="/bc-business/certLost/form.js" />,<s:url value="/bc/identity/identity.js" />,<s:url value="/bc-business/bs.js" />'
	data-initMethod='bc.certLostForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow:hidden;">
	<s:form name="certLostForm" theme="simple">	
		<table class="formFields" cellspacing="2" cellpadding="0" style="width: 53em">
			<tbody>
				<tr class="widthMarker">
	                <td style="width: 5em;">&nbsp;</td>
	                <td style="width: 23em;">&nbsp;</td>
	                <td >&nbsp;</td>
				 </tr>
				<tr>
				    <td class="label">*<s:text name="certLost.subject"/>:</td>
					<td class="value"><s:textfield name="e.subject" cssClass="ui-widget-content" data-validate="required"/></td>
					<td class="topLabel" style="text-align: left;"><s:text name="certLost.desc"/>:</td>
				</tr>
				<tr>
					<td class="label">*<s:text name="certLost.plate"/>:</td>
					<s:if test="%{carManId != null || carId !=null }">
						<td class="value"><s:textfield name="carPlate" value="%{e.car.plateType+'.'+e.car.plateNo }" readonly="true" cssClass="ui-widget-content"/></td>
				    </s:if><s:else>
						<td class="value" style="position:relative;display: block;"><s:textfield name="carPlate" value="%{e.car.plateType+'.'+e.car.plateNo }"
				    		data-validate="required" cssClass="ui-widget-content" readonly="true" />
				    	<span id="selectCar" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></span>
				    </td>
				    </s:else>
					<td class="value" rowspan="5"><s:textarea name="e.description" rows="5" cssClass="ui-widget-content noresize" cssStyle="width: 99%;height:100%;"/></td>
				</tr>
				<tr>
				    <td class="label"><s:text name="certLost.motorcade"/>:</td>
	                <td class="value"><s:select name="e.motorcadeId" list="motorcadeList" listKey="key" listValue="value" value="e.motorcadeId" 
		                headerKey="" headerValue="" cssClass="ui-widget-content"></s:select>
	                </td>
				</tr>
				<tr>
					<td class="label"><s:text name="certLost.driver"/>:</td>
					<s:if test="%{carManId != null || carId !=null}">
						<td class="value">
							<div style="position:relative;display: inline-block">
						 		<s:textfield name="e.driverNane" readonly="true" cssStyle="width:7.5em;" cssClass="ui-widget-content" />
								<ul class="inputIcons">
							 		<li class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="contract.title.click2selectCarMan"/>' id="selectDriverName">
							 	</ul>
					 		</div>
							<s:text name="certLost.certFWZG"/>:<s:textfield name="e.driver.cert4FWZG" cssStyle="width:6.5em;" cssClass="ui-widget-content" />
						</td>
				    </s:if>
				    <s:else>
						<td class="value">
							<div style="position:relative;display: inline-block">
						 		<s:textfield name="e.driverNane" readonly="true" cssStyle="width:5.5em;" cssClass="ui-widget-content " />
								<ul class="inputIcons">
							 		<li class="inputIcon ui-icon ui-icon-circle-plus" title='<s:text name="certLost.title.click2selectCarMan"/>' id="selectDriverName">
							 	</ul>
						 	</div>
							<s:text name="certLost.certFWZG"/>:<s:textfield name="e.driver.cert4FWZG" cssStyle="width:5.5em;" cssClass="ui-widget-content" />
						</td>
				     </s:else>
				</tr>
				<tr>
				    <td class="label"><s:text name="certLost.handlerName"/>:</td>
					<td class="value" style="position:relative;display: block;"><s:textfield name="e.transactorName" data-validate="required"
				    	cssClass="ui-widget-content" readonly="true" />
				    	<span id="selectTransactor" class="selectButton verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="title.click2select"/>'></span>
				    </td>
				</tr>
				<tr>
				    <td class="label">*<s:text name="certLost.lostDate"/>:</td>
					<td class="value relative">
						<input type="text" name="e.lostDate" data-validate='{"type":"date","required":true}'
							value='<s:date format="yyyy-MM-dd" name="e.lostDate" />'
							class="bc-date ui-widget-content" />
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='e.lostDate'></li>
						</ul>
					</td>
				</tr>
				<tr>
					<td class="label" colspan="3">
						<div class="formTopInfo">
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
		<!-- 证件列表 -->
		<div class="ui-widget-content" style="border-width:1px 0 0 0;margin-bottom:8px;width: 100%;">
			<div class="ui-widget-header title" style="position:relative;border-width:0;">
				<span class="text"><s:text name="certLost.certs"/>：</span>
				<ul class="inputIcons">
					<li id="addLine" class="inputIcon ui-icon ui-icon-circle-plus"
						title='<s:text name="certLost.title.click2addLine"/>'></li>
					<li id="deleteLine" class="inputIcon ui-icon ui-icon-circle-close"
						title='<s:text name="certLost.title.click2deleteLine"/>'></li>
				</ul>
			</div>
	    	<div class="bc-grid header" style="overflow-x:scroll;">
			<table class="table" id="certTables" cellspacing="0" cellpadding="0">
				<tr class="ui-state-default header row">
					<td class="first" style="width: 15px;">&nbsp;</td>
					<td class="middle" style="width: 10em;">证件名称</td>
					<td class="middle" style="width: 6em;">证件号码</td>
					<td class="middle" style="width: 5em;">补办原因</td>
					<td class="middle" style="width: 4em;">残骸</td>
					<td class="middle" style="width: 5em;">补办结果</td>
					<td class="middle" style="width: 8em;">补办日期</td>
					<td class="middle" style="width: 6em;">新证件号码</td>
					<td class="middle" style="width: 8em;">遗失地点</td>
					<td class="middle" style="width: 14em;">报警单位</td>
					<td class="last" style="width: 12em;">备注</td>
				</tr>
				<s:if test="%{e.isNew()}">
				<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
					<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<div class="bc-relativeContainer">
							<input type="text" name="certName" value='<s:property value="certName"/>' style="width:99%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" 
								class="bc-select ui-widget-content" data-validate="required" 
								data-maxHeight="150px"
								data-source='<s:property value="certNames"/>'/>
							<ul class="inputIcons">
								<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							</ul>
						</div>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
							value='<s:property value="certNo"/>'/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">	
						<s:select name="reason" list="{'掉失','被盗','损坏','被抢','其它'}" theme="simple" data-validate="required" cssClass="ui-widget-content" 
									cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<s:select name="isRemains" list="#{false:'无',true:'有'}" listKey="key" listValue="value" data-validate="required" cssClass="ui-widget-content" 
									cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<s:select name="isReplace" list="#{false:'未补办',true:'补办'}" listKey="key" listValue="value" data-validate="required" cssClass="ui-widget-content" 
									cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
					<div class="relative">
						<input type="text" name="replaceDate" data-validate='{"type":"date","required":false}' style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"
						value='<s:date format="yyyy-MM-dd" name="replaceDate" />'
						class="bc-date ui-widget-content" />
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>
						</ul>
					</div>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
							value='<s:property value="NewCertNo"/>'/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
							value='<s:property value="lostAddress"/>' />
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content" 
							value='<s:property value="alarmUnit"/>' />
					</td>
					<td class="last" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" type="text" class="ui-widget-content"
							 value='<s:property value="description"/>'/>
					</td>
				</tr>
				</s:if>
				<s:iterator var="b" value="e.certLostItem">
				<tr class="ui-widget-content row" data-id='<s:property value="id"/>'>
					<td class="id first" style="padding:0;text-align:left;"><span class="ui-icon"></span>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<s:if test="isReadonly()">
							<s:textfield name="certName" cssClass="ui-widget-content" cssStyle="width:99%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;"/>
						</s:if>
						<s:else>
						<div class="bc-relativeContainer">
							<input type="text" name="certName" value='<s:property value="certName"/>' style="width:99%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" 
								class="bc-select ui-widget-content" data-validate="required" 
								data-maxHeight="150px"
								data-source='<s:property value="certNames"/>'/>
							<ul class="inputIcons">
								<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title='<s:text name="title.click2select"/>'></li>
							</ul>
						</div>
						</s:else>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
							value='<s:property value="certNo"/>'/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">	
						<s:select name="reason" list="{'掉失','被盗','损坏','被抢','其它'}" theme="simple" data-validate="required" cssClass="ui-widget-content" 
									cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<s:select name="remains" list="#{'false':'无','true':'有'}" listKey="key" listValue="value" data-validate="required" cssClass="ui-widget-content" 
									cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<s:select name="replace" list="#{false:'未补办',true:'补办'}" listKey="key" listValue="value" data-validate="required" cssClass="ui-widget-content" 
									cssStyle="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
					<div class="relative">
						<input type="text" name="replaceDate" data-validate='{"type":"date","required":false}' style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"
						value='<s:date format="yyyy-MM-dd" name="replaceDate" />'
						class="bc-date ui-widget-content" />
						<ul class="inputIcons">
							<li class="selectCalendar inputIcon ui-icon ui-icon-calendar" data-cfg='replaceDate'></li>
						</ul>
					</div>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
							value='<s:property value="newCertNo"/>'/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
							value='<s:property value="lostAddress"/>'/>
					</td>
					<td class="middle" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content" 
							value='<s:property value="alarmUnit"/>'/>
					</td>
					<td class="last" style="padding:0;text-align:left;">
						<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"type="text" class="ui-widget-content"
							 value='<s:property value="description"/>'/>
					</td>
				</tr>
				</s:iterator>
			</table>
			</div>
		</div>
		<s:hidden name="e.id"/>
		<s:hidden name="e.car.id"/>
		<s:hidden name="e.driver.id"/>
		<s:hidden name="e.author.id"/>
		<s:hidden name="e.transactor.id"/>
		<s:hidden name="e.modifier.id"/>
		<s:hidden name="certs"/>
		<s:hidden name="carPlate"/>
		<s:hidden name="isMoreCarMan"/>
		<s:hidden name="certLists" value="%{certNames}"/>
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>