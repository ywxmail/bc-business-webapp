if (!window['bs'])
	window['bs'] = {};
bs.contract4LabourView = {
	/** 页面的初始化方法 */
	init : function(option, readonly) {
		var $page = $(this);
	},

	/** 标记为按钮的事件处理 */
	clickOk : function(option) {
		var $page = $(this);
		var id = "";
		if(option != null && option.extras.carId){
			id = '?carId='+option.extras.carId;
		}
		if(option != null && option.extras.driverId){
			id = '?driverId='+option.extras.driverId;
		}
		bc.page.newWin({
			url: bc.root + "/bc-business/contract4Labour/create"+id,
			name: "补录劳动合同",
			mid:  "supplyContractLabour",
			data : {isSupply : true},
			afterClose: function(status){
				if(status){
					//刷新视图
					bc.grid.reloadData($page);
				}
			}
		});
	}

};