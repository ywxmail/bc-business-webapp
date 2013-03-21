if(!window['bs'])window['bs']={};
bc.carPrepareForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		//鼠标单击流程名称事件
		$form.delegate(".bs-caseTraffic-workFlow-processName","click",function(){
			var $tr=$(this).closest("tr");
			var procInstId=$tr.find(".bs-caseTraffic-workFlow-procInstId").val();
			bc.page.newWin({
				name: "工作空间",
				mid: "workspace"+procInstId,
				url: bc.root+ "/bc-workflow/workspace/open?id="+procInstId
			});
		});
		
		//绑定展开事件
		$form.delegate(".showGroups","click",function(){
			$(this).hide();
			$(this).closest(".bs-carPrepare-containers").find(".bs-carPrepare-Groups").toggle('fast');
			$(this).closest(".bs-carPrepare-containers").find(".hiddenGroups").show();
		});
		
		//绑定隐藏事件
		$form.delegate(".hiddenGroups","click",function(){
			$(this).hide();
			$(this).closest(".bs-carPrepare-containers").find(".bs-carPrepare-Groups").toggle('fast');
			$(this).closest(".bs-carPrepare-containers").find(".showGroups").show();
		});
		
		
		if(readonly) return;
		// 初始化多页签
		
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
					}
				}
			});
		};
		if($form.find(":input[name='isNullCar']").val()=="true"){
			bc.msg.alert("该司机还没有驾驶任何车辆！");	
		}
		
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
					$form.find(":input[name='e.company']").val(car.company);
					var motorcadeName = $form.find(":input[name='e.motorcadeId']").find("option:selected").text();
					$form.find(":hidden[name='e.motorcadeName']").val(motorcadeName);
					$form.find(":hidden[name='e.charger']").val(car.charger);
					
					var str = car.charger;
					if(str != null && str.length > 0){
						var strAry = str.split(";");
						var tempStr = "";
						for(var i=0;i<strAry.length;i++){
							tempStr += strAry[i].split(",")[0];
							if((i+1) < strAry.length)
								tempStr += ",";
						}
						$form.find(":input[name='chargers']").val(tempStr);
					}
					
					//按照司机信息更新表单相应的域
					function updateFieldsFromDriver(driver){
						$form.find(":input[name='e.driverId']").val(driver.id);
						$form.find(":input[name='e.driverName']").val(driver.name);
						$form.find(":input[name='e.driverCert']").val(driver.cert4FWZG);
						
					};
					
					//根据选择的车辆信息获取相应的营运司机信息
					var url=bc.root +"/bc-business/caseTraffic/selectCarMansInfo?carId="+car.id;
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
									id: "selectTrafficDriver",
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
		
		//------------添加行-------------------
		var tableEl=$form.find("#carPrepareItemTables")[0];
		$form.find("#addCarPrepareItem").click(function() {
			//插入行
			var newRow=tableEl.insertRow(tableEl.rows.length);
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
			cell.innerHTML='<input name="name" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
				           +'type="text" class="ui-widget-content">';//插入项目
			
			cell=newRow.insertCell(2);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<div class="relative">'
							+'	<input type="text" name="date" data-validate=\'{"type":"date","required":false}\''
							+'  style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" class="bc-date ui-widget-content" >'
							+'	<ul class="inputIcons">'
							+'		<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>'
							+'	</ul>'
							+'</div>';//插入更新日期
			//绑定日期选择
			bc.form.initCalendarSelect($(cell));

			cell=newRow.insertCell(3);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input type="radio" name="status" id="carPrepareItem_create_e_status0" value="0" style="width:auto;">'
				            +'<label for="carPrepareItem_create_e_status0">未完成</label>'
							+'<input type="radio" name="status" id="carPrepareItem_create_e_status1" value="1" style="width:auto;">'
							+'<label for="carPrepareItem_create_e_status1">完成</label>';//插入状态
			
			cell=newRow.insertCell(4);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="desc" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
							+'type="text" class="ui-widget-content" >';//插入备注
			
		});
		//添加选中更新项目
		$form.find("#carPrepareItemTables").delegate("tr.ui-widget-content.row>td.id","click",function(){
			$(this).parent().toggleClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").toggleClass("ui-icon-check");
		});
		$form.find("#carPrepareItemTables").delegate("tr.ui-widget-content.row input","focus",function(){
			$(this).closest("tr.row").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
		});
		//全选
		$form.find("#carPrepareItemTables").delegate("tr.ui-state-default.row>td.first","click",function(){
			var spanClass=$form.find("#carPrepareItemTables > tbody > tr.ui-state-default.row>td.first >span").attr("class");
			if(spanClass=="ui-icon ui-icon-notice"){
				$form.find("#carPrepareItemTables > tbody > tr:gt(1)").addClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").addClass("ui-icon-check");
				$form.find("#carPrepareItemTables > tbody > tr.ui-state-default.row>td.first >span").addClass("ui-icon-check").removeClass("ui-icon-notice");
			}else{
				$form.find("#carPrepareItemTables > tbody > tr:gt(1)").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
				$form.find("#carPrepareItemTables > tbody > tr.ui-state-default.row>td.first >span").addClass("ui-icon-notice").removeClass("ui-icon-check");
			}
		});
		//删除表中选中的更新项目
		$form.find("#deleteCarPrepareItem").click(function() {
			var $trs = $form.find("#carPrepareItemTables tr.ui-state-highlight");
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
		//上移表中选中的更新项目
		$form.find("#upCarPrepareItem").click(function() {
			var $trs = $form.find("#carPrepareItemTables tr.ui-state-highlight");
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
		//下移表中选中的更新项目
		$form.find("#downCarPrepareItem").click(function() {
			var $trs = $form.find("#carPrepareItemTables tr.ui-state-highlight");
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
	
	closefile : function(){
		var $form = $(this);
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
	save:function(){
		var $form = $(this);
		$form.find(":input[name='e.status']").val("0");
		$form.data("data-status","saved");
		//调用标准的方法执行保存
		bc.page.save.call($form);
	},

};