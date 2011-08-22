if (!bc.business)
bc.business = {};

bc.business.blacklistForm = {
	init : function() {
		var $form = $(this);
		
		//选择锁定人
		$form.find(":input[name='e.locker.name']").click(function(){
			var data = {};
			var selected = $form.find(":input[name='e.locker.name']")
					.val();
			if (selected && selected.length > 0)
				data.selected = selected;
			bc.identity.selectUser({
				data: data,
				onOk : function(item) {
					$form.find(":input[name='e.locker.id']").val(item.id);
					$form.find(":input[name='e.locker.name']").val(item.name);
				}
			});
		});
		
		
		//选择解锁人
		$form.find(":input[name='e.unlocker.name']").click(function(){
			var data = {};
			var selected = $form.find(":input[name='e.unlocker.name']")
					.val();
			if (selected && selected.length > 0)
				data.selected = selected;
			bc.identity.selectUser({
				data: data,
				onOk : function(item) {
					$form.find(":input[name='e.unlocker.id']").val(item.id);
					$form.find(":input[name='e.unlocker.name']").val(item.name);
				}
			});
		});
		
		
       // 选择司机
		
		$form.find("#driverName").click(
				function() {
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
							
							$form.find(":input[name='e.car.unit.name']").val("");
							$form.find(":input[name='plate']").val("");
							$form.find(":input[name='e.car.motorcade.name']").val("");
							
							var url="/bc-business/blacklist/carManMess?carManId="+carMan.id;
							$.ajax({ url: url,dataType:"json", success: update_page});
							function update_page(json){
									
								$form.find(":input[name='e.car.id']").val(json.carId);
								$form.find(":input[name='e.car.unit.name']").val(json.unitName);
								$form.find(":input[name='e.unit.id']").val(json.unitId);
								$form.find(":input[name='plate']").val(json.carPlate);
								$form.find(":input[name='e.motorcade.id']").val(json.motorcadeId);
								$form.find(":input[name='e.car.motorcade.name']").val(json.motorcadeName);
								
							}
						}
					});
				});

	}


};