if(!window['bs'])window['bs']={};
bs.carManView = {
	/** 使用服务资格证到出租协会网查询信誉档案 */
	gztaxixhDriverInfo : function(option) {
		var $page = $(this);
		
		// 确定选中的行
		var $trs = $page.find(">.bc-grid>.data>.right tr.ui-state-highlight");
		if($trs.length > 1){
			bc.msg.slide("一次只能查询一个司机！");
			return;
		}
		
		// 服务资格证号
		var v = $($trs[0]).children("td[data-column='m.cert_fwzg']").attr("data-value");

		// 打开查询窗口
		bc.page.newWin({
			mid: "gztaxixhDriverInfo" + v,
			name: "出租协会" + (v ? " - " + v : ""),
			url: bc.root + "/bc-business/gztaxixh/driverInfo",
			data: {value: (v ? v : "")}
		});
	},
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
			//如果不是草稿状态的返回[status=-1:草稿]
			if(-1 != $tr.find("td:eq(0)").attr("data-value")){
				bc.msg.alert("只能删除草稿状态的司机！");
				return;
			}else{
				data = "id=" + $tds.attr("data-id");
			}
		}else if($tds.length > 1){
			data = "ids=";
			//如果不是草稿状态的返回[status=-1:草稿]
			if(-1 != $($trs.get(0)).find("td:eq(0)").attr("data-value")){
				bc.msg.alert("只能删除草稿状态的司机！");
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