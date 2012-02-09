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
					$form.find(":input[name='toCarPlate']").val(car.plate);
					$form.find(":input[name='e.toMotorcadeId']").val(car.motorcadeId);
					$form.find(":input[name='e.toUnit']").val(car.company);
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
					$form.find(":input[name='fromCarPlate']").val(car.plate);
					$form.find(":input[name='e.fromMotorcadeId']").val(car.motorcadeId);
					$form.find(":input[name='e.fromUnit']").val(car.company);
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
							$form.find(":input[name='fromCarPlate']").val(json.plate);
							$form.find(":input[name='e.fromMotorcadeId']").val(json.fromMotorcadeId);
							$form.find(":input[name='e.fromClasses']").val(json.fromclasses);
							$form.find(":input[name='e.fromUnit']").val(json.fromUnit);
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
				data: {id: $page.find(":input[name='e.id']").val()},
				afterClose: function(status){
					if(status) bc.grid.reloadData($page);
				}
			});
		});

	},
};





