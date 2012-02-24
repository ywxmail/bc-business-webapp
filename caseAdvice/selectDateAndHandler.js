bc.selectDateAndHandlerForm = {
	init : function (){
		var $form = $(this);
		// 核准人
		$form.find("#selectHandlerName").click(function(){
			bc.identity.selectUser({
				history: true,
				selecteds: $form.find(":input[name='handlerName']").val(),
				onOk : function(user) {
					$form.find(":input[name='handlerId']").val(user.id);
					$form.find(":input[name='handlerName']").val(user.name);
				}
			});
		});
	},
	clickOk : function(option) {
		var $page = $(this);
		
		//验证用户输入信息的正确性
		if(!bc.validator.validate($page)){
			return;
		}
		
		$page.data("data-status",{
			handlerId: $page.find(":input[name='handlerId']").val(),
			handlerName: $page.find(":input[name='handlerName']").val(),
			handleDate: $page.find(":input[name='handleDate']").val(),
			handleOpinion : $page.find(":input[name='handleOpinion']").val()
		});
		$page.dialog("close");
	}
};