if(!window['bs'])window['bs']={};
bs.carSelectDialog = {
	/** 点击确认按钮后的处理函数 */
	clickOk : function() {
		var $page = $(this);
		
		// 获取选中的行的id单元格
		var $tds = $page.find(".bc-grid>.data>.left tr.ui-state-highlight>td.id");
		if($tds.length == 0){
			alert("请先选择！");
			return false;
		}

		// 获取选中的数据
		var data;
		var $grid = $page.find(".bc-grid");
		if($grid.hasClass("singleSelect")){//单选
			data = {};
			data.id = $tds.attr("data-id");
			var $tr = $grid.find(">.data>.right tr.ui-state-highlight");
			data.code = $tr.find("td:eq(0)").attr("data-value");
			data.plate = $tr.find("td:eq(1)").text();
			data.registerDate = $tr.find("td:eq(2)").text();
			data.scrapDate = $tr.find("td:eq(3)").text();
			data.bsType = $tr.find("td:eq(5)").attr("data-value");
			data.charger = $tr.find("td:eq(6)").attr("data-value");
			data.company = $tr.find("td:last(0)").attr("data-value");
			var p = data.plate.split(".");
			data.plateType = p[0];
			data.plateNo = p[1];
			$.extend(data,$tr.data("hidden"));
		}else{//多选
			data = [];
			var $trs = $grid.find(">.data>.right tr.ui-state-highlight");
			$tds.each(function(i){
				var $tr = $($trs.get(i));
				var code = $tr.find("td:eq(0)").attr("data-value");
				var plate = $tr.find("td:eq(1)").text();
				var registerDate = $tr.find("td:eq(2)").text();
				var scrapDate = $tr.find("td:eq(3)").text();
				var bsType = $tr.find("td:eq(5)").attr("data-value");
				var charger = $tr.find("td:eq(6)").attr("data-value");
				var company = $tr.find("td:last(0)").attr("data-value");
				var p = plate.split(".");
				logger.info("--" + $.toJSON($tr.data("hidden")));
				data.push($.extend({
					id: $(this).attr("data-id"),
					code: code,
					plate:plate,
					plateType:p[0],
					plateNo:p[1],
					registerDate:registerDate,
					scrapDate:scrapDate,
					bsType:bsType,
					charger:charger,
					company:company
				},$tr.data("hidden")));
			});
		}
		logger.info($.toJSON(data));
		
		// 返回
		$page.data("data-status", data);
		$page.dialog("close");
	}
};