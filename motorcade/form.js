if (!bc.business)
	bc.business = {};

bc.business.motorcadeForm = {
	init : function() {
		var $form = $(this);
		// 绑定选择上级的按钮事件处理
		$form.find(":input[name='e.company']").click(function() {
			var data = {};
			var selected = $form.find(":input[name='e.company']").val();
			if (selected && selected.length > 0)
				data.selected = selected;

			bc.identity.selectUnitOrDepartment({
				data : data,
				onOk : function(actor) {
					$form.find(":input[name='e.company']").val(actor.name);
				}
			});
		});

		// 选择负责人
//		$form.find(":input[name='e.principal']").click(
//				function() {
//					var data = {};
//					var selected = $form.find(":input[name='e.principal']")
//							.val();
//					if (selected && selected.length > 0)
//						data.selected = selected;
//					bc.business.charger.selectCharger({
//						data : data,
//						onOk : function(actors) {
//							if ($.isArray(actors)) {
//								var t="";
//								$.each(actors, function(i, actor) {
//									t += actor.name + ",";
//								});
//								var lastIndex = t.lastIndexOf(',');
//								 if (lastIndex > -1) {
//							          t = t.substring(0, lastIndex) + t.substring(lastIndex + 1, t.length);
//							      }
//								$form.find(":input[name='e.principal']").val(t);
//							} else {
//								$form.find(":input[name='e.principal']").val(actors.name);
//										
//							}
//						}
//					});
//				});
	},

	// 查看车队历史信息
	check : function() {
		var $form = $(this);
		var motorcadeId = $form.find(":input[name='e.id']").val();
		var option = jQuery.extend({
			url : bc.root + "/bc-business/historyCarQuantity/list?pid="
					+ motorcadeId,
			name : "历史车辆数",
			mid : "historyCarQuantity"
		}, option);

		bc.page.newWin(option);
	}
};