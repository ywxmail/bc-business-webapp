<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="bc-page" title='<s:text name="carByDriverHistory.chooseMoveType"/>' 
	data-type='dialog' data-initMethod='bc.selectMoveType.init'
	data-js='<s:url value="/bc-business/carByDriverHistory/selectMoveType/select.js" />,<s:url value="/bc/identity/identity.js" />'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectMoveType.clickOk"}],
		"width":300,"modal":true
	}' >
	<div style="margin:4px;">
	<s:if test="%{carManId != null}">
		<s:select list="#{5:getText('carByDriverHistory.moveType.xinruzhi'),4:getText('carByDriverHistory.moveType.jiaohuiweizhuxiao')
		     ,0:getText('carByDriverHistory.moveType.cheliangdaocheliang'),8:getText('carByDriverHistory.moveType.jiaohuizhuanche')
		     ,2:getText('carByDriverHistory.moveType.zhuxiaoweiyouquxiang'),1:getText('carByDriverHistory.moveType.gongsidaogongsiyizhuxiao')
		     ,3:getText('carByDriverHistory.moveType.youwaigongsiqianhui'),9:getText('carByDriverHistory.moveType.weijiaozhengzhuxiao')
	         }" theme="simple"
		size="10" cssStyle="width:100%;height:100%;" value="selected" cssClass="ui-widget-content"
		multiple="%{multiple}"></s:select>
	</s:if><s:else>
	<s:select list="#{5:getText('carByDriverHistory.moveType.xinruzhi'),4:getText('carByDriverHistory.moveType.jiaohuiweizhuxiao')
		     ,0:getText('carByDriverHistory.moveType.cheliangdaocheliang'),8:getText('carByDriverHistory.moveType.jiaohuizhuanche')
		     ,2:getText('carByDriverHistory.moveType.zhuxiaoweiyouquxiang'),1:getText('carByDriverHistory.moveType.gongsidaogongsiyizhuxiao')
		     ,3:getText('carByDriverHistory.moveType.youwaigongsiqianhui'),9:getText('carByDriverHistory.moveType.weijiaozhengzhuxiao')
		     ,6:getText('carByDriverHistory.moveType.cheduidaochedui')
		     }" theme="simple"
		size="10" cssStyle="width:100%;height:100%;" value="selected" cssClass="ui-widget-content"
		multiple="%{multiple}"></s:select>
	</s:else>
	</div>
</div>