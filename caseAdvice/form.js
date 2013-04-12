if(!window['bs'])window['bs']={};
bc.caseAdviceForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		// 初始化多页签
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		//初始化点击隐藏按钮
		bc.caseAdviceForm.foldingDiv($form,"showGroups1","div1");
		bc.caseAdviceForm.foldingDiv($form,"showGroups2","div2");
		bc.caseAdviceForm.foldingDiv($form,"showGroups3","div3");
		bc.caseAdviceForm.foldingDiv($form,"showGroups4","div4");
		bc.caseAdviceForm.foldingDiv($form,"showGroups5","div5");
		bc.caseAdviceForm.foldingDiv($form,"showGroups6","div6");
		
		//鼠标单击流程名称事件
		$form.find("#div5").delegate(".bs-case4Advice-workFlow-processName","click",function(){
			var $tr=$(this).closest("tr");
			var procInstId=$tr.find(".bs-case4Advice-workFlow-procInstId").val();
			// 打开工作空间
			bc.flow.openWorkspace({id : procInstId});
		});
		
		//只读权限控制
		if(readonly) return;
		
		if($form.find(":input[name='isMoreCar']").val()=="true"){
			var carManId=$form.find(":input[name='carManId']").val();
			var url=bc.root +"/bc-business/selectMoreCarWithCarMan/selectCars?carManId="+carManId;
			bc.page.newWin({
				url: url,
				name: "选择车辆信息",
				mid: "selectCar",
				afterClose: function(car){
					if(car){
						$form.find(":input[name='e.carId']").val(car.id);
						$form.find(":input[name='e.carPlate']").val(car.name);
						$form.find(":input[name='e.motorcadeId']").val(car.motorcadeId);
						var motorcadeName = $form.find(":input[name='e.motorcadeId']").find("option:selected").text();
						$form.find(":hidden[name='e.motorcadeName']").val(motorcadeName);
						$form.find(":input[name='e.company']").val(car.company);
						$form.find(":input[name='registerDate']").val(car.registerDate);
						$form.find(":input[name='scrapDate']").val(car.scrapDate);
					}
				}
			});
		};
		if($form.find(":input[name='isNullCar']").val()=="true"){
			bc.msg.alert("该司机还没有驾驶任何车辆！");	
		};
		if($form.find(":input[name='isMoreCarMan']").val()=="true"){
			var carId=$form.find(":input[name='carId']").val();
			var url=bc.root +"/bc-business/selectMoreCarManWithCar/selectCarMans?carId="+carId;
			bc.page.newWin({
				url: url,
				name: "选择司机信息",
				mid: "selectCarMan",
				afterClose: function(carMan){
					if(carMan){
						$form.find(":input[name='e.driverId']").val(carMan.id);
						$form.find(":input[name='e.driverName']").val(carMan.name);
						$form.find(":input[name='e.driverCert']").val(carMan.cert4FWZG);
						$form.find(":input[name='origin']").val(carMan.origin);
						$form.find(":input[name='birthDate']").val(carMan.birthDate);
						$form.find(":input[name='workDate']").val(carMan.workDate);
					}
				}
			});
		};
		if($form.find(":input[name='isNullCarMan']").val()=="true"){
			bc.msg.alert("该车辆还没有被任何司机驾驶！");	
		};
		
		//绑定车队事件
		$form.find(":input[name='e.motorcadeId']").change(function(){
			var $select = $(this);
			var name = $select.find("option:selected").text();
			$form.find(":hidden[name='e.motorcadeName']").val(name);
		});
		
		// 选择车辆车牌
		$form.find("#selectCarPlate").click(function() {
			var selecteds = $form.find(":input[name='e.carPlate']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.carId']").val(car.id);
					$form.find(":input[name='e.carPlate']").val(car.plate);
					$form.find(":input[name='e.motorcadeId']").val(car.motorcadeId);
					$form.find(":input[name='e.motorcadeName']").val(car.motorcadeName);
					$form.find(":input[name='e.company']").val(car.company);
					$form.find(":hidden[name='e.charger']").val(car.charger);
					$form.find(":input[name='businessType']").val(car.bsType);
					$form.find(":input[name='registerDate']").val(car.registerDate);
					$form.find(":input[name='scrapDate']").val(car.scrapDate);
					
					var str = car.charger;
					if(str != null && str.length > 0){
						var strAry = str.split(";");
						var tempStr = "";
						for(var i=0;i<strAry.length;i++){
							tempStr += strAry[i].split(",")[0];
							if((i+1) < strAry.length)
								tempStr += ",";
						}
						$form.find(":input[name='chargers']").val(tempStr);
					}
					
					
					//按照司机信息更新表单相应的域
					function updateFieldsFromDriver(driver){
						$form.find(":input[name='e.driverId']").val(driver.id);
						$form.find(":input[name='e.driverName']").val(driver.name);
						$form.find(":input[name='e.driverCert']").val(driver.cert4FWZG);
						$form.find(":input[name='origin']").val(driver.origin);
						$form.find(":input[name='birthDate']").val(driver.birthDate);
						$form.find(":input[name='workDate']").val(driver.workDate);
					};
					
					//根据选择的车辆信息获取相应的营运司机信息
					var url=bc.root +"/bc-business/caseAdvice/selectCarMansInfo?carId="+car.id;
					$.ajax({
						url:url,
						dataType:"json",
						success: function(drivers){
							logger.info("drivers=" + $.toJSON(drivers));
							if(drivers.length==0){
								$form.find(":input[name='e.driverId']").val("");
								$form.find(":input[name='e.driverName']").val("");
								$form.find(":input[name='e.driverCert']").val("");
								bc.msg.alert("该车辆还没有被任何司机驾驶！");
							}
							if(drivers.length == 1){//单个司机直接填写
								updateFieldsFromDriver(drivers[0]);
							}else if(drivers.length > 1){//多个司机，让用户选择后再填写
								//生成对话框的html代码
								var html = [];
								html.push('<div class="bc-page" data-type="dialog">');
								html.push('<div style="margin: 4px;">');
								html.push('<select id="drivers" size="10" style="width:100%;height:100%;">');
								for(var i=0; i<drivers.length; i++){
									html.push('<option value="' + drivers[i].id + '"');
									if(i == 0){
										//默认选中第一个司机
										html.push(' selected="selected"');
									}
									html.push('>' + drivers[i].name + '</option>');
								}
								html.push('</select>');
								html.push('</div>');
								html.push('</div>');
								html = $(html.join("")).appendTo("body");
								
								function onSelectDriver(){
									if(driversEl.selectedIndex == -1){
										alert("请先选择事发司机！");
										return false;
									}
									//更新司机信息
									updateFieldsFromDriver(drivers[driversEl.selectedIndex]);
									//销毁对话框
									html.dialog("destroy").remove();
								}
								
								//绑定双击事件
								var driversEl = html.find("#drivers").dblclick(onSelectDriver)[0];
								
								//弹出对话框让用户选择司机
								html.dialog({
									id: "selectAdviceDriver",
									title: "所选车辆有多个营运司机，请选择当事司机",
									dialogClass: 'bc-ui-dialog ui-widget-header',
									width:300,modal:true,
									buttons:[{text:"确定",click: onSelectDriver}],
								});
								
							}
						}
					});
				}
			});
		});
		
		// 绑定投诉项目大类选择
		$form.find("#selectSubject").click(function(){
			bc.page.newWin({
				url: bc.root + "/bc-business/caseAdvice/selectSubject?multiple=true",
				name: "选择投诉项目",
				mid: "selectSubjectOption",
				afterClose: function(option){
					if(option != null){
						if(option.length == 1){
							$form.find(":input[name='e.subject']").val(option[0].fname);
						}else{
							var str = "";
							for(var i=0;i<option.length;i++){
								str += option[i].fname
								if((i+1) < option.length){
									str += " ";
								}
							}
							$form.find(":input[name='e.subject']").val(str);
						}
					}
				}
			});
		});
		
		
		// 选择司机
		$form.find("#selectDriverName").click(function() {
			var selecteds = $form.find(":input[name='e.driverName']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(carMan) {
					$form.find(":input[name='e.driverId']").val(carMan.id);
					$form.find(":input[name='e.driverName']").val(carMan.name);
				}
			});
					
		});
		
		
		// 责任人
		$form.find("#selectCharger").click(function() {
			var selecteds = $form.find(":input[name='e.chargerName']").val();
			bs.selectCharger({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				multiple : true,
				onOk : function(chargers) {
					var chargerName = $form.find(":input[name='chargers']").val();
					var chargerIdAndName = $form.find(":hidden[name='e.charger']").val();
					$.each(chargers,function(i,charger){
						var chargerStr = $form.find(":hidden[name='e.charger']").val();
						if(chargerStr.indexOf(charger.id) > 0){//已存在
							logger.info("duplicate select: id=" + charger.id + ",name=" + charger.name);
						}else{
							if($form.find(":input[name='chargers']").val().length>0){//之前存在责任人的话先加逗号
								chargerName = chargerName+",";
							}
							chargerName += charger.name;
							if((i+1) < chargers.length){ //最后一位不加分号
								chargerName = chargerName+",";
							}
							var tempStr = charger.name+","+charger.id+";";
							chargerIdAndName += tempStr;
						}
					});
					$form.find(":input[name='chargers']").val(chargerName);
					$form.find(":hidden[name='e.charger']").val(chargerIdAndName);
				}
			});
		});
		
		// 经办人
		$form.find("#selectTransactorName").click(function(){
			bc.identity.selectUser({
				history: true,
				selecteds: $form.find(":input[name='e.transactorName']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.transactorId']").val(user.id);
					$form.find(":input[name='e.transactorName']").val(user.name);
				}
			});
		});
		
		// 分公司负责人id
		$form.find("#selectBranchChargerName").click(function(){
			bc.identity.selectUser({
				history: true,
				selecteds: $form.find(":input[name='e.branchChargerName']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.branchChargerId']").val(user.id);
					$form.find(":input[name='e.branchChargerName']").val(user.name);
				}
			});
		});
		
		// 公司审批人姓名
		$form.find("#selectCompanyApprovalName").click(function(){
			bc.identity.selectUser({
				history: true,
				selecteds: $form.find(":input[name='e.companyApprovalName']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.companyApprovalId']").val(user.id);
					$form.find(":input[name='e.companyApprovalName']").val(user.name);
				}
			});
		});
		
