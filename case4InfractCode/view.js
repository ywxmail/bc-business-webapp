if(!window['bs'])window['bs']={};
bs.caseTrafficView = {
	startFlowing : false,
	/** 发起流程 */
	startFlow : function(option) {
		var $page = $(this);
		// 确定选中的行
		var $trs = $page.find(">.bc-grid>.data>.left tr.ui-state-highlight");
		if($trs.size()==0){
			bc.msg.slide("请选择需要发起流程的交通违法信息！");
			return;
		}
		
		var ids="";
		$trs.each(function(){
			ids+=$(this).find("td").attr("data-id")+",";
		});
		
		bs.caseTrafficView.startFlowing = true;
		bc.msg.confirm("确认发起驾驶员交通违法处理流程？"
				,function(){
					bc.ajax({
						url : bc.root + "/bc-business/caseTraffic/startFlow",
						data : {tdIds:ids},
						dataType : "json",
						success : function(json) {
							bc.msg.slide(json.msg);
							if(json.success){
								bc.grid.reloadData($page);
								bc.sidebar.refresh();
							}
							bs.caseTrafficView.startFlowing = false;
						}
					});
				},function(){
					bs.caseTrafficView.startFlowing = false;
				},"发起流程确认窗口"
		);
	}
};