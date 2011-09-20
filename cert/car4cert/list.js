bc.certcarList = {
	/** 新建选择证件类型 */
	create : function() {
		bc.page.newWin({
			url: bc.root + "/bc-business/car4cert/create",
			name: "选择车辆证件类型",
			mid: "selectCert4CarType",
			afterClose: function(type){
				if(type != null){
					switch(type.id){
					case "1":
						bc.certcarList.doSth('certVehicelicense','机动车行驶证','createCertVehicelicense');
						break;
					case "2":
						bc.certcarList.doSth('certRoadtransport','道路运输证','createCertRoadtransport');
						break;
					default:
						var $page = $(this);
						$page.dialog("close");
					}
				}
			}
		});
	},

	edit : function(option) {
		var $page = $(this);
		var url;
		var $tdType = $page.find(".bc-grid>.data>.right tr.ui-state-focus>td:eq(3)").attr("data-value");
		//logger.info("type is?  " + $tdType);
		
		
		if($tdType != null){
			switch($tdType){
			case "6":
				url = bc.root + "/bc-business/certVehicelicense/edit";
				break;
			case "7":
				url = bc.root + "/bc-business/certRoadtransport/edit";
				break;
			}
		}
		
		option = option || {};
		//option对象的函数个数
		option =  $.extend(option, {url: url});
		bc.page.edit.call(this, option);		
	
	},
	
	doSth : function(urlStr,nameStr,midStr){
		bc.page.newWin({
			url:  bc.root + "/bc-business/"+urlStr+"/create",
			name: nameStr,
			mid:  midStr
		})
	}
};

