if (!bc.business)
bc.business = {};

bc.business.blacklistForm = {
	init : function() {
		var $form = $(this);
		
		//选择锁定人
		$form.find(":input[name='e.locker.name']").click(function(){
			bc.identity.selectUser({
				selectdes:$form.find(":input[name='e.locker.id']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.locker.id']").val(user.id);
					$form.find(":input[name='e.locker.name']").val(user.name);
				}
			});
		});
		
		
		//选择解锁人
		$form.find(":input[name='e.unlocker.name']").click(function(){
			bc.identity.selectUser({
				selecteds: $form.find(":input[name='e.unlocker.id']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.unlocker.id']").val(user.id);
					$form.find(":input[name='e.unlocker.name']").val(user.name);
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
					bs.selectDriver({
						data : data,
						onOk : function(carMan) {
							$form.find(":input[name='e.driver.id']").val(carMan.id);
							$form.find(":input[name='e.driver.name']").val(carMan.name);
							
							$form.find(":input[name='e.car.unit.name']").val("");
							$form.find(":input[name='plate']").val("");
							$form.find(":input[name='e.car.motorcade.name']").val("");
							
							var url=bc.root +"/bc-business/blacklist/carManMess?carManId="+carMan.id;
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