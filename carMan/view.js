if(!window['bs'])window['bs']={};
bs.carManView = {
	/** 使用服务资格证到出租协会网查询信誉档案 */
	gztaxixhDriverInfo : function(option) {
		var $page = $(this);
		
		// 确定选中的行
		var $trs = $page.find(">.bc-grid>.data>.right tr.ui-state-highlight");
		if($trs.length == 0){
			bc.msg.slide("请先选择司机信息！");
			return;
		}else if($trs.length > 1){
			bc.msg.slide("一次只能查询一个司机！");
			return;
		}
		
		// 服务资格证号
		var v = $($trs[0]).children("td[data-column='m.cert_fwzg']").attr("data-value");

		// 打开查询窗口
		bc.page.newWin({
			mid: "gztaxixhDriverInfo" + v,
			name: "出租协会" + (v ? " - " + v : ""),
			url: bc.root + "/bc-business/gztaxixh/driverInfo",
			data: {v:v}
		});
	}
};