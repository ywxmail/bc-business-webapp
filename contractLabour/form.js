if(!window['bs'])window['bs']={};
bc.contractLabourForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		/* 初始化多页签*/
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		if(readonly) return;
		
		// 选择车辆车牌
		$form.find(":input[name='e.ext_str1']").click(function() {
			var selecteds = $form.find(":input[name='carId']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.ext_str1']").val(car.plate);
					$form.find(":input[name='carId']").val(car.id);
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