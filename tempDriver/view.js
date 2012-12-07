if(!window['bs'])window['bs']={};
bs.tempDriverView = {
	startFlowing : false,
	/** 使用服务资格证到出租协会网查询信誉档案 */
	gztaxixhDriverInfo : function(option) {
		var $page = $(this);
		
		// 确定选中的行
		var $trs = $page.find(">.bc-grid>.data>.right tr.ui-state-highlight");
		if($trs.length > 1){
			bc.msg.slide("一次只能查询一个司机！");
			return;
		}
		
		// 服务资格证号
		var v = $($trs[0]).children("td[data-column='t.cert_fwzg']").attr("data-value");
		
		if(v == ''){
			 bc.msg.alert("没有服务资格证！");
			 return;
		}

		// 打开查询窗口
		bc.page.newWin({
			mid: "gztaxixhDriverInfo" + v,
			name: "出租协会" + (v ? " - " + v : ""),
			url: bc.root + "/bc-business/gztaxixh/driverInfo",
			data: {value: (v ? v : "")}
		});
	},
	/** 发起流程 */
	startFlow : function(option) {
		var $page = $(this);
		
		bc.msg.alert("司机入职处理流程开发中。");
		return;
		
		
		// 确定选中的行
		var $trs = $page.find(">.bc-grid>.data>.left tr.ui-state-highlight");
		if($trs.size()==0){
			bc.msg.slide("请选择需要发起流程的招聘司机信息！");
			return;
		}
		
		var ids="";
		$trs.each(function(){
			ids+=$(this).find("td").attr("data-id")+",";
		});
		
		bs.tempDriverView.startFlowing = true;
		bc.msg.confirm("确认发起司机入职审批流程？"
				,function(){
					bc.ajax({
						url : bc.root + "/bc-business/tempDriver/startFlow",
						data : {tdIds:ids},
						dataType : "json",
						success : function(json) {
							bc.msg.slide(json.msg);
							if(json.success){
								bc.grid.reloadData($page);
								bc.sidebar.refresh();
							}
							bs.tempDriverView.startFlowing = false;
						}
					});
				},function(){
					bs.tempDriverView.startFlowing = false;
				},"发起流程确认窗口"
		);
	}
};