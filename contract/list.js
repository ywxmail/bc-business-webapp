bc.contractList = {
	/** 新建选择合同类型 */
	create : function(option) {
		var $page = $(this);
		var id;
		if(option != null && option.extras.carId){
			id = '?carId='+option.extras.carId;
		}
		if(option != null && option.extras.carManId){
			id = '?driverId='+option.extras.carManId;
		}
		bc.page.newWin({
			url: bc.root + "/bc-business/contract/create",
			name: "选择合同类型",
			mid: "selectContractType",
			afterClose: function(type){
				if(type != null && type.id == 1){
					bc.page.newWin({
						url: bc.root + "/bc-business/contract4Labour/create"+id,
						name: "新建劳动合同",
						mid:  "createContract4Labour",
						afterClose: function(status){
							if(status){
								//刷新视图
								bc.grid.reloadData($page);
							}
						}
					})
				}else if(type != null && type.id == 2){
					bc.page.newWin({
						url: bc.root + "/bc-business/contract4Charger/create"+id,
						name: "新建经济合同",
						mid:  "createContract4Charger",
						afterClose: function(status){
							if(status){
								//刷新视图
								bc.grid.reloadData($page);
							}
						}
					})
				}
			}
		});
	},

	edit : function(option) {
		var $page = $(this);
		var url;
		var $tdType = $page.find(".bc-grid>.data>.right tr.ui-state-focus>td:eq(0)").attr("data-value");
		//logger.info("type is?  " + $tdType);

		if($tdType == 1){
			url = bc.root + "/bc-business/contract4Labour/open";
		}else{
			url = bc.root + "/bc-business/contract4Charger/open";
		}
		option = option || {};
		//option对象的函数个数
		option =  $.extend(option, {url: url});
		bc.page.edit.call(this, option);		
	
	},
	
	del : function(option) {
		option = option || {};
		var $page = $(this);
		var url;
		var $tdType = $page.find(".bc-grid>.data>.right tr.ui-state-focus>td:eq(0)").attr("data-value");
		//logger.info("type is?  " + $tdType);
		
		if($tdType == 1){
			url = bc.root + "/bc-business/contract4Labour/delete";
		}else{
			url = bc.root + "/bc-business/contract4Charger/delete";
		}
		var data=null;
		var $tds = $page.find(".bc-grid>.data>.left tr.ui-state-focus>td.id");
		if($tds.length == 1){
			data = "id=" + $tds.attr("data-id");
		}else if($tds.length > 1){
			bc.msg.slide("一次只可以删除一条信息，请确认您只选择了一条信息！");
			return;
		}
		if(logger.infoEnabled) logger.info("bc.page.delete_: data=" + data);
		if(data == null){
			bc.msg.slide("请先选择要删除的条目！");
			return;
		}
		bc.msg.confirm("确定要删除选定的 <b>"+$tds.length+"</b> 项吗？",function(){
			bc.ajax({
				url: url, data: data, dataType: "json",
				success: function(json) {
					if(logger.debugEnabled)logger.debug("delete success.json=" + jQuery.param(json));
					//调用回调函数
					var showMsg = true;
					if(typeof option.callback == "function"){
						//返回false将禁止保存提示信息的显示
						if(option.callback.call($page[0],json) === false)
							showMsg = false;
					}
					if(showMsg)
						bc.msg.slide(json.msg);
					
					//重新加载列表
					bc.grid.reloadData($page);
				}
			});
		});
	}
	
//	del : function(option) {
//		var $page = $(this);
//		var url;
//		var $tdType = $page.find(".bc-grid>.data>.right tr.ui-state-focus>td:eq(0)").attr("data-value");
//		//logger.info("type is?  " + $tdType);
//		
//		if($tdType == 1){
//			url = bc.root + "/bc-business/contractLabour/delete";
//		}else{
//			url = bc.root + "/bc-business/contractCharger/delete";
//		}
//		
//		option = option || {};
//		//option对象的函数个数
//		option =  $.extend(option, {url: url});
//		//
//		bc.page.delete_.call(this, option);	
//	}
};