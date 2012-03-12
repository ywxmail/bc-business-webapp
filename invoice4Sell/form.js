if(!window['bs'])window['bs']={};
bs.invoice4SellForm = {
	init : function(option,readonly)  {
		var $form = $(this);
		
		if(readonly) return;
		
		//绑定销售员按钮事件
		// 经办人
		$form.find("#selectCashier").click(function(){
			bc.identity.selectUser({
				history: true,
				selecteds: $form.find(":input[name='cashier']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.cashierId']").val(user.id);
					$form.find(":input[name='cashier']").val(user.name);
				}
			});
		});
		
		//预加载一个司机关联多台车的对话框选择
		if($form.find(":input[name='isMoreCar']").val()=="true"){
			var driverId=$form.find(":input[name='e.buyerId']").val();
			var url= bc.root +"/bc-business/selectMoreCarWithCarMan/selectCars?carManId="+driverId;
			var optionCar = {
				url: url,
				name: "选择车辆信息",
				mid: "selectCar",
				afterClose: function(car){
					if(car != null){
						$form.find(":input[name='e.carId']").val(car.id);
						$form.find(":input[name='e.carPlate']").val(car.plate);
						$form.find("select[name='e.motorcadeId']").val(car.motorcadeId);
						$form.find("select[name='e.company']").val(car.company);
					}
				}
			};
			bc.page.newWin(optionCar);
		};
		if($form.find(":input[name='isNullCar']").val()=="true"){
			bc.msg.alert("此司机没有驾驶任何车辆！");	
		};
		
		//预加载一台车关联多个司机的对话框选择
		if($form.find(":input[name='isMoreCarMan']").val()=="true"){
			var carId=$form.find(":input[name='e.carId']").val();
			bs.findInfoByCar({
				carId: carId,
				success: function(info){
					logger.info("info=" + $.toJSON(info));
					if(info.driver){
						$form.find(":input[name='e.buyerId']").val(info.driver.id);
						$form.find(":input[name='e.buyerName']").val(info.driver.name);
					}else{
						$form.find(":input[name='e.buyerId']").val('');
						$form.find(":input[name='e.buyerName']").val('');
						bc.msg.alert("该车辆还没有被任何司机驾驶！");
					}
				}
			});
		};
		if($form.find(":input[name='isNullCarMan']").val()=="true"){
			bc.msg.alert("此车辆没有被任何司机驾驶！");	
		};
		
		//------------绑定选择车辆按钮事件开始-------------------
		$form.find("#selectCar").click(function() {
			var selecteds = $form.find(":input[name='e.carPlate']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.carId']").val(car.id);
					$form.find(":input[name='e.carPlate']").val(car.plate);
					$form.find("select[name='e.motorcadeId']").val(car.motorcadeId);
					$form.find("select[name='e.company']").val(car.company);
					//选择司机信息
					bs.findInfoByCar({
						carId: car.id,
						success: function(info){
							logger.info("info=" + $.toJSON(info));
							if(info.driver){
								$form.find(":input[name='e.buyerId']").val(info.driver.id);
								$form.find(":input[name='e.buyerName']").val(info.driver.name);
							}else{
								$form.find(":input[name='e.buyerId']").val('');
								$form.find(":input[name='e.buyerName']").val('');
								bc.msg.alert("该车辆还没有被任何司机驾驶！");
							}
						}
					});
				}
			});
		});
		//------------绑定选择车辆按钮事件结束-------------------
		
		//绑定选择购买人按钮事件
		$form.find("#selectBuyer").click(function() {
			var selecteds = $form.find(":input[name='e.buyerId']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(carMan) {
					$form.find(":input[name='e.buyerId']").val(carMan.id);
					$form.find(":input[name='e.buyerName']").val(carMan.name);
				}
			});
		});
	}
};