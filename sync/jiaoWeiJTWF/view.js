if (!window['bs'])
	window['bs'] = {};
bs.jiaoWeiJTWFView = {
	/** 页面的初始化方法 */
	init : function(option, readonly) {
		var $page = $(this);

	},

	/** 标记为按钮的事件处理 */
	selectMenuButtonItem : function(option) {
		var $page = $(this);
		
		if(option.value.indexOf("mark") == 0){
			//标记为的操作
			bs.jiaoWeiJTWFView.changeStatus($page,option.value.split(".")[1]);
		} else if(option.value.indexOf("sync") == 0){
			//同步的操作
			bs.jiaoWeiJTWFView.sync($page,option.value.split(".")[1]);
		}else{
			alert("不支持的操作类型!");
		}
	},
	syncing: false,
	/** 同步的操作 */
	sync : function($page,dateType) {
		if(bs.jiaoWeiJTWFView.syncing){
			alert("上次执行的同步操作还在后台进行中，请耐心等待！");
			return;
		}
		//同步前先确认
		bc.msg.confirm("确定要执行同步处理吗？",function(){
			bs.jiaoWeiJTWFView.syncing = true;
			jQuery.ajax({
				url: bc.root + "/bc-business/jiaoWeiJTWFs/sync", 
				data: {dateType: dateType}, 
				dataType: "json",
				success: function(json) {
					bs.jiaoWeiJTWFView.syncing = false;
					if(json.success){
						// 显示处理结果
						bc.msg.slide(json.msg);
						
						// 重新加载列表
						bc.grid.reloadData($page);
					}else{
						alert(json.msg);
					}
				}
			});
			// 显示提示结果
			bc.msg.slide("正在后台执行同步操作，完成后会提示你！");
		});
	},
	/** 标记为的操作 */
	changeStatus : function($page,toStatus) {
		// 获取用户选中的条目
		var ids = bc.grid.getSelected($page.find(".bc-grid"));
		
		// 检测是否选中条目
		if(ids.length ==0){
			bc.msg.slide("请先选择要处理的信息！");
			return;
		}
		
		// 执行处理
		jQuery.ajax({
			url: bc.root + "/bc/syncBase/changeStatus", 
			data: {ids: ids.join(","), toStatus: toStatus}, 
			dataType: "json",
			success: function(json) {
				if(json.success){
					// 显示处理结果
					bc.msg.slide(json.msg);
					
					// 重新加载列表
					bc.grid.reloadData($page);
				}else{
					alert(json.msg);
				}
			}
		});
	},

	/** 生成按钮的事件处理 */
	generate : function() {
		var $page = $(this);
		
		// 获取用户选中的条目
		var ids = bc.grid.getSelected($page.find(".bc-grid"));
		
		// 检测是否选中条目
		if(ids.length ==0){
			bc.msg.slide("请先选择要处理的信息！");
			return;
		}else if(ids.length >1 ){
			bc.msg.slide("一次只可以生成一条处理单，请确认您只选择了一条信息！");
			return;
		}
		
		// 检测是否已有生成记录，没有才允许继续生成，避免重复生成
		jQuery.ajax({
			url: bc.root + "/bc/syncBase/hadGenerate", 
			data: {id: ids[0], syncTo: "BS_CASE_BASE"}, 
			dataType: "json",
			success: function(json) {
				// 如果已经生成过就提示用户
				if(!json.success){
					alert(json.msg);
					return;
				}
				// 执行生成操作：带参数跳转到交通违法表单
				bc.page.newWin({
					url: bc.root + "/bc-business/case4InfractTraffic/createFromJiaoWei", 
					mid: "case4InfractTraffic.createFromJiaoWei",
					name: "生成交通违法处理单",
					data: {syncId: ids[0]}
				});
			}
		});
	}
};