if(!window['bs'])window['bs']={};
bs.carView = {
	selectMenuButtonItem : function(option) {
		var $page = $(this);
		if (option.value == "jinDun-jiaoTongWeiFa") {
			//--金盾网原始查询
			
			// 确定选中的行
			var $trs = $page.find(">.bc-grid>.data>.right tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择车辆信息！");
				return;
			}
			
			//跳转到金盾网的交通违法查询页面
			var $tr,plateNo,engineNo;
			$trs.each(function(){
				$tr = $(this);
				plateNo = $tr.children("td[data-column='c.plate_no']").attr("data-value");// 车牌号，不含"粤A"
				engineNo = $tr.children("td[data-column='c.engine_no']").attr("data-value");// 发动机号
				if(engineNo && engineNo.length >= 4){
					engineNo = engineNo.substr(engineNo.length - 4);//发动机后四位数字
					var url = "http://www.gzjd.gov.cn/gzwfcx/chaxunservlet?ywlx=cxlist";
					url += "&hpzl=02";
					url += "&hphm=" + "A" + plateNo;
					url += "&fdjh=" + engineNo;
					url += "&jm=156756dfgd75sdfsdf123fasdfsdfsdf" + "A" + plateNo + engineNo;
					window.open(url,"_blank");
				}else{
					bc.msg.slide(plateNo + "的发动机号码不合规范，无法处理！");
				}
			});
		}else if (option.value == "jinDun-jiaoTongWeiFa-spider") {
			//--后台网络爬虫进行自动抓取
			
			// 确定选中的行
			var $tds = $page.find(">.bc-grid>.data>.left tr.ui-state-focus>td.id");
			var carIds = [];
			$tds.each(function(){
				carIds.push($(this).attr("data-id"));
			});
			bc.page.newWin({
				mid: "jinDunSpider4JiaoTongWeiFa",
				name: "金盾网交通违法信息",
				url: bc.root + "/bc-business/jinDunJTWFs/paging",
				carIds: carIds.join(",")
			});
		}
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
				bc.msg.alert("只能删除草稿状态的车辆！");
				return;
			}else{
				data = "id=" + $tds.attr("data-id");
			}
		}else if($tds.length > 1){
			data = "ids=";
			//如果不是草稿状态的返回[status=-1:草稿]
			if(-1 != $($trs.get(0)).find("td:eq(0)").attr("data-value")){
				bc.msg.alert("只能删除草稿状态的车辆！");
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