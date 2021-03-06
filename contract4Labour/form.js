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
				status: '-1,0',
				success: function(info){
					var url = bc.root + "/bc-business/contract4Labour/isExistContract?driverId="+info.driver.id;
					var isSupply = $page.find(":hidden[name='isSupply']").val();//true为补录
					$.ajax({url: url,dataType:"json",success: function (json){
						if(json.isExistContract && isSupply == "false"){//非录取状态下检测司机是否存在合同
							bc.msg.alert("所选司机已配置了相应的劳动合同，不能重复配置，请您编辑原来的劳动合同！");
							//$page.find(":input[name='e.ext_str1']").val('');
							//$page.find(":input[name='carId']").val('');
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
				//----车辆超连接
				$page.find(".link.showCar").attr("data-cfg",car.id);
				$page.find(".link.showCar").text(car.plate);

				bs.findInfoByCar({
					carId: car.id,
					status: '-1,0',
					success: function(info){
						logger.info("info=" + $.toJSON(info));
						// 根据车辆ID查找关联的司机否存在劳动合同
						//车辆没有营运司机时也填写车辆的登记与合同性质
						$page.find(":input[name='registerDate']").val(car.registerDate);
						$page.find(":input[name='bsType']").val(car.bsType);

						if(info.driver){
							var url = bc.root + "/bc-business/contract4Labour/isExistContract?driverId="+info.driver.id;
							var isSupply = $page.find(":hidden[name='isSupply']").val();//true为补录
							
							$.ajax({url: url,dataType:"json",success: function (json){
								if(json.isExistContract && isSupply == "false"){//非录取状态下检测司机是否存在合同
									bc.msg.alert("所选司机已配置了相应的劳动合同，不能重复配置，请您编辑原来的劳动合同！");
									//$page.find(":input[name='e.ext_str1']").val('');
									//$page.find(":input[name='carId']").val('');
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
									//----司机超连接
									$page.find(".link.showCarMan").attr("data-cfg",info.driver.id);
									$page.find(".link.showCarMan").text(info.driver.name);

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
					//----司机超连接
					$page.find(".link.showCarMan").attr("data-cfg",carMan.id);
					$page.find(".link.showCarMan").text(carMan.name);

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
		
		//绑定使用区域小按钮事件
		$page.find("#selectArea").click(function() {
			bc.selectPlaceOrigin({
				types:'1,2,3',
				onOk: function(json){
					$page.find(":input[name='e.domicilePlace']").val(json.code+'.'+json.pname+json.name);
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
	//-----------------------------------------------劳动合同操作-----------
	
	
	/** 续约处理 */
	doRenew : function($form) {
		var $page = $(this);
		bc.contract4LabourForm.openNewWin("续约",4,$page);
	},
	
	/** 转车处理 */
	doChangeCar : function($form) {
		var $page = $(this);
		bc.contract4LabourForm.openNewWin("转车",3,$page);
	},
	
	
	
	/**
	 * 
	 * @param type 签约类型
	 * @param $page 表单上下文
	 * @param $opType 操作类型
	 */
	openNewWin : function (signType,opType,$page){
			//关闭当前窗口
			$page.dialog("close");
			// 让用户输入当前经济合同的实际结束日期
			bc.page.newWin({
				name: signType,
				mid: "stopContract4Labour",
				url: bc.root + "/bc/common/selectDate",
				data: {time:false,title:signType+":请输入当前劳动合同的实际结束日期"},
				afterClose: function(date){
					if(!date) return;
					var data = {contractId: $page.find(":input[name='e.id']").val(),
							driverId : $page.find(":input[name='driverId']").val(),
							signType : signType,
							opType : opType,
							stopDate : date,
							};
				// 重新打开可编辑表单
				bc.page.newWin({
					name: "对"+ $page.find(":input[name='e.ext_str1']").val()+"进行"+signType+"操作",
					mid: "contract4Labour" + $page.find(":input[name='e.id']").val(),
					url: bc.root + "/bc-business/contract4Labour/create",
					data: data,
					afterClose: function(status){
						if(status) bc.grid.reloadData($page);
					}
				});
					
				}
			});		
	},
	
	//-------------------------------------------------------------------
	
	
	
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
		//新建劳动合同入库.社保号加必填验证
		if($page.find(":input[name='e.status']").val() == -1){
			$page.find(":input[name='e.insurCode']").removeAttr("data-validate");
			$page.find(":input[name='e.joinDate']").removeAttr("data-validate");
		}
		
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
		bc.page.save.call(this,{callback: function(json){
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
		//新建劳动合同入库.社保号加必填验证
		if($form.find(":input[name='e.status']") != -1){
			$form.find(":input[name='e.insurCode']").attr("data-validate","required");
			$form.find(":input[name='e.joinDate']").attr("data-validate",'{"type":"date","required":true}');
		}
		//表单验证
		if(!bc.validator.validate($form))
			return;
		bc.msg.confirm("确定要入库吗？",function(){
			//status=0为正常状态
//			$form.find(":input[name='e.status']").val("0");
			//入库
			bc.contract4LabourForm.storage.call($form,function(success){
				if(success){
					bc.msg.slide("入库成功！");
					//记录已保存状态
					//刷新
					$form.data("data-status","saved");
					$form.dialog("close");
					
				}else{
					bc.msg.alert(this.msg);
				}
				return false;
			});
			});
	},
	/**
	 * 劳动合同入库
	 */
	storage : function (callback){
		var $form = $("form",this);
		var data = $form.serialize();
		var url = bc.root + "/bc-business/contract4Labour/warehousing";
		$.ajax({
			url: url,
			dataType:"json",
			data: data,
			success: function (json){

				// 默认的处理
				if(json.success){ //合同编号存在
					// 自定义回调函数
						return callback.call(json,true);
				}else{
					// 自定义回调函数
					if(typeof callback == "function"){
						return callback.call(json,false);
					}
				}
			}
		});
	},
	
	/** 从模板添加附件 */
	addAttachFromTemplate: function(){
		var $atm = $(this)
		var $page = $atm.closest(".bc-page");
		var id = $page.find(":input[name='e.id']").val();
		bc.addAttachFromTemplate($atm, id, bc.root + "/bc-business/contract4Labour/addAttachFromTemplate",{
			category: "营运系统/劳动合同附件",
			multiple: true
		});
	}
};