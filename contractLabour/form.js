bc.contractLabourForm = {
	init : function() {
		var $form = $(this);
		
		// 初始化多页签
		$form.find('#formTabs').tabs();
		
		// 选择车辆车牌
		$form.find(":input[name='plate']").click(function() {
					var data = {};
					var selected = $form.find(":input[name='plate']")
							.val();
					if (selected && selected.length > 0)
						data.selected = selected;
					bc.business.slectCarPlateNo.selectCar({
						data : data,
						onOk : function(car) {
							$form.find(":input[name='e.car.id']").val(car.id);
							$form.find(":input[name='plate']").val(car.plate);
						}
					});
		});
		
		// 选择司机
		
		$form.find(":input[name='e.driver.name']").click(function() {
					var data = {};
					var selected = $form.find(":input[name='e.driver.name']")
							.val();
					if (selected && selected.length > 0)
						data.selected = selected;
					bc.business.slectCarManName.selectCarMan({
						data : data,
						onOk : function(carMan) {
							$form.find(":input[name='e.driver.id']").val(carMan.id);
							$form.find(":input[name='e.driver.name']").val(carMan.name);
							
							var url = "/bc-business/contractLabour/certMess?carManId="+carMan.id;
							$.ajax({ url: url,dataType:"json", success: update_page});
							function update_page(json){

								if(json.certCode != null){
									$form.find(":input[name='e.certNo']").val(json.certCode);
								}else{
									$form.find(":input[name='e.certNo']").val("");
								}
							}
							
						}
					});
					
		});
		
		
		//选择经办人
		$form.find(":input[name='e.transactor.name']").click(function(){
			bc.identity.selectUser({
				selecteds: $form.find(":input[name='e.transactor.id']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.transactor.id']").val(user.id);
					$form.find(":input[name='e.transactor.name']").val(user.name);
				}
			});
		});

	}
};