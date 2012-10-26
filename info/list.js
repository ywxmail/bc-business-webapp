bc.namespace("bs");
bs.info = {
	/** 打开管理端视图 */
	doManage : function() {
		var $page = $(this);
		bc.page.newWin({
			name: $page.attr("data-name") + "管理",
			mid: "info.manage." + $page.attr("data-infoType"),
			url: $page.attr("data-namespace") + "Manage/paging"
		});
	},
		
	/** 发布 */
	doIssue : function() {
		var $page = $(this);
		var data=null;
		var $tds = $page.find(".bc-grid>.data>.left tr.ui-state-highlight>td.id");
		if($tds.length == 0){
			bc.msg.slide("请先选择要发布的信息！");
			return;
		}
		if($tds.length > 1){
			bc.msg.info("每次只可发布一条信息！");
			return;
		}
		var status = $page.find(".bc-grid>.data>.right tr.ui-state-highlight>td[data-column='i.status_']").attr("data-value");
		if(status === "0"){
			bc.msg.info("你选择的信息已经处于发布状态，无须重复发布！");
			return;
		}
		var id = $tds.attr("data-id");
		bc.msg.confirm("确定要发布选定的信息吗？",function(){
			bc.ajax({
				url: bc.root + "/bc-business/info/doIssue?id=" + id, 
				data: data, dataType: "json",
				success: function(json) {
					if(json.success === false){
						bc.msg.alert(json.msg);// 仅显示失败信息
					}else{
						bc.msg.slide(json.msg);
						
						//重新加载列表
						bc.grid.reloadData($page);
					}
				}
			});
		});
	},
	
	/** 禁用 */
	doDisabled : function() {
		var $page = $(this);
		var data=null;
		var $tds = $page.find(".bc-grid>.data>.left tr.ui-state-highlight>td.id");
		if($tds.length == 0){
			bc.msg.slide("请先选择要禁用的信息！");
			return;
		}
		if($tds.length > 1){
			bc.msg.info("每次只可禁用一条信息！");
			return;
		}
		var status = $page.find(".bc-grid>.data>.right tr.ui-state-highlight>td[data-column='i.status_']").attr("data-value");
		if(status === "1"){
			bc.msg.info("你选择的信息已经处于禁用状态，无须重复禁用！");
			return;
		}
		var id = $tds.attr("data-id");
		bc.msg.confirm("确定要禁用选定的信息吗？",function(){
			bc.ajax({
				url: bc.root + "/bc-business/info/doDisabled?id=" + id, 
				data: data, dataType: "json",
				success: function(json) {
					if(json.success === false){
						bc.msg.alert(json.msg);// 仅显示失败信息
					}else{
						bc.msg.slide(json.msg);
						
						//重新加载列表
						bc.grid.reloadData($page);
					}
				}
			});
		});
	}
};