if (!bc.business)
	bc.business = {};

bc.business.motorcadeForm = {
	init : function() {
		var $form = $(this);
		// 绑定选择所属单位的按钮事件处理
		$form.find(":input[name='e.unit.name']").click(function() {
			bc.identity.selectUnit({
				selecteds: $form.find(":input[name='e.unit.id']").val(),
				onOk: function(unit){
					$form.find(":input[name='e.unit.name']").val(unit.name);
					$form.find(":input[name='e.unit.id']").val(unit.id);
				}
			});
		});

		// 选择负责人
		$form.find(":input[name='e.principalName']").click(function() {
			bc.identity.selectUser({
				history:false,
				selecteds: $form.find(":input[name='e.principalId']").val(),
				onOk: function(user){
					$form.find(":input[name='e.principalName']").val(user.name);
					$form.find(":input[name='e.principalId']").val(user.id);
				}
			});
		});
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