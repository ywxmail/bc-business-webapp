if(!window['bs'])window['bs']={};
bs.carByDriverForm = {
	init : function() {
		var $form = $(this);
		
		// 选择车辆
		$form.find("#selectCar").click(function() {
			var selecteds = $form.find(":input[name='e.car.id']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.car.id']").val(car.id);
					$form.find(":input[name='plate']").val(car.plate);
				}
			});
		});
		// 选择顶班车辆
		var car=null;
		var carId=null;
		var $select = $form.find(":input[name='plates']");
		var selectEl = $select[0];
		$form.find("#selectShiftworkCar").click(function() {
			var selecteds = $form.find(":input[name='e.car.id']").val();
			bs.selectCar({
				multiple: true,
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(cars) {
					for(var i=0;i<cars.length;i++){
						car+=cars[i].plate+",";
						carId+=cars[i].id;
						carId=carId.replace("null","");
						car=car.replace("null","");
						car=car.substr(car.length-8,car.length);
						carId=carId.substr(car.length-8,car.length);
						alert(carId);
						selectEl.options[selectEl.length] = new Option(car, carId);
					}
					
//					car=car+selectedCar;
//					car=car.replace("null","");
//					$form.find(":input[name='plates']").val(car);
//					selectEl.options[selectEl.length] = new Option(car.motorcadeName, car.motorcadeId);
//					selectEl.options[selectEl.length-1].selected = true;
				}
			});
		});
		// 选择司机
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