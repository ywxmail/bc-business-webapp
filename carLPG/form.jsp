<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="carlpg.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/carLPG/save" />'
	data-js='<s:url value="/bc-business/carLPG/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.carLPGForm.init'
	data-option='<s:property value="%{formPageOption}"/>' style="overflow-y:auto;">
	<s:form name="carlpgForm" theme="simple">
		<div class="formFields ui-widget-content"  style="width:500px;">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr class="widthMarker">
						<td style="width: 150px;">&nbsp;</td>
						<td style="width: 100px;">&nbsp;</td>
						<td style="width: 100px;">&nbsp;</td>
						<td >&nbsp;</td>
					</tr>
					<!-- carlpg.order			=排序号
						carlpg.status			=状态
						carlpg.title			=LPG配置信息
						carlpg.name				=名称
						carlpg.fullname			=专用装置供应商
						carlpg.model			=专用装置品牌型号
						carlpg.gpmodel			=钢瓶品牌型号
						carlpg.jcfmodel			=集成阀品牌型号
						carlpg.qhqmodel			=汽化器品牌型号
						carlpg.psgmodel			=混合/喷射器品牌型号
						carlpg.desc				=描述 -->
					<tr>
						<td class="label" >*<s:text name="carlpg.name"/>:</td>
						<td class="value" colspan="3" ><s:textfield name="e.name" data-validate="required" cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carlpg.fullname"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.fullname"  cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carlpg.model"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.model"  cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carlpg.gpmodel"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.gpmodel"  cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carlpg.jcfmodel"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.jcfmodel"  cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carlpg.qhqmodel"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.qhqmodel"  cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carlpg.psqmodel"/>:</td>
						<td class="value" colspan="3"><s:textfield name="e.psqmodel"  cssClass="ui-widget-content"/></td>
					</tr>
					<tr>
						<td class="topLabel" ><s:text name="carlpg.desc"/>:</td>
						<td class="value" colspan="3"><s:textarea name="e.desc" rows="3" cssClass="ui-widget-content noresize"/></td>
					</tr>
					<tr>
						<td class="label" ><s:text name="carlpg.order" />:</td>
						<td class="value" ><s:textfield name="e.order" data-validate='{"type" : "digits"}' cssClass="ui-widget-content"/></td>
						<td class="label"><s:text name="carlpg.status"/>:</td>
						<td><s:radio name="e.status" list="#{'0':'在案','1':'禁用'}" cssStyle="width:auto;"/></td>
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
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>