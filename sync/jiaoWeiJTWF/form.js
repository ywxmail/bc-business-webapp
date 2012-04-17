if(!window['bs'])window['bs']={};
bc.jiaoWeiJTWFForm = {
	init : function(option,readonly) {
		var $form = $(this);
		//点击查看金盾网相关的交通违法信息
		$form.find("#jinDunInfo").click(function() {
			var $page = $(this);
			// 重新打开可编辑表单
			bc.page.newWin({
				name: "与车辆号码:" + $form.find(":input[name='e.carPlate']").val() + "相关的金盾网交通违法信息",
				mid: "jinDunJTWF" + $form.find(":input[name='jinDunInfoId']").val(),
				url: bc.root + "/bc-business/jinDunJTWF/open",
				data: {id: $form.find("#jinDunInfoID").val()},
				afterClose: function(status){
					if(status) bc.grid.reloadData($page);
				}
			});
			return false;
		});
		if(readonly) return;

	}

};