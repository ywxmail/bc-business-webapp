if(!window['bs'])window['bs']={};
bs.carView = {
	selectMenuButtonItem : function(option) {
		var $page = $(this);
		if (option.value == "jinDun-jiaoTongWeiFa") {
			//--金盾网原始查询
			
			// 确定选中的行
			var $trs = $page.find(">.bc-grid>.data>.right tr.ui-state-focus");
			if($trs.length == 0){
				bc.msg.slide("请先选择车辆信息！");
				return;
			}
			
			//跳转到金盾网的交通违法查询页面
			var $tr,plateNo,engineNo;
			$trs.each(function(){
				$tr = $(this);
				plateNo = $tr.children("td[data-column='c.plate_no']").attr("data-value");// 车牌号
				engineNo = $tr.children("td[data-column='c.engine_no']").attr("data-value");// 发动机号
				if(engineNo && engineNo.length >= 4){
					engineNo = engineNo.substr(engineNo.length - 4);
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
				url: bc.root + "/bc-business/jinDunSpider4JiaoTongWeiFa/list",
				carIds: carIds.join(",")
			});
		}
	}
};