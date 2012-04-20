if(!window['bs'])window['bs']={};
bs.feeTemplateList = {
	/** 禁用*/
	disabled: function(){
		var $view=$(this);
		var $tds = $view.find(".bc-grid>.data>.left tr.ui-state-highlight>td.id");
		if($tds.length == 1){
			bc.page.disabled.call($view);
			return;
		}else if($tds.length > 1){
			bc.page.disabled.call($view);
			return;
		}else{
			bc.msg.slide("请先选择要禁用的！");
			return;
		}	
	}
};