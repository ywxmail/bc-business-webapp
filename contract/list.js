bc.contractList = {
	/** 新建选择合同类型 */
	create : function() {
		bc.page.newWin({
			url: bc.root + "/bc-business/contract/create",
			name: "选择合同类型",
			mid: "selectContractType",
			afterClose: function(type){
				if(type != null && type.id == 1){
					bc.page.newWin({
						url: bc.root + "/bc-business/contractLabour/create",
						name: "新建司机劳动合同",
						mid:  "createContractLabour"
					})
				}else if(type != null && type.id == 2){
					bc.page.newWin({
						url: bc.root + "/bc-business/contractCharger/create",
						name: "新建责任人合同",
						mid:  "createContractCharger"
					})
				}else{
					var $page = $(this);
					$page.dialog("close");
				}
			}
		});
	},

	edit : function(option) {
		var $page = $(this);
		var url;
		var $tdType = $page.find(".bc-grid>.data>.right tr.ui-state-focus>td:eq(1)").attr("data-value");
		//logger.info("type is?  " + $tdType);
		
		if($tdType == 1){
			url = bc.root + "/bc-business/contractLabour/edit";
		}else{
			url = bc.root + "/bc-business/contractCharger/edit";
		}
		
		option = option || {};
		//option对象的函数个数
		option =  $.extend(option, {url: url});
		//
		bc.page.edit.call(this, option);		
	
	}
};