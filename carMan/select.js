if(!window['bs'])window['bs']={};
bs.carManSelectDialog = {
	/** 点击确认按钮后的处理函数 */
	clickOk : function() {
		var $page = $(this);
		
		// 获取选中的行的id单元格
		var $tds = $this.find(".bc-grid>.data>.left tr.ui-state-focus>td.id");
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
			data.name = $grid.find(">.data>.right tr.ui-state-focus").find("td:eq(0)").attr("data-value");
		}else{//多选
			data = [];
			var $trs = $grid.find(".bc-grid>.data>.right tr.ui-state-focus");
			$tds.each(function(i){
				data.push({
					id: $(this).attr("data-id"),
					name:$($trs.get(i)).find("td:eq(0)").attr("data-value")
				});
			});
		}
		
		// 返回
		$this.data("data-status", data);
		$this.dialog("close");
	}
};