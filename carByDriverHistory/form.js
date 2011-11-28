if (!bc.business)
bc.business = {};
bc.business.carByDriverHistoryForm = {
	init : function() {
		var $form = $(this);
		
		// 选择迁自车辆
		$form.find("#selectOldCar").click(function() {
			var selecteds = $form.find(":input[name='e.fromCar.id']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.fromCar.id']").val(car.id);
					$form.find(":input[name='e.fromCar.name']").val(car.plate);
					
				}
			});
		});
		// 选择迁往车辆
		$form.find("#selectNewCar").click(function() {
			var selecteds = $form.find(":input[name='e.toCar.id']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.toCar.id']").val(car.id);
					$form.find(":input[name='e.toCar.name']").val(car.plate);
				}
			});
		});
		
		// 选择司机
		$form.find("#driverName").click(function() {
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