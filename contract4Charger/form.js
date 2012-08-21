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
			//是否经过重发包，过户，续约操作标识
			var isChange =$form.find(":input[name='isChange']").val();
				//获取上份合同收费明细的信息
				var url = bc.root + "/bc-business/contract4Charger/getContractFeeInfoByEndDate";
				$.ajax({
					url: url,
					dataType:"json",
					data: {contractId : $form.find(":input[name='oldContractId']").val(),stopDate: $form.find(":input[name='stopDate']").val()},
					success: function (json){
						//相关承包合同的结束日
						if(json){
						var contractFee4EndDate = json.contractFee4EndDate;
						//相关的承包费
						var contractFee4Price = json.contractFee4Price;
						}
						bs.selectFeeTemplate({
							module : '经济合同',
							multiple: true,
							onOk : function(selectFeeTemplate) {
								
								bc.contract4ChargerForm.getDriverAmount($form.find(":input[name='carId']").val(),selectFeeTemplate,function(count){

									for(var i=0;i<selectFeeTemplate.length;i++){
										//截取项目编码最后一个"."后的字符
										var code4name=selectFeeTemplate[i].code;
										var lastCode =code4name.substring(code4name.lastIndexOf(".")+1,code4name.length);

										var priceDate=selectFeeTemplate[i].spec;//特殊设置的样式格式为[不足一月收取(6850),每年递减(500).]
										if(priceDate!=null){
										//不足一个月的金额
										var lackPrice=priceDate.lackPrice;
										//每年递减的金额v
										var cutPrice=priceDate.cutPrice;
										//是否拆分
										var isSplit=priceDate.isSplit;
										//是否按司机填写数量
										var isByDriver=priceDate.isByDriver;
										//金额是否*司机数量
										var  isRide=priceDate.isRide;
										//是否输入合同期限
										var isDeadline=priceDate.isDeadline;
										//是否读取拆分后第一条每月承包款的开始日期(isReadyStartDay)
										var isRSD=priceDate.isRSD;
										//开始日期是否是合同开始日期的推迟一日(isDeferOneDay)
										var isDOD=priceDate.isDOD;
										//开始日期是否为结束日期的前三个月或两个月(isThreeOrTwoMonthBefore)
										var isTOTMB=priceDate.isTOTMB;
										//提前几个月
										var monthCount=priceDate.monthCount;
										
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
										//var mustPrice=selectFeeTemplate[i].price.replace(",","").substring(0,selectFeeTemplate[i].price.indexOf("."));
										if(selectFeeTemplate[i].price.indexOf(".")>0){
											var mustPrice=selectFeeTemplate[i].price.replace(",","").substring(0,selectFeeTemplate[i].price.indexOf("."));
										}else{
											var mustPrice=selectFeeTemplate[i].price.replace(",","");
										}

										//如果为空，默认为8850
										if(mustPrice==null){
											mustPrice=8850;
										}
										
										//是否第一条
										var fristone=true;
										//如果项目为每月承包费的根据合同期限来生成相应的项目
										if(isSplit !=null && isSplit ==true){
											//获取合同的开始日期和结束日期
											var startDate=$form.find(":input[name='e.startDate']").val();
											var endDate=$form.find(":input[name='e.endDate']").val();
											//交费实际开始日期为合同开始日期加1日
											if(isDOD !=null && isDOD==true){
											var realityStartDate=$form.find(":input[name='e.startDate']").val();
											var rsd= new Date();
											rsd=$.datepicker.parseDate('yy-mm-dd', realityStartDate);
											rsd.setDate(rsd.getDate()+1);
											}
											var sd =new Date();//开始日期
											var ed =new Date();//结束日期
											sd=$.datepicker.parseDate('yy-mm-dd', startDate);
											ed=$.datepicker.parseDate('yy-mm-dd', endDate);
											
											if(sd!=null){
												//重发包，过户后生成的每月承包款	
												if(isChange=="true" && json ){
														//第一条每月承包款的结束日期
														sd=$.datepicker.parseDate('yy-mm-dd', contractFee4EndDate);	
														mustPrice=contractFee4Price;
														mustPrice=mustPrice.substring(0,mustPrice.lastIndexOf("."));
														if(isDOD !=null && isDOD==true){
															//标记读取第一条每月承包款的开始日期
															if(isRSD !=null && isRSD==true && fristone==true){
																//往特殊配置值中添加读取标记
																var v1=$.toJSON(priceDate);
																var specValue=eval("("+v1+")");
																specValue.isRSDV=true;
																bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],$.datepicker.formatDate('yy-mm-dd', rsd),$.datepicker.formatDate('yy-mm-dd', sd),mustPrice,null,specValue);
																fristone=false;
															}else{
																bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],$.datepicker.formatDate('yy-mm-dd', rsd),$.datepicker.formatDate('yy-mm-dd', sd),mustPrice,null,null);
															}
														}else{
															bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],startDate,$.datepicker.formatDate('yy-mm-dd', sd),mustPrice,null,null);
														}
														//将第一条承包费项目的结束日期设置为下一个月的第一日并增加一年时间 
														sd.setDate(sd.getDate()+1);
														sd.setMonth(sd.getMonth()+12);
														//如果开始日期比结束日期小,就循环生成每月承包费项目
														var md;
														//实收的金额每年递减
														mustPrice=mustPrice-cutPrice;
														while(sd<=ed){
															var md=new Date(sd.getTime());
															md.setMonth(md.getMonth()-12);
															sd.setDate(sd.getDate()-1);
															//承包费项目期限满足一年的开始日期
															var mDate=$.datepicker.formatDate('yy-mm-dd', md);
															//承包费项目期限满足一年的结束日期
															var eDate=$.datepicker.formatDate('yy-mm-dd', sd);
															bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],mDate,eDate,mustPrice,null,null);
															//实收的金额每年递减
															mustPrice=mustPrice-cutPrice;
															sd.setDate(sd.getDate()+1);
															sd.setMonth(sd.getMonth()+12);
														}
														//最后一条承包费项目
														sd.setMonth(sd.getMonth()-12);
														var edStr=$.datepicker.formatDate('yy-mm-dd', ed);
														var sdStr=$.datepicker.formatDate('yy-mm-dd', sd);
														
														if(sd<ed){
															bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],sdStr,edStr,mustPrice,null,null);
														}
												}else if(sd.getDate()!=1 ){
													//第一条承包费项目期限为开始日期到本月的月底
													sd.setMonth(sd.getMonth()+1);//将开始日期的月份加1
													sd.setDate(1);//将开始日期的月份加1后的日期的天数设置为1
													sd.setDate(sd.getDate()-1);//日期的天数设置为开始日期同一月份的最后一日
													//第条承包款的开始日期默认为合同的开始日期加1日
													if(isDOD !=null && isDOD==true){
														//标记读取第一条每月承包款的开始日期
														if(isRSD !=null && isRSD==true && fristone==true){
															//往特殊配置值中添加读取标记
															var v1=$.toJSON(priceDate);
															var specValue=eval("("+v1+")");
															specValue.isRSDV=true;
															bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],$.datepicker.formatDate('yy-mm-dd', rsd),$.datepicker.formatDate('yy-mm-dd', sd),lackPrice,null,specValue);
															fristone=false;
														}else{
															bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],$.datepicker.formatDate('yy-mm-dd', rsd),$.datepicker.formatDate('yy-mm-dd', sd),lackPrice,null,null);
														}
													}else{
														bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],startDate,$.datepicker.formatDate('yy-mm-dd', sd),lackPrice,null,null);
													}
													//将第一条承包费项目的结束日期设置为下一个月的第一日并增加一年时间 
													sd.setDate(sd.getDate()+1);
													sd.setMonth(sd.getMonth()+12);
													//如果开始日期比结束日期小,就循环生成每月承包费项目
													var md;
													while(sd<=ed){
														var md=new Date(sd.getTime());
														md.setMonth(md.getMonth()-12);
														sd.setDate(sd.getDate()-1);
														//承包费项目期限满足一年的开始日期
														var mDate=$.datepicker.formatDate('yy-mm-dd', md);
														//承包费项目期限满足一年的结束日期
														var eDate=$.datepicker.formatDate('yy-mm-dd', sd);
														bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],mDate,eDate,mustPrice,null,null);
														//实收的金额每年递减
														mustPrice=mustPrice-cutPrice;
														sd.setDate(sd.getDate()+1);
														sd.setMonth(sd.getMonth()+12);
													}
													//最后一条承包费项目
													sd.setMonth(sd.getMonth()-12);
													var edStr=$.datepicker.formatDate('yy-mm-dd', ed);
													var sdStr=$.datepicker.formatDate('yy-mm-dd', sd);

													bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],sdStr,edStr,mustPrice,null,null);

												}else{
													//如果是1号开始的
													sd.setMonth(sd.getMonth()+12);
													var begDate=new Date(sd.getTime());
													//满一年期限的
													if(begDate<ed){
														logger.info("ed:"+ed);
														var md;
														//var f = true;
														while(sd<=ed){
															var md=new Date(sd.getTime());
															md.setMonth(md.getMonth()-12);
															sd.setDate(sd.getDate()-1);
															//承包费项目期限满足一年的开始日期
															var mDate=$.datepicker.formatDate('yy-mm-dd', md);
															//承包费项目期限满足一年的实际开始日期为开始日期加多一日(默认)
															if(isDOD !=null && isDOD==true){
															var rd=new Date(md.getTime());
															rd.setDate(rd.getDate()+1);
															var rDate=$.datepicker.formatDate('yy-mm-dd', rd);
															//承包费项目期限满足一年的结束日期
															var eDate=$.datepicker.formatDate('yy-mm-dd', sd);
															//第一条数据的开始日期为实际开始日期
															if(fristone ==true && isRSD !=null && isRSD==true){
																//往特殊配置值中添加读取标记
																var v1=$.toJSON(priceDate);
																var specValue=eval("("+v1+")");
																specValue.isRSDV=true;
																bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],rDate,eDate,mustPrice,null,specValue);
																fristone=false;
															}else{
																bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],mDate,eDate,mustPrice,null,null);
																}
															}else{
																bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],mDate,$.datepicker.formatDate('yy-mm-dd', sd),mustPrice,null,null);
															}
															
															//bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],mDate,eDate,mustPrice,null);
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

														bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],sdStr,edStr,mustPrice,null,null);
														
													}else{
														//不满一年的
														var edStr=$.datepicker.formatDate('yy-mm-dd', ed);
														var sdStr=$.datepicker.formatDate('yy-mm-dd', sd);

														bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],sdStr,edStr,mustPrice,null,null);
														
													}
													
												}
												
											}else{
												if(selectFeeTemplate[i].price.indexOf(".")>0){
													var price=selectFeeTemplate[i].price.replace(",","").substring(0,selectFeeTemplate[i].price.indexOf("."));
												}else{
													var price=selectFeeTemplate[i].price.replace(",","");
												}
												bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],"","",price,null,null);
											}
											
											
										}else if(isDeadline!=null && isDeadline==true){
											//输入合同开始日期和结束期
											var startDate=$form.find(":input[name='e.startDate']").val();
											var endDate=$form.find(":input[name='e.endDate']").val();
											if(selectFeeTemplate[i].price.indexOf(".")>0){
												var price=selectFeeTemplate[i].price.replace(",","").substring(0,selectFeeTemplate[i].price.indexOf("."));
											}else{
												var price=selectFeeTemplate[i].price.replace(",","");
											}
											//开始日期是否推迟一日
											if(isDOD !=null && isDOD==true){
												var realityStartDate=$form.find(":input[name='e.startDate']").val();
												var rsd= new Date();
												rsd=$.datepicker.parseDate('yy-mm-dd', realityStartDate);
												rsd.setDate(rsd.getDate()+1);
												if(isRSD !=null && isRSD==true){
													//往特殊配置值中添加读取标记
													var v1=$.toJSON(priceDate);
													var specValue=eval("("+v1+")");
													specValue.isRSDV=true;
													bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],$.datepicker.formatDate('yy-mm-dd', rsd),endDate,price,null,specValue);
												}else{
													bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],$.datepicker.formatDate('yy-mm-dd',rsd),endDate,price,null,null);
												}
											}else{
												if(isRSD !=null && isRSD==true){
													//往特殊配置值中添加读取标记
													var v1=$.toJSON(priceDate);
													var specValue=eval("("+v1+")");
													specValue.isRSDV=true;
													bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],startDate,endDate,price,null,specValue);
												}else{
													bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],startDate,endDate,price,null,null);
												}
											}
											
										}else if(isTOTMB !=null && isTOTMB==true){
											//如果只配置isTOTMB默认提前三个月
											var endDate=$form.find(":input[name='e.endDate']").val();
											if(selectFeeTemplate[i].price.indexOf(".")>0){
												var price=selectFeeTemplate[i].price.replace(",","").substring(0,selectFeeTemplate[i].price.indexOf("."));
											}else{
												var price=selectFeeTemplate[i].price.replace(",","");
											}
											var mb = new Date();
											mb = $.datepicker.parseDate('yy-mm-dd', endDate)
											if(monthCount !=null){
												mb.setMonth(mb.getMonth() - monthCount);
											}else{
												mb.setMonth(mb.getMonth() - 3);
											}
											//加1日
											mb.setDate(mb.getDate() +1);
											//是否按司机人数
											if(isByDriver!=null && isByDriver==true){
													bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],$.datepicker.formatDate('yy-mm-dd',mb),endDate,price,count,null);
											}else{
												bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],$.datepicker.formatDate('yy-mm-dd',mb),endDate,price,null,null);
											}
										}else{
											//其他选项
											if(selectFeeTemplate[i].price.indexOf(".")>0){
												var price=selectFeeTemplate[i].price.replace(",","").substring(0,selectFeeTemplate[i].price.indexOf("."));
											}else{
												var price=selectFeeTemplate[i].price.replace(",","");
											}

											//根据营运司机的数量特殊处理安全互助金 ,个人所得税,工资,残疾人基金
											if(isByDriver!=null && isByDriver==true){
												//如果是安全互助金,金额*司机数量
												if(isRide!=null && isRide==true){
													var price=price*count;
													bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],"","",price,null,null);
													
												}else{
													//个人所得税,工资,残疾人基金
													bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],"","",price,count,null);
												}
												
											}else{
												//其他 
												bc.contract4ChargerForm.addFeeDetailData(tableEl,selectFeeTemplate[i],"","",price,null,null);
											}
											
										}
									}						
									
								});
							}
						});					
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
		//上移表中选中的明细项目
		$form.find("#upFeeTemplate").click(function() {
			var $trs = $form.find("#feeDetailTables tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要上移的项目！");
				return;
			}else{
				$trs.each(function(){
					var $tr = $(this);
					if($tr[0].rowIndex < 3){
						bc.msg.slide("选中的项目为第一条项目,不能再上移！");					
					}else{
						var $beroreTr=$tr.prev();
						$beroreTr.insertAfter($tr);
					}
				});
			}

		});
		//下移表中选中的明细项目
		$form.find("#downFeeTemplate").click(function() {
			var $trs = $form.find("#feeDetailTables tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要下移的项目！");
				return;
			}else{
				
				for(var i=$trs.length;i>0;i--){
					var $tr=$($trs[i-1]);
					var $beroreTr=$tr.next();
					if($beroreTr.length==0){
						bc.msg.slide("选中的项目为最后一条项目,不能再下移！");					
					}else{
						$beroreTr.insertBefore($tr);
					}
				}
			}
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
			//入库前检测车辆司机是否入库
				bc.contract4ChargerForm.checkDriverOrCarStatus.call($form,function(success){
					if(success){
						bc.msg.confirm("确定要入库吗？",function(){
							//入库
							bc.contract4ChargerForm.storage.call($form,null,null,function(success){
								if(success){
									bc.msg.slide("入库成功！");
									//刷新
									$form.data("data-status","saved");
									$form.dialog("close");
								}
								return false;
							});
						});
	
					}else{
						//获取未入库的车辆id
						if(this.carManId){
							var carManIdStr=this.carManId;
						}
						//获取未入库的司机id
						if(this.carId){
							var carIdStr=this.carId;
						}
						//获取未入库的迁移记录id
						if(this.carByDriverHistoryId){
							var carByDriverHistoryIdStr=this.carByDriverHistoryId;
						}
						bc.msg.confirm(this.msg,function(){
							//入库
							bc.contract4ChargerForm.storage.call($form,carIdStr,carManIdStr,carByDriverHistoryIdStr,function(success){
								if(success){
									bc.msg.slide("入库成功！");
									//刷新
									$form.data("data-status","saved");
									$form.dialog("close");
								}
								return false;
							});
						});
						
					}
					
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
			var spec=$(this).find("td.id.first").attr("data-spec");
			logger.info("name:"+$inputs[0].value);
			logger.info("price:"+$inputs[1].value);
			logger.info("count:"+$inputs[2].value);
			logger.info("payType:"+$inputs[3].value);
			logger.info("startDate:"+$divInput[0].value);
			logger.info("endDate:"+$divInput[1].value);
			logger.info("description:"+$inputs[4].value);
			var json = {
				code:code,
				spec:spec,
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
	 * @option  spec 特殊配置
	 *
	 */
	addFeeDetailData : function (tableEl,selectFeeTemplate,sDate,eDate,price,count,spec){
		//插入行
		var newRow=tableEl.insertRow(tableEl.rows.length);
		newRow.setAttribute("class","ui-widget-content row");
		//插入列
		//插入列
		var cell=newRow.insertCell(0);
		cell.style.padding="0";
		cell.style.textAlign="left";
		cell.setAttribute("class","id first");
		cell.setAttribute("data-code",selectFeeTemplate.code);//编码
		cell.setAttribute("data-spec",(spec !=null ? $.toJSON(spec) : $.toJSON(selectFeeTemplate.spec)));//特殊配置
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
			category: "营运系统/经济合同附件,营运系统/经济合同附件/收费通知,营运系统/经济合同附件/合同,营运系统/经济合同附件/补充协议,营运系统/经济合同附件/终止协议",
			multiple: true
		});
	},
	/**
	 * 经济合同入库
	 */
	storage : function (carIdStr,carManIdStr,carByDriverHistoryIdStr,callback){
		var $form = $(this);
		var url = bc.root + "/bc-business/contract4Charger/warehousing";
		if(carIdStr){
			url = bc.addParamToUrl(url,"draftCarId=" + carIdStr);			
		}
		if(carManIdStr){
			url = bc.addParamToUrl(url,"draftCarManId=" + carManIdStr);			
		}
		if(carByDriverHistoryIdStr){
			url = bc.addParamToUrl(url,"draftcarByDriverHistoryId=" + carByDriverHistoryIdStr);			
		}
		
//		else if(carIdStr !=null && carManIdStr ==null){
//			var url = bc.root + "/bc-business/contract4Charger/warehousing?draftCarId ="+ carIdStr;			
//		}else if(carIdStr ==null && carManIdStr !=null){
//			var url = bc.root + "/bc-business/contract4Charger/warehousing?draftCarManId ="+ carManIdStr;			
//		}else{
//			var url = bc.root + "/bc-business/contract4Charger/warehousing";			
//		}
//		var url = bc.root + "/bc-business/contract4Charger/warehousing";
//		+(carIdStr !=null ? "?draftCarId ="+carIdStr :)
		var $form = $("form",this);
		var data = $form.serialize();
		
		$.ajax({
			url: url,
			dataType:"json",
			data: data,
			success: function (json){
				// 默认的处理
				if(json.success){ 
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
	},
	/** 获取司机的数目 */
	getDriverAmount : function(carId,selectFeeTemplate,callback) {
				bc.ajax({
					url: bc.root + "/bc-business/contract4Charger/getDriverAmount",
					dataType: "json",
					data: {carId: carId},
					success: function(json){
						// 自定义回调函数
						if(typeof callback == "function"){
							return callback.call(this,json);
						}
					}
				});
			},
	/** 检查司机或车辆的状态是否为入库 */		
	checkDriverOrCarStatus : function(callback){
		var $form = $(this);
		bc.ajax({
			url: bc.root + "/bc-business/contract4Charger/checkDriverOrCarStatus",
			dataType: "json",
			data: {carId: $form.find(":input[name='carId']").val(),str2: $form.find(":input[name='e.ext_str2']").val()},
			success: function(json){
				// 默认的处理
				if(json.success){ 
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
	}

};