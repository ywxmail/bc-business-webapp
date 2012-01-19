if (!bc.business)
bc.business = {};
bc.business.shiftworkByDriverForm = {
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
			// 添加顶班车辆
			
			var $select = $form.find(":input[name='plates']");
			var selectEl = $select[0];
			$form.find("#addCar").click(function() {
				var selecteds = $form.find(":input[name='e.car.id']").val();
				bs.selectCar({
					multiple: true,
					selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
					onOk : function(cars) {
						var car=null;
						var carId=null;
				
						for(var i=0;i<cars.length;i++){
							carPlate=cars[i].plate;
							carId=cars[i].id;
							
							if(!bc.business.shiftworkByDriverForm.isExist(selectEl, carId)){
								selectEl.options[selectEl.length] = new Option(carPlate, carId);
								selectEl.options[selectEl.length-1].selected = true;
							}
							//selectEl.options[selectEl.length] = new Option(carPlate, carId);
						}
						//$form.find(":input[name='e.driver.id']").val(carId);
					}
				});
			});
			//删除所选中的车辆
			$form.find("#removeCar").click(function() {
				var selectedindex = selectEl.selectedIndex;
				var length=selectEl.options.length;
				if(length==0){
					bc.msg.slide("车辆列表为空！无法执行操作！");
				}else{
	               if(selectedindex !=-1){
	            	   selectEl.options[selectedindex]=null;
	                           }else{
	                        	   bc.msg.slide("请选择车辆！");  
	                           }
				}

			});
			//向上移动所选中的车辆
			$form.find("#upCar").click(function() {
				var selectedindex = selectEl.selectedIndex;
				var length=selectEl.options.length;
				if(length==0){
					bc.msg.slide("车辆列表为空！无法执行操作！");
				}else{
				if(selectedindex==0){
					bc.msg.slide("当前位置为最前一行！");
					return false;
				}
				if(selectedindex != -1){
					var pre=selectEl.options[selectedindex-1];
					var sel=selectEl.options[selectedindex];
					selectEl.options[selectedindex-1]=new Option(sel.text, sel.value);
					selectEl.options[selectedindex-1].selected = true;
					selectEl.options[selectedindex]=new Option(pre.text, pre.value);
				  }else{
					bc.msg.slide("请选择车辆！");
				  }
			   }	
			});
			
			//向上移动所选中的车辆
			$form.find("#downCar").click(function() {
				var selectedindex = selectEl.selectedIndex;
				var length=selectEl.options.length;
				if(length==0){
					bc.msg.slide("车辆列表为空！无法执行操作！");
				}else{
				if(selectedindex==length-1){
					bc.msg.slide("当前位置为最后一行！");
					return false;
				}
				if(selectedindex != -1){
					var pre=selectEl.options[selectedindex+1];
					var sel=selectEl.options[selectedindex];
					selectEl.options[selectedindex+1]=new Option(sel.text, sel.value);
					selectEl.options[selectedindex+1].selected = true;
					selectEl.options[selectedindex]=new Option(pre.text, pre.value);
				  }else{
					bc.msg.slide("请选择车辆！");
				  }
			   }	
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
			// 选择顶班司机
			$form.find("#selectShiftworkDriver").click(function() {
				bs.selectDriver({
					//selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
					onOk : function(driver) {
						$form.find(":input[name='driverId']").val(driver.id);
						$form.find(":input[name='driverName']").val(driver.name);
					}
				});
			});
		},
		/**
		 * 判断指定的列表中是否存在指定的值
		 * @param selectEl 列表
		 * @param value 要判断的值
		 */
		isExist:function(selectEl, value){
			if(null == selectEl) return false;
			
			for(var j = 0; j < selectEl.length; j++){
				if(selectEl.options[j].value == value)
					return true;
			}
			return false;
		}
};





