if(!window['bs'])window['bs']={};
bc.caseTrafficForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		//鼠标单击流程名称事件
		$form.delegate(".bs-caseTraffic-workFlow-processName","click",function(){
			var $tr=$(this).closest("tr");
			var procInstId=$tr.find(".bs-caseTraffic-workFlow-procInstId").val();
			bc.page.newWin({
				name: "工作空间",
				mid: "workspace"+procInstId,
				url: bc.root+ "/bc-workflow/workspace/open?id="+procInstId
			});
		});
		
		//绑定展开事件
		$form.delegate(".showGroups","click",function(){
			$(this).hide();
			$(this).closest(".bs-caseTraffic-containers").find(".bs-caseTraffic-Groups").toggle('fast');
			$(this).closest(".bs-caseTraffic-containers").find(".hiddenGroups").show();
		});
		
		//绑定隐藏事件
		$form.delegate(".hiddenGroups","click",function(){
			$(this).hide();
			$(this).closest(".bs-caseTraffic-containers").find(".bs-caseTraffic-Groups").toggle('fast');
			$(this).closest(".bs-caseTraffic-containers").find(".showGroups").show();
		});
		
		
		if(readonly) return;
		// 初始化多页签
		
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
					}
				}
			});
		};
		if($form.find(":input[name='isNullCar']").val()=="true"){
			bc.msg.alert("该司机还没有驾驶任何车辆！");	
		}
		
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
					$form.find(":input[name='e.company']").val(car.company);
					var motorcadeName = $form.find(":input[name='e.motorcadeId']").find("option:selected").text();
					$form.find(":hidden[name='e.motorcadeName']").val(motorcadeName);
					$form.find(":hidden[name='e.charger']").val(car.charger);
					
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
						
					};
					
					//根据选择的车辆信息获取相应的营运司机信息
					var url=bc.root +"/bc-business/caseTraffic/selectCarMansInfo?carId="+car.id;
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
									id: "selectTrafficDriver",
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
		$form.find("#selectChargerName").click(function() {
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
		
		// 绑定邮递日期事件
		$form.find(":checkbox[name='e.deliver']").change(function() {
			if(this.checked){
				$form.find('#tdTitle1').css("visibility","visible");
				$form.find('#tdValue1').css("visibility","visible");
			}else{
				$form.find('#tdTitle1').css("visibility","hidden");
				$form.find('#tdValue1').css("visibility","hidden");
			}
		});
		
		// 绑定签领日期事件
		$form.find(":checkbox[name='e.sign']").change(function() {
			if(this.checked){
				$form.find('#tdTitle2').css("visibility","visible");
				$form.find('#tdValue2').css("visibility","visible");
			}else{
				$form.find('#tdTitle2').css("visibility","hidden");
				$form.find('#tdValue2').css("visibility","hidden");
			}
		});
		
	},
	
	closefile : function(){
		var $form = $(this);
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
	
	//保存的处理
	save:function(){
		var $form = $(this);
		$form.find(":input[name='e.status']").val("0");
		$form.data("data-status","saved");
		//调用标准的方法执行保存
		bc.page.save.call($form);
	},
	/** 选择违法代码后 */
	afterSelectInfractCode: function(event, ui){
		var $form = $(this).closest(".bc-page");
		$form.find(":input[name='e.infractCode']").val(ui.item.code);
		$form.find(":input[name='e.subject']").val(ui.item.subject);
		$form.find(":input[name='e.penalty']").val(ui.item.penalty);
		$form.find(":input[name='e.jeom']").val(ui.item.jeom);
		// 记得返回false，否则车辆域信息会被清空
		return false;
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