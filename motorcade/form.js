if(!bc.business) bc.business={};

bc.business.motorcade={
	//查看车队历史信息	
check:function(){
		var option = jQuery.extend({
			url: bc.root + "/bc-business/historyCarQuantity/list",
			name: "历史车辆数",
			mid: "historyCarQuantity"
		    },option);
		
		bc.page.newWin(option);
	 },

};