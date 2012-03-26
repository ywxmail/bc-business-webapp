bc.selectTwoDate4contractLabourForm = {
	init : function() {
		var $page = $(this);
		//默认就弹出日期选择框
		var $resignDate = $page.find(":input[name='resignDate']");
		$resignDate.focus();
	},
	clickOk : function(option) {
		var $page = $(this);
		//验证用户输入信息的正确性
		if(!bc.validator.validate($page)){
			return;
		}

		$page.data("data-status",{
			resignDate: $page.find(":input[name='resignDate']").val(),
			stopDate: $page.find(":input[name='stopDate']").val()
		});
		$page.dialog("close");

	}
};