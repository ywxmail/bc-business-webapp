if (!bc.business)
bc.business = {};
bc.business.carByDriverHistoryForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		if(readonly) return;
		// 选择迁往车辆
		$form.find("#selectNewCar").click(function() {
			var selecteds = $form.find(":input[name='e.toCar.id']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.toCar.id']").val(car.id);
					$form.find(":input[name='e.toCar.name']").val(car.plate);
					$form.find(":input[name='e.toMotorcadeId']").val(car.motorcadeId);
					$form.find(":input[name='e.toUnit']").val(car.old_unit_name);
					 var $select = $form.find(":input[name='e.toMotorcadeId']");
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
		
//		// 选择司机返回其他信息
//		$form.find("#driverName").click(function() {
//			bs.selectDriver({
//				onOk : function(driver){
//				logger.info("driver=" + $.toJSON(driver));
//				bs.findInfoByDriver({
//					driverId: driver.id,
//					success: function(info){
//						 $form.find(":input[name='e.toCar.id']").val(info.car.id);
//						 $form.find(":input[name='e.toCar.name']").val(info.car.plate)
//						 $form.find(":input[name='e.driver.id']").val(info.driver.id);
//						 $form.find(":input[name='e.driver.name']").val(info.driver.name);
//						 var $select = $form.find(":input[name='e.toMotorcadeId']");
//						 var selectEl = $select[0];
//						if(bc.select.isExist(selectEl, info.motorcade.id)){
//							$select.val(info.motorcade.id);
//						}else{
//							selectEl.options[selectEl.length] = new Option(info.motorcade.name, info.motorcade.id);
//							selectEl.options[selectEl.length-1].selected = true;
//						}
//					}
//				});
//			}});
//		});
		
//		//独立模块下迁移为车辆到车辆选择司机的方法
//		$form.find("#driverName").click(function() {
//			var selecteds = $form.find(":input[name='e.driver.id']").val();
//			bs.selectDriver({
//				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
//				onOk : function(driver) {
//					$form.find(":input[name='e.driver.id']").val(driver.id);
//					$form.find(":input[name='e.driver.name']").val(driver.name);
//					//
//					bs.findInfoByDriver({driverId:driver.id,success:function(json){
//						$form.find(":input[name='e.fromCar.id']").val(json.car.id);
//						$form.find(":input[name='e.fromCar.name']").val(json.car.plate);
//						$form.find(":input[name='e.fromMotorcadeId']").val(json.motorcade.id);
//						$form.find(":input[name='e.fromClasses']").val(json.driver.classes);
//					}});
//					
//					//
//					
//				}
//			});
//		});	
		
		//独立模块下选择司机的方法
		$form.find("#driverName").click(function() {
			var selecteds = $form.find(":input[name='e.driver.id']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(driver) {
					$form.find(":input[name='e.driver.id']").val(driver.id);
					$form.find(":input[name='e.driver.name']").val(driver.name);
					var url=bc.root + "/bc-business/selectNewnestCarByDriver/findNewnestCarByDriver?carManId="+driver.id;
					bc.ajax({
						dataType: "json",
						url: url,
						success: function(json){
							$form.find(":input[name='e.fromCar.id']").val(json.fromCarId);
							$form.find(":input[name='e.fromCar.name']").val(json.plate);
							$form.find(":input[name='e.fromMotorcadeId']").val(json.fromMotorcadeId);
							$form.find(":input[name='e.fromClasses']").val(json.fromclasses);	
						}
					});
				}
			});
		});	
	},
	/** 维护处理 */
	doMaintenance : function() {
		var $page = $(this);
		bc.msg.confirm("是否对"+ $page.find("#header").val() + "的迁移记录进行维护？若不是修改录入时的错误信息，请新建迁移记录以保证信息的准确性",function(){
			// 关闭当前窗口
			$page.dialog("close");
			// 重新打开可编辑表单
			bc.page.newWin({
				name: "维护" + $page.find("#header").val() + "的迁移记录",
				mid: "carByDriverHistory" + $page.find(":input[name='e.id']").val(),
				url: bc.root + "/bc-business/carByDriverHistory/edit",
				data: {id: $page.find(":input[name='e.id']").val()}
			});
		});

	},
};





