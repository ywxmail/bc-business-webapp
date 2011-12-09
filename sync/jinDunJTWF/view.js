if (!window['bs'])
	window['bs'] = {};
bs.jinDunJTWFView = {
	/** 页面的初始化方法 */
	init : function(option, readonly) {
		var $page = $(this);

	},

	/** 标记为按钮的事件处理 */
	selectMenuButtonItem : function(option) {
		var $page = $(this);
		
		if(option.value.indexOf("mark") == 0){
			//标记为的操作
			bs.jinDunJTWFView.changeStatus($page,option.value.split(".")[1]);
		} else if(option.value.indexOf("jindunSpider") == 0){
			//同步的操作
			bs.jinDunJTWFView.sync($page,option.value.split(".")[1]);
		} else if(option.value == "opento"){
			//--金盾网原始查询
			
			// 确定选中的行
			var $trs = $page.find(">.bc-grid>.data>.right tr.ui-state-focus");
			if($trs.length == 0){
				bc.msg.slide("请先选择信息！");
				return;
			}
			
			//跳转到金盾网的交通违法查询页面
			var $tr,plateNo,engineNo;
			$trs.each(function(){
				$tr = $(this);
				plateNo = $tr.children("td[data-column='t.car_plate_no']").attr("data-value");// 车牌号，不含"粤A"
				engineNo = $tr.children("td[data-column='t.engine_no']").attr("data-value");// 发动机号
				if(engineNo && engineNo.length >= 4){
					engineNo = engineNo.substr(engineNo.length - 4);//发动机后四位数字
					var url = "http://www.gzjd.gov.cn/gzwfcx/chaxunservlet?ywlx=cxlist";
					url += "&hpzl=02";
					url += "&hphm=" + "A" + plateNo;
					url += "&fdjh=" + engineNo;
					url += "&jm=156756dfgd75sdfsdf123fasdfsdfsdf" + "A" + plateNo + engineNo;
					window.open(url,"_blank");
				}else{
					bc.msg.slide(plateNo + "的发动机号码不合规范，无法处理！");
				}
			});
		}else{
			alert("不支持的操作类型!");
		}
	},
	syncing: false,
	/** 同步的操作 */
	sync : function($page,unitId) {
		if(bs.jinDunJTWFView.syncing){
			alert("上次执行的网络抓取操作还在后台进行中，请耐心等待！");
			return;
		}
		//同步前先确认
		bc.msg.confirm("确定要执行网络抓取处理吗？(金盾网的网络抓取比较耗时，要耐心等候！)",function(){
			bs.jinDunJTWFView.syncing = true;
			jQuery.ajax({
				url: bc.root + "/bc-business/jinDunJTWFs/sync", 
				data: {unitId: unitId}, 
				dataType: "json",
				success: function(json) {
					bs.jinDunJTWFView.syncing = false;
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
			bc.msg.slide("正在后台执行网络抓取操作，完成后会提示你！");
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
					bc.msg.confirm("该同步记录已生成过相应的处理单,不可重复生成! 需要查阅已生成的处理单吗?",function(){
						bc.page.newWin({
							url: bc.root + "/bc-business/caseTraffic/edit",
							name: "交通违章信息",
							data: {syncId: ids[0]},
							mid:  "editCaseTraffic4JinDun"
						})
					});
					//alert(json.msg);
					return;
				}
				// 执行生成操作：带参数跳转到交通违法表单
				bc.page.newWin({
					url: bc.root + "/bc-business/caseTraffic/createFromJinDun", 
					mid: "case4InfractTraffic.createFromJinDun",
					name: "生成交通违法处理单",
					data: {syncId: ids[0]}
				});
			}
		});
	}
};