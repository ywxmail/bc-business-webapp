if(!window['bs'])window['bs']={};
bc.caseBusinessForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		// 初始化多页签
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		if(readonly) return;
		
		
		if($form.find(":input[name='isMoreCar']").val()=="true"){
			var carManId=$form.find(":input[name='carManId']").val();
			var url=bc.root +"/bc-business/selectMoreCarWithCarMan/selectCars?carManId="+carManId;
			var option = jQuery.extend({
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
			},option);
			bc.page.newWin(option);
		};
		if($form.find(":input[name='isNullCar']").val()=="true"){
			bc.msg.slide("该司机还没有驾驶任何车辆！");	
		};
		if($form.find(":input[name='isMoreCarMan']").val()=="true"){
			var carId=$form.find(":input[name='carId']").val();
			var url=bc.root +"/bc-business/selectMoreCarManWithCar/selectCarMans?carId="+carId;
			var option = jQuery.extend({
				url: url,
				name: "选择司机信息",
				mid: "selectCarMan",
				afterClose: function(carMan){
					if(carMan){
						$form.find(":input[name='e.driverId']").val(carMan.id);
						$form.find(":input[name='e.driverName']").val(carMan.name);
						$form.find(":input[name='e.driverCert']").val(carMan.cert4FWZG);
					}
				}
			},option);
			bc.page.newWin(option);
		};
		if($form.find(":input[name='isNullCarMan']").val()=="true"){
			bc.msg.slide("该车辆还没有被任何司机驾驶！");	
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
					
					//按照司机信息更新表单相应的域
					function updateFieldsFromDriver(driver){
						$form.find(":input[name='e.driverId']").val(driver.id);
						$form.find(":input[name='e.driverName']").val(driver.name);
						$form.find(":input[name='e.driverCert']").val(driver.cert4FWZG);
					};
					
					//根据选择的车辆信息获取相应的营运司机信息
					var url=bc.root +"/bc-business/caseBusiness/selectCarMansInfo?carId="+car.id;
					$.ajax({
						url:url,
						dataType:"json",
						success: function(drivers){
							logger.info("drivers=" + $.toJSON(drivers));
							if(drivers.length==0){
								$form.find(":input[name='e.driverId']").val("");
								$form.find(":input[name='e.driverName']").val("");
								$form.find(":input[name='e.driverCert']").val("");
								bc.msg.slide("该车辆还没有被任何司机驾驶！");
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
									id: "selectBusinessDriver",
									title: "所选车辆有多个营运司机，请选择事发司机",
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
				onOk : function(carMan) {
					$form.find(":input[name='e.chargerId']").val(carMan.id);
					$form.find(":input[name='e.chargerName']").val(carMan.name);
				}
			});
		});
		
		// 接案人
		$form.find("#selectReceiverName").click(function(){
			bc.identity.selectUser({
				history: false,
				selecteds: $form.find(":input[name='e.receiverName']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.receiverId']").val(user.id);
					$form.find(":input[name='e.receiverName']").val(user.name);
				}
			});
		})

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