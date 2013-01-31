if (!bc.business)
	bc.business = {};

bc.business.motorcadeForm = {
	init : function() {
	},

	// 查看车队历史信息
	check : function() {
		var $form = $(this);
		var motorcadeId = $form.find(":input[name='e.id']").val();
		var option = jQuery.extend({
			title :  $form.find(":input[name='e.name']").val()+"历史车辆数",
			url : bc.root + "/bc-business/historyCarQuantitys/paging?motorcade_id="
					+ motorcadeId,
			name :  $form.find(":input[name='e.name']").val()+"历史车辆数",
			mid : "historyCarQuantity."+motorcadeId
		}, option);

		bc.page.newWin(option);
	}
};