//		// 核准人
//		$form.find("#selectHandlerName").click(function(){
//			bc.identity.selectUser({
//				history: false,
//				selecteds: $form.find(":input[name='e.handlerName']").val(),
//				onOk : function(user) {
//					$form.find(":input[name='e.handlerId']").val(user.id);
//					$form.find(":input[name='e.handlerName']").val(user.name);
//				}
//			});
//		});
		

	},
	
	//绑定点击按钮内容展出事件
	foldingDiv : function (context,spanId,divId){
		var $form = context;
		var flip = 0;
		$form.find('#'+spanId).click(function(){
			$(this).toggleClass("ui-icon-carat-1-s ui-icon-carat-1-n");
			//$form.find('#'+divId).toggle( flip++ % 2 == 0 );
			$form.find('#'+divId).toggle('fast',function(){
				if(flip++ % 2 == 0){
					$form.find('#'+spanId).attr('title','点击展出内容');
				}else{
					$form.find('#'+spanId).attr('title','点击隐藏内容');
				}
			});
		});
	},
	
	//结案
	closefile : function(){
		var $form = $(this);
		if($form.find(":input[name='e.carPlate']").val().length < 1
			|| $form.find(":input[name='e.driverId']").val().length < 1	
			|| $form.find(":input[name='e.motorcadeId']").val().length < 1
			|| $form.find(":input[name='e.transactorName']").val().length < 1
			){
			bc.msg.alert('请确认司机,车辆,车队,分公司经办人信息是否填写完整!!');
			return;
		}
		if(!bc.validator.validate($form))
			return;
		bc.msg.confirm("确定要结案吗？",function(){
			$form.find(":input[name='e.status']").val("1");
			$form.data("data-status","saved");
			var option = { callback : function (){
					$form.dialog("close");
					bc.msg.slide("结案成功");
				}
			};
			//调用标准的方法执行保存
			bc.page.save.call($form,option);
		});
	},
	
	//维护按钮
	doMaintenance : function(){
		var $page = $(this);
		// 关闭当前窗口
		bc.msg.confirm("确定维护此投诉信息？",function(){
			$page.dialog("close");
//			var option = { callback : function (){
//					$page.find('#maintenance').hide();
//					$page.find('#bcSaveDlgButton').show();
//				}
//			};
			// 重新打开可编辑表单
			bc.page.newWin({
				name: "维护" + $page.find(":input[name='e.carPlate']").val() + "的投诉信息",
				mid: "caseAdvice" + $page.find(":input[name='e.id']").val(),
				url: bc.root + "/bc-business/caseAdvice/edit",
				data: {id: $page.find(":input[name='e.id']").val()},
				afterClose: function(status){
					if(status) bc.grid.reloadData($page);
				},
			});
		});
	},
	
	//核准按钮
	doManage : function(){
		var $page = $(this);
		bc.page.newWin({
			name:"投诉核准",
			mid: "managecaseAdvice",
			url: bc.root + "/bc-business/selectDateAndHandler/select",
			data: {title:"核准操作"},
			afterClose: function(status){
				logger.info("status=" + $.toJSON(status));
				if(!status) return;
				
				//执行续签处理
				bc.ajax({
					url: bc.root + "/bc-business/caseAdviceOperate/doManage",
					dataType: "json",
					data: {
						handlerId: status.handlerId,
						handlerName: status.handlerName,
						handleDate : status.handleDate,
						handleOpinion : status.handleOpinion,
						id: $page.find(":input[name='e.id']").val()
					},
					success: function(json){
						logger.info("doManage result=" + $.toJSON(json));
						//完成后提示用户
						//bc.msg.info(json.msg);
						var str = json.msg.split(" ")[2];
						str = "<a id='chakan' href=#>"+str+"</a>";
						str = json.msg.split(" ")[0]+" "+json.msg.split(" ")[1]+" "+str+" "+json.msg.split(" ")[3];
						var $a = bc.msg.alert(str);
						$a.find('#chakan').click(function(){
							bc.page.newWin({
								url: bc.root + "/bc-business/caseAdvice/open?id="+json.id,
								name: "查看投诉信息",
								mid:  "viewcaseAdvice",
							   from: $page.attr("data-from")
							})
							$a.dialog("close");
							return false;
						});

						$page.data("data-status","saved");
						$page.dialog("close");
					}
				});
			}
		});
	},
	
	//生成通知单
	doGenNotice : function(){
		var $page = $(this);
		bc.msg.alert('功能正在开发中!');
	},
	
//	//生成表格
//	doGenForm : function(){
//		var $page = $(this);
//		bc.msg.alert('功能正在开发中!');
//	},
	
	//保存的处理
	save : function(){
		var $form = $(this);
		$form.find(":input[name='e.status']").val("0");
		$form.data("data-status","saved");
		//调用标准的方法执行保存
		bc.page.save.call($form);
	}
 /*   
  	closefile : function(){
		var $form = $(this);
		var $page = $(this).next();
	    bc.msg.confirm("确定要结案吗？",function(){
			var url = bc.root + "/bc-business/caseTraffic/closefile";
			$.ajax({ url: url,dataType:"json", success: update_page});
			function update_page(json){
				if(json.status != null && json.status == 1){
					$form.find(":input[name='e.status']").val("1");
					$form.find(":input[name='e.closeDate']").val(json.closeDate);
					$form.find(":input[name='e.closerId']").val(json.closeId);
					$form.find(":input[name='e.closerName']").val(json.closeName);
					$form.find('#divTitle').css("visibility","visible");
					$form.find('#divValue').css("visibility","visible");
					$page.parent().find("#bcSaveDlgButton").button("disable");
					bc.msg.slide("结案成功,请保存！");
//					alert('当前上下文:   \n'+ $form.html());
//					var $button = $("span:contains('结案')").parent();
//					alert('结案的爸爸:   \n'+$button.html());
//					alert('结案的爸爸的爸爸:   \n'+$button.parent().html());
//					return false;
				}
			}
	    });
	}
	*/
};