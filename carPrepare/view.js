if(!window['bs'])window['bs']={};
bs.carPrepareView = {
		//点击“生成年度计划”弹出输入年份和月份对话框
	 createPlanDateDialog : function() {
			var $form = $(this);
			var url=bc.root +"/bc-business/carPrepare/createPlanDateDialog";
			var option = jQuery.extend({
				url: url,
				name: "生成更新计划",
				mid: "createAnnualPlan",
				afterClose: function(MoveType){
					//刷新视图
					bc.grid.reloadData($form)
				}
			},option);
			bc.page.newWin(option);
	 },
	 
	//生成年度计划
	 createAnnualPlan : function(){
		 var $form = $(this);
		//表单验证
		if(!bc.validator.validate($form))
			return;
		 var year = $form.find(":input[name='year']").val();
		 var month = $form.find(":input[name='month']").val();
		 
			// 显示导入进度对话框
			var $page = $(this).closest(".ui-dialog").children(".bc-page");
			var title = $page.dialog("option", "title")
			var doing = true;
			var $processDlg = '<div data-type="custom" class="bc-page">';
			$processDlg += '<div class="info">正在生成更新计划数据，请耐心等候！</div>';
			$processDlg += '<div class="time" style="text-align:center;font-size:200%">00:00:00</div>';
			$processDlg += '</div>';
			$processDlg = $($processDlg);
			$processDlg.dialog({title: title, modal: true});
			
			// 定时更新耗时值
			var time = new Date(1976,0,1,0,0,0);
			var timeEl = $processDlg.children(".time").get(0);
			var timeId = window.setInterval(function(){
				time.setSeconds(time.getSeconds()+1);
				timeEl.innerText = bc.formatTime(time.getHours(),time.getMinutes(),time.getSeconds());
			}, 1000);
			$processDlg.bind("dialogclose",function(event,ui){
				// 删除定时器
				window.clearInterval(timeId);
				// 刷新视图
				if($processDlg.data("refresh"))
					//bc.grid.reloadData($form.closest(".bc-page"));
				
				// 彻底删除所有相关的dom元素
				$processDlg.dialog("destroy").remove();
			}).bind("dialogbeforeclose",function(event,ui){
				if(doing) return false;// 请求未完成不允许关闭窗口
			});
		 		 
		 //生成年度计划
		var url=bc.root +"/bc-business/carPrepare/createAnnualPlan";
		$.ajax({
			url: url,
			dataType:"json",
			data: {plan4Year: year,plan4Month: month},
			complete: function(){
				doing = false;
				window.clearInterval(timeId);// 删除定时器
			},
			success: function (json){
				//新提示方式
				var msg = json.msg;
				var detailID = "detail-"+new Date().getTime();
				if(json.isUpdate){
					msg += '&nbsp;<a href="#" id="'+detailID+'">点击查看详情</a>';
				}
				$processDlg.children(".info").html(msg);
				if(json.success) $processDlg.data("refresh",true);
				if(json.detail){
					$processDlg.find("#"+detailID).click(function(){
						//打开查看详情的窗口
						var errorWin=window.open('', 'showImportDetail');
						var errorDoc = errorWin.document;
						errorDoc.open();
						var html = [];
						html.push('<!DOCTYPE html>');
						html.push('<html>');
						html.push('<head>');
						html.push('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>');
						// 获取视图的标题
						html.push('<title>'+title+'</title>');
						html.push('<style type="text/css">');
						html.push('body>div{color:red;font-weight:bold;font-size:150%}');
						html.push('table{border:none;border-collapse:collapse}');
						html.push('thead{font-weight:bold;}');
						html.push('td{border:1px solid gray;padding:2px;}');
						html.push('td:nth-child(1),td:nth-child(2){font-weight:bold;}');
						html.push('td:nth-child(2){max-width:600px;}');
						html.push('</style>');
						html.push('</head>');
						html.push('<body>');
						
						html.push('<div>'+year+'年'+(month !=''?month+'月':'')+'车辆更新计划'+'</div>');
						html.push('<table>');
						
						// 获取列名
						var carPrepareInfos = json.detail;
						
						// 构建列头行
						html.push('<thead><tr>');
						html.push('<td>行号</td><td style="text-align: centre;">状态</td><td>公司</td><td>车队</td><td>车牌号码</td><td>经营权号</td>');
						html.push('<td>预计交车日期</td><td>车辆登记日期</td><td>合同到期日</td><td>强制险到期日</td>');
						html.push('<td>商业险到期日</td><td>合同性质</td><td>残值归属</td>');
						html.push('</tr></thead>');
						
//						// 构建数据行
						html.push('<tbody>');
						for(var i=0;i<carPrepareInfos.length;i++){
							var carPrepareInfo=carPrepareInfos[i];
							if(carPrepareInfo.status=='生成'){
								html.push('<tr>');
							}else{
								html.push('<tr style="color:red;">');
							}
							html.push('<td>'+(i+1)+'</td>');
							html.push('<td>'+carPrepareInfo.status+'</td>');
							html.push('<td>'+carPrepareInfo.company+'</td>');
							html.push('<td>'+carPrepareInfo.motorcadeName+'</td>');
							html.push('<td>'+carPrepareInfo.plateType+"."+carPrepareInfo.plateNo+'</td>');
							html.push('<td>'+carPrepareInfo.certNo2+'</td>');
							html.push('<td>'+carPrepareInfo.scrapDate+'</td>');
							html.push('<td>'+carPrepareInfo.registerDate+'</td>');
							html.push('<td>'+carPrepareInfo.ccEndDate+'</td>');
							html.push('<td>'+carPrepareInfo.greenslipEndDate+'</td>');
							html.push('<td>'+carPrepareInfo.commerialEndDate+'</td>');
							html.push('<td>'+carPrepareInfo.bsType+'</td>');
							html.push('<td>'+carPrepareInfo.scrapto+'</td>');
							html.push('<tr>');
						}
						html.push('</tbody></table>');
						
						html.push('</body>');
						html.push('</html>');
						errorDoc.write(html.join(""));
						errorDoc.close();
						errorWin.focus();
						return false;
					});
				}
			}

				
				
				
		});
	 
	 }
};