if(!window['bs'])window['bs']={};
bc.contractLabourForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		/* 初始化多页签*/
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		//var id = $form.find(":input[name='e.id']").val();
		//if(readonly && id == null) return;
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
			bs.findInfoByCar({
				carId: carId,
				success: function(info){
					$form.find(":input[name='carManId']").val(info.driver.id);
					$form.find(":input[name='e.ext_str2']").val(info.driver.name);
					$form.find(":input[name='e.certNo']").val(info.driver.cert4FWZG);
					$form.find(":input[name='e.certIdentity']").val(info.driver.cert4IDENTITY);
					$form.find(":input[name='e.age']").val(info.driver.age);
					$form.find(":input[name='e.birthDate']").val(info.driver.birthDate);
					$form.find(":input[name='e.houseType']").val(info.driver.houseType);
					$form.find(":input[name='e.origin']").val(info.driver.origin);
					if(info.driver.sex == 2){
						$form.find(":radio[name='e.sex']")[1].checked = true;
					}
				}
			});
		};
		if($form.find(":input[name='isNullCarMan']").val()=="true"){
			bc.msg.slide("此车辆没有被任何司机驾驶！");	
		};
		
		// 选择车辆车牌
		$form.find("#selectCarPlate").click(function(){
			bs.selectCar({onOk: function(car){
				bs.findInfoByCar({
					carId: car.id,
					success: function(info){
						//TODO 根据车辆ID查找关联的司机否存在劳动合同
						
						$form.find(":input[name='e.ext_str1']").val(info.car.plate);
						$form.find(":input[name='carId']").val(info.car.id);
						$form.find(":input[name='e.registerDate']").val(info.car.registerDate);
						$form.find(":input[name='e.bsType']").val(info.car.bsType);
						$form.find(":input[name='carManId']").val(info.driver.id);
						$form.find(":input[name='e.ext_str2']").val(info.driver.name);
						$form.find(":input[name='e.certNo']").val(info.driver.cert4FWZG);
						$form.find(":input[name='e.certIdentity']").val(info.driver.cert4IDENTITY);
						$form.find(":input[name='e.age']").val(info.driver.age);
						$form.find(":input[name='e.birthDate']").val(info.driver.birthDate);
						$form.find(":input[name='e.houseType']").val(info.driver.houseType);
						$form.find(":input[name='e.origin']").val(info.driver.origin);
						if(info.driver.sex == 2){
							$form.find(":radio[name='e.sex']")[1].checked = true;
						}
					}
				});
			}});
		});
		
		// 选择司机
		$form.find("#selectDriverName").click(function() {
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
		
		//签约期限日期控件设置日期范围
		var startDates = $form.find(':input[name^="e.startDate"], :input[name^="e.endDate"]').datepicker({
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
				startDates.not( this ).datepicker( "option", option, date );
			}
		});

		//申领期限日期控件设置日期范围
		var getDates = $form.find(':input[name^="e.getStartDate"], :input[name^="e.getEndDate"]').datepicker({
			changeYear:     true,
			firstDay: 		7,
			dateFormat:		"yy-mm-dd",//yy4位年份、MM-大写的月份
			onSelect: function( selectedDate ) {
				var option = this.name == "e.getStartDate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				getDates.not( this ).datepicker( "option", option, date );
			}
		});
	},
	
	/**
	 * 上下文为按钮所在窗口，第一个参数为选中的项({text:[text]},value:[value])
	 * 
	 */
	selectMenuButtonItem : function(option) {
		logger.info("selectMenuButtonItem:option=" + $.toJSON(option));
	}
};