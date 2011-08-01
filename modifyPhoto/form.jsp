<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc-business/charger/save" />'
	data-js='<s:url value="/ui-libs/jcrop/0.9.9/jquery.Jcrop.min.js" />,<s:url value="/bc-business/modifyPhoto/form.js" />,
	<s:url value="/ui-libs/jcrop/0.9.9/themes/default/jquery.Jcrop.css" />'
	data-initMethod='bc.business.modifyPhoto.init'
	data-option='{
		"buttons":[{"text":"<s:text name="确定"/>","click":"bc.business.modifyPhoto.check"}],
		"width":680,"minWidth":250,"minHeight":250,"modal":false}'
	style="overflow-y: auto;">
	<s:form name="modifyPhoto" theme="simple">
		<div class="formFields ui-widget-content">
			<div id="outer">
				<div class="jcExample">
					<div class="article">
						<!-- This is the image we're attaching Jcrop to -->
						<img src="bc-business/modifyPhoto/img/1.jpg" id="target"
							alt="Flowers" />
						<!-- This is the form that our event handler fills -->
						<form id="coords" class="coords" onsubmit="return false;"
							action="">
							<div>
							   <label>X1 <input type="text" size="4" id="x1" name="x1" /></label>
			                   <label>Y1 <input type="text" size="4" id="y1" name="y1" /></label>
			                   <label>X2 <input type="text" size="4" id="x2" name="x2" /></label>
			                   <label>Y2 <input type="text" size="4" id="y2" name="y2" /></label>
			                   <label>W <input type="text" size="4" id="w" name="w" /></label>
			                   <label>H <input type="text" size="4" id="h" name="h" /></label>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

	</s:form>
</div>