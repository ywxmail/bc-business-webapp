if(!window['bs'])window['bs']={};
bs.carByDriverForm = {
	init : function() {
		var $form = $(this);
		
		// 选择车辆
		$form.find(":input[name='plate']").click(function() {
			var selecteds = $form.find(":input[name='e.car.id']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.car.id']").val(car.id);
					$form.find(":input[name='plate']").val(car.plate);
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