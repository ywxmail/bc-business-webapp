if (!bc.business)
bc.business = {};
bc.business.blacklistForm = {
	init : function() {
		var $form = $(this);
		
		//需要组装的li
		var liTpl = '<li class="horizontal ui-state-highlight" data-id="{2}" data-classes="{1}"'+
		'style="position: relative;margin:0 2px;float: left;padding: 0;border-width: 0;">'+
		'<span class="text"><a href="#">{0}</a></span>'+
		'<span class="click2remove verticalMiddle ui-icon ui-icon-close" style="margin: -8px -2px;" title={3}></span></li>';
		var ulTpl = '<ul class="horizontal" style="padding: 0;"></ul>';
		var title = $form.find("#assignDrivers").attr("data-removeTitle");

		//选择锁定人
		$form.find(":input[name='e.locker.name']").click(function(){
			bc.identity.selectUser({
				history: false,
				selectdes:$form.find(":input[name='e.locker.id']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.locker.id']").val(user.id);
					$form.find(":input[name='e.locker.name']").val(user.name);
				}
			});
		});
		
		//选择解锁人
		$form.find(":input[name='e.unlocker.name']").click(function(){
			bc.identity.selectUser({
				history: false,
				selecteds: $form.find(":input[name='e.unlocker.id']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.unlocker.id']").val(user.id);
					$form.find(":input[name='e.unlocker.name']").val(user.name);
				}
			});
		});
		if($form.find(":input[name='isMoreCar']").val()=="true"){
			var carManId=$form.find(":input[name='carManId']").val();
			var url=bc.root +"/bc-business/selectMoreCarWithCarMan/selectCars?carManId="+carManId;
			var option = jQuery.extend({
				url: url,
				name: "选择车辆信息",
				mid: "selectCar",
				afterClose: function(car){
					if(car){
						$form.find(":input[name='e.car.id']").val(car.id);
						$form.find(":input[name='plate']").val(car.name);
						$form.find(":input[name='e.motorcade.id']").val(car.motorcadeId);
						$form.find(":input[name='e.car.motorcade.name']").val(car.motorcadeName);
					}
				}
			},option);
			bc.page.newWin(option);
		};
		if($form.find(":input[name='isNullCar']").val()=="true"){
			bc.msg.alert("该司机还没有驾驶任何车辆！不能创建黑名单！");
			//关闭表单
			$form.dialog("close");
		};
		if($form.find(":input[name='isMoreCarMan']").val()=="true"){
			var carId=$form.find(":input[name='carId']").val();
			var url=bc.root +"/bc-business/selectMoreCarManWithCar/selectCarMans";
			var option = jQuery.extend({
				url: url,
				name: "选择司机信息",
				data:{carId:carId,multiple:true},
				mid: "selectCarMan",
				afterClose: function(drivers){
					if(drivers){
						var $ul = $form.find("#assignDrivers ul");
						var $lis = $ul.find("li");
						var driversInfo="" ;
						$.each(drivers,function(i,driver){
								var classes = bc.business.blacklistForm.getClassesValue(driver.drivingStatus);
								if(!$ul.size()){//先创建ul元素
									$ul = $(ulTpl).appendTo($form.find("#assignDrivers"));
								}
								//组装并加入对应的值
								var $liObj = $(liTpl.format(driver.name,classes,driver.id,title)).appendTo($ul);
								//绑定查看事件
								$liObj.find("span.text").click(function(){
									bc.page.newWin({
										url: bc.root + "/bc-business/carMan/edit?id="+driver.id,
										name: "查看责任人信息",
										mid:  "viewDriver"+driver.id
									})
								});
								if(i>0){
									var tempStr = ";"+driver.name+","+classes+","+driver.id;
								}else{
									var tempStr = driver.name+","+classes+","+driver.id;
								}
								
								driversInfo += tempStr;
						});
						$form.find(":hidden[name='e.drivers']").val(driversInfo);
					}
				}
			},option);
			bc.page.newWin(option);
		};
		if($form.find(":input[name='isNullCarMan']").val()=="true"){
			bc.msg.alert("该车辆还没有被任何司机驾驶！");	
			
		};
		//----------------------------------------
		/* 选择司机责任人*/
		
		$form.find("#addDrivers").click(function() {
			var $ul = $form.find("#assignDrivers ul");
			var $lis = $ul.find("li");

			bs.selectCarMan({
				status :'0,1',
				multiple : true,
				onOk : function(drivers) {
					var driversInfo = $form.find(":hidden[name='e.drivers']").val();
					//添加司机责任人
					$.each(drivers,function(i,driver){
						if($lis.filter("[data-id='" + driver.id + "']").size() > 0){//已存在
							logger.info("duplicate select: id=" + driver.id + ",name=" + driver.name);
						}else{//新添加的
							if(!$ul.size()){//先创建ul元素
								$ul = $(ulTpl).appendTo($form.find("#assignDrivers"));
							}
							if($form.find(":input[name='e.drivers']").val().length>0){//之前存在司机责任人的话先加逗号
								driversInfo = driversInfo+";";
							}

							//组装并加入对应的值
							var $liObj = $(liTpl.format(driver.name,driver.classes,driver.id,title)).appendTo($ul);
							//绑定查看事件
							$liObj.find("span.text").click(function(){
								bc.page.newWin({
									url: bc.root + "/bc-business/carMan/edit?id="+driver.id,
									name: "查看责任人信息",
									mid:  "viewDriver"+driver.id
								})
							});
							if(i>0){
								var tempStr = ";"+driver.name+","+driver.classes+","+driver.id;
							}else{
								var tempStr = driver.name+","+driver.classes+","+driver.id;
							}
							
							driversInfo += tempStr;
						}
					});
					$form.find(":hidden[name='e.drivers']").val(driversInfo);
				}
			});
		});
		
		//绑定查看责任人的按钮事件处理
		var $objs = $form.find('.horizontal').children('span.text');
		$.each($objs,function(i,obj){
			//绑定查看
			$(obj).click(function(){
				bc.page.newWin({
					url: bc.root + "/bc-business/carMan/edit?id="+$(obj).parent().attr('data-id'),
					name: "查看责任人信息",
					mid:  "viewDriver"+$(obj).parent().attr('data-id')
				})
			});
		});
		
//		//只读权限控制
//		if(readonly) return;
		
//		//绑定删除责任人的按钮事件处理
		$form.find("#assignDrivers").delegate("span.click2remove","click", function(e) {
			$(this).parent().remove();
			var driverInfo ="";
			$li=$form.find(".horizontal>.horizontal");
			//每删除一个重新组合
			if($li.length>0){
				for(var i=0;i<$li.length;i++){
					var id=$($li[i]).attr("data-id");
					var classes=$($li[i]).attr("data-classes");
					var name=$($li[i]).children().children().text();
					if(i>0){
						driverInfo +=";"+name+","+classes+","+id;
					}else{
						driverInfo =name+","+classes+","+id;
					}
				}
				$form.find(":hidden[name='e.drivers']").val(driverInfo);
			}
			//当无司机责任人时就清空
			if($li.length==0){
				$form.find(":hidden[name='e.drivers']").val("");
			}
		});
		
		//---------------------------------------
		//通过车辆id查询相关信息
		$form.find("#selectCar").click(function(){
			bs.selectCar({onOk: function(car){
				//清空司机字段
				$form.find("span.click2remove").parent().remove();
				$form.find(":hidden[name='e.drivers']").val("");
				logger.info("car=" + $.toJSON(car));
				bs.findInfoByCar({
					carId: car.id,
					multiple: true,
					success: function(info){
						logger.info("---"+$.toJSON(info));
						//----车辆超连接
						$form.find(".link").attr("data-cfg",info.car.id);
						$form.find(".link").text(info.car.plate);
						//---
						$form.find(":input[name='e.car.id']").val(info.car.id);
						$form.find(":input[name='e.company']").val(info.car.company);
						if(info.driver){
							if(info.driver.length>0){
							var drivers=info.driver;
							var $ul = $form.find("#assignDrivers ul");
							var $lis = $ul.find("li");
							var driversInfo="" ;
							$.each(drivers,function(i,driver){
									var classes = bc.business.blacklistForm.getClassesValue(driver.classes);
									if(!$ul.size()){//先创建ul元素
										$ul = $(ulTpl).appendTo($form.find("#assignDrivers"));
									}
									//组装并加入对应的值
									var $liObj = $(liTpl.format(driver.name,classes,driver.id,title)).appendTo($ul);
									//绑定查看事件
									$liObj.find("span.text").click(function(){
										bc.page.newWin({
											url: bc.root + "/bc-business/carMan/edit?id="+driver.id,
											name: "查看责任人信息",
											mid:  "viewDriver"+driver.id
										})
									});
									if(i>0){
										var tempStr = ";"+driver.name+","+classes+","+driver.id;
									}else{
										var tempStr = driver.name+","+classes+","+driver.id;
									}
									
									driversInfo += tempStr;
							});
							$form.find(":hidden[name='e.drivers']").val(driversInfo);
						}
					}
						$form.find(":input[name='e.motorcade.id']").val(info.motorcade.id);
						$form.find(":input[name='e.car.motorcade.name']").val(info.motorcade.name);
						//返回车辆信息
						$form.find(":input[name='e.car.id']").val(car.id);
						$form.find(":input[name='e.company']").val(car.company);
						$form.find(":input[name='e.motorcade.id']").val(car.motorcadeId);
						 var $select = $form.find(":input[name='e.motorcade.id']");
						 var selectEl = $select[0];
						if(bc.select.isExist(selectEl, car.motorcadeId)){
							$select.val(car.motorcadeId);
						}else{
							selectEl.options[selectEl.length] = new Option(car.motorcadeName, car.motorcadeId);
							selectEl.options[selectEl.length-1].selected = true;
						}

					}
				});
				
			}});
		});
		
	},
	//绑定锁定事件
	lcoker : function(){
		var $form = $(this);
		//表单验证
		if(!bc.validator.validate($form))
			return;
		bc.msg.confirm("是否锁定？",function(){
			//status=0为锁定状态
			$form.find(":input[name='e.status']").val("0");
			//调用标准的方法执行保存
			bc.page.save.call($form,{callback:function(){
				$form.dialog("close");
				//显示结案成功提示信息
				bc.msg.slide("锁定成功");
				
				//返回false，禁止默认的“保存成功”提示信息的显示
				return false;
			}});
		});
	},
	//绑定解锁事件
	unlcoker : function(){
		var $form = $(this);
		//表单验证
		if(!bc.validator.validate($form))
			return;
		//解锁原因必填验证
		if($form.find(":input[name='e.unlockReason']").val()==""){
			bc.msg.alert("请填写解锁信息");
			return;
		}
		bc.msg.confirm("请确定信息是否准确！一但执行解锁功能将无法进行修改，是否继续执行？",function(){
			//status=1为解锁状态
			$form.find(":input[name='e.status']").val("1");
			//调用标准的方法执行保存
			bc.page.save.call($form,{callback:function(){
				$form.dialog("close");
				//显示结案成功提示信息
				bc.msg.slide("解锁成功");
				//返回false，禁止默认的“保存成功”提示信息的显示
				return false;
			}});
		});
	},
	//获取班次中文值
	getClassesValue : function(classes){
		var classesValue ="";
		if(classes==1){
			classesValue="正班";
		}else if (classes==2){
			classesValue="副班";
		}else if(classes==3 || classes==4){
			classesValue="顶班";
		}else{
			classesValue="无";
		}
		return classesValue;
	}
};