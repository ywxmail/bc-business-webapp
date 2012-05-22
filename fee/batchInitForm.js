if(!window['bs'])window['bs']={};
bs.batchInitForm = {
	init : function() {
		var $form = $(this);
		// 添加顶班车辆
		var $select = $form.find(":input[name='vehiclesView']");
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
						
						if(!bs.batchInitForm.isExist(selectEl, carId)){
							selectEl.options[selectEl.length] = new Option(carPlate, carId);
							selectEl.options[selectEl.length-1].selected = true;
						}
					}
					
					//将顶班车辆变成字符串
					bs.batchInitForm.shiftworkCars2String(selectEl,$form);
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
            	   	for (var i=selectEl.options.length-1; i>=0; i--) {
            	   		if (selectEl.options[i].selected){
            	   			selectEl.options.remove(i);
            	   		}
            	   	}
            	   	//将初始化车辆变成字符串
            	   	bs.batchInitForm.shiftworkCars2String(selectEl,$form);
            	}else{
            	   bc.msg.slide("请选择车辆！");  
            	}
			}
		});
		//添加所有在案车辆
		$form.find("#addAllCar").click(function(){
			bc.msg.confirm("确定添加所有在案车辆？",function(){
				bc.msg.slide("本操作比较耗时,请稍后.");
				var url=bc.root +"/bc-business/batchInit/selectAllCar"
				$.ajax({
					url:url,
					dataType:"json",
					success: function(cars){
						var car=null;
						var carId=null;
				
						for(var i=0;i<cars.length;i++){
							carPlate=cars[i].plate;
							carId=cars[i].id;
							
							if(!bs.batchInitForm.isExist(selectEl, carId)){
								selectEl.options[selectEl.length] = new Option(carPlate, carId);
								selectEl.options[selectEl.length-1].selected = true;
							}
						}
						
						//将顶班车辆变成字符串
						bs.batchInitForm.shiftworkCars2String(selectEl,$form);
					}
				});
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
	},
	
	//确认
	saveAndClose:function(){
		$form = $(this);
		
		var selectEl = $form.find(":input[name='vehiclesView']")[0];
		
		if(selectEl.length <= 0){//车辆列表不能为空
			bc.msg.alert('初始化车辆不能为空!');
			return;
		}
		
		if(selectEl.length >= 100){//保存车辆列表数大于100提示
			bc.msg.slide("本操作比较耗时,请稍后.");
		}
		
		//唯一性检测
		var option = { callback : function (json){
				if(json.success){
					bc.msg.slide(json.msg);
					$form.dialog("close");
				}else{
					bc.msg.alert(json.msg,null,function(){ //车辆已存在承包费用处理
						var $select = $form.find(":input[name='vehiclesView']");
						var cars= json.carIds.split(","); //已存在承包费的carId
						
						var exists; //设置开关变量
						$select.children().each(function(){ //遍历select控件下的option
							exists = false;
							for(var i=0;i<cars.length;i++){
								if(cars[i] == this.value){//此月份已存在的承包费车辆选中
									exists = true;
									this.selected = true;
									break;
								}
							}
							if(!exists)//此月份不存在的承包费车辆取消选中
								this.selected = false;
						});
						
					},null
					);
				}
				return false;
			}
		};

		//调用标准的方法执行保存
		bc.page.save.call(this,option);
	}
};