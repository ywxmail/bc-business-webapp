if(!window['bs'])window['bs']={};
bc.certLostForm = {
	init : function(option,readonly) {
		var $form=$(this);
		//只读状态就不需要执行其它初始化，直接返回
		if(readonly) return;
		
		// 选择申办人
		$form.find("#selectDriverName").click(function() {
			var selecteds = $form.find(":input[name='e.driver.id']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(driver) {
					$form.find(":input[name='e.driver.id']").val(driver.id);
					$form.find(":input[name='e.driverNane']").val(driver.name);
					$form.find(":input[name='e.driver.cert4FWZG']").val(driver.cert4FWZG);
				}
			});
		});

		
		//------------绑定选择车辆按钮事件开始-------------------
		$form.find("#selectCar").click(function() {
			var selecteds = $form.find(":input[name='e.carPlate']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.car.id']").val(car.id);
					$form.find(":input[name='carPlate']").val(car.plate);
					$form.find(":input[name='e.motorcadeId']").val(car.motorcadeId);
					var subject="["+car.plate+"]"+bc.certLostForm.changeTimeToString()+"补办证件";
					$form.find(":input[name='e.subject']").val(subject);
					 var $select = $form.find(":input[name='e.motorcadeId']");
					 var selectEl = $select[0];
					if(bc.select.isExist(selectEl, car.motorcadeId)){
						$select.val(car.motorcadeId);
					}else{
						selectEl.options[selectEl.length] = new Option(car.motorcadeName, car.motorcadeId);
						selectEl.options[selectEl.length-1].selected = true;
					}

					//根据选择的车辆信息获取相应的营运司机信息
					var url=bc.root +"/bc-business/caseAccident/selectCarMansInfo?carId="+car.id;
					$.ajax({
						url:url,
						dataType:"json",
						success: function(drivers){
							logger.info("drivers=" + $.toJSON(drivers));
							if(drivers.length==0){
								$form.find(":input[name='e.driver.id']").val("");
								$form.find(":input[name='e.driver.cert4FWZG']").val("");
								$form.find(":input[name='e.driverNane']").val("");
								bc.msg.alert("该车辆还没有被任何司机驾驶！");
								//按照司机信息更新表单相应的域
								function updateFieldsFromDriver(driver){
									$form.find(":input[name='e.driver.id']").val(driver.id);
									$form.find(":input[name='e.driverNane']").val(driver.name);
									$form.find(":input[name='e.driver.cert4FWZG']").val(driver.cert4FWZG);
								};

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
								
								//绑定双击事件
								function onSelectDriver(){
									if(driversEl.selectedIndex == -1){
										alert("请先选择营运司机！");
										return false;
									}
									//更新司机信息
									updateFieldsFromDriver(drivers[driversEl.selectedIndex]);
									//销毁对话框
									html.dialog("destroy").remove();
								}
								var driversEl = html.find("#drivers").dblclick(onSelectDriver)[0];
								
								//弹出对话框让用户选择司机
								html.dialog({
									id: "selectAccidentDriver",
									title: "所选车辆有多个营运司机，请选择当事司机",
									dialogClass: 'bc-ui-dialog ui-widget-header',
									width:300,modal:true,
									buttons:[{text:"确定",click: onSelectDriver}]
								});
							}
						}
					});
				}
			});
		});
		//------------绑定选择车辆按钮事件结束-------------------
		//------------添加行-------------------
		var tableEl=$form.find("#certTables")[0];
		$form.find("#addLine").click(function() {
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
			cell.innerHTML='<div class="bc-relativeContainer">'
				+'<input type="text" name="certName" style="width:99%;height:100%;border:none;margin:0;padding:0 0 0 2px;'
				+'background:none;" class="bc-select ui-widget-content" data-validate="required" data-maxheight="150px" '
				+'data-source='+$form.find(":input[name='certLists']").val()+'>'
				+'<ul class="inputIcons">'
				+'	<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title="点击选择"></li>'
				+'</ul></div>';//插入证件名称
			
			cell=newRow.insertCell(2);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="certNo" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
				           +'type="text" class="ui-widget-content">';//插入证件号
			
			cell=newRow.insertCell(3);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<select name="reason" class="ui-widget-content" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"'
							+'data-validate="required">'
							+'		<option value="掉失">掉失</option>'
							+'		<option value="被盗">被盗</option>'
							+'		<option value="损坏">损坏</option>'
							+'		<option value="其它">其它</option>'
							+'</select>';//插入原因

			cell=newRow.insertCell(4);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<select name="remains" class="ui-widget-content" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"'
				            +'data-validate="required">'
							+'   <option value="false">无</option>'
							+'   <option value="true">有</option>'
							+'</select>';//插入残骸
			
			cell=newRow.insertCell(5);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<select name="replace" class="ui-widget-content" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"' 
							+'data-validate="required">'
							+'    <option value="false">未补办</option>'
							+'    <option value="true">补办</option>'
			    			+'+</select>';//插入补办
			
			cell=newRow.insertCell(6);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<div class="relative">'
							+'	<input type="text" name="replaceDate" data-validate=\'{"type":"date","required":false}\''
							+'  style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;" class="bc-date ui-widget-content" >'
							+'	<ul class="inputIcons">'
							+'		<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>'
							+'	</ul>'
							+'</div>';//插入补办日期
			//绑定日期选择
			bc.form.initCalendarSelect($(cell));
			
			cell=newRow.insertCell(7);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="newCertNo" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
							+'type="text" class="ui-widget-content" >';//插入新证件号码
			
			cell=newRow.insertCell(8);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="lostAddress" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
							+'type="text" class="ui-widget-content" >';//插入遗失地点
			
			cell=newRow.insertCell(9);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="description" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
							+'type="text" class="ui-widget-content" >';//插入备注
			
		});
		//点击选中行
		$form.find("#certTables").delegate("tr.ui-widget-content.row>td.id","click",function(){
			$(this).parent().toggleClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").toggleClass("ui-icon-check");
		});
		$form.find("#certTables").delegate("tr.ui-widget-content.row input","focus",function(){
			$(this).closest("tr.row").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
		});
		//删除表中选中的险种
		$form.find("#deleteLine").click(function() {
			var $trs = $form.find("#certTables tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要删除遗失的证件！");
				return;
			}
			bc.msg.confirm("确定要删除选定的 <b>"+$trs.length+"</b>个遗失的证件吗？",function(){
				for(var i=0;i<$trs.length;i++){
					$($trs[i]).remove();
				}
			});
			
		});
		//经办人
		$form.find("#selectTransactor").click(function(){
			bc.identity.selectUser({
				history: true,
				selectdes:$form.find(":input[name='e.transactor.id']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.transactor.id']").val(user.id);
					$form.find(":input[name='e.transactorName']").val(user.name);
				}
			});
		});


	},
	/**保存的处理*/
	save:function(){
		$page = $(this);
		//先将证件合并到隐藏域
		var certs=[];
		//将补办证件表中的内容添加到certs里
		$page.find("#certTables tr:gt(0)").each(function(){
			var $inputs = $(this).find("td>input");
			var $selects= $(this).find("td>select");
			var $divInput= $(this).find("td>div>input");
			var json = {
				certName: $divInput[0].value,
				certNo: $inputs[0].value,
				reason: $selects[0].value,
				remains: $selects[1].value,
				replace: $selects[2].value,
				replaceDate: $divInput[1].value,
				newCertNo: $inputs[1].value,
				lostAddress: $inputs[2].value,
				description: $inputs[3].value
			};
			var id = $(this).attr("data-id");
			if(id && id.length > 0)
				json.id = id;
			certs.push(json);
		});
		$page.find(":input[name='certs']").val($.toJSON(certs));
		//表单验证
		$certTables=$page.find("#certTables tr");
		
		if(!bc.validator.validate($certTables))
			return;
		//调用标准的方法执行保存
		bc.page.save.call(this);
	},
	//将当前时间转化为字符串
	changeTimeToString:function(){
		var year=0;
		var month=0;
		var day=0;
		var currentDate="";
		var now =new Date();
		year=now.getFullYear();
		month=now.getMonth()+1;
		day=now.getDate();
		currentDate=year+"-";
		if(month>10){
			currentDate=currentDate+month+"-";
		}else{
			currentDate=currentDate+"0"+month+"-";
		}
		if(day>10){
			currentDate=currentDate+day;
		}else{
			currentDate=currentDate+"0"+day;
		}
		return currentDate;
	}
	
	
};