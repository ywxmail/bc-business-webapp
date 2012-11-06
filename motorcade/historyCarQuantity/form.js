if(!window['bs'])window['bs']={};
bs.historyCarQuantityForm = {
	init : function(option,readonly) {
	
	},
	//维护
	doMaintenance : function(){
		$form=$(this);
		bc.msg.confirm("是否维护车队历史车辆数？",function(){
			// 关闭当前窗口
			$form.dialog("close");
			// 重新打开可编辑表单
			bc.page.newWin({
				name: "维护车队历史车辆数",
				mid: "historyCarQuantity" + $form.find(":input[name='e.id']").val(),
				url: bc.root + "/bc-business/historyCarQuantity/edit",
				data: {id: $form.find(":input[name='e.id']").val()},
				afterClose: function(status){
					if(status) bc.grid.reloadData($form);
				}
			});
		});
	},
	//保存并关闭
	saveAndClose : function(){
		$form=$(this);
		//调用标准的方法执行保存
		bc.page.save.call($form,{callback: function(json){
			bc.msg.slide(json.msg);
			$form.dialog("close");
		}});
	}
};