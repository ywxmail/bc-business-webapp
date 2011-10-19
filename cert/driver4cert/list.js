bc.certdriverList = {
	/** 新建选择证件类型 */
	create : function(option) {
		var $page = $(this);
		function doSth (urlStr,nameStr,midStr,id){
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
		if(option != null && option.extras.carManId){
			id = '?carManId='+option.extras.carManId;
		}
		bc.page.newWin({
			url: bc.root + "/bc-business/driver4cert/create",
			name: "选择车辆证件类型",
			mid: "selectCert4CarManType",
			afterClose: function(type){
				//bc.certdriverList.doSth('certIdentity','新建居民身份证','createCertIdentity');
				if(type != null){
					switch(type.id){
					case "1":
						doSth('certIdentity','新建居民身份证','createCertIdentity',id);
						break;
					case "2":
						doSth('certDriving','机动车驾驶证','createCertDriving',id);
						break;
					case "3":
						doSth('certCyzg','从业资格证','createCertCyzg',id);
						break;
					case "4":
						doSth('certFwzg','服务资格证','createCertFwzg',id);
						break;
					case "5":
						doSth('certJspx','驾驶培训证','createCertJspx',id);
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
			case "1":
				url = bc.root + "/bc-business/certIdentity/edit";
				break;
			case "2":
				url = bc.root + "/bc-business/certDriving/edit";
				break;
			case "3":
				url = bc.root + "/bc-business/certCyzg/edit";
				break;
			case "4":
				url = bc.root + "/bc-business/certFwzg/edit";
				break;
			case "5":
				url = bc.root + "/bc-business/certJspx/edit";
				break;
			}
		}
		
		
//		if($tdType == 1){
//			url = bc.root + "/bc-business/contractLabour/edit";
//		}else{
//			url = bc.root + "/bc-business/contractCharger/edit";
//		}
		
		option = option || {};
		//option对象的函数个数
		option =  $.extend(option, {url: url});
		//
		bc.page.edit.call(this, option);		
	
	}
	
};

