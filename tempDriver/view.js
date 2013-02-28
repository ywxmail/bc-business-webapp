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
			case "workflow.requestServiceCertificate":
				
				if(!bs.tempDriverView.starflowing){
					bs.tempDriverView.startFlow4RSC.call($page);
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
		
		var $trsRight = $page.find(">.bc-grid>.data>.right tr.ui-state-highlight");
		var names="";
		$trsRight.each(function(){
			names+=$(this).data("hidden").name+"、";
		});
		
		var msg="";
		var flagStatus=false;
		msg+="确认发起<b>"+names.substring(0,names.length-1)+"</b>共<b>"+$trs.size()+"</b>人 的";
		if(flowKey=="CarManEntry"){
			msg+="<b>司机新入职、留用审批流程</b>吗？";
			flagStatus=true;
		}else{
			return;
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
	/** 服务资格办证流程的发起 **/
	startFlow4RSC : function() {
		var $page = $(this);
		// 确定选中的行
		var $trs = $page.find(">.bc-grid>.data>.left tr.ui-state-highlight");
		if($trs.size()==0){
			bc.msg.slide("请选择需要发起流程的招聘司机信息！");
			return;
		}else if($trs.size()>1){
			bc.msg.slide("只能选择一个司机！");
			return;
		}
		
		var id=$trs.find("td").attr("data-id");
		var $trsRight = $page.find(">.bc-grid>.data>.right tr.ui-state-highlight");
		var $hidden = $trsRight.data("hidden");
		var name=$hidden.name;
		
		bs.tempDriverView.starflowing = true;
		//验证司机是否符合发起服务资格办理流程的异步请求验证处理
		bc.ajax({
			url:bc.root + "/bc-business/tempDriver/requestServiceCertificateValidate",
			data:{driverId:id},
			dataType:"json",
			success:function(json){
				var msg="";
				var $msg;
				//验证失败
				if(!json.validate){
					if(json.validate_lost_type!=null){
						switch(json.validate_lost_type){
							case 0:msg=json.msg;break;
							case 1:msg="<b>"+name+"</b>"+"未参与入职审批！";break;
							case 2:
								msg='<b>'+name+'</b>最新参与的入职审批流程<b>未结束</b>！';
								break;
							case 3:
								msg='<b>'+name+'</b>最新参与的入职审批流程<b>选择放弃入职审批</b>！';
								break;
							case 4:
								msg='<b>'+name+'</b>最新参与的入职审批流程<b>审批不通过</b>！';
								break;
							default:alert("other!");
						}
					}else if(json.validate_pair_lost_type!=null){
						var pairDriverMsg='<b>'+name+'</b>最新参与入职审批流程中所选择的对班司机'
							+'<b><a href="#" class="pairDriver" data-pairDriver-id="'+json.pair_id+'">'+json.pair_name+'</a></b>';
						
						switch(json.validate_pair_lost_type){
							case 1:
								msg=pairDriverMsg+'未参与入职审批！';
								break;
							case 2:
								msg=pairDriverMsg+'，其最新参与的入职审批流程</b>未结束</b>！';
								break;
							case 3:
								msg=pairDriverMsg+'，其最新参与的入职审批流程</b>选择放弃入职审批</b>！';
								break;
							case 4:
								msg=pairDriverMsg+'，其最新参与的入职审批流程</b>审批不通过</b>！';
								break;
							case 5:
								msg=pairDriverMsg+'，其最新参与的入职审批流程中</b>没有选择对班</b>，两流程不匹配';
								break;
							case 6:
								msg=pairDriverMsg+'，其最新参与的入职审批流程中</b>所选择对班 不是当前司机</b>，两流程不匹配';
								break;
							default:alert("other!");
						}
					}
					bs.tempDriverView.starflowing=false;
					$msg=bc.msg.alert(msg);
				}else{//验证成功
					var data=[];
					msg+="确定对"+name+"</b>";
					
					//申请属性
					var applyAttr= $hidden.applyAttr;
					var applyAttrType="4";//1：新考，2：外司加入，3：留用，4：其它
					if(applyAttr==""||applyAttr.indexOf("新")>-1){
						applyAttrType="1";
					}else if(applyAttr.indexOf("外")>-1){
						applyAttrType="2";
					}else if(applyAttr.indexOf("留")>-1){
						applyAttrType="3";
					}
					
					
					data.push({
						no:1,
						id:id,
						name:name,
						certIdentity:$hidden.certIdentity,
						certCYZG:$hidden.certCYZG,
						pid:json.pid,
						pname:json.pname,
						applyAttrType:applyAttrType
					});
					
					if(json.isPairDriver){
						msg+="和对班"
							+'<b><a href="#" class="pairDriver" data-pairDriver-id="'+json.pair_id+'">'+json.pair_name+'</a></b>';
						applyAttr=json.pair_applyAttr;
						applyAttrType="4";//1：新考，2：外司加入，3：留用，4：其它
						if(applyAttr==""||applyAttr.indexOf("新")>-1){
							applyAttrType="1";
						}else if(applyAttr.indexOf("外")>-1){
							applyAttrType="2";
						}else if(applyAttr.indexOf("留")>-1){
							applyAttrType="3";
						}
						
						data.push({
							no:2,
							id:json.pair_id,
							name:json.pair_name,
							certIdentity:json.pair_certIdentity,
							certCYZG:json.pair_certCYZG,
							pid:json.pair_pid,
							pname:json.pair_pname,
							applyAttrType:applyAttrType
						})
					}
					
					msg+="发起司机服务资格证办理流程吗？"
					
					$msg=bc.msg.confirm(msg
							,function(){
								bc.ajax({
									url : bc.root + "/bc-business/tempDriver/startFlow",
									data : {listDriver:$.toJSON(data),flowKey:"RequestServiceCertificate"},
									dataType : "json",
									success : function(json) {
										bc.msg.slide(json.msg);
										if(json.success){
											bc.grid.reloadData($page);
											bc.sidebar.refresh();
											//打开工作空间
											bc.page.newWin({
												name: "工作空间",
												mid: "workspace"+json.procInstId,
												url: bc.root+ "/bc-workflow/workspace/open?id="+json.pid
											});
											
										}
										bs.tempDriverView.starflowing = false;
									}
								});
							},function(){
								bs.tempDriverView.starflowing = false;
							},"发起流程确认窗口"
						);
				}
				bs.tempDriverView.openPairDriver.call($msg);
			}
		});
	},
	/** 查看流程 **/
	openWorkFlow:function(){
		var $msgPage=$(this);
		var $a=$msgPage.find(".process");
		if($a==null)return;
		var pid=$a.attr("data-process-id");
		$a.click(function(){
			//打开工作空间
			bc.page.newWin({
				name: "工作空间",
				mid: "workspace"+pid,
				url: bc.root+ "/bc-workflow/workspace/open?id="+pid
			});
		})
		
	},
	/** 查看对班司机信息 **/
	openPairDriver:function(){
		var $msgPage=$(this);
		var $a=$msgPage.find(".pairDriver");
		if($a==null)return;
		var id=$a.attr("data-pairDriver-id");
		var name=$a.text();
		
		$a.click(function(){
			bc.page.newWin({
				mid: "tempDriver." + id,
				name: name,
				url: bc.root + "/bc-business/tempDriver/open",
				data: {id:id}
			});
		})
		
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
				html.push('<td class="value" >'+"修改<b>"+names.substring(0,names.length-1)+"</b>共<b>"+$trs.size()+"</b>人的状态为"+'</td>');
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
		
		var msg="确定修改<b>"+names.substring(0,names.length-1)+"</b>共<b>"+$trs.size()+"</b>人的<b>面试日期</b>为";
		
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