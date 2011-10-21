if(!window['bs'])window['bs']={};
bc.contractLabourForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		/* 初始化多页签*/
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		if(readonly) return;
		
		//预加载一个司机关联多台车的对话框选择
		if($form.find(":input[name='isMoreCar']").val()=="true"){
			
			var carManId=$form.find(":input[name='carManId']").val();
			var url= bc.root +"/bc-business/selectMoreCarWithCarMan/selectCars?carManId="+carManId;
			var option = jQuery.extend({
				url: url,
				name: "选择车辆信息",
				mid: "selectCar",
				afterClose: function(car){
					if(car != null){
						$form.find(":input[name='carId']").val(car.id);
						$form.find(":input[name='e.ext_str1']").val(car.name);
					}
				}
			},option);
			bc.page.newWin(option);
		};
		if($form.find(":input[name='isNullCar']").val()=="true"){
			bc.msg.slide("此司机没有驾驶任何车辆！");	
		};
		
		//预加载一台车关联多个司机的对话框选择
		if($form.find(":input[name='isMoreCarMan']").val()=="true"){
			
			var carId=$form.find(":input[name='carId']").val();
			var url=bc.root +"/bc-business/selectMoreCarManWithCar/selectCarMans?carId="+carId;
			var option = jQuery.extend({
				url: url,
				name: "选择司机信息",
				mid: "selectCarMan",
				afterClose: function(carMan){
					if(carMan != null){
						$form.find(":input[name='carManId']").val(carMan.id);
						$form.find(":input[name='e.ext_str2']").val(carMan.name);
						$form.find(":input[name='e.certNo']").val(carMan.cert4FWZG);
					}
				}
			},option);
			bc.page.newWin(option);
			
		};
		if($form.find(":input[name='isNullCarMan']").val()=="true"){
			bc.msg.slide("此车辆没有被任何司机驾驶！");	
		};
		
		// 选择车辆车牌
		$form.find(":input[name='e.ext_str1']").click(function() {
			var selecteds = $form.find(":input[name='carId']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.ext_str1']").val(car.plate);
					$form.find(":input[name='carId']").val(car.id);
					
					var url = bc.root + "/bc-business/contractLabour/carManInfo?carId="+car.id;
					$.ajax({ url: url,dataType:"json", success: update_page});
					function update_page(json){
						$form.find(":input[name='isMoreCar']").val(json.isMore);
						if($form.find(":input[name='isMoreCar']").val()=="false"){
							if(json.id != null){
								$form.find(":input[name='carManId']").val(json.id);
							}else{
								$form.find(":input[name='carManId']").val('');
								bc.msg.slide("此车辆没有被任何司机驾驶！");
							}
							if(json.name != null){
								$form.find(":input[name='e.ext_str2']").val(json.name);
							}else{
								$form.find(":input[name='e.ext_str2']").val('');
							}
							if(json.certNo != null){
								$form.find(":input[name='e.certNo']").val(json.certNo);
							}else{
								$form.find(":input[name='e.certNo']").val('');
							}
						}else{
							var url=bc.root +"/bc-business/selectMoreCarManWithCar/selectCarMans?carId="+car.id;
							var option = jQuery.extend({
								url: url,
								name: "选择司机信息",
								mid: "selectCarMan",
								afterClose: function(carMan){
									if(carMan != null){
										$form.find(":input[name='carManId']").val(carMan.id);
										$form.find(":input[name='e.ext_str2']").val(carMan.name);
										$form.find(":input[name='e.certNo']").val(carMan.cert4FWZG);
									}
								}
							},option);
							bc.page.newWin(option);
						}

					}
					
//					var url=bc.root +"/bc-business/selectMoreCarManWithCar/selectCarMans?carId="+car.id;
//					var option = jQuery.extend({
//						url: url,
//						name: "选择司机信息",
//						mid: "selectCarMan",
//						afterClose: function(carMan){
//							if(carMan != null){
//								$form.find(":input[name='carManId']").val(carMan.id);
//								$form.find(":input[name='e.ext_str2']").val(carMan.name);
//								$form.find(":input[name='e.certNo']").val(carMan.cert4FWZG);
//							}
//						}
//					},option);
//					bc.page.newWin(option);	
					
				}
			});
		});
		
		// 选择司机
		$form.find(":input[name='e.ext_str2']").click(function() {
			var selecteds = $form.find(":input[name='carManId']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(carMan) {
					$form.find(":input[name='e.ext_str2']").val(carMan.name);
					$form.find(":input[name='carManId']").val(carMan.id);
					
					var url = bc.root + "/bc-business/contractLabour/certInfo?carManId="+carMan.id;
					$.ajax({ url: url,dataType:"json", success: update_page});
					function update_page(json){

						if(json.cert_code != null){
							$form.find(":input[name='e.certNo']").val(json.cert_code);
						}else{
							$form.find(":input[name='e.certNo']").val("");
						}
					}
					
				}
			});
					
		});
		
		
		//选择经办人
		$form.find(":input[name='e.transactorName']").click(function(){
			bc.identity.selectUser({
				history : false,
				selecteds: $form.find("input[name='e.transactorId']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.transactorId']").val(user.id);
					$form.find(":input[name='e.transactorName']").val(user.name);
				}
			});
		});
		
		//日期控件设置日期范围
		var dates = $form.find(':input[name^="e.startDate"], :input[name^="e.endDate"]').datepicker({
			changeYear:     true,
			firstDay: 		7,
			dateFormat:		"yy-mm-dd",//yy4位年份、MM-大写的月份
			onSelect: function( selectedDate ) {
				var option = this.name == "e.startDate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});

	}
};