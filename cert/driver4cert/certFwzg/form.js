if(!window['bs'])window['bs']={};
bc.certFwzgForm = {
	init : function(option,readonly) {
		var $form = $(this);
		if(readonly) return;
		/* 初始化多页签*/
		//$form.find('#formTabs').tabs();
		
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
		
		// 选择司机
		$form.find("#selectCarMan").click(function() {
			var selecteds = $form.find(":input[name='e.name']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(carMan) {
					$form.find(":input[name='e.name']").val(carMan.name);
					$form.find(":input[name='carManId']").val(carMan.id);
				}
			});
		});
		
		//绑定选择上级的按钮事件处理
		$form.find("#selectBelong,:input[name='e.serviceUnit']").click(function(){
			bc.identity.selectUnit({
				onOk: function(actor){
					$form.find(":input[name='e.serviceUnit']").val(actor.name);
				}
			});
		});
	}
};