if(!window['bs'])window['bs']={};
bc.contractLabourForm = {
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
						var url = bc.root + "/bc-business/contractLabour/isExistContract?carManId="+info.driver.id;
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
					
					var url = bc.root + "/bc-business/contractLabour/certInfo?carManId="+carMan.id;
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

		//申领期限日期控件设置日期范围
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
	 * 上下文为按钮所在窗口，第一个参数为选中的项({text:[text]},value:[value])
	 * 
	 */
	selectMenuButtonItem : function(option) {
		logger.info("selectMenuButtonItem:option=" + $.toJSON(option));
		
		var $page = $(this);
		//可编辑表单的处理
		$page.find(":input:visible").each(function(){
			logger.debug("disabled:" + this.name);
			this.disabled=false;
		});
		$page.find("ul.inputIcons,span.selectButton").each(function(){
			$(this).show();
		});
			
		//先卸载元素已绑定的编辑器
		$page.find("#textareaId").xheditor(false);
		//绑定富文本编辑器
		$page.find("textarea.bc-editor").each(function(){
			$this = $(this);
			$this.xheditor(bc.editor.getConfig({
				ptype: $this.attr("data-ptype"),
				puid: $this.attr("data-puid"),
				readonly: false,
				tools: $this.attr("data-tools")
			}));
		});
		
		//绑定日期选择
		$page.find('.bc-date[readonly!="readonly"],.bc-time[readonly!="readonly"],.bc-datetime[readonly!="readonly"]')
			.each(function bindSelectCalendar(){
				var $this = $(this);
				var cfg = $this.attr("data-cfg");
				if(cfg && cfg.length > 0){
					cfg = eval("(" + cfg + ")");
				}else{
					cfg = {};
				}
				if(typeof cfg.onSelect == "string"){
					var fn = bc.getNested(cfg.onSelect);
					if(typeof fn != "function"){
						alert('函数“' + cfg.onSelect + '”没有定义！');
						return false;
					}
					cfg.onSelect = fn;
				}
				cfg = jQuery.extend({
					//showWeek: true,//显示第几周
					//showButtonPanel: true,//显示今天按钮、
					showOtherMonths: true,
					selectOtherMonths: true,
					firstDay: 7,
					dateFormat:"yy-mm-dd"//yy4位年份、MM-大写的月份
				},cfg);
				
				if($this.hasClass('bc-date'))
					$this.datepicker(cfg);
				else if($this.hasClass('bc-datetime'))
					$this.datetimepicker(cfg);
				else
					$this.timepicker(cfg);
		});
		
		//重新设定附件
		var attuId = $page.find(":hidden[name='e.uid']").val();
		$page.find("#attachment").html(
			'<div data-extensions="bat,sh,reg,zip,rar,7z,gz,tar,pdf,txt,doc,xls,docx,xlsx,ppt,pptx,png,psd,jpg,jpeg,gif,tif,tiff,mp3,mid,wma,swf,avi,wmv,mkv,apk" data-maxsize="1048576000" data-maxcount="6" data-ptype="contractLabour.main" data-puid='+attuId+' class="attachs formAttachs">' 
			+	'<table cellspacing="0" cellpadding="0" class="header">'
			+		'<tbody>'
			+		'<tr>'
			+			'<td class="summary">'
			+			'<span id="totalCount">0</span>&nbsp;个附件共&nbsp;<span data-size="0" id="totalSize">0Bytes</span>'
			+			'</td>'
			+			'<td class="uploadFile">添加附件<input type="file" multiple="" name="uploadFile" id="fid1322123360263" class="uploadFile">'
			+			'</td>'
			+			'<td><a data-action="downloadAll" class="operation" href="#">打包下载</a><a data-action="deleteAll" class="operation" href="#">全部删除</a>'
			+			'</td>'
			+		'</tr>'
			+		'</tbody>'
			+	'</table>'
			+'</div>'
		);
		bc.contractLabourForm.init(null,false,$page);
		
		switch(option.value){
			case "2":	//维护
				bc.contractLabourForm.setData(2,$page,false);
				break;
			case "3":	//转车
				bc.contractLabourForm.setData(3,$page,true);
				break;
			case "4":	//续约
				bc.contractLabourForm.setData(4,$page,true);
				break;
			case "5":	//离职
				bc.msg.confirm("确定此劳动合同的持有人离职吗？",function(){
					$page.find(":input[name='e.status']").val("2");
					$page.find(":input[name='e.opType']").val("5");
					$page.data("data-status","saved");
					var option = { callback : function (){
							$page.dialog("close");
						}
					};
					//调用标准的方法执行保存
					bc.page.save.call($page,option);
				});
				break;
		}

	},
	
	//维护,转车,续签处理清空内容
	setData : function (opType,context,flag){
		var $page = context;
		$page.find(":input[name='e.status']").val(0);
		$page.find(":input[name='e.opType']").val(opType);
		var verMajor = $page.find(":input[name='e.verMajor']").val();
		var verMinor = $page.find(":input[name='e.verMinor']").val();
		if(flag){ //设置主版本号(转车,续约)
			$page.find("#showVer").html('版本号:&nbsp;'
				+$page.find(":input[name='e.verMajor']").val(eval(++verMajor)).val()+'.'
				+verMinor
			);
			//设置合同编号自增
			var code = $page.find(":input[name='e.code']").val();
			if(code.split('-')[1]){
				var lastNo = eval(++code.split('-')[1]);
				$page.find(":input[name='e.code']").val(
					code.split('-')[0]+'-'+ lastNo
				);
			}else{
				$page.find(":input[name='e.code']").val(
					code+'-'+'1'
				)
			}
		}else{ //设置次版本号(维护)
			$page.find("#showVer").html('版本号:&nbsp;'+verMajor+'.'
				+$page.find(":input[name='e.verMinor']").val(eval(++verMinor)).val()
			);
		}
		//清空id新增一份维护操作类型的合同
		var eId = $page.find(":input[name='e.id']").val();
		if(eId.length > 0){
			$page.find(":input[name='e.pid']").val(eId);
		}
		$page.find(":input[name='e.id']").val('');
		$page.find(":input[name='e.uid']").val('');
	}
};