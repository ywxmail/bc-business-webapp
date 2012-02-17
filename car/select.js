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
			data.code = $tr.find("td:eq(0)").text();
			data.plate = $tr.find("td:eq(1)").text();
			data.bsType = $tr.find("td:eq(4)").text();
			data.company = $tr.find("td:last(0)").text();
			var p = data.plate.split(".");
			data.plateType = p[0];
			data.plateNo = p[1];
			$.extend(data,$tr.data("hidden"));
		}else{//多选
			data = [];
			var $trs = $grid.find(">.data>.right tr.ui-state-highlight");
			$tds.each(function(i){
				var $tr = $($trs.get(i));
				var code = $tr.find("td:eq(0)").text();
				var plate = $tr.find("td:eq(1)").text();
				var bsType = $tr.find("td:eq(4)").text();
				var company = $tr.find("td:last(1)").text();
				var p = plate.split(".");
				logger.info("--" + $.toJSON($tr.data("hidden")));
				data.push($.extend({
					id: $(this).attr("data-id"),
					code: code,
					plate:plate,
					plateType:p[0],
					plateNo:p[1],
					bsType:bsType,
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