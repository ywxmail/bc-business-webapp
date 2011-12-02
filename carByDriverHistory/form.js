if (!bc.business)
bc.business = {};
bc.business.carByDriverHistoryForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		if(readonly) return;
		// 选择迁自车辆
		$form.find("#selectOldCar").click(function() {
			var selecteds = $form.find(":input[name='e.fromCar.id']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.fromCar.id']").val(car.id);
					$form.find(":input[name='e.fromCar.name']").val(car.plate);
					$form.find(":input[name='e.fromMotorcadeId']").val(car.motorcadeId);
					 var $select = $form.find(":input[name='e.fromMotorcadeId']");
					 var selectEl = $select[0];
					if(bc.select.isExist(selectEl, car.motorcadeId)){
						$select.val(car.motorcadeId);
					}else{
						selectEl.options[selectEl.length] = new Option(car.motorcadeName, car.motorcadeId);
						selectEl.options[selectEl.length-1].selected = true;
					}
				}
			});
		});
		
		// 选择司机返回其他信息
		$form.find("#driverName").click(function() {
			bs.selectDriver({
				onOk : function(driver){
				logger.info("driver=" + $.toJSON(driver));
				bs.findInfoByDriver({
					driverId: driver.id,
					success: function(info){
						 $form.find(":input[name='e.toCar.id']").val(info.car.id);
						 $form.find(":input[name='e.toCar.name']").val(info.car.plate)
						 $form.find(":input[name='e.driver.id']").val(info.driver.id);
						 $form.find(":input[name='e.driver.name']").val(info.driver.name);
						 var $select = $form.find(":input[name='e.toMotorcadeId']");
						 var selectEl = $select[0];
						if(bc.select.isExist(selectEl, info.motorcade.id)){
							$select.val(info.motorcade.id);
						}else{
							selectEl.options[selectEl.length] = new Option(info.motorcade.name, info.motorcade.id);
							selectEl.options[selectEl.length-1].selected = true;
						}
					}
				});
			}});
		});
		
		// 只选择司机
		$form.find("#selectDriver").click(function() {
			var selecteds = $form.find(":input[name='e.driver.id']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(driver) {
					$form.find(":input[name='e.driver.id']").val(driver.id);
					$form.find(":input[name='e.driver.name']").val(driver.name);
				}
			});
		});	
	}
};





