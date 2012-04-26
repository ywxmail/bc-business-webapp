if(!window['bs'])window['bs']={};
bs.feeForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		// 初始化多页签
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		//初始化点击隐藏按钮
		bs.feeForm.foldingDiv($form,"showGroups1","div1",false);
		bs.feeForm.foldingDiv($form,"showGroups2","div2",false);
		bs.feeForm.foldingDiv($form,"showGroups3","div3",false);
		bs.feeForm.foldingDiv($form,"showGroups4","div4",false);
		bs.feeForm.foldingDiv($form,"showGroups5","div5",false);
		bs.feeForm.foldingDiv($form,"showGroups6","div6",false);
		
		//只读权限控制
		if(readonly) return;
		
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
						$form.find(":input[name='e.payerId']").val(carMan.id);
						$form.find(":input[name='e.payerName']").val(carMan.name);
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
						$form.find(":input[name='e.payerId']").val(driver.id);
						$form.find(":input[name='e.payerName']").val(driver.name);
					};
					
					//根据选择的车辆信息获取相应的营运司机信息
					var url=bc.root +"/bc-business/caseAdvice/selectCarMansInfo?carId="+car.id;
					$.ajax({
						url:url,
						dataType:"json",
						success: function(drivers){
							logger.info("drivers=" + $.toJSON(drivers));
							if(drivers.length==0){
								$form.find(":input[name='e.payerId']").val("");
								$form.find(":input[name='e.payerName']").val("");
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
									id: "selectFeeDriver",
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
		$form.find("#selectPayerName").click(function() {
			var selecteds = $form.find(":input[name='e.payerName']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(carMan) {
					$form.find(":input[name='e.payerId']").val(carMan.id);
					$form.find(":input[name='e.payerName']").val(carMan.name);
				}
			});
		});
		
		// 绑定应收合计计算事件(本期应收小计)
		$form.find(":input[name='e.shouldSubtotal']").blur(function() {
			var shouldSubTotal = $form.find(":input[name='e.shouldSubtotal']").val();
			var shouldUpKeep = $form.find(":input[name='e.shouldUpkeep']").val();
			var adjustSubTotal = $form.find(":input[name='e.adjustSubtotal']").val();
			var adjustUpKeep = $form.find(":input[name='e.adjustUpkeep']").val();
			var b4owe = $form.find(":input[name='b4oweTotal']").val();
			
			var shouldTotal = parseFloat(shouldSubTotal)+parseFloat(shouldUpKeep); 
			var adjustTotal = parseFloat(adjustSubTotal)+parseFloat(adjustUpKeep); 
			var b4oweTotal = parseFloat(b4owe);
			
			$form.find(":input[name='e.shouldTotal']").val(shouldTotal); //本期应收合计
			$form.find(":input[name='e.saTotal1']").val(shouldTotal - adjustTotal);//本期应收款合计
			$form.find(":input[name='e.saTotal2']").val(shouldTotal - adjustTotal + b4oweTotal); //前期加本期应收款合计
		});
		
		// 绑定应收合计计算事件(本期应收维修费)
		$form.find(":input[name='e.shouldUpkeep']").blur(function() {
			var shouldSubTotal = $form.find(":input[name='e.shouldSubtotal']").val();
			var shouldUpKeep = $form.find(":input[name='e.shouldUpkeep']").val();
			var adjustSubTotal = $form.find(":input[name='e.adjustSubtotal']").val();
			var adjustUpKeep = $form.find(":input[name='e.adjustUpkeep']").val();
			var b4owe = $form.find(":input[name='b4oweTotal']").val();
			
			var shouldTotal = parseFloat(shouldSubTotal)+parseFloat(shouldUpKeep); 
			var adjustTotal = parseFloat(adjustSubTotal)+parseFloat(adjustUpKeep); 
			var b4oweTotal = parseFloat(b4owe);
			
			$form.find(":input[name='e.shouldTotal']").val(shouldTotal); //本期应收合计
			$form.find(":input[name='e.saTotal1']").val(shouldTotal - adjustTotal);//本期应收款合计
			$form.find(":input[name='e.saTotal2']").val(shouldTotal - adjustTotal + b4oweTotal); //前期加本期应收款合计
		});
		
		// 绑定应收合计计算事件(本期调整小计)
		$form.find(":input[name='e.adjustSubtotal']").blur(function() {
			var shouldSubTotal = $form.find(":input[name='e.shouldSubtotal']").val();
			var shouldUpKeep = $form.find(":input[name='e.shouldUpkeep']").val();
			var adjustSubTotal = $form.find(":input[name='e.adjustSubtotal']").val();
			var adjustUpKeep = $form.find(":input[name='e.adjustUpkeep']").val();
			var b4owe = $form.find(":input[name='b4oweTotal']").val();
			
			var shouldTotal = parseFloat(shouldSubTotal)+parseFloat(shouldUpKeep); 
			var adjustTotal = parseFloat(adjustSubTotal)+parseFloat(adjustUpKeep); 
			var b4oweTotal = parseFloat(b4owe);
			
			$form.find(":input[name='e.adjustTotal']").val(adjustTotal); //本期应收合计
			$form.find(":input[name='e.saTotal1']").val(shouldTotal - adjustTotal);//本期应收款合计
			$form.find(":input[name='e.saTotal2']").val(shouldTotal - adjustTotal + b4oweTotal); //前期加本期应收款合计
		});
		
		// 绑定应收合计计算事件(本期调整维修费)
		$form.find(":input[name='e.adjustUpkeep']").blur(function() {
			var shouldSubTotal = $form.find(":input[name='e.shouldSubtotal']").val();
			var shouldUpKeep = $form.find(":input[name='e.shouldUpkeep']").val();
			var adjustSubTotal = $form.find(":input[name='e.adjustSubtotal']").val();
			var adjustUpKeep = $form.find(":input[name='e.adjustUpkeep']").val();
			var b4owe = $form.find(":input[name='b4oweTotal']").val();
			
			var shouldTotal = parseFloat(shouldSubTotal)+parseFloat(shouldUpKeep);
			var adjustTotal = parseFloat(adjustSubTotal)+parseFloat(adjustUpKeep);
			var b4oweTotal = parseFloat(b4owe);
			
			$form.find(":input[name='e.adjustTotal']").val(adjustTotal); //本期应收合计
			$form.find(":input[name='e.saTotal1']").val(shouldTotal - adjustTotal); //本期应收款合计
			$form.find(":input[name='e.saTotal2']").val(shouldTotal - adjustTotal + b4oweTotal); //前期加本期应收款合计
		});
		
		// 绑定实收合计计算事件(本期实收小计)
		$form.find(":input[name='e.realSubtotal']").blur(function() {
			var realSubTotal = $form.find(":input[name='e.realSubtotal']").val();
			var realUpKeep = $form.find(":input[name='e.realUpkeep']").val();
			
			$form.find(":input[name='e.realTotal']").val(
				parseFloat(realSubTotal)+parseFloat(realUpKeep)
			);
		});
		// 绑定实收合计计算事件(本期实收维修费)
		$form.find(":input[name='e.realUpkeep']").blur(function() {
			var realSubTotal = $form.find(":input[name='e.realSubtotal']").val();
			var realUpKeep = $form.find(":input[name='e.realUpkeep']").val();
			
			$form.find(":input[name='e.realTotal']").val(
				parseFloat(realSubTotal)+parseFloat(realUpKeep)
			);
		});
		// 绑定欠费合计计算事件(本期欠费小计)
		$form.find(":input[name='e.oweSubtotal']").blur(function() {
			var oweSubTotal = $form.find(":input[name='e.oweSubtotal']").val();
			var oweUpKeep = $form.find(":input[name='e.oweUpkeep']").val();
			
			$form.find(":input[name='e.oweTotal']").val(
				parseFloat(oweSubTotal)+parseFloat(oweUpKeep)
			);
		});
		// 绑定欠费合计计算事件(本期欠费维修费)
		$form.find(":input[name='e.oweUpkeep']").blur(function() {
			var oweSubTotal = $form.find(":input[name='e.oweSubtotal']").val();
			var oweUpKeep = $form.find(":input[name='e.oweUpkeep']").val();
			
			$form.find(":input[name='e.oweTotal']").val(
				parseFloat(oweSubTotal)+parseFloat(oweUpKeep)
			);
		});
		
		
		//------------本期实收添加行 开始-------------------
		var tableElOne=$form.find("#feeDetailTables")[0];
		$form.find("#addLine").click(function() {
			//插入行
			var newRow=tableElOne.insertRow(tableElOne.rows.length);
			newRow.setAttribute("class","ui-widget-content row");
			//插入列
			var cell=newRow.insertCell(0);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","id first");
			cell.innerHTML='<span class="ui-icon"></span>';//空白头列

			cell=newRow.insertCell(1);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="feeName" data-validate="required" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"' 
				           +'type="text" class="ui-widget-content">';//费用名称
			
			cell=newRow.insertCell(2);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="charge" data-validate=\'{"type":"number","required":true}\' style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"' 
				+'type="text" class="ui-widget-content">';//费用
			
			cell=newRow.insertCell(3);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="feeDescription" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
							+'type="text" class="ui-widget-content" >';//插入明细备注
			
			cell=newRow.insertCell(4);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="feeType" type="hidden" value="1" class="ui-widget-content" >';//插入明细类型 1:实收明细,2欠费明细

		});
		//点击选中行
		$form.find("#feeDetailTables").delegate("tr.ui-widget-content.row>td.id","click",function(){
			$(this).parent().toggleClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").toggleClass("ui-icon-check");
		});
		$form.find("#feeDetailTables").delegate("tr.ui-widget-content.row input","focus",function(){
			$(this).closest("tr.row").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
		});
		//删除表中选中的险种
		$form.find("#deleteLine").click(function() {
			var $trs = $form.find("#feeDetailTables tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要删除承包费明细！");
				return;
			}
			bc.msg.confirm("确定要删除选定的 <b>"+$trs.length+"</b>个承包费明细吗？",function(){
				for(var i=0;i<$trs.length;i++){
					$($trs[i]).remove();
				}
			});
		});
		//------------本期实收添加行 结束-------------------
		
		
		
		//------------本期欠费添加行 开始-------------------
		var tableElTwo=$form.find("#feeOweDetailTables")[0];
		$form.find("#addOweLine").click(function() {
			//插入行
			var newRow=tableElTwo.insertRow(tableElTwo.rows.length);
			newRow.setAttribute("class","ui-widget-content row");
			//插入列
			var cell=newRow.insertCell(0);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","id first");
			cell.innerHTML='<span class="ui-icon"></span>';//空白头列
			
			cell=newRow.insertCell(1);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="feeName" data-validate="required" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"' 
				+'type="text" class="ui-widget-content">';//费用名称
			
			cell=newRow.insertCell(2);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="charge" data-validate=\'{"type":"number","required":true}\' style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"' 
				+'type="text" class="ui-widget-content">';//费用
			
			cell=newRow.insertCell(3);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="feeDescription" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
				+'type="text" class="ui-widget-content" >';//插入明细备注
			
			cell=newRow.insertCell(4);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="feeType" type="hidden" value="2" class="ui-widget-content" >';//插入明细类型 1:实收明细,2欠费明细
			
		});
		//点击选中行
		$form.find("#feeOweDetailTables").delegate("tr.ui-widget-content.row>td.id","click",function(){
			$(this).parent().toggleClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").toggleClass("ui-icon-check");
		});
		$form.find("#feeOweDetailTables").delegate("tr.ui-widget-content.row input","focus",function(){
			$(this).closest("tr.row").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
		});
		//删除表中选中的险种
		$form.find("#deleteOweLine").click(function() {
			var $trs = $form.find("#feeOweDetailTables tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要删除承包费明细！");
				return;
			}
			bc.msg.confirm("确定要删除选定的 <b>"+$trs.length+"</b>个承包费明细吗？",function(){
				for(var i=0;i<$trs.length;i++){
					$($trs[i]).remove();
				}
			});
		});
		//------------本期欠费添加行 结束-------------------
		
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
	
	//批量初始化
	batchInti : function(){
		var $form = $(this);
		var url=bc.root +"/bc-business/batchInit/create";
		var option = jQuery.extend({
			url: url,
			name:"批量初始化",
			mid: "batchInti",
			afterClose: function(){
				//重新加载列表
				bc.grid.reloadData($form);
			}
		},option);
		bc.page.newWin(option);
	},
	
	//保存的处理
	save : function(){
		var $form = $(this);
		var json;
		
		//--------  组装实收明细代码开始      --------//
		
		//先将明细合并到隐藏域
		var feeDetails=[];
		//将明细列表的内容添加到feeDetails里
		$form.find("#feeDetailTables tr:gt(0)").each(function(){
			var $inputs = $(this).find("td>input");
			json = {
				feeName: $inputs[0].value,
				charge: $inputs[1].value,
				feeDescription: $inputs[2].value,
				feeType: $inputs[3].value
			};
			var id = $(this).attr("data-id");
			if(id && id.length > 0)
				json.id = id;
			feeDetails.push(json);
		});
		
		//表单验证
		var $feeDetailTables=$form.find("#feeDetailTables tr");
		
		//--------  组装实收明细代码结束     --------//
		
		
		//--------  组装欠费明细代码开始      --------//
		//将欠费明细列表的内容添加到feeDetails里
		$form.find("#feeOweDetailTables tr:gt(0)").each(function(){
			var $inputs = $(this).find("td>input");
			var json = {
					feeName: $inputs[0].value,
					charge: $inputs[1].value,
					feeDescription: $inputs[2].value,
					feeType: $inputs[3].value
			};
			feeDetails.push(json);
		});
		//表单验证
		var $feeOweDetailTables=$form.find("#feeOweDetailTables tr");
		
		//--------  组装欠费明细代码结束     --------//
		
		//将所有明细放在隐藏域feeDetails里面
		$form.find(":input[name='feeDetails']").val($.toJSON(feeDetails));
		
		if(!bc.validator.validate($feeDetailTables)
			|| !bc.validator.validate($feeOweDetailTables))
			return;
		
		//唯一性检测 : 保存之前检测此车辆是否存在本年本月的承包费用
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
	}
	
};