if(!window['bs'])window['bs']={};
bc.contract4LabourForm = {
	init : function(option,readonly,page) {
		var $form;
		if(page == null){
			$form = $(this);
		}else{
			$form = page;
		}
		/* 初始化多页签*/
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		if(readonly){
			$form.parent().find('#bcSaveBtn').hide();
			return;
		}else{
			$form.parent().find('#bcOpBtn').hide();
			$form.parent().find('#bcSaveBtn').show();
		}
		//if(readonly) return;
		//预加载一个司机关联多台车的对话框选择
		if($form.find(":input[name='isMoreCar']").val()=="true"){
			
			var carManId=$form.find(":input[name='carManId']").val();
			var url= bc.root +"/bc-business/selectMoreCarWithCarMan/selectCars?carManId="+carManId;
			var optionCar = {
				url: url,
				name: "选择车辆信息",
				mid: "selectCar",
				afterClose: function(car){
					if(car != null){
						$form.find(":input[name='carId']").val(car.id);
						$form.find(":input[name='e.ext_str1']").val(car.name);
					}
				}
			};
			bc.page.newWin(optionCar);
		};
		if($form.find(":input[name='isNullCar']").val()=="true"){
			bc.msg.slide("此司机没有驾驶任何车辆！");	
		};
		
		//预加载一台车关联多个司机的对话框选择
		if($form.find(":input[name='isMoreCarMan']").val()=="true"){
			
			var carId=$form.find(":input[name='carId']").val();
			bs.findInfoByCar({
				carId: carId,
				success: function(info){
					$form.find(":input[name='carManId']").val(info.driver.id);
					$form.find(":input[name='e.ext_str2']").val(info.driver.name);
					$form.find(":input[name='e.certNo']").val(info.driver.cert4FWZG);
					$form.find(":input[name='e.certIdentity']").val(info.driver.cert4IDENTITY);
					$form.find(":input[name='e.age']").val(info.driver.age);
					$form.find(":input[name='e.birthDate']").val(info.driver.birthDate);
					$form.find(":input[name='e.houseType']").val(info.driver.houseType);
					$form.find(":input[name='e.origin']").val(info.driver.origin);
					if(info.driver.sex == 2){
						$form.find(":radio[name='e.sex']")[1].checked = true;
					}
				}
			});
		};
		if($form.find(":input[name='isNullCarMan']").val()=="true"){
			bc.msg.slide("此车辆没有被任何司机驾驶！");	
		};
		
		// 选择车辆车牌
		$form.find("#selectCarPlate").click(function(){
			bs.selectCar({onOk: function(car){
				bs.findInfoByCar({
					carId: car.id,
					success: function(info){
						//TODO 根据车辆ID查找关联的司机否存在劳动合同
						var url = bc.root + "/bc-business/contract4Labour/isExistContract?carManId="+info.driver.id;
						$.ajax({ url: url,dataType:"json", success: tips});
						function tips (json){
							var num = 0;
							if(json.isExistContract == "true"){
								bc.msg.alert("此司机已存在劳动合同版本,请维护原有的劳动合同版本！");
								num = 1;
							}
							if(num == 0){
								$form.find(":input[name='e.ext_str1']").val(info.car.plate);
								$form.find(":input[name='carId']").val(info.car.id);
								$form.find(":input[name='e.registerDate']").val(info.car.registerDate);
								$form.find(":input[name='e.bsType']").val(info.car.bsType);
								$form.find(":input[name='carManId']").val(info.driver.id);
								$form.find(":input[name='e.ext_str2']").val(info.driver.name);
								$form.find(":input[name='e.certNo']").val(info.driver.cert4FWZG);
								$form.find(":input[name='e.certIdentity']").val(info.driver.cert4IDENTITY);
								$form.find(":input[name='e.age']").val(info.driver.age);
								$form.find(":input[name='e.birthDate']").val(info.driver.birthDate);
								$form.find(":input[name='e.houseType']").val(info.driver.houseType);
								$form.find(":input[name='e.origin']").val(info.driver.origin);
								if(info.driver.sex == 2){
									$form.find(":radio[name='e.sex']")[1].checked = true;
								}
							}
							if(num == 1){
								$form.find(":input[name='e.ext_str1']").val('');
								$form.find(":input[name='carId']").val('');
								$form.find(":input[name='e.registerDate']").val('');
								$form.find(":input[name='e.bsType']").val('');
								$form.find(":input[name='carManId']").val('');
								$form.find(":input[name='e.ext_str2']").val('');
								$form.find(":input[name='e.certNo']").val('');
								$form.find(":input[name='e.certIdentity']").val('');
								$form.find(":input[name='e.age']").val('');
								$form.find(":input[name='e.birthDate']").val('');
								$form.find(":input[name='e.houseType']").val('');
								$form.find(":input[name='e.origin']").val('');
							}
						}
	
					}
				});
			}});
		});
		
		// 选择司机
		$form.find("#selectDriverName").click(function() {
			var selecteds = $form.find(":input[name='carManId']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(carMan) {
					$form.find(":input[name='e.ext_str2']").val(carMan.name);
					$form.find(":input[name='carManId']").val(carMan.id);
					
					var url = bc.root + "/bc-business/contract4Labour/certInfo?carManId="+carMan.id;
					$.ajax({ url: url,dataType:"json", success: update_page});
					function update_page(json){

						if(json.cert_code != null){
							$form.find(":input[name='e.certNo']").val(json.cert_code);
						}else{
							$form.find(":input[name='e.certNo']").val("");
						}
					}
					
				}
			});
					
		});
		
		
		//选择经办人
		$form.find(":input[name='e.transactorName']").click(function(){
			bc.identity.selectUser({
				history : false,
				selecteds: $form.find("input[name='e.transactorId']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.transactorId']").val(user.id);
					$form.find(":input[name='e.transactorName']").val(user.name);
				}
			});
		});
		
		//签约期限日期控件设置日期范围
		var startDates = $form.find(':input[name^="e.startDate"], :input[name^="e.endDate"]').datepicker({
			changeYear:     true,
			firstDay: 		7,
			dateFormat:		"yy-mm-dd",//yy4位年份、MM-大写的月份
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
		var getDates = $form.find(':input[name^="e.getStartDate"], :input[name^="e.getEndDate"]').datepicker({
			changeYear:     true,
			firstDay: 		7,
			dateFormat:		"yy-mm-dd",//yy4位年份、MM-大写的月份
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
	doMaintenance : function($page) {
		// 关闭当前窗口
		$page.dialog("close");
		
		// 重新打开可编辑表单
		bc.page.newWin({
			name: "维护" + $page.find(":input[name='e.ext_str2']").val() + "的劳动合同",
			mid: "contract4Labour" + $page.find(":input[name='e.id']").val(),
			url: bc.root + "/bc-business/contract4Labour/edit",
			data: {id: $page.find(":input[name='e.id']").val()}
		});
	},
	
	/** 续签处理 */
	doRenew : function($page) {
		// 让用户输入新的合同期限
		bc.page.newWin({
			name:"劳动合同续约",
			mid: "renewContract4Labour",
			url: bc.root + "/bc/common/selectDateRange",
			data: {startDate: $page.find(":input[name='e.endDate']").val(),title:"请输入新的续约期限"},
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
						bc.msg.info(json.msg);
						$page.data("data-status","saved");
						$page.dialog("close");
					}
				});
			}
		});
	},
	
	/** 离职处理 */
	doResign : function($page) {
		// 让用户输入离职日期，默认为当前时间
		bc.page.newWin({
			name:"劳动合同离职处理",
			mid: "resignContract4Labour",
			url: bc.root + "/bc/common/selectDate",
			data: {title:"请输入司机的离职日期"},
			afterClose: function(status){
				logger.info("status=" + $.toJSON(status));
				if(!status) return;
				
				//执行离职处理
				bc.ajax({
					url: bc.root + "/bc-business/contract4LabourOperate/doResign",
					dataType: "json",
					data: {resignDate: status,id: $page.find(":input[name='e.id']").val()},
					success: function(json){
						logger.info("doResign result=" + $.toJSON(json));
						//完成后提示用户
						bc.msg.info(json.msg);
						$page.data("data-status","saved");
						$page.dialog("close");
					}
				});
			}
		});
	},
	
	/** 转车处理 */
	doChangeCar : function($page) {
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
					data: {newCarId: car.id,id: $page.find(":input[name='e.id']").val()},
					success: function(json){
						logger.info("doChangeCar result=" + $.toJSON(json));
						//完成后提示用户
						bc.msg.info(json.msg);
						$page.data("data-status","saved");
						$page.dialog("close");
					}
				});
			}
		});
	}
};