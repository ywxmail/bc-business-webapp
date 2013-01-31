if(!window['bs'])window['bs']={};
bc.motorcadeList = {
	/** 查看车队历史车辆数 **/
	viewHistoryCarQuantity : function(){
		bc.page.newWin({
			url : bc.root+"/bc/historyCarQuantitys/paging",
			name: "车队历史车辆数管理",
			mid : "historyCarQuantityeViews"		
		});
	}
};