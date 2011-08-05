if(!bc.business) bc.business={};

bc.business.chargerForm = {
	init : function() {
		var $form = $(this);
		//绑定选择上级的按钮事件处理
		$form.find("#selectBelong,:input[name='e.unit']").click(function(){
			var data = {};
			var selected = $form.find(":input[name='e.unit']").val();
			if(selected && selected.length > 0)
				data.selected = selected;
			
			bc.identity.selectUnitOrDepartment({
				data: data,
				onOk: function(actor){
					$form.find(":input[name='e.unit']").val(actor.name);
				}
			});
		});
		
		
		$form.find(":input[name='charger.photo']").click(function(){
			
			var option = jQuery.extend({
				url : bc.root + "/bc-business/modifyPhoto/create",
				name : "修改相片",
				mid : "modifyPhoto"
			}, option);

			bc.page.newWin(option);	
			
		});
		
	},
	

};