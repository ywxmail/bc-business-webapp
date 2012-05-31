if(!window['bs'])window['bs']={};
bc.contract4ChargerForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		/* 初始化多页签*/
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		bc.contract4ChargerForm.foldingDiv($form,"showGroups1","div1");
		/* 选择司机责任人*/
		//需要组装的li
		var liTpl = '<li class="horizontal ui-state-highlight" data-id="{0}" '+
		'style="position: relative;margin:0 2px;float: left;padding: 0;border-width: 0;">'+
		'<span class="text"><a href="#">{1}</a></span>'+
		'<span class="click2remove verticalMiddle ui-icon ui-icon-close" style="margin: -8px -2px;" title={2}></span></li>';
		var ulTpl = '<ul class="horizontal" style="padding: 0;overflow:hidden;"></ul>';
		var title = $form.find("#assignChargers").attr("data-removeTitle");
		var selectEl = $form.find(":input[name='e.quitterId']")[0];
		
		$form.find("#addChargers").click(function() {
			var data = {};
			var $ul = $form.find("#assignChargers ul");
			var $lis = $ul.find("li");

			bs.selectCharger({
				status :'-1,0,1',
				multiple : true,
				onOk : function(chargers) {
					var driversInfo = $form.find(":hidden[name='e.ext_str2']").val();
					//添加司机责任人
					$.each(chargers,function(i,charger){
						if($lis.filter("[data-id='" + charger.id + "']").size() > 0){//已存在
							logger.info("duplicate select: id=" + charger.id + ",name=" + charger.name);
						}else{//新添加的
							if(!$ul.size()){//先创建ul元素
								$ul = $(ulTpl).appendTo($form.find("#assignChargers"));
							}
							if($form.find(":input[name='e.ext_str2']").val().length>0){//之前存在司机责任人的话先加逗号
								//如果司机责任人最后一位存在“;”号就不用加";"
								if (driversInfo.substr(driversInfo.length-1,1) == ";") {
									driversInfo = driversInfo;
								}else{
									driversInfo = driversInfo+";";
								}
							}
							//组装并加入对应的值
							var $liObj = $(liTpl.format(charger.id,charger.name,title)).appendTo($ul);
							//绑定查看事件
							$liObj.find("span.text").click(function(){
								bc.page.newWin({
									url: bc.root + "/bc-business/carMan/edit?id="+charger.id,
									name: "查看责任人信息",
									mid:  "viewDriver"+charger.id
								})
							});
							var tempStr="";
							if(i>0){
								//如果司机责任人最后一位存在“;”号就不用加";"
								if (driversInfo.substr(driversInfo.length-1,1) == ";"){
									 tempStr =charger.name+","+charger.id;
								}else{
									 tempStr = ";"+charger.name+","+charger.id;
								}

							}else{
								tempStr = charger.name+","+charger.id;
							}
							driversInfo += tempStr;
						}
						
						//向提前终止方的下拉列表添加值
						selectEl.options[selectEl.length] = new Option(charger.name, charger.id);
					});
					$form.find(":hidden[name='e.ext_str2']").val(driversInfo);
				
				
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
		
		
//		//绑定删除责任人的按钮事件处理
		$form.find("#assignChargers").delegate("span.click2remove","click", function(e) {
			//获取要删除责任人的ID
			var delId=$(this).parent().attr("data-id");
			$(this).parent().remove();
			//删除提前终止方的责任人
			for(var j = 0; j < selectEl.length; j++){
				if(selectEl.options[j].value == delId){
					selectEl.options.remove(j);
				}
			}
			
			var driverInfo ="";
			$li=$form.find(".horizontal>.horizontal");
			//每删除一个重新组合
			if($li.length>0){
				for(var i=0;i<$li.length;i++){
					var id=$($li[i]).attr("data-id");
					var name=$($li[i]).children().children().text();
					if(i>0){
						driverInfo +=";"+name+","+id;
					}else{
						driverInfo =name+","+id;
					}

				}
				$form.find(":hidden[name='e.ext_str2']").val(driverInfo);
			}
			//当无司机责任人时就清空
			if($li.length==0){
				$form.find(":hidden[name='e.ext_str2']").val("");
			}
		});
		
		
		
		/* 选择车辆车牌*/
		$form.find("#selectCarPlate").click(function() {
			var selecteds = $form.find(":input[name='carId']").val();
			bs.selectCar({
				status :'-1,0,1',
				onOk : function(car) {
					//----车辆超连接
					$form.find(".link.showCar").attr("data-cfg",car.id);
					$form.find(".link.showCar").text(car.plate);

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
//		var $code = $form.find(":input[name='e.code']");
//		$code.bind("blur",function(){
//			var code = $code.val();
//			if(!code || code.length == 0)
//				return false;
//			
//			bc.contract4ChargerForm.checkCode($form.find(":input[name='e.id']").val(),$code,null);
//		});
		
	
	//收费明细
		
		var tableEl=$form.find("#feeDetailTables")[0];
		
		/**收费明细表格中插入input控件
		 * @option {string} name 单元格的name属性值
		 * @option {Object} value 单元格的json值
		 * @option {Boolean} readonly 单元格是否只读
		 * @option {Boolean} isFirst 单元格是列头
		 */
		function buildInput(name,value,readonly,isFirst){
			var s = '<input style="width:99%;height:100%;border:none;margin:0;padding:0 0 0 2px;';
			if(isFirst){
				s='<span class="ui-icon"></span><input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;'
				s += 'background:none;';
			}
			if(name=="coverage"){
				s += '" name="' + name + '" type="text" class="ui-widget-content" value="' + value + '"';
			}else{
				s += '" name="' + name + '" type="text" class="ui-widget-content" value="' + value + '"';
			}

			s += '" name="' + name + '" type="text" class="ui-widget-content" value="' + value + '"';
			if(readonly){
				s += ' readonly="' + readonly + '"';
			}
			s += '/>';
			return s;
		}
		// 选择收费项目
		$form.find("#selectFeeTemplate").click(function() {
			bs.selectFeeTemplate({
				module : '经济合同',
				multiple: true,
				onOk : function(selectFeeTemplate) {
					for(var i=0;i<selectFeeTemplate.length;i++){
						//如果项目为每月承包费的根据合同期限来生成相应的项目
						if(selectFeeTemplate[i].code=="contract4Charger.MYCBK"){
							//获取合同的开始日期和结束日期
							var startDate=$form.find(":input[name='e.startDate']").val();
							var endDate=$form.find(":input[name='e.endDate']").val();
							
							var sd =new Date();//开始日期
							var ed =new Date();//结束日期
							sd=$.datepicker.parseDate('yy-mm-dd', startDate);
							ed=$.datepicker.parseDate('yy-mm-dd', endDate);
							var priceDate=selectFeeTemplate[i].spec;//特殊设置的样式格式为[不足一月收取(6850),每年递减(500).]
							if(priceDate!=null){
							//不足一个月的金额
							var lackPrice=priceDate.key1;
							//每年递减的金额v
							var cutPrice=priceDate.key2;
							}
							//不足一个月的金额
							//如果为空，默认为6850
							if(lackPrice==null||lackPrice==""){
								lackPrice=6850;
							}
							//每年递减的金额
							//var cutPrice=spec.substring(spec.lastIndexOf("(")+1,spec.lastIndexOf(")"));
							
							//如果为空，默认为500
							if(cutPrice==null||cutPrice==""){
								cutPrice=500;
							}
							//每年应收的金额
							var mustPrice=selectFeeTemplate[i].price.replace(",","").substring(0,selectFeeTemplate[i].price.indexOf("."));
							//如果为空，默认为8850
							if(mustPrice==null){
								mustPrice=8850;
							}
							
							if(sd!=null){
								//第一条承包费项目期限为开始日期到本月的月底
								if(sd.getDate()!=1){
									sd.setMonth(sd.getMonth()+1);//将开始日期的月份加1
									sd.setDate(1);//将开始日期的月份加1后的日期的天数设置为1
									sd.setDate(sd.getDate()-1);//日期的天数设置为开始日期同一月份的最后一日
									bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],startDate,$.datepicker.formatDate('yy-mm-dd', sd),lackPrice,null);
									//将第一条承包费项目的结束日期设置为下一个月的第一日并增加一年时间 
									sd.setDate(sd.getDate()+1);
									sd.setMonth(sd.getMonth()+12);
									//如果开始日期比结束日期小,就循环生成每月承包费项目
									var md;
									while(sd<ed){
										var md=new Date(sd.getTime());
										md.setMonth(md.getMonth()-12);
										sd.setDate(sd.getDate()-1);
										//承包费项目期限满足一年的开始日期
										var mDate=$.datepicker.formatDate('yy-mm-dd', md);
										//承包费项目期限满足一年的结束日期
										var eDate=$.datepicker.formatDate('yy-mm-dd', sd);
										bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],mDate,eDate,mustPrice,null);
										//实收的金额每年递减
										mustPrice=mustPrice-cutPrice;
										sd.setDate(sd.getDate()+1);
										sd.setMonth(sd.getMonth()+12);
									}
									//最后一条承包费项目
									sd.setMonth(sd.getMonth()-12);
									var edStr=$.datepicker.formatDate('yy-mm-dd', ed);
									var sdStr=$.datepicker.formatDate('yy-mm-dd', sd);

									bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],sdStr,edStr,mustPrice,null);

									
								}else{
									//如果是1号开始的
									sd.setMonth(sd.getMonth()+12);
									var begDate=new Date(sd.getTime());
									//满一年期限的
									if(begDate<ed){
										logger.info("ed:"+ed);
										var md;
										while(sd<ed){
											var md=new Date(sd.getTime());
											md.setMonth(md.getMonth()-12);
											sd.setDate(sd.getDate()-1);
											//承包费项目期限满足一年的开始日期
											var mDate=$.datepicker.formatDate('yy-mm-dd', md);
											//承包费项目期限满足一年的结束日期
											var eDate=$.datepicker.formatDate('yy-mm-dd', sd);
											bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],mDate,eDate,mustPrice,null);
											//实收的金额每年递减
											mustPrice=mustPrice-cutPrice;
											sd.setDate(sd.getDate()+1);
											sd.setMonth(sd.getMonth()+12);
											logger.info("sd:"+sd);
										}
										//最后一条承包费项目
										sd.setMonth(sd.getMonth()-12);
										var edStr=$.datepicker.formatDate('yy-mm-dd', ed);
										var sdStr=$.datepicker.formatDate('yy-mm-dd', sd);

										bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],sdStr,edStr,mustPrice,null);
										
									}else{
										//不满一年的
										var edStr=$.datepicker.formatDate('yy-mm-dd', ed);
										var sdStr=$.datepicker.formatDate('yy-mm-dd', sd);

										bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],sdStr,edStr,mustPrice,null);
										
									}
									
								}
								
							}else{
								var price=selectFeeTemplate[i].price.replace(",","").substring(0,selectFeeTemplate[i].price.indexOf("."));
								bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],"","",price,null);
							}
							
							//其他选项
						}else{
							//如果责任人只有一个，其工资和个人所得税的数量为1
							//如果没有选择责任人，按正常情况初始化
							var chargers=$form.find(":hidden[name='e.ext_str2']").val();//责任人信息
							if((chargers)&&(selectFeeTemplate[i].code=="contract4Charger.GRSDS"||selectFeeTemplate[i].code=="contract4Charger.salary")){
								//如果是一个责任人，数量就为1
								if((chargers.split(',')).length-1==1){
									//设置数量为1
									var price=selectFeeTemplate[i].price.replace(",","").substring(0,selectFeeTemplate[i].price.indexOf("."));
									bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],"","",price,1);
								}else{
									var price=selectFeeTemplate[i].price.replace(",","").substring(0,selectFeeTemplate[i].price.indexOf("."));
									bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],"","",price,null);
								}
							}else{
								var price=selectFeeTemplate[i].price.replace(",","").substring(0,selectFeeTemplate[i].price.indexOf("."));
								bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],"","",price,null);
								
							}
						}
					}
				}
			});
		});
		//添加选中明细项目
		$form.find("#feeDetailTables").delegate("tr.ui-widget-content.row>td.id","click",function(){
			$(this).parent().toggleClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").toggleClass("ui-icon-check");
		});
		$form.find("#feeDetailTables").delegate("tr.ui-widget-content.row input","focus",function(){
			$(this).closest("tr.row").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
		});
		//全选
		$form.find("#feeDetailTables").delegate("tr.ui-state-default.row>td.first","click",function(){
			var spanClass=$form.find("#feeDetailTables > tbody > tr.ui-state-default.row>td.first >span").attr("class");
			if(spanClass=="ui-icon ui-icon-notice"){
				$form.find("#feeDetailTables > tbody > tr:gt(1)").addClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").addClass("ui-icon-check");
				$form.find("#feeDetailTables > tbody > tr.ui-state-default.row>td.first >span").addClass("ui-icon-check").removeClass("ui-icon-notice");
			}else{
				$form.find("#feeDetailTables > tbody > tr:gt(1)").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
				$form.find("#feeDetailTables > tbody > tr.ui-state-default.row>td.first >span").addClass("ui-icon-notice").removeClass("ui-icon-check");
			}
		});
		//删除表中选中的明细项目
		$form.find("#deleteFeeTemplate").click(function() {
			var $trs = $form.find("#feeDetailTables tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要删除的项目！");
				return;
			}
			bc.msg.confirm("确定要删除选定的 <b>"+$trs.length+"</b>个项目吗？",function(){
				for(var i=0;i<$trs.length;i++){
					$($trs[i]).remove();
				}
			});
			
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
					// 自定义回调函数
					if(typeof callback == "function"){
						return callback.call(this,false);
					}
				}else{
					// 自定义回调函数
					if(typeof callback == "function"){
						return callback.call(this,true);
					}
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
					var data = {contractId: $page.find(":input[name='e.id']").val(),
							signType : signType,
							opType : opType,
							stopDate : date
							};
				// 重新打开可编辑表单
				bc.page.newWin({
					name: signType + $page.find(":input[name='e.ext_str1']").val() + "的经济合同",
					mid: "contract4Charger" + $page.find(":input[name='e.id']").val(),
					url: bc.root + "/bc-business/contract4Charger/create",
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
		var $form = $(this);
		
		//表单验证
		if(!bc.validator.validate($form))
			return;

		//保存之前
		if(bc.contract4ChargerForm.beforeSave($form)==false)
			return;
		
		//调用标准的方法执行保存
		bc.page.save.call(this,{callback: function(json){
			if(json.success){
				bc.msg.slide(json.msg);
			}else{
				bc.msg.alert(json.msg);
			}
			return false;
		}});

	},
	//保存并关闭
	saveAndClose:function(){
		var $form = $(this);
		//表单验证
		if(!bc.validator.validate($form))
			return;
		//保存之前
		if(bc.contract4ChargerForm.beforeSave($form)==false)
			return;
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
		//绑定失去焦点自编号唯一性检测
		var $code = $form.find(":input[name='e.code']");
		bc.contract4ChargerForm.checkCode($form.find(":input[name='e.id']").val(),$code,function(sucess){
			//如果存在相同编号就返回
			if(!sucess){
				return;
			}else{
				//表单验证
				if(!bc.validator.validate($form))
					return;
				//保存之前
				if(!bc.contract4ChargerForm.beforeSave($form))
					return;
				bc.msg.confirm("确定要入库吗？",function(){
				//入库
				bc.contract4ChargerForm.storage.call($form,function(success){
					if(success){
						bc.msg.slide("入库成功！");
						//刷新
						$form.data("data-status","saved");
						$form.dialog("close");
					}else{
						bc.msg.alert(this.msg);
					}
					return false;
				});
				});	
			}
		});

	},
	//保存之前的操作
	beforeSave:function($page){
		
		//收费明细合并到隐藏域
		var feeDetails=[];
		//将收费明细表中的内容添加到buyPlants里
		$page.find("#feeDetailTables tr:gt(1)").each(function(){
			var $inputs = $(this).find("td>:input");
			var $divInput= $(this).find("td>div>input");
			var code=$(this).find("td.id.first").attr("data-code");
			logger.info("name:"+$inputs[0].value);
			logger.info("price:"+$inputs[1].value);
			logger.info("count:"+$inputs[2].value);
			logger.info("payType:"+$inputs[3].value);
			logger.info("startDate:"+$divInput[0].value);
			logger.info("endDate:"+$divInput[1].value);
			logger.info("description:"+$inputs[4].value);
			var json = {
				code:code,
				name: $inputs[0].value,
				price: $inputs[1].value,
				count: $inputs[2].value,
				payType: $inputs[3].value,
				startDate: $divInput[0].value,
				endDate: $divInput[1].value,
				description: $inputs[4].value
			};
			var id = $(this).attr("data-id");
			if(id && id.length > 0)
				json.id = id;
			feeDetails.push(json);
		});
		$page.find(":input[name='feeDetails']").val($.toJSON(feeDetails));
		//表单验证
		$feeDetailTables=$page.find("#feeDetailTables tr");
		
		if(!bc.validator.validate($feeDetailTables))
			return;

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
			return true;
		}else{
			bc.msg.alert("最少选择一个责任人！");
			return false;
		}
		

	},
	/**收费明细表格中插入input控件
	 * @option {string} name 单元格的name属性值
	 * @option {Object} value 单元格的json值
	 * @option {Boolean} readonly 单元格是否只读
	 * @option {Boolean} isFirst 单元格是列头
	 */

	 buildInput : function(name,value,readonly,isFirst){
		//正常
		var s = '<input style="width:99%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;';
		if(isFirst){
			s='<span class="ui-icon"></span><input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;'
			s += 'background:none;';
		}
		//金额的样式
		if(name=="price"){
			s += '" name="' + name + '" type="text" class="ui-widget-content" value="' +bc.formatNumber(value,'#,##0.##')+ '"';
		}else{
			s += '" name="' + name + '" type="text" class="ui-widget-content" value="' + value + '"';
		}
		
		
		//s += '" name="' + name + '" type="text" class="ui-widget-content" value="' + value + '"';
		if(readonly){
			s += ' readonly="' + readonly + '"';
		}
		s += '/>';
		return s;
	},
	
	/**收费明细表格中插入select控件
	 * @option {string} name 单元格的name属性值
	 * @option {Object} value 单元格的json值
	 *
	 */
buildSelect : function (value){
		var s='<select name="payType" id="edit_payType" class="ui-widget-content" data-validate="required" style="border:none;">';
		(value==''? s+='  <option value="" selected="selected"></option>':s+='  <option value="" ></option>');
		(value==1? s+='  <option value="1" selected="selected">每月</option>':s+='  <option value="1" >每月</option>');
		(value==2? s+='  <option value="2" selected="selected">每季</option>':s+='  <option value="2" >每季</option>');
		(value==3? s+='  <option value="3" selected="selected">每年</option>':s+='  <option value="3" >每年</option>');
		(value==4? s+='  <option value="4" selected="selected">一次性</option>':s+='  <option value="4" >一次性</option>');
		s+="</select>"
		return s;
	},
	
	
	/**添加收费明细行数据
	 * @option  tableEl 表格
	 * @option  selectFeeTemplate json对象
	 * @option  sDate开始日期
	 * @option  eDate 结束日期 
	 * @option  price 金额	
	 * @option  count 数量
	 *
	 */
	addFeeDetailData : function (tableEl,selectFeeTemplate,sDate,eDate,price,count){
		//插入行
		var newRow=tableEl.insertRow(tableEl.rows.length);
		newRow.setAttribute("class","ui-widget-content row");
		//插入列
		//插入列
		var cell=newRow.insertCell(0);
		cell.style.padding="0";
		cell.style.textAlign="left";
		cell.setAttribute("class","id first");
		cell.setAttribute("data-code",selectFeeTemplate.code)//编码
		cell.innerHTML='<span class="ui-icon"></span>';//空白头列

		
		var cell=newRow.insertCell(1);
		cell.style.padding="0";
		cell.style.textAlign="left";
		cell.style.width="130px"; 
		cell.setAttribute("class","middle");
		cell.innerHTML=bc.contract4ChargerForm.buildInput("name",selectFeeTemplate.name);//插入项目
		
		cell=newRow.insertCell(2);
		cell.style.padding="0";
		cell.style.textAlign="left";
		cell.setAttribute("class","middle");
		cell.style.width="105px"; 
		cell.innerHTML=bc.contract4ChargerForm.buildInput("price",price);//插入金额
		
		cell=newRow.insertCell(3);
		cell.style.padding="0";
		cell.style.textAlign="left";
		cell.setAttribute("class","middle");
		cell.style.width="50px"; 
		cell.innerHTML=bc.contract4ChargerForm.buildInput("count",(count!=null?count:selectFeeTemplate.count));//插入数量

		cell=newRow.insertCell(4);
		cell.style.padding="0";
		cell.style.textAlign="left";
		cell.setAttribute("class","middle");
		cell.style.width="85px"; 
		cell.innerHTML=bc.contract4ChargerForm.buildSelect(selectFeeTemplate.payType);//插入收费方式
		
		cell=newRow.insertCell(5);
		cell.style.padding="0";
		cell.style.textAlign="left";
		cell.style.borderRight="1px";
		cell.setAttribute("class","middle");
		cell.style.width="100px";
//		cell.innerHTML=bc.contract4ChargerForm.buildInput("startDate",sDate);//插入开始期限
		cell.innerHTML='<div class="relative">'
			+'	<input type="text" name="startDate" data-validate=\'{"type":"date","required":false}\' value="'+sDate+'"'
			+'  style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" class="bc-date ui-widget-content" >'
			+'	<ul class="inputIcons">'
			+'		<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>'
			+'	</ul>'
			+'</div>';//插入开始期限
		//绑定日期选择
		bc.form.initCalendarSelect($(cell));


		cell=newRow.insertCell(6);
		cell.style.padding="0";
		cell.style.textAlign="left";
		cell.style.borderRight="1px";
		cell.style.borderLeft="1px";
		cell.setAttribute("class","middle");
		cell.style.width="15px";
		cell.innerHTML="~";//~

		
		cell=newRow.insertCell(7);
		cell.style.padding="0";
		cell.style.textAlign="left";
		cell.style.borderLeft="1px";
		cell.setAttribute("class","middle");
//		cell.innerHTML=bc.contract4ChargerForm.buildInput("description",eDate);//插入结束期限
		cell.style.width="100px";
		cell.innerHTML='<div class="relative">'
			+'	<input type="text" name="startDate" data-validate=\'{"type":"date","required":false}\' value="'+eDate+'"'
			+'  style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" class="bc-date ui-widget-content" >'
			+'	<ul class="inputIcons">'
			+'		<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>'
			+'	</ul>'
			+'</div>';//插入结束期限
		//绑定日期选择
		bc.form.initCalendarSelect($(cell));


		cell=newRow.insertCell(8);
		cell.style.padding="0";
		cell.style.textAlign="left";
		cell.setAttribute("class","middle");
		cell.innerHTML=bc.contract4ChargerForm.buildInput("description",selectFeeTemplate.desc);//插入备注
	},
	
	/** 从模板添加附件 */
	addAttachFromTemplate: function(){
		var $atm = $(this)
		var $page = $atm.closest(".bc-page");
		var id = $page.find(":input[name='e.id']").val();
		bc.addAttachFromTemplate($atm, id, bc.root + "/bc-business/contract4Charger/addAttachFromTemplate",{
			category: "营运系统/经济合同附件",
			multiple: true
		});
	},
	/**
	 * 经济合同入库
	 */
	storage : function (callback){
		var $form = $("form",this);
		var data = $form.serialize();
		var url = bc.root + "/bc-business/contract4Charger/warehousing";
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
	}

};