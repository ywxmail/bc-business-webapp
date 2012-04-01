if(!window['bs'])window['bs']={};
bs.ownershipForm = {
	init : function() {
		var $form = $(this);
		
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
						car=cars[i].plate;
						carId=cars[i].id;
						selectEl.options[selectEl.length] = new Option(car, carId);
					}
					//$form.find(":input[name='e.driver.id']").val(carId);
				}
			});
		});
		//删除所选中的车辆
		$form.find("#deleteCar").click(function() {
			alert("123");
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

	}
};