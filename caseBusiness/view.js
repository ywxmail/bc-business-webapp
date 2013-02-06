if(!window['bs'])window['bs']={};
bs.caseBusinessView = {
	startFlowing : false,
	/** 发起流程 */
	startFlow : function(option) {
		var $page = $(this);
		// 确定选中的行
		var $trs = $page.find(">.bc-grid>.data>.left tr.ui-state-highlight");
		if($trs.size()==0){
			bc.msg.slide("请选择需要发起流程的信息！");
			return;
		}
		
		var ids="";
		$trs.each(function(){
			ids+=$(this).find("td").attr("data-id")+",";
		});
		
		//声明提示信息
		var msg="确认发起";
		
		//选中的右边行
		var $trs_r=$page.find(">.bc-grid>.data>.right tr.ui-state-highlight");
		$trs_r.each(function(index){
			var $hidden_r=$(this).data("hidden");
			if($hidden_r.carId==""){
				bc.msg.alert("发起流程的违章信息 必须要选择车辆！");
				return;
			}
			msg+="<b>"+$hidden_r.carPlate;
			if($hidden_r.category=="0"){
				msg+="营运违章</b>";
			}else if($hidden_r.category=="1"){
				msg+="站台违章</b>";
			}else{
				msg+="服务违章</b>";
			}
			
			if($trs_r.size()>index+1){
				msg+="、";
			}
		});
		
		msg+="的"+"<b>驾驶员违章处理流程</b>"+"吗？"
		
		bs.caseBusinessView.startFlowing = true;

		bc.msg.confirm(msg
				,function(){
					bc.ajax({
						url : bc.root + "/bc-business/caseBusiness/startFlow",
						data : {tdIds:ids},
						dataType : "json",
						success : function(json) {
							bc.msg.slide(json.msg);
							if(json.success){
								bc.grid.reloadData($page);
								bc.sidebar.refresh();
							}
							bs.caseBusinessView.startFlowing = false;
						}
					});
				},function(){
					bs.caseBusinessView.startFlowing = false;
				},"发起流程确认窗口"
		);
	}
};