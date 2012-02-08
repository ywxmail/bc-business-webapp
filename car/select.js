if(!window['bs'])window['bs']={};
bs.carSelectDialog = {
	/** 点击确认按钮后的处理函数 */
	clickOk : function() {
		var $page = $(this);
		
		// 获取选中的行的id单元格
		var $tds = $page.find(".bc-grid>.data>.left tr.ui-state-focus>td.id");
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
			var $tr = $grid.find(">.data>.right tr.ui-state-focus");
			data.plate = $tr.find("td:eq(0)").text();
			data.oldUnitName = $tr.find("td:last(0)").text();
			var p = data.plate.split(".");
			data.plateType = p[0];
			data.plateNo = p[1];
			$.extend(data,$tr.data("hidden"));
		}else{//多选
			data = [];
			var $trs = $grid.find(">.data>.right tr.ui-state-focus");
			$tds.each(function(i){
				var $tr = $($trs.get(i));
				var plate = $tr.find("td:eq(0)").text();
				var company = $tr.find("td:last(0)").text();
				var p = plate.split(".");
				logger.info("--" + $.toJSON($tr.data("hidden")));
				data.push($.extend({
					id: $(this).attr("data-id"),
					plate:plate,
					plateType:p[0],
					plateNo:p[1],
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