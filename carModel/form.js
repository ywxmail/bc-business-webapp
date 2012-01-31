bc.carModelForm = {
	init : function(option,readonly) {
		var $form = $(this);
		// 初始化多页签
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		if(readonly) return;
		
	}
};