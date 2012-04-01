if (!bc.business)
bc.business = {};
bc.business.piliangXiuGaiForm = {
	init : function() {
		var $form = $(this);
		// 添加顶班车辆
		var $select = $form.find(":input[name='vehicles']");
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
						
						if(!bc.business.piliangXiuGaiForm.isExist(selectEl, carId)){
							selectEl.options[selectEl.length] = new Option(carPlate, carId);
							selectEl.options[selectEl.length-1].selected = true;
						}
					}
					
					//将顶班车辆变成字符串
					bc.business.piliangXiuGaiForm.shiftworkCars2String(selectEl,$form);
				}
			});
		});
		//删除所选中的车辆
		$form.find("#deleteCar").click(function() {
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
	},
	
	/**
	 * 将顶班车辆变成字符串
	 */
	shiftworkCars2String:function(selectEl,$form){
		var shiftworkCars = "";
		for(var i=0;i<selectEl.length;i++){
			if(i>0) shiftworkCars +=";";
			shiftworkCars+=selectEl.options[i].text+","+selectEl.options[i].value;
		}
		$form.find(":input[name='vehicles']").val(shiftworkCars);
	}
};