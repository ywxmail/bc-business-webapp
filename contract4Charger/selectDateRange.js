bc.selectDateRangeFrom4contractCharger = {
	init : function() {
		var $page = $(this);
		
		// 聚焦到合同编号框
		$page.find(":input[name='code']").focus();
	},
	clickOk : function(option) {
		var $page = $(this);
		//验证用户输入信息的正确性
		if(!bc.validator.validate($page)){
			return;
		}
		
		//检测编号的唯一性
		var $code = $page.find(":input[name='code']");
		bc.contract4ChargerForm.checkCode("",$code.val(),function(json){
			if(json.isExist == "true"){ 
				//合同编号存在
				bc.msg.alert("所输入的合同编号已经被占用，请重新输入！");
			}else{
				// 返回
				$page.data("data-status",{
					startDate: $page.find(":input[name='startDate']").val(),
					endDate: $page.find(":input[name='endDate']").val(),
					code: $code.val(),
				});
				$page.dialog("close");
			}
		});
	}
};