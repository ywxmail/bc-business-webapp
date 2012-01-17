if(!window['bs'])window['bs']={};
bs.insuranceTypeSelectDialog = {
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
			data.id = $tds.attr("data-id");//险种id
			var $tr = $grid.find(">.data>.right tr.ui-state-focus");
			data.name = $tr.find("td:eq(0)").text();//险种名称
			data.coverage = $tr.find("td:eq(1)").text();//保额
			data.description = $tr.find("td:eq(2)").text();//备注
		}else{//多选
			data = [];
			var $trs = $grid.find(">.data>.right tr.ui-state-focus");
			$tds.each(function(i){
				var $tr = $($trs.get(i));
				var name = $tr.find("td:eq(0)").text();//险种名称
				var coverage = $tr.find("td:eq(1)").text();//保额
				var description = $tr.find("td:eq(2)").text();//备注
				data.push({
					id: $(this).attr("data-id"),//险种id
					name:name,
					coverage:coverage,
					premium:premium,
					description:description
				});
				
			});
		}
		logger.info($.toJSON(data));
		
		// 返回
		$page.data("data-status", data);
		$page.dialog("close");
	}
};