if(!window['bs'])window['bs']={};
bs.tempDriverSelectDialog = {
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
			var $trs = $grid.find(">.data>.right tr.ui-state-highlight");
			data.name = $trs.find("td:eq(0)").attr("data-value");
			data.certIdentity = $trs.find("td:eq(1)").attr("data-value");
			data.certFWZG= $trs.find("td:eq(2)").attr("data-value");
			data.certCYZG = $trs.find("td:eq(3)").attr("data-value");

		}else{//多选
			data = [];
			var $trs = $grid.find(">.data>.right tr.ui-state-highlight");
			$tds.each(function(i){
				data.push({
					id: $(this).attr("data-id"),
					name:$($trs.get(i)).find("td:eq(0)").attr("data-value"),
					certIdentity:$($trs.get(i)).find("td:eq(1)").attr("data-value"),
					certFWZG:$($trs.get(i)).find("td:eq(2)").attr("data-value"),
					certCYZG:$($trs.get(i)).find("td:eq(3)").attr("data-value"),
				});
			});
		}
		logger.info($.toJSON(data));
		
		// 返回
		$page.data("data-status", data);
		$page.dialog("close");
	}
};