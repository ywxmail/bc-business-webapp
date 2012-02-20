bc.namespace("bs");
bs.infoCenter = {
	init: function(option,readonly) {
		var $page = $(this);

		// 默认聚焦到查询输入框
		$page.find("input#searchText").focus();

		// 车辆列表的样式控制
		$page.find("ul#results").delegate("li",{
			mouseover: function() {
				$(this).addClass("ui-state-hover");
			},
			mouseout: function() {
				$(this).removeClass("ui-state-hover");
			},
			click: function() {
				var $this = $(this);
				$this.toggleClass("ui-state-highlight",true)
				.siblings(".ui-state-highlight").toggleClass("ui-state-highlight",false);
			}
		});
		
	},
	
	/** 执行查询处理 */
	doSearch: function(){
		var $page = $(this);
		logger.info("bs.infoCenter.doSearch");
	}
};