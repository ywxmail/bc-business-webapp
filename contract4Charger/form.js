if(!window['bs'])window['bs']={};
bc.contract4ChargerForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		/* 初始化多页签*/
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		/* 选择司机责任人*/
		//需要组装的li
		var liTpl = '<li class="horizontal ui-widget-content ui-corner-all ui-state-highlight" data-id="{0}">'+
		'<span class="text"><a href="#">{1}</a></span>'+
		'<span class="click2remove verticalMiddle ui-icon ui-icon-close" title={2}></span></li>';
		var ulTpl = '<ul class="horizontal"></ul>';
		var title = $form.find("#assignChargers").attr("data-removeTitle");
		
		$form.find("#addChargers").click(function() {
			var data = {};
			var $ul = $form.find("#assignChargers ul");
			var $lis = $ul.find("li");

			bs.selectCharger({
				status :'0,1',
				multiple : true,
				onOk : function(chargers) {
					//var chargers = [charger];
					//添加司机责任人
					$.each(chargers,function(i,charger){
						if($lis.filter("[data-id='" + charger.id + "']").size() > 0){//已存在
							logger.info("duplicate select: id=" + charger.id + ",name=" + charger.name);
						}else{//新添加的
							if(!$ul.size()){//先创建ul元素
								$ul = $(ulTpl).appendTo($form.find("#assignChargers"));
							}
							//组装并加入对应的值
							var $liObj = $(liTpl.format(charger.id,charger.name,title)).appendTo($ul);
							//绑定删除事件
							$liObj.find("span.click2remove").click(function(){
								$(this).parent().remove();
							});
							//绑定查看事件
							$liObj.find("span.text").click(function(){
								bc.page.newWin({
									url: bc.root + "/bc-business/carMan/edit?id="+charger.id,
									name: "查看责任人信息",
									mid:  "viewCharger"+charger.id
								})
							});
						}
					});
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
					mid:  "viewCharger"+$(obj).parent().attr('data-id')
				})
			});
		});
		
		//只读权限控制
		if(readonly) return;
		
		//绑定删除责任人的按钮事件处理
		$.each($objs,function(i,obj){
			//绑定删除
			$(obj).next().click(function(){
				$(this).parent().remove();
			});
		});
		
//		if($form.find(":input[name='isExistContract']").val()=="true"){
//			bc.msg.alert("所选车辆已配置了相应的经济合同，不能重复配置，请您编辑原来的经济合同！");
//		};
		
		/* 选择车辆车牌*/
		$form.find("#selectCarPlate").click(function() {
			var selecteds = $form.find(":input[name='carId']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.ext_str1']").val(car.plate);
					$form.find(":input[name='e.wordNo']").val(car.code); 
					$form.find(":input[name='carId']").val(car.id); 
					$form.find(":input[name='e.businessType']").val(car.bsType); 
					
					
//					var url = bc.root + "/bc-business/contract4Charger/isExistContract?carId="+car.id;
//					$.ajax({url: url,dataType:"json",success: function (json){
//						if(json.isExistContract){
//							bc.msg.alert("所选车辆已配置了相应的经济合同，不能重复配置，请您编辑原来的经济合同！");
//							$form.find(":input[name='e.ext_str1']").val('');
//							$form.find(":input[name='carId']").val('');
//						}else{
//							$form.find(":input[name='e.ext_str1']").val(car.plate);
//							$form.find(":input[name='carId']").val(car.id);
//						}
//					}});
				}
			});
		});
		
		/* 选择经办人*/
		$form.find("#selectTransactorName").click(function(){
			bc.identity.selectUser({
				history : false,
				selecteds: $form.find(":input[name='e.transactorId']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.transactorName']").val(user.name);
					$form.find(":input[name='e.transactorId']").val(user.id);
				}
			});
		});
		
		//日期控件设置日期范围
		//if($form.find(":input[name='e.id']").val().length <= 0){ //只能在新建时可以选择开始日期和结束日期
			var dates = $form.find(':input[name^="e.startDate"], :input[name^="e.endDate"]').datepicker({
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
					dates.not( this ).datepicker( "option", option, date );
				}
			});
		//}
		
		//绑定失去焦点自编号唯一性检测
		var $code = $form.find(":input[name='e.code']");
		$code.bind("blur",function(){
			var code = $code.val();
			if(!code || code.length == 0)
				return false;
			
			bc.contract4ChargerForm.checkCode($form.find(":input[name='e.id']").val(),$code,null);
		});
		
	},
	
	/** 编号的格式验证:上下文为validate对象,格式为CLHT+[yyyy]+[MM]+[两位流水号] */
	validateCode: function(element, $form){
		return /^CLHT\d{8}$/.test(element.value);
	},
	
	/**
	 * 绑定失去焦点自编号唯一性检测
	 */
	checkCode : function (excludeId,$code,callback){
		var url = bc.root + "/bc-business/contract4Charger/checkCodeIsExist";
		$.ajax({
			url: url,
			dataType:"json",
			data: {code : $code.val(),excludeId: excludeId},
			success: function (json){
				// 自定义回调函数
				if(typeof callback == "function"){
					return callback.call(this,json);
				}
				
				// 默认的处理
				if(json.isExist == "true"){ //合同编号存在
					//组装提示查看信息
					var tempAry = json.msg.split(" ");
					var str = tempAry[2];
					str = "<a id='chakan' href=#>"+str+"</a>";
					str = tempAry[0]+" "+tempAry[1]+" "+str+" "+tempAry[3];
					var $a = bc.msg.alert(str);
					$a.find('#chakan').click(function(){
						bc.page.newWin({
							url: bc.root + "/bc-business/contract4Charger/open?id="+json.id,
							name: "查看经济合同",
							mid:  "contract4Charger." + json.id,
							afterClose: function(){
								$code.focus();
							}
						})
						$a.dialog("close");
					});
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
				name: "维护" + $page.find(":input[name='e.ext_str1']").val() + "的经济合同",
				mid: "contract4Charger" + $page.find(":input[name='e.id']").val(),
				url: bc.root + "/bc-business/contract4Charger/edit",
				data: {id: $page.find(":input[name='e.id']").val()},
				afterClose: function(status){
					if(status) bc.grid.reloadData($page);
				}
			});
		});		
	},
	
	/** 续约处理 */
	doRenew : function($form) {
		var $page = $(this);
		bc.contract4ChargerForm.openNewWin("确定对此合同续约操作？","续约",4,$page);
	},
	
	/** 过户处理 */
	doChangeCharger : function($form) {
		var $page = $(this);
		bc.contract4ChargerForm.openNewWin("确定对此合同过户操作？","过户",6,$page);
	},
	
	
	/** 重发包处理 */
	doChangeCharger2 : function($form) {
		var $page = $(this);
		bc.contract4ChargerForm.openNewWin("确定对此合同重发包操作？","重发包",7,$page);
	},
	
	/**
	 * @param tips 提示信息
	 * @param type 签约类型
	 * @param $page 表单上下文
	 */
	openNewWin : function (tips,signType,opType,$page){
		//var $page = $(this);
		// 关闭当前窗口
	//	bc.msg.confirm(tips,function(){
			$page.dialog("close");
			//---

			// 让用户输入当前经济合同的实际结束日期
			bc.page.newWin({
				name: signType,
				mid: "stopContract4Charger",
				url: bc.root + "/bc/common/selectDate",
				data: {time:false,title:signType+":请输入当前经济合同的实际结束日期"},
				afterClose: function(date){
					if(!date) return;
					var data = {id: $page.find(":input[name='e.id']").val(),
							signType : signType,
							opType : opType,
							stopDate : date
							};
				// 重新打开可编辑表单
				bc.page.newWin({
					name: signType + $page.find(":input[name='e.ext_str1']").val() + "的经济合同",
					mid: "contract4Charger" + $page.find(":input[name='e.id']").val(),
					url: bc.root + "/bc-business/contract4ChargerOperate2/create",
					data: data,
					afterClose: function(status){
						if(status) bc.grid.reloadData($page);
					}
				});
					
				}
			});		
			//----
//		});
	},
	
	/** 注销处理 */
	doLogout : function($form) {
		var $page = $(this);
		// 让用户输入新的经济合同的实际结束日期
		bc.page.newWin({
			name: "注销经济合同",
			mid: "logoutContract4Charger",
			url: bc.root + "/bc/common/selectDate",
			data: {time:false,title:"请输入经济合同的实际结束日期"},
			afterClose: function(date){
				logger.info("status=" + $.toJSON(status));
				if(!date) return;
				
				//执行注销处理
				bc.ajax({
					url: bc.root + "/bc-business/contract4ChargerOperate/doLogout",
					dataType: "json",
					data: {id: $page.find(":input[name='e.id']").val(),stopDate: date},
					success: function(json){
						logger.info("doLogout result=" + $.toJSON(json));
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
	
	//保存的处理
	save:function(){
		$page = $(this);
		
//		var $code = $page.find(":input[name='e.code']");
//		var id = $page.find(":input[name='e.id']").val();
//		
//		if(id.length > 0){//新建id不为空做code格式检测
//			if($code.val().length > 0 && 
//			$code.val().toUpperCase().indexOf("C",0) != 0){//code不为空,并且满足代码验证
//				$code.removeAttr('data-validate');
//			}else if($code.val().length == 0 || $code.val().toUpperCase().indexOf("C",0) == 0){
//				$code.attr('data-validate','{"required":true,"method":"bc.contract4ChargerForm.validateCode",'+
//				'"msg":"请输入正确的经济合同编号格式：<br/>CLHT+[4位年份]+[2位月份]+[2位流水号]"}');
//			}
//		}
		
		//先将角色的id合并到隐藏域
		var ids=[];
		var names=[];
		$page.find("#assignChargers li").each(function(){
			ids.push($(this).attr("data-id"));
			names.push($(this).find(".text").text());
		});
		if(names != null && names.length > 0){
			$page.find(":input[name=assignChargerIds]").val(ids.join(","));
			$page.find(":input[name=assignChargerNames]").val(names.join(","));
		}else{
			bc.msg.alert("最少选择一个责任人！");
			return false;
		}
		
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
		$page = $(this);
		
//		var $code = $page.find(":input[name='e.code']");
//		var id = $page.find(":input[name='e.id']").val();
//		
//		if(id.length > 0){//新建id不为空做code格式检测
//			if($code.val().length > 0 && 
//			$code.val().toUpperCase().indexOf("C",0) != 0){//code不为空,并且满足代码验证
//				$code.removeAttr('data-validate');
//			}else if($code.val().length == 0 || $code.val().toUpperCase().indexOf("C",0) == 0){
//				$code.attr('data-validate','{"required":true,"method":"bc.contract4ChargerForm.validateCode",'+
//				'"msg":"请输入正确的经济合同编号格式：<br/>CLHT+[4位年份]+[2位月份]+[2位流水号]"}');
//			}
//		}
		
		//先将角色的id合并到隐藏域
		var ids=[];
		var names=[];
		$page.find("#assignChargers li").each(function(){
			ids.push($(this).attr("data-id"));
			names.push($(this).find(".text").text());
		});
		if(names != null && names.length > 0){
			$page.find(":input[name=assignChargerIds]").val(ids.join(","));
			$page.find(":input[name=assignChargerNames]").val(names.join(","));
		}else{
			bc.msg.alert("最少选择一个责任人！");
			return false;
		}
		
		//唯一性检测
		var option = { callback : function (json){
				if(json.success){
					bc.msg.slide(json.msg);
					$page.dialog("close");
				}else{
					bc.msg.alert(json.msg);
				}
				return false;
			}
		};
		
		//调用标准的方法执行保存
		bc.page.save.call(this,option);
	}
	

/**		
		// 选择司机责任人
		//需要组装的li
		var liTpl = '<li class="horizontal ui-widget-content ui-corner-all ui-state-highlight" data-id="{0}">'+
		'<span class="text">{1}</span>'+
		'<span class="click2remove verticalMiddle ui-icon ui-icon-close" title={2}></span></li>';
		var ulTpl = '<ul class="horizontal"></ul>';
		var title = $form.find("#assignChargers").attr("data-removeTitle");
		
		$form.find("#addChargers").click(function() {
			var $ul = $form.find("#assignChargers ul");
			var $lis = $ul.find("li");

			bs.selectCharger({
				multiple : true,
				onOk : function(chargers) {
					//onOk : function(charger) {  未修改选择司机责任人方法的时候chargers传进来是单个对象所以要转成数组遍历
					//var chargers = [charger];
					if(chargers.length > 2){
						bc.msg.slide("最多只能选择两个,请筛选!");
					}else if(chargers.length == 2){
						$ul.empty();
						$.each(chargers,function(i,charger){
							var index = i+1;
							var cid	 = "e.changerId"+index;
							var cname = "e.changerName"+index;
							//组装并加入对应的值
							var $liObj = $(liTpl.format(charger.id,charger.name,title)).appendTo($ul);
							
							bc.contractChargerForm.setup($form,$liObj,cid,cname);
							
							$form.find(":input[name='"+cid+"']").val(charger.id);
							$form.find(":input[name='"+cname+"']").val(charger.name);
							
							if(i == 1)
								return false;
						});
					}else if(chargers.length == 1){
						var $lis = $ul.children();
						var index;
						var cid,cname;
						if($lis.size() <= 1){
							//加一个
							index = $lis.size() ==0 ? 1 :2;
							cid	 = "e.changerId"+index;
							cname = "e.changerName"+index;
						}else{
							//删除最后那个
							index = 2;
							cid	 = "e.changerId"+index;
							cname = "e.changerName"+index;
							$($lis[1]).remove();
							$form.find(":input[name='"+cid+"']").val("");
							$form.find(":input[name='"+cname+"']").val("");
						}
						
						//加上去
						var charger = chargers[0];
						var $liObj = $(liTpl.format(charger.id,charger.name,title)).appendTo($ul);
						
						bc.contractChargerForm.setup($form,$liObj,cid,cname);
						
						$form.find(":input[name='"+cid+"']").val(charger.id);
						$form.find(":input[name='"+cname+"']").val(charger.name);
					}
						
				}
			});
		});
		
		//绑定查看,删除责任人的按钮事件处理
		var $objs = $form.find('.horizontal').children('span.text');
		$.each($objs,function(i,obj){
			//绑定查看
			$(obj).click(function(){
				bc.page.newWin({
					url: bc.root + "/bc-business/carMan/edit?id="+$(obj).parent().attr('data-id'),
					name: "查看责任人信息",
					mid:  "viewCharger"
				})
			});
			
			//绑定删除
			$(obj).next().click(function(){
				var id = $(this).parent().attr('data-id');
				$form.find(":input[value='"+id+"']").next().val("");
				$form.find(":input[value='"+id+"']").val("");
				$(this).parent().remove();
			});
		});
		
		//绑定删除责任人的按钮事件处理
		//$form.find("span.click2remove").click(function(){
		//	$(this).parent().remove();
		//});
		
	},
	//保存的处理
	save : function(){
		$page = $(this);
		if(($page.find(":input[name='e.changerId1']").val().length > 0 &&
			$page.find(":input[name='e.changerId1']").val().length != null) ||
			($page.find(":input[name='e.changerId2']").val().length > 0 &&
			$page.find(":input[name='e.changerId2']").val().length != null)
			){
			//调用标准的方法执行保存
			bc.page.save.call(this);
		}else{
			bc.msg.slide("最少选择一个责任人！");
		}
	},
	
	setup : function(page,obj,cid,cname){
		var $form  = page;
		var $liObj = obj;
		//绑定删除事件
		$liObj.find("span.click2remove").click(function(){
			$form.find(":input[name='"+cid+"']").val("");
			$form.find(":input[name='"+cname+"']").val("");
			$(this).parent().remove();
		});
		//绑定查看事件
		$liObj.find("span.text").click(function(){
			bc.page.newWin({
				url: bc.root + "/bc-business/carMan/edit?id="+charger.id,
				name: "查看责任人信息",
				mid:  "viewCharger"
			})
		});
	}
**/
};