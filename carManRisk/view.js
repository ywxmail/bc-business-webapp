if(!window['bs'])window['bs']={};
bc.carManRishView = {
	deleteing : false,
	/** 删除 */
	delete_ : function(option) {
		if(bc.carManRishView.deleteing)return;
		
		var $page = $(this);
		// 确定选中的行
		var $trs = $page.find(">.bc-grid>.data>.left tr.ui-state-highlight");
		if($trs.size()==0){
			bc.msg.slide("请选择需要删除的人意险信息！");
			return;
		}
		
		//选中的右边行
		var $trs_r=$page.find(">.bc-grid>.data>.right tr.ui-state-highlight");
		
		//信息的拼装 ：人意险ID1,司机ID1;人意险ID1,司机ID2;人意险ID2,司机ID3;。。。。。。
		var info="";
		var msg="";
		
		$trs.each(function(index){
			info+=$(this).find("td").attr("data-id")+":"+$($trs_r[index]).data("hidden").man_id;
			msg+=$($trs_r[index]).data("hidden").man_name;
			if(index+1<$trs.size()){
				info+=",";
				msg+=",";
			}	
		});
		
		bc.carManRishView.deleteing=true;
		
		bc.msg.confirm("确定要删除<b>"+msg+"</b>的人意险信息吗？"
				,function(){
					bc.ajax({
						url : bc.root+"/bc-business/carManRisk/deleteCarMan",
						data : {idsAndCarManIds:info},
						dataType : "json",
						success : function(json){
							if(json.success){
								bc.msg.slide("删除成功");
								bc.grid.reloadData($page);
							}else{
								bc.msg.alert(json.msg);
							}
							bc.carManRishView.deleteing=false;
						}
					});
				},function(){
					bc.carManRishView.deleteing=false;
				},"删除人意险信息确认窗口"
		);
		
	}
};