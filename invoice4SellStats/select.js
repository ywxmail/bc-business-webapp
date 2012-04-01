if(!window['bs'])window['bs']={};
bs.invoice4SellStatsWindow = {
	init : function(){
		var $page = $(this);
		//绑定日期选择
		bc.form.initCalendarSelect($page);

	},
	onClick : function(){
		var $page = $(this);
		//验证视图	
		if(bc.validator.validate($page)){
			var startDate=$page.find("#i4SellStatsStartDateId").val();
			var endDate=$page.find("#i4SellStatsEndDateId").val();
			alert(startDate+endDate);
			var url="";
		}
	}
};