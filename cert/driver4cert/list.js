bc.certList = {
	/** 新建选择证件类型 */
	create : function() {
		bc.page.newWin({
			url: bc.root + "/bc-business/driver4cert/create",
			name: "选择证件类型",
			mid: "selectCert4CarType",
			afterClose: function(type){
				//bc.certList.doSth('certIdentity','新建居民身份证','createCertIdentity');
				if(type != null){
					switch(type.id){
					case "1":
						bc.certList.doSth('certIdentity','新建居民身份证','createCertIdentity');
						break;
					case "2":
						bc.certList.doSth('certDriving','机动车驾驶证','createCertDriving');
						break;
					case "3":
						bc.certList.doSth('certCyzg','从业资格证','createCertCyzg');
						break;
					case "4":
						bc.certList.doSth('certFwzg','服务资格证','createCertFwzg');
						break;
					case "5":
						bc.certList.doSth('certJspx','驾驶培训证','createCertJspx');
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
	
	},
	
	doSth : function(urlStr,nameStr,midStr){
		bc.page.newWin({
			url:  bc.root + "/bc-business/"+urlStr+"/create",
			name: nameStr,
			mid:  midStr
		})
	}
};

