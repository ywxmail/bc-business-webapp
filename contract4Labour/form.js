if(!window['bs'])window['bs']={};
bc.contract4LabourForm = {
	init : function(option,readonly) {
		var $page = $(this);
		
		/* 初始化多页签*/
		$page.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		//只读状态就不需要执行其它初始化，直接返回
		if(readonly) return;
		
		if($page.find(":input[name='isExistContract']").val()=="true"){
			bc.msg.alert("所选司机已配置了相应的劳动合同，不能重复配置，请您编辑原来的劳动合同！");
		};
		
		//预加载一个司机关联多台车的对话框选择
		if($page.find(":input[name='isMoreCar']").val()=="true"){
			var driverId=$page.find(":input[name='driverId']").val();
			var url= bc.root +"/bc-business/selectMoreCarWithCarMan/selectCars?carManId="+driverId;
			var optionCar = {
				url: url,
				name: "选择车辆信息",
				mid: "selectCar",
				afterClose: function(car){
					if(car != null){
						$page.find(":input[name='carId']").val(car.id);
						$page.find(":input[name='e.ext_str1']").val(car.name);
					}
				}
			};
			bc.page.newWin(optionCar);
		};
		if($page.find(":input[name='isNullCar']").val()=="true"){
			bc.msg.alert("此司机没有驾驶任何车辆！");	
		};
		
		//预加载一台车关联多个司机的对话框选择
		if($page.find(":input[name='isMoreCarMan']").val()=="true"){
			
			var carId=$page.find(":input[name='carId']").val();
			bs.findInfoByCar({
				carId: carId,
				success: function(info){
					var url = bc.root + "/bc-business/contract4Labour/isExistContract?driverId="+info.driver.id;
					var isSupply = $page.find(":hidden[name='isSupply']").val();//true为补录
					$.ajax({url: url,dataType:"json",success: function (json){
						if(json.isExistContract && isSupply == "false"){//非录取状态下检测司机是否存在合同
							bc.msg.alert("所选司机已配置了相应的劳动合同，不能重复配置，请您编辑原来的劳动合同！");
							$page.find(":input[name='e.ext_str1']").val('');
							$page.find(":input[name='carId']").val('');
							$page.find(":input[name='registerDate']").val('');
							$page.find(":input[name='bsType']").val('');
							$page.find(":input[name='driverId']").val('');
							$page.find(":input[name='e.ext_str2']").val('');
							$page.find(":input[name='certNo']").val('');
							$page.find(":input[name='certIdentity']").val('');
							//$page.find(":input[name='e.age']").val('');
							$page.find(":input[name='birthDate']").val('');
							$page.find(":input[name='e.houseType']").val('');
							$page.find(":input[name='origin']").val('');
						}else{
							$page.find(":input[name='driverId']").val(info.driver.id);
							$page.find(":input[name='e.ext_str2']").val(info.driver.name);
							$page.find(":input[name='certNo']").val(info.driver.cert4FWZG);
							$page.find(":input[name='certIdentity']").val(info.driver.cert4IDENTITY);
							//$page.find(":input[name='e.age']").val(info.driver.age);
							$page.find(":input[name='birthDate']").val(info.driver.birthDate);
							$page.find(":input[name='e.houseType']").val(info.driver.houseType);
							$page.find(":input[name='origin']").val(info.driver.origin);
							if(info.driver.sex == 2){
								$page.find(":radio[name='e.sex']")[1].checked = true;
							}
						}
					}});
				}
			});
		};
		if($page.find(":input[name='isNullCarMan']").val()=="true"){
			bc.msg.alert("此车辆没有被任何司机驾驶！");	
		};
		
		// 选择车辆车牌
		$page.find("#selectCarPlate").click(function(){
			bs.selectCar({
				status :'-1,0,1',
				onOk: function(car){
				//填写车辆信息
				$page.find(":input[name='carId']").val(car.id);
				$page.find(":input[name='e.ext_str1']").val(car.plate);
				bs.findInfoByCar({
					carId: car.id,
					success: function(info){
						logger.info("info=" + $.toJSON(info));
						// 根据车辆ID查找关联的司机否存在劳动合同
						if(info.driver){
							var url = bc.root + "/bc-business/contract4Labour/isExistContract?driverId="+info.driver.id;
							var isSupply = $page.find(":hidden[name='isSupply']").val();//true为补录
							
							$.ajax({url: url,dataType:"json",success: function (json){
								if(json.isExistContract && isSupply == "false"){//非录取状态下检测司机是否存在合同
									bc.msg.alert("所选司机已配置了相应的劳动合同，不能重复配置，请您编辑原来的劳动合同！");
									$page.find(":input[name='e.ext_str1']").val('');
									$page.find(":input[name='carId']").val('');
									$page.find(":input[name='registerDate']").val('');
									$page.find(":input[name='e.bsType']").val('');
									$page.find(":input[name='driverId']").val('');
									$page.find(":input[name='e.ext_str2']").val('');
									$page.find(":input[name='certNo']").val('');
									$page.find(":input[name='certIdentity']").val('');
									//$page.find(":input[name='e.age']").val('');
									$page.find(":input[name='birthDate']").val('');
									$page.find(":input[name='e.houseType']").val('');
									$page.find(":input[name='origin']").val('');
								}else{//填写司机信息
									$page.find(":input[name='e.ext_str2']").val(info.driver.name);
									$page.find(":input[name='registerDate']").val(info.car.registerDate);
									$page.find(":input[name='bsType']").val(info.car.bsType);
									$page.find(":input[name='driverId']").val(info.driver.id);
									$page.find(":input[name='certNo']").val(info.driver.cert4FWZG);
									$page.find(":input[name='certIdentity']").val(info.driver.cert4IDENTITY);
									//$page.find(":input[name='e.age']").val(info.driver.age);
									$page.find(":input[name='birthDate']").val(info.driver.birthDate);
									$page.find(":input[name='e.houseType']").val(info.driver.houseType);
									$page.find(":input[name='origin']").val(info.driver.origin);
									if(info.driver.sex == 2){
										$page.find(":radio[name='e.sex']")[1].checked = true;
									}
								}
							}});
						}
					}
				});
			}});
		});
		
		// 选择司机
		$page.find("#selectDriverName").click(function() {
			var selecteds = $page.find(":input[name='driverId']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				status :'-1,0,1',
				onOk : function(carMan) {
					$page.find(":input[name='e.ext_str2']").val(carMan.name);
					$page.find(":input[name='driverId']").val(carMan.id);
					
					var url = bc.root + "/bc-business/contract4Labour/certInfo?driverId="+carMan.id;
					$.ajax({ url: url,dataType:"json", success: update_page});
					function update_page(json){
						if(json.sex == 2){
							$page.find(":radio[name='e.sex']")[1].checked = true;
						}
						$page.find(":input[name='certNo']").val(json.cert_fwzg);
						$page.find(":input[name='certIdentity']").val(json.certIdentity);
						$page.find(":input[name='birthDate']").val(json.birthDate);
						$page.find(":input[name='e.houseType']").val(json.house_type);
						$page.find(":input[name='origin']").val(json.origin);
					}
					
				}
			});
		});
		
		//签约期限日期控件设置日期范围
		var startDates = $page.find(':input[name^="e.startDate"], :input[name^="e.endDate"]').datepicker({
			changeYear : true,
			firstDay : 7,
			dateFormat : "yy-mm-dd",// yy4位年份、MM-大写的月份
			onSelect: function( selectedDate ) {
				var option = this.name == "e.startDate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				startDates.not( this ).datepicker( "option", option, date );
			}
		});

		///申领期限日期控件设置日期范围
		var getDates = $page.find(':input[name^="e.getStartDate"], :input[name^="e.getEndDate"]').datepicker({
			changeYear : true,
			firstDay : 7,
			dateFormat : "yy-mm-dd",// yy4位年份、MM-大写的月份
			onSelect: function( selectedDate ) {
				var option = this.name == "e.getStartDate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				getDates.not( this ).datepicker( "option", option, date );
			}
		});
	
		//绑定点击查询社保号唯一性检测
		$page.find("#selectInsurCode").bind("click",function(){
			var $insurCode = $page.find(":input[name='e.insurCode']");
			var insurCode = $insurCode.val();
			if(!insurCode || insurCode.length == 0)
				return false;
			bc.contract4LabourForm.checkCode($page.find(":input[name='e.id']").val(),$insurCode,null);
		});
	},
	
	/**
	 * 查询社保号唯一性检测
	 */
	checkCode : function (excludeId,$insurCode,callback){
		var url = bc.root + "/bc-business/contract4Labour/checkInsurCodeIsExist";
		$.ajax({
			url: url,
			dataType:"json",
			data: {insurCode : $insurCode.val(),excludeId: excludeId},
			success: function (json){
				// 自定义回调函数
				if(typeof callback == "function"){
					return callback.call(this,json);
				}
				
				// 默认的处理
				if(json.isExist == "true"){ //社保编号存在
					//组装提示查看信息
					var tempAry = json.msg.split(" ");
					var str = tempAry[2];
					str = "<a id='chakan' href=#>"+str+"</a>";
					str = tempAry[0]+" "+tempAry[1]+" "+str+" "+tempAry[3];
					var $a = bc.msg.alert(str);
					$a.find('#chakan').click(function(){
						bc.page.newWin({
							url: bc.root + "/bc-business/carMan/edit?id="+json.carManId,
							name: "查看司机信息",
							mid:  "contract4Charger." + json.carManId
//							afterClose: function(){
//								$$insurCode.focus();
//							}
						})
						$a.dialog("close");
					});
				}else{
					bc.msg.slide("此社保编号没有被占用,可以使用!");
				}
			}
		});
	},

	
	/**
	 * 操作按钮的回调函数
	 * 
	 */
	selectMenuButtonItem : function(option) {
		logger.info("selectMenuButtonItem:option=" + $.toJSON(option));
		// option.value的值参考 Contract.OPTYPE_XXX 常数的定义
		if(option.value == "4"){//续约 renew
			bc.contract4LabourForm.doRenew($(this));
		}else if(option.value == "5"){//离职 resign
			bc.contract4LabourForm.doResign($(this));
		}else if(option.value == "3"){//转车 transfer
			bc.contract4LabourForm.doChangeCar($(this));
		}else if(option.value == "2"){//维护 maintenance
			bc.contract4LabourForm.doMaintenance($(this));
		}
	},
	
	/** 维护处理 */
	doMaintenance : function($form) {
		var $page = $(this);
		// 关闭当前窗口
		bc.msg.confirm("确定维护此合同？",function(){
			$page.dialog("close");
			// 重新打开可编辑表单
			bc.page.newWin({
				name: "维护" + $page.find(":input[name='e.ext_str2']").val() + "的劳动合同",
				mid: "contract4Labour" + $page.find(":input[name='e.id']").val(),
				url: bc.root + "/bc-business/contract4Labour/edit",
				data: {id: $page.find(":input[name='e.id']").val(),isDoMaintenance: true},
				afterClose: function(status){
					if(status) bc.grid.reloadData($page);
				}
			});
		});
		
	},
	
	/** 续约处理 */
	doRenew : function($form) {
		var $page = $(this);
		// 让用户输入新的合同期限
		bc.page.newWin({
			name:"劳动合同续约",
			mid: "renewContract4Labour",
			url: bc.root + "/bc/common/selectDateRange",
			data: {addDay:1,startDate: $page.find(":input[name='e.endDate']").val(),title:"请输入新的续约期限"},
			afterClose: function(status){
				logger.info("status=" + $.toJSON(status));
				if(!status) return;
				
				//执行续签处理
				bc.ajax({
					url: bc.root + "/bc-business/contract4LabourOperate/doRenew",
					dataType: "json",
					data: {newStartDate: status.startDate,newEndDate: status.endDate,id: $page.find(":input[name='e.id']").val()},
					success: function(json){
						logger.info("doRenew result=" + $.toJSON(json));
						//完成后提示用户
						//bc.msg.info(json.msg);
						var str = json.msg.split(" ")[2];
						str = "<a id='chakan' href=#>"+str+"</a>";
						str = json.msg.split(" ")[0]+" "+json.msg.split(" ")[1]+" "+str+" "+json.msg.split(" ")[3];
						var $a = bc.msg.alert(str);
						$a.find('#chakan').click(function(){
							bc.page.newWin({
								url: bc.root + "/bc-business/contract4Labour/open?id="+json.id,
								name: "查看劳动合同",
								mid:  "viewcontract4Labour",
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
	
	/** 离职处理 */
	doResign : function($page) {
		var $page = $(this);
		// 让用户输入离职日期，默认为当前时间
		bc.page.newWin({
			name:"劳动合同离职处理",
			mid: "resignContract4Labour",
			url: bc.root + "/bc-business/selectTwoDate/select",
			data: {title:"离职操作"},
			afterClose: function(status){
				logger.info("status=" + $.toJSON(status));
				if(!status) return;
				
				//执行离职处理
				bc.ajax({
					url: bc.root + "/bc-business/contract4LabourOperate/doResign",
					dataType: "json",
					data: {resignDate: status.resignDate,
						     stopDate: status.stopDate,
						           id: $page.find(":input[name='e.id']").val()},
					success: function(json){
						logger.info("doResign result=" + $.toJSON(json));
						//完成后提示用户
						bc.msg.info(json.msg);
						$page.data("data-status","saved");
						$page.dialog("close");
						return false;
					}
				});
			}
		});
	},
	
	/** 转车处理 */
	doChangeCar : function($form) {
		var $page = $(this);
		// 让用户选择新的车辆
		bs.selectCar({
			title: "请为司机劳动合同选择新的车辆",
			onOk: function(car){
				// 不允许选择原来的车辆
				if(car.id == $page.find(":input[name='carId']").val()){
					bc.msg.alert("你所选择的车辆与原车辆相同，转车操作将被忽略！");
					return;
				}
				
				// 执行转车处理
				bc.ajax({
					url: bc.root + "/bc-business/contract4LabourOperate/doChangeCar",
					dataType: "json",
					data: {newCarId: car.id,newCarPlate: car.plate,id: $page.find(":input[name='e.id']").val()},
					success: function(json){
						logger.info("doChangeCar result=" + $.toJSON(json));
						//完成后提示用户
						//bc.msg.info(json.msg);
						var str = json.msg.split(" ")[2];
						str = "<a id='chakan' href=#>"+str+"</a>";
						str = json.msg.split(" ")[0]+" "+json.msg.split(" ")[1]+" "+str+" "+json.msg.split(" ")[3];
						var $a = bc.msg.alert(str);
						$a.find('#chakan').click(function(){
							bc.page.newWin({
								url: bc.root + "/bc-business/contract4Labour/open?id="+json.id,
								name: "查看劳动合同",
								mid:  "viewcontract4Labour",
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
	
	//保存的处理
	save:function(){
		$page = $(this);
		//唯一性检测
		var option = { callback : function (json){
				if(json.success){
					bc.msg.slide(json.msg);
				}else{
					bc.msg.alert(json.msg);
				}
				return false;
			}
		};
		//调用标准的方法执行保存
		bc.page.save.call(this,option);
	},	
	//保存并关闭
	saveAndClose:function(){
		var $form = $(this);
		//唯一性检测
		var option = { callback : function (json){
				if(json.success){
					bc.msg.slide(json.msg);
				}else{
					bc.msg.alert(json.msg);
				}
				return false;
			}
		};

		//调用标准的方法执行保存
		bc.page.save.call(this,option,{callback: function(json){
			if(json.success){
				bc.msg.slide(json.msg);
				$form.dialog("close");
			}else{
				bc.msg.alert(json.msg);
			}
			return false;
		}});
	},
	//入库
	warehousing:function(){
		
		var $form = $(this);
		
		//唯一性检测
		var option = { callback : function (json){
				if(json.success){
					bc.msg.slide(json.msg);
				}else{
					bc.msg.alert(json.msg);
				}
				return false;
			}
		};

		//status=0为正常状态
		$form.find(":input[name='e.status']").val("0");
		//调用标准的方法执行保存
		bc.page.save.call(this,option,{callback: function(json){
			if(json.success){
				bc.msg.slide("入库成功！");
				$form.dialog("close");
			}else{
				bc.msg.alert(json.msg);
			}
			return false;
		}});

	}
};