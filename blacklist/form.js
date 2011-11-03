if (!bc.business)
bc.business = {};

bc.business.blacklistForm = {
	init : function() {
		var $form = $(this);
		
		//选择锁定人
		$form.find(":input[name='e.locker.name']").click(function(){
			bc.identity.selectUser({
				history: false,
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
				history: false,
				selecteds: $form.find(":input[name='e.unlocker.id']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.unlocker.id']").val(user.id);
					$form.find(":input[name='e.unlocker.name']").val(user.name);
				}
			});
		});
		if($form.find(":input[name='isMoreCar']").val()=="true"){
			var carManId=$form.find(":input[name='carManId']").val();
			var url=bc.root +"/bc-business/selectMoreCarWithCarMan/selectCars?carManId="+carManId;
			var option = jQuery.extend({
				url: url,
				name: "选择车辆信息",
				mid: "selectCar",
				afterClose: function(car){
					if(car){
						$form.find(":input[name='e.car.id']").val(car.id);
						$form.find(":input[name='plate']").val(car.name);
						$form.find(":input[name='e.motorcade.id']").val(car.motorcadeId);
						$form.find(":input[name='e.car.motorcade.name']").val(car.motorcadeName);
					}
				}
			},option);
			bc.page.newWin(option);
		};
		if($form.find(":input[name='isNullCar']").val()=="true"){
			bc.msg.slide("该司机还没有驾驶任何车辆！");	
		};
		if($form.find(":input[name='isMoreCarMan']").val()=="true"){
			var carId=$form.find(":input[name='carId']").val();
			var url=bc.root +"/bc-business/selectMoreCarManWithCar/selectCarMans?carId="+carId;
			var option = jQuery.extend({
				url: url,
				name: "选择司机信息",
				mid: "selectCarMan",
				afterClose: function(carMan){
					if(carMan){
						$form.find(":input[name='e.driver.id']").val(carMan.id);
						$form.find(":input[name='e.driver.name']").val(carMan.name);
						
					}
				}
			},option);
			bc.page.newWin(option);
		};
		if($form.find(":input[name='isNullCarMan']").val()=="true"){
			bc.msg.slide("该车辆还没有被任何司机驾驶！");	
		};
		
       // 选择司机
		
//		$form.find("#driverName").click(
//				function() {
//					var data = {};
//					var selected = $form.find(":input[name='e.driver.name']")
//							.val();
//					if (selected && selected.length > 0)
//						data.selected = selected;
//					bs.selectDriver({
//						data : data,
//						onOk : function(carMan) {
//							$form.find(":input[name='e.driver.id']").val(carMan.id);
//							$form.find(":input[name='e.driver.name']").val(carMan.name);
//							
//							$form.find(":input[name='e.car.unit.name']").val("");
//							$form.find(":input[name='plate']").val("");
//							$form.find(":input[name='e.car.motorcade.name']").val("");
//							
//							var url=bc.root +"/bc-business/blacklist/carManMess?carManId="+carMan.id;
//							$.ajax({ url: url,dataType:"json", success: update_page});
//							function update_page(json){
//									
//								$form.find(":input[name='e.car.id']").val(json.carId);
//								$form.find(":input[name='e.car.unit.name']").val(json.unitName);
//								$form.find(":input[name='e.unit.id']").val(json.unitId);
//								$form.find(":input[name='plate']").val(json.carPlate);
//								$form.find(":input[name='e.motorcade.id']").val(json.motorcadeId);
//								$form.find(":input[name='e.car.motorcade.name']").val(json.motorcadeName);
//								
//							}
//						}
//					});
//				});
		
		//通过车辆id查询相关信息
		$form.find("#selectCar").click(function(){
			bs.selectCar({onOk: function(car){
				logger.info("car=" + $.toJSON(car));
				bs.findInfoByCar({
					carId: car.id,
					success: function(info){
						$form.find(":input[name='e.car.id']").val(info.car.id);
						$form.find(":input[name='plate']").val(info.car.plate);
						$form.find(":input[name='e.driver.id']").val(info.driver.id);
						$form.find(":input[name='e.driver.name']").val(info.driver.name);
						$form.find(":input[name='e.motorcade.id']").val(info.motorcade.id);
						$form.find(":input[name='e.car.motorcade.name']").val(info.motorcade.name);
					}
				});
			}});
		});
		
	},
	//绑定锁定事件
	lcoker : function(){
		var $form = $(this);
		bc.msg.confirm("请确定信息是否准确！一但执行锁定功能将无法进行修改，是否继续执行？",function(){
			//status=0为锁定状态
			$form.find(":input[name='e.status']").val("0");
			//调用标准的方法执行保存
			bc.page.save.call($form,{callback:function(){
				$form.dialog("close");
				//显示结案成功提示信息
				bc.msg.slide("锁定成功");
				
				//返回false，禁止默认的“保存成功”提示信息的显示
				return false;
			}});
		});
	},
	//绑定解锁事件
	unlcoker : function(){
		var $form = $(this);
		bc.msg.confirm("请确定信息是否准确！一但执行解锁功能将无法进行修改，是否继续执行？",function(){
			//status=1为解锁状态
			$form.find(":input[name='e.status']").val("1");
			//调用标准的方法执行保存
			bc.page.save.call($form,{callback:function(){
				$form.dialog("close");
				//显示结案成功提示信息
				bc.msg.slide("解锁成功");
				
				//返回false，禁止默认的“保存成功”提示信息的显示
				return false;
			}});
		});
		
		
	}
};