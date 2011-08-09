bc.carManForm = {
	init : function() {
		var $form = $(this);
		
		// 初始化多页签
		$form.find('#formTabs').tabs();
		
		
		//绑定选择上级的按钮事件处理
		$form.find("#selectBelong,:input[name='e.extFZJG']").click(function(){
			var data = {};
			var selected = $form.find(":input[name='e.extFZJG']").val();
			if(selected && selected.length > 0)
				data.selected = selected;
			
			bc.identity.selectUnitOrDepartment({
				data: data,
				onOk: function(actor){
					$form.find(":input[name='e.extFZJG']").val(actor.name);
				}
			});
		});
		
        $form.find("#carMan_photo").click(function(){
			
			var option = jQuery.extend({
				url : bc.root + "/bc-business/modifyPhoto/create",
				name : "修改相片",
				mid : "modifyPhoto"
			}, option);

			bc.page.newWin(option);	
			
		});
		

	}
};