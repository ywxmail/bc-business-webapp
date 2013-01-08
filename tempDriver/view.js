if(!window['bs'])window['bs']={};
bs.tempDriverView = {
	operate : false,
	starflowing : false,
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

		// 打开查询窗口
		bc.page.newWin({
			mid: "gztaxixhDriverInfo" + v,
			name: "出租协会" + (v ? " - " + v : ""),
			url: bc.root + "/bc-business/gztaxixh/driverInfo",
			data: {value: (v ? v : "")}
		});
	},/** 标记为按钮的事件处理 */
	selectMenuButtonItem : function(option) {
		var $page = $(this);
		
		switch(option.value){
			case "workflow.carManEntry":
				if(!bs.tempDriverView.starflowing)
					bs.tempDriverView.startFlow($page,"CarManEntry");
				
				break;
			case "workflow.requestDerviceCertficate":
				bc.msg.alert("司机办证流程开发中。。。");
				if(!bs.tempDriverView.starflowing){
					//bs.tempDriverView.startFlow($page,"RequestDerviceCertficate");
				}
				break;
			case "operate.interviewDate":
				if(!bs.tempDriverView.operate)
					bs.tempDriverView.updateInterviewDate($page);
				break;
			case "operate.status":
				if(!bs.tempDriverView.operate)
					bs.tempDriverView.updateStatus($page);
				break;
			default:alert("other");
		}
	},
	/** 发起流程 */
	startFlow : function($page,flowKey) {

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
		
		$trsRight = $page.find(">.bc-grid>.data>.right tr.ui-state-highlight");
		var names="";
		$trsRight.each(function(){
			names+=$(this).find("td:eq(2)").attr("data-value")+"、";
		});
		
		var msg="";
		var flagStatus=false;
		msg+="确认发起<b>"+names.substring(0,names.length-1)+"</b>";
		if(flowKey=="CarManEntry"){
			msg+="的<b>司机新入职、留用审批流程</b>";
			flagStatus=true;
		}else if(flowKey=="RequestDerviceCertficate"){
			msg+="的<b>司机服务资格证办理流程</b>";
		}
		
		bs.tempDriverView.starflowing = true;
		bc.msg.confirm(msg
				,function(){
					bc.ajax({
						url : bc.root + "/bc-business/tempDriver/startFlow",
						data : {tdIds:ids,flowKey:flowKey,flagStatus:flagStatus},
						dataType : "json",
						success : function(json) {
							bc.msg.slide(json.msg);
							if(json.success){
								bc.grid.reloadData($page);
								bc.sidebar.refresh();
								if($trs.size()==1){
									//打开工作空间
									bc.page.newWin({
										name: "工作空间",
										mid: "workspace"+json.procInstId,
										url: bc.root+ "/bc-workflow/workspace/open?id="+json.procInstId
									});
								}
							}
							bs.tempDriverView.starflowing = false;
						}
					});
				},function(){
					bs.tempDriverView.starflowing = false;
				},"发起流程确认窗口"
		);
	},
	/** 更新状态 **/
	updateStatus :function($page){
		// 确定选中的行
		var $trs = $page.find(">.bc-grid>.data>.left tr.ui-state-highlight");
		if($trs.size()==0){
			bc.msg.slide("请选择需要更新司机状态的招聘司机信息！");
			return;
		}
		
		var ids="";
		$trs.each(function(){
			ids+=$(this).find("td").attr("data-id")+",";
		});
		
		$trsRight = $page.find(">.bc-grid>.data>.right tr.ui-state-highlight");
		var names="";
		$trsRight.each(function(){
			names+=$(this).find("td:eq(2)").attr("data-value")+",";
		});	
		
		//生成对话框的html代码
		var html = [];
		html.push('<div class="bc-page" data-type="dialog" style="overflow-y:auto;">');
		html.push('<div style="margin: 4px;max-height: 400px;max-width: 400px;">');
		html.push('<table id="tables" style="width:100%;height:100%;">');
		html.push('<tbody>');
			html.push('<tr>')
				html.push('<td class="value" >'+"修改<b>"+names.substring(0,names.length-1)+"</b>的状态为"+'</td>');
			html.push('</tr>')
			html.push('<tr>')
				html.push('<td>');
					html.push('<input type="radio"  name="status" value="0" style="width:auto;" />');
					html.push('<label>待聘</label>');
					html.push('<input type="radio"  name="status" value="1" style="width:auto;" />');
					html.push('<label>审批中</label>');
					html.push('<input type="radio"  name="status" value="2" style="width:auto;" />');
					html.push('<label>聘用</label>');
					html.push('<input type="radio"  name="status" value="3" style="width:auto;" />');
					html.push('<label>未聘用</label>');
				html.push('</td>');
			html.push('</tr>')
		html.push('</tbody>');
		html.push('</table>');
		html.push('</div>');
		html.push('</div>');
		html = $(html.join("")).appendTo("body");
		
		var $table = html.find("#tables");
		//绑定确认事件
		function onConfirmClick(){
			$rstatus=$table.find(":input[name='status']");
			var checked=false;
			$rstatus.each(function(){
				if($(this)[0].checked)
					checked=true;
			});

			if(!checked){
				bc.msg.alert("请选择状态！");
				return false;
			}
			
			var status=$table.find(":input[name='status']:checked").val();
			bs.tempDriverView.operate = true;
			bc.ajax({
				url : bc.root + "/bc-business/tempDriver/updateStatus",
				data : {ids:ids,status:status},
				dataType : "json",
				success : function(json) {
					bc.msg.slide(json.msg);
					if(json.success)
						bc.grid.reloadData($page);
					bs.tempDriverView.operate = false;
				}
			});
			html.dialog("destroy").remove();
		};
		
		//绑定确认事件
		function onCancelClick(){
			//销毁对话框
			html.dialog("destroy").remove();
		};
		
		//弹出对话框让用户选择状态
		html.dialog({
			id: "tempDriver.updateStatus",
			title: "批量修改状态窗口",
			dialogClass: 'bc-ui-dialog ui-widget-header',
			width:300,modal:true,
			minWidth:300,
			buttons:[{text:"确定",click: onConfirmClick},{text:"取消",click: onCancelClick}]
		});	
	},
	/** 更新面试日期 **/
	updateInterviewDate :function($page){
		// 确定选中的行
		var $trs = $page.find(">.bc-grid>.data>.left tr.ui-state-highlight");
		if($trs.size()==0){
			bc.msg.slide("请选择需要更新面试日期的招聘司机信息！");
			return;
		}
		
		var ids="";
		$trs.each(function(){
			ids+=$(this).find("td").attr("data-id")+",";
		});
		
		$trsRight = $page.find(">.bc-grid>.data>.right tr.ui-state-highlight");
		var names="";
		$trsRight.each(function(){
			names+=$(this).find("td:eq(2)").attr("data-value")+",";
		});
		
		var msg="确定修改<b>"+names.substring(0,names.length-1)+"</b>的面试日期为";
		
		bc.page.newWin({
			name: "确定面试日期",
			mid: "tempDriver.updateInterviewDate",
			url: bc.root + "/bc/common/selectDate",
			data: {time:false,title:"请输入面试日期"},
			afterClose: function(date){
				msg+="<b>"+date+"</b>吗？";
				bs.tempDriverView.operate = true;
				bc.msg.confirm(msg
						,function(){
							bc.ajax({
								url : bc.root + "/bc-business/tempDriver/updateInterviewDate",
								data : {ids:ids,interviewDate:date},
								dataType : "json",
								success : function(json) {
									bc.msg.slide(json.msg);
									if(json.success){
										bc.grid.reloadData($page);					
									}
									bs.tempDriverView.operate = false;
								}
							});
						},function(){
							bs.tempDriverView.operate = false;
						},"批量编辑面试日期窗口"
				);
			}
		});
	}
	
};