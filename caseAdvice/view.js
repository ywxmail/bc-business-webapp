if(!window['bs'])window['bs']={};
bs.caseAdviceView = {
	startFlowing : false,
	/** 发起流程 */
	startFlow : function(option) {
		var $page = $(this);
		// 确定选中的行
		var $trs = $page.find(">.bc-grid>.data>.left tr.ui-state-highlight");
		var $trs4Right = $page.find(".bc-grid>.data>.right tr.ui-state-highlight");
		if($trs.size()==0){
			bc.msg.slide("请选择需要发起流程的投诉信息！");
			return;
		}
		
		var ids="";
		var type;
		$trs.each(function(){
			ids+=$(this).find("td").attr("data-id")+",";
		});
		$trs4Right.each(function(){
			type=$(this).data("hidden").type;
		});
		
		bs.caseAdviceView.startFlowing = true;
		bc.msg.confirm("确认发起驾驶员"+(type==2?"客管":"自接")+"投诉处理流程？"
				,function(){
					bc.ajax({
						url : bc.root + "/bc-business/caseAdvice/startFlow",
						data : {tdIds:ids},
						dataType : "json",
						success : function(json) {
							
							if(json.success){
								bc.msg.slide(json.msg);
							}else{
								bc.msg.alert(json.msg);
							}
							bc.grid.reloadData($page);
							bc.sidebar.refresh();

							bs.caseAdviceView.startFlowing = false;
						}
					});
				},function(){
					bs.caseAdviceView.startFlowing = false;
				},"发起流程确认窗口"
		);
	}
};