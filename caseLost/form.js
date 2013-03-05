if(!window['bs'])window['bs']={};
bc.caseLostForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		// 初始化多页签
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		//初始化点击隐藏按钮
		bc.caseLostForm.foldingDiv($form,"showGroups1","div1",false);
		bc.caseLostForm.foldingDiv($form,"showGroups2","div2",false);
		bc.caseLostForm.foldingDiv($form,"showGroups3","div3",false);
		bc.caseLostForm.foldingDiv($form,"showGroups4","div4",true);
		bc.caseLostForm.foldingDiv($form,"showGroups5","div5",false);
		//领取绑定事件
		bc.caseLostForm.foldingDiv($form,"tookId","div4",false);
		
		//只读权限控制
		if(readonly) return;
		

		
		if($form.find(":input[name='e.took']")[0].checked){
			$form.find('#div4').show();
		}
		
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
		
		//失物取向事件
		$form.find(":input[name='e.result']").change(function(){
			var $select = $(this);
			var name = $select.find("option:selected").val();
			if(name == 2){
				$form.find(":input[name='e.retrunDate']").val('');
			}
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

					//按照司机信息更新表单相应的域
					function updateFieldsFromDriver(driver){
						$form.find(":input[name='e.driverId']").val(driver.id);
						$form.find(":input[name='e.driverName']").val(driver.name);
						$form.find(":input[name='e.driverCert']").val(driver.cert4FWZG);
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
		
	},
	
	//绑定点击按钮内容展出事件
	foldingDiv : function (context,spanId,divId,flag){
		var $form = context;
		var flip = 0;
		if(flag){
			$form.find('#'+divId).hide();
		}
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
			bc.msg.alert('请确认司机,车辆,车队,经办人信息是否填写完整!!');
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
	
	//保存的处理
	save : function(){
		var $form = $(this);
		$form.find(":input[name='e.status']").val("0");
		$form.data("data-status","saved");
		//调用标准的方法执行保存
		bc.page.save.call($form);
	}
	
};