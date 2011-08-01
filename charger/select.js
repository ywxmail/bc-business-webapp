if(!bc.business) bc.business={};

bc.business.charger={
		
		selectCharger: function(option) {
			var option = jQuery.extend({
				url: bc.root + "/bc-business/selectCharger/list",
				name: "选择负责人",
				mid: "slectCharger",
				afterClose: function(status){
					if(status && typeof(option.onOk) == "function"){
						option.onOk(status);
					}
				}
			    },option);
			
			bc.page.newWin(option);	
		}
		
		
		
};