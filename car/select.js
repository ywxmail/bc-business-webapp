if(!bc.business) bc.business={};

bc.business.slectCarPlateNo={
		
		selectCar: function(option) {
			var option = jQuery.extend({
				url: bc.root + "/bc-business/selectCar/list",
				name: "选择车辆",
				mid: "slectCar",
				afterClose: function(status){
					if(status && typeof(option.onOk) == "function"){
						option.onOk(status);
					}
				}
			    },option);
			
			bc.page.newWin(option);	
		}
		
		
		
};