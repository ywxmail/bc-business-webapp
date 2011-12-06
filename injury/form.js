if(!window['bs'])window['bs']={};
bc.injuryForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		if(readonly) return;
		
		
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