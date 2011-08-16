if (!bc.business)
	bc.business = {};

bc.business.selectCarMan = {
	// 单选或多选车辆
		// 单选或多选负责人
		clickOk : function() {
			var $this = $(this);
			var url = $this.attr("data-deleteUrl");
			var data = null;
			var $tds = $this.find(".bc-grid>.data>.left tr.ui-state-focus>td.id");
			var id=$tds.attr("data-id");
			var name = $this.find(".bc-grid>.data>.right tr.ui-state-focus").find("td:eq(0)").text();
			var item = [];
			if ($tds.length == 1) {
				data = "id=" + $tds.attr("data-id");
				item = { id:id,name:name  };
				
			} else if ($tds.length > 1) {
				data = "ids=";
				$tds.each(function(i) {
					data += $(this).attr("data-id")
							+ (i == $tds.length - 1 ? "" : ",");
					});
			
				bc.msg.slide("只能选择一个司机！");
				return;
			}
			if (data == null) {
				bc.msg.slide("请先选择司机！");
				return;
			}
			$this.data("data-status", item);
			$this.dialog("close");
		},
		dblickOk : function() {
			var $this = $(this);
			// 绑定双击事件
			bc.business.selectCarMan.clickOk.call($this[0]);
		}
}