if(!window['bs'])window['bs']={};
bs.insuranceTypeForm = {
	init : function(option,readonly)  {
		var $form = $(this);
		
		//控制选择险种时显示保额
		if($form.find("input:[name='e.type']:radio:checked").val()==1){
			$form.find("#pidId").hide();
			$form.find("#coverageId").hide();
		}
		if(readonly) return;
		
		//当类型值改变时，输入框也改变
		$form.find("input:[name='e.type']:radio").change(function(){
			if($(this).val()==0){
				$form.find("#coverageId").show();
				$form.find("#pidId").show();
			}else{
				$form.find("#coverageId").hide();
				$form.find("#pidId").hide();
				$form.find(":input[name='e.coverage']").val('');
				$form.find("select[name='e.pid']").val('');
			}
		});
		
	}
};