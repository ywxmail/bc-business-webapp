if(!window['bs'])window['bs']={};
bc.certVehicelicenseForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		if(readonly) return;
		/* 初始化多页签*/
		//$form.find('#formTabs').tabs();
		
		/*		
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
		*/
		
		// 选择车辆
		$form.find(":input[name='e.plate'][disabled!='disabled']").click(function() {
			var selecteds = $form.find(":input[name='e.name']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.plate']").val(car.plate);
					$form.find(":input[name='carId']").val(car.id);
					
					var url = "/bc-business/certVehicelicense/carInfo?carId="+car.id;
					$.ajax({ url: url,dataType:"json", success: update_page});
					function update_page(json){
						$form.find(":input[name='e.registerDate']"	).val(json.registerdate);
						$form.find(":input[name='e.scrapDate']"		).val(json.scrapdate);
						$form.find(":input[name='e.engineNo']"		).val(json.engineno);
						$form.find(":input[name='e.factory']"		).val(json.factorytype);
						$form.find(":input[name='e.vin']"			).val(json.vin);
						$form.find(":input[name='e.accessCount']"	).val(json.accesscount);
						$form.find(":input[name='e.totalWeight']"	).val(json.totalweight);
						$form.find(":input[name='e.accessWeight']"	).val(json.accessweight);
						$form.find(":input[name='e.dimLen']"		).val(json.dimlen);
						$form.find(":input[name='e.dimWidth']"		).val(json.dimwidth);
						$form.find(":input[name='e.dimHeight']"		).val(json.dimheight);
					}
				}
			});
		});
		
		//绑定选择上级的按钮事件处理
		$form.find("#selectBelong,:input[name='e.owner']").click(function(){
			bc.identity.selectUnit({
				onOk: function(actor){
					$form.find(":input[name='e.owner']").val(actor.name);
				}
			});
		});
	}
};