bc.selectDateRangeFrom = {
	init : function() {
		var $page = $(this);
		
		//默认就弹出日期选择框
		var $startDate = $page.find(":input[name='startDate']");
		if($startDate.val().length > 0)
			$page.find(":input[name='endDate']").focus();
		else
			$startDate.focus();
		
		//绑定失去焦点自编号唯一性检测
		var $code = $page.find(":input[name='code']");
		$code.bind("blur",function(){
			var code = $code.val();
			if(!code || code.length == 0)
				return false;
			
			bc.contract4ChargerForm.checkCode($page,$code);
		});
	},
	clickOk : function(option) {
		var $page = $(this);
		//验证用户输入信息的正确性
		if(!bc.validator.validate($page)){
			return;
		}

		$page.data("data-status",{
			startDate: $page.find(":input[name='startDate']").val(),
			endDate: $page.find(":input[name='endDate']").val(),
			code: $page.find(":input[name='code']").val(),
		});
		$page.dialog("close");
	}
};