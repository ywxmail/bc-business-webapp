if(!window['bs'])window['bs']={};
bs.carByDriverHistoryView = {
	//删除草稿
	delete_: function(option) {
		option = option || {};
		var $page = $(this);
		var url=$page.attr("data-deleteUrl");
		if(!url || url.length == 0){
			url=$page.attr("data-namespace");
			if(!url || url.length == 0){
				alert("Error:页面没有定义data-deleteUrl或data-namespace属性的值");
				return;
			}else{
				url += "/delete";
			}
		}
		var data=null;
		var $tds = $page.find(".bc-grid>.data>.left tr.ui-state-highlight>td.id");
		var $tr = $page.find(".bc-grid>.data>.right tr.ui-state-highlight");
		var $trs = $page.find(".bc-grid>.data>.right tr.ui-state-highlight");
		if($tds.length == 1){
			var statusValue=$.evalJSON($tr.attr("data-hidden"));
			if(statusValue.status){
			//如果不是草稿状态的返回[status=-1:草稿]
			if(-1 != statusValue.status){
				bc.msg.alert("只能删除草稿状态的迁移记录！");
				return;
			}else{
				data = "id=" + $tds.attr("data-id");
			}
			}else{
				bc.msg.alert("只能删除草稿状态司机的迁移记录");
				return;
			}
		}else if($tds.length > 1){
			data = "ids=";
			//如果不是草稿状态的返回[status=-1:草稿]
			if(-1 != $($trs.get(0)).find("td:eq(0)").attr("data-value")){
				bc.msg.alert("只能删除草稿状态的迁移记录！");
				return;
			}else{
			$tds.each(function(i){
					data += $(this).attr("data-id") + (i == $tds.length-1 ? "" : ",");
			});
			}
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
};