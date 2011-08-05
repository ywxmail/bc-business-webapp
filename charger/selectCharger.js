if (!bc.business)
	bc.business = {};

bc.business.selectCharger = {
	// 单选或多选负责人
	clickOk : function() {
		var $this = $(this);
		var url = $this.attr("data-deleteUrl");
		var data = null;
		var $tds = $this.find(".bc-grid>.data>.left tr.ui-state-focus>td.id");
		var $name = $this.find(".bc-grid>.data>.right tr.ui-state-focus").find(
				"td:eq(0)");
		var item = [];
		if ($tds.length == 1) {
			data = "id=" + $tds.attr("data-id");
			item = {
				name : $($name[0]).attr("data-value")
			};
		} else if ($tds.length > 1) {
			data = "ids=";
			$tds.each(function(i) {
				data += $(this).attr("data-id")
						+ (i == $tds.length - 1 ? "" : ",");
				item.push({
					name : $($name[i]).attr("data-value")
				});
			});
		}
		if (logger.infoEnabled)
			logger.info("bc.page.delete_: data=" + data);
		if (data == null) {
			bc.msg.slide("请先选择负责人！");
			return;
		}
		$this.data("data-status", item);
		$this.dialog("close");
	},
	dblickOk : function() {
		var $this = $(this);
		// 绑定双击事件
		bc.business.selectCharger.clickOk.call($this[0]);
	}
}