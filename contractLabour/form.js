bc.contractLabourForm = {
	init : function() {
		var $form = $(this);
		
		// 初始化多页签
		$form.find('#formTabs').tabs();
		
		//绑定选择上级的按钮事件处理
//		$form.find("#selectBelong,:input[name='e.unit.name']").click(function(){
//			var data = {};
//			var selected = $form.find(":input[name='e.unit.id']").val();
//			//var myId = $form.find(":input[name='e.id']").val();
//			if(selected && selected.length > 0)
//				data.selected = selected;//当前选择的
//			//if(myId && myId.length > 0)
//			//	data.exclude = myId;//排除选择自己
//			
//			bc.identity.selectUnit({
//				data: data,
//				onOk: function(actor){
//					//if(myId != actor.id){
//						$form.find(":input[name='e.unit.name']").val(actor.name);
//						$form.find(":input[name='e.unit.id']").val(actor.id);
//					//}else{
//					//	alert("不能选择自己作为自己的上级！");
//					//}
//				}
//			});
//		});
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
							
							
							
							/*
							var url="/bc-business/contractLabour/carManMess?carManId="+carMan.id;
							$.ajax({ url: url,dataType:"json", success: update_page});
							function update_page(json){
								
							
								$form.find(":input[name='e.car.id']").val(json.carId);
								$form.find(":input[name='e.car.motorcade.name']").val(json.motorcadeName);
								
								$form.find(":input[name='e.certNo']").val(carMan.cert4CYZG);
							}
							*/
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