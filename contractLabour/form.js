if(!window['bs'])window['bs']={};
bc.contractLabourForm = {
	init : function() {
		var $form = $(this);
		
		// 初始化多页签
		$form.find('#formTabs').tabs();
		
		// 选择车辆车牌
		$form.find(":input[name='plate']").click(function() {
			var selecteds = $form.find(":input[name='plate']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.car.id']").val(car.id);
					$form.find(":input[name='plate']").val(car.plate);
				}
			});
		});
		
		// 选择司机
		
		$form.find(":input[name='e.driver.name']").click(function() {
			var selecteds = $form.find(":input[name='e.driver.name']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(carMan) {
					$form.find(":input[name='e.driver.id']").val(carMan.id);
					$form.find(":input[name='e.driver.name']").val(carMan.name);
					
					var url = "/bc-business/contractLabour/certInfo?carManId="+carMan.id;
					$.ajax({ url: url,dataType:"json", success: update_page});
					function update_page(json){

						if(json.certCode != null){
							$form.find(":input[name='e.certNo']").val(json.certCode);
						}else{
							$form.find(":input[name='e.certNo']").val("");
						}
					}
					
				}
			});
					
		});
		
		
		//选择经办人
		$form.find(":input[name='e.transactor.name']").click(function(){
			bc.identity.selectUser({
				selecteds: $form.find(":input[name='e.transactor.id']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.transactor.id']").val(user.id);
					$form.find(":input[name='e.transactor.name']").val(user.name);
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