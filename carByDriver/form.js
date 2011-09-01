if (!bc.business)
bc.business = {};

bc.business.carByDriverForm = {
	init : function() {
		var $form = $(this);
		
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
		$form.find(":input[name='e.driver.name'][readonly!='readonly']").click(function() {
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