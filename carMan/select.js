if(!bc.business) bc.business={};

bc.business.slectCarManName={
		
		selectCarMan: function(option) {
			var option = jQuery.extend({
				url: bc.root + "/bc-business/selectCarMan/paging?typeId=2",
				name: "选择司机",
				mid: "slectCarMan",
				afterClose: function(status){
					if(status && typeof(option.onOk) == "function"){
						option.onOk(status);
					}
				}
			    },option);
			
			bc.page.newWin(option);	
		}
		
		
		
};