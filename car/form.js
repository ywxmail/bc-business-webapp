bc.carForm = {
	init : function(option,readonly) {
		var $form = $(this);
		// 初始化多页签
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		if(readonly) return;
		
		//绑定选择上级的按钮事件处理
		$form.find("#selectBelong,:input[name='e.unit.name']").click(function(){
			var data = {};
			var selected = $form.find(":input[name='e.unit.id']").val();
			//var myId = $form.find(":input[name='e.id']").val();
			if(selected && selected.length > 0)
				data.selected = selected;//当前选择的
			//if(myId && myId.length > 0)
			//	data.exclude = myId;//排除选择自己
			
			bc.identity.selectUnit({
				data: data,
				onOk: function(actor){
					//if(myId != actor.id){
						$form.find(":input[name='e.unit.name']").val(actor.name);
						$form.find(":input[name='e.unit.id']").val(actor.id);
					//}else{
					//	alert("不能选择自己作为自己的上级！");
					//}
				}
			});
		});
		
	}
};