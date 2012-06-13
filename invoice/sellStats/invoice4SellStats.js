if(!window['bs'])window['bs']={};
bs.invoice4SellStatsWindow = {
	init : function(){
		var $page = $(this);
		
		//初始化日期输入input值
		var now=(new Date()).format("yyyy-MM-dd");
		$page.find("#i4SellStatsStartDateId").val(now);
		$page.find("#i4SellStatsEndDateId").val(now);
		
		//绑定日期选择
		bc.form.initCalendarSelect($page);

	},
	onClick : function(){
		var $page = $(this);
		//验证视图	
		if(bc.validator.validate($page)){
			var s=$page.find("#i4SellStatsStartDateId").val();
			var e=$page.find("#i4SellStatsEndDateId").val();
			var t="0";
			
			//添加搜索条件
			var extras = $page.data("extras");
			if(!extras){
				$page.data("extras",{});
				extras = $page.data("extras");
			}
			extras.type=t;
			extras.startDate=s;
			extras.endDate=e;
			
			// 重新加载列表数据
			bc.grid.reloadData($page, function(){
				logger.info("advanceSearch reloadData callback");
			});
			
		}
	}
};