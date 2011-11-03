bc.certcarList = {
	/** 新建选择证件类型 */
	create : function(option) {
		var $page = $(this);
		function doSth(urlStr,nameStr,midStr,id){
			var url;
			if(id != null){
				url = bc.root + "/bc-business/"+urlStr+"/create"+id;
			}else{
				url = bc.root + "/bc-business/"+urlStr+"/create";
			}
			bc.page.newWin({
				url:  url,
				name: nameStr,
				mid:  midStr,
				afterClose: function(status){
					if(status){
						//刷新视图
						bc.grid.reloadData($page);
					}
				}
			})
		}
		var id;
		if(option != null && option.extras && option.extras.carId){
			id = '?carId='+option.extras.carId;
		}
		var $B = bc.page.newWin({
			url: bc.root + "/bc-business/car4cert/create",
			name: "选择车辆证件类型",
			mid: "selectCert4CarType",
			afterClose: function(type){
				if(type != null){
					switch(type.id){
					case "1":
						doSth('certVehicelicense','机动车行驶证','createCertVehicelicense',id);
						break;
					case "2":
						doSth('certRoadtransport','道路运输证','createCertRoadtransport',id);
						break;
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
	
	}
};

