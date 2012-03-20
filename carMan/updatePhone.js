bc.updataCarManPhone = {
	init : function(option,readonly) {
		var $form = $(this);

	},
	//保存
	save : function (){
		var $form = $(this);
		var phone1 = $form.find(":input[name='phone1']").val();
		var phone2 = $form.find(":input[name='phone2']").val();
		var carManId = $form.find(":input[name='id']").val();
		var url = bc.root + "/bc-business/carMan/updatePhone";
		var phone;
		$.ajax({
			url: url,
			dataType:"json",
			data: {phone1 : phone1,phone2 : phone2,carManId : carManId},
			success: function (json){
				if(json.success){
					bc.msg.slide(json.msg);
					// 返回
					phone = [];
					phone={phone1 : phone1,phone2 : phone2};
					$form.data("data-status", phone);
					$form.dialog("close");
				}else{
					bc.msg.alert(json.msg);
				}
				return false;
			}
		});

	}
};