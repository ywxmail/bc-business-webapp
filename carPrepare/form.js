if(!window['bs'])window['bs']={};
bs.carPrepareForm = {
	//发起驾驶员出车处理流程
	startFlowing : false,
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
		//点击添加经营权证事件
		$form.find("#selectCertNo2").click(function(){
			bs.selectOwnership({
				onOk:function(json){
					$form.find(":input[name='e.code']").val(json.number);
				}
			});
				
		});

		//选择司机1
		$form.find("#addC2Driver1").click(function() {
			bs.selectTempDriver({
				status: '2',
				onOk : function(driver) {
					$form.find(":input[name='e.C2Driver1']").val(driver.name);
					$form.find(":input[name='e.C2Driver1Id']").val(driver.id);
					$form.find(":input[name='e.C2CertFWZG4Driver1']").val(driver.certFWZG);
				}
			});
		});	
		//清除司机1
		$form.find("#clearC2Driver1").click(function() {
			$form.find(":input[name='e.C2Driver1']").val("");
			$form.find(":input[name='e.C2Driver1Id']").val("");
			$form.find(":input[name='e.C2CertFWZG4Driver1']").val("");
		});
		//选择司机2
		$form.find("#addC2Driver2").click(function() {
			bs.selectTempDriver({
				status: '2',
				onOk : function(driver) {
					$form.find(":input[name='e.C2Driver2']").val(driver.name);
					$form.find(":input[name='e.C2Driver2Id']").val(driver.id);
					$form.find(":input[name='e.C2CertFWZG4Driver2']").val(driver.certFWZG);
				}
			});
		});	
		//清除司机2
		$form.find("#clearC2Driver2").click(function() {
			$form.find(":input[name='e.C2Driver2']").val("");
			$form.find(":input[name='e.C2Driver2Id']").val("");
			$form.find(":input[name='e.C2CertFWZG4Driver2']").val("");
		});

		//绑定项目进度中状态列单选按钮组的点击事件(如果之前的项目有没完成的不让其完成)
		var isReturn =false;
		$form.delegate("#carPrepareItemTables td>:input[type='radio']","change",function(){
			//处理点击完成按钮的事件
			if($(this).val()==1){
				//验证日期更新日期是否已填
				var dateVal =$(this).parent().prev().find(":input[name='date']").val();
				if(dateVal.length==0){
					bc.msg.alert("请完成该项目的更新日期！");
					isReturn=true;
				}else{
					isReturn=false;
				}
				//找出点击完成时，当前tr前的所有同辈tr
				var beftorTr=$(this).closest("tr").prevAll();
				//找出点击完成按钮的当前项目的之前所有项目的的已选择的单选按钮
				if(!isReturn){
					var $choosedRadios=$(beftorTr).find("td>:input[type='radio'][checked='checked']");
//					if($choosedRadios.size()==0){
//						isReturn=true;
//					}else{
//						isReturn=false;
//					}
				$choosedRadios.each(function(){
					if($(this).val()==0){
						var projectNane=$(this).closest("tr").children().eq(1).children().val();
						bc.msg.alert("请完成该项目前的“"+projectNane+"”才能完成此项目！");
						isReturn=true;
						return false;
					}else{
						isReturn=false;
					}
				});
				}
				//如果之前存在未完成的返回选择前的状态
				if(isReturn){
					var p=$(this).prev().prev().get(0);
					$(this).prev().prev().get(0).checked=true;
				} 
			}
			
			//若进度中的“出车”或“迁入”的状态为已完成则车辆更新信息的状态也更改为已完成
			var itemName=$(this).parent().prev().prev().children().val();
			if(itemName=='出车'||itemName=='迁入'){
				//如果状态是已完成则更新信息的状态也为“已完成”其他为“更新中”
				if($(this).val()==1){
					$form.find(":input[name='e.status'][value='2']")[0].checked=true;	
				}else{
					$form.find(":input[name='e.status'][value='1']")[0].checked=true;	
				}
			}
			//若进度中的“交车”的状态为已完成则车辆更新信息的状态也更改为更新中
			if(itemName=='交车'){
				//如果状态是已完成则更新信息的状态也为“已完成”其他为“更新中”
				if($(this).val()==1){
					$form.find(":input[name='e.status'][value='1']")[0].checked=true;	
				}else{
					$form.find(":input[name='e.status'][value='0']")[0].checked=true;	
				}
			}

		});
		
	
		
		//新建草稿车辆信息
		$form.find("#createDraftCar").click(function(){
			//获取旧车车牌号码
			var c2PlateNo=$form.find(":input[name='e.C2PlateNo']").val();
			//获取公司
			var c2Company=$form.find(":input[name='e.C2Company']").val();
//			//获取分公司
//			var C2Branch=$form.find(":input[name='e.C2Branch']").val();
			//获取车队
			var c2Motorcade=$form.find(":input[name='e.C2Motorcade']").val();
			//发动机号码
			var c2EngineNo=$form.find(":input[name='e.C2EngineNo']").val();
			//必须有车队才能生成草稿车辆信息
			if(c2Motorcade.length==0){
				bc.msg.alert("请选择车队！");	
				return;
			}
			
			if(c2PlateNo.trim()==''){
				bc.msg.alert("请输入新车牌号码！");
			}else{
				//验证车牌号码
				if(c2PlateNo.length<5||!(/[A-Z_0-9]{5}$/.test(c2PlateNo))||c2PlateNo.length>5){
					bc.msg.alert("请输入正确格式的5位车牌号，如Q1B23！");
					return ;
				}
				
				//获取车辆的相关信息
				$.ajax({
					url: bc.root + "/bc-business/car/createDraftCar",
					dataType:"json",
					data: {plateNo: c2PlateNo,company: c2Company,
							motorcade: c2Motorcade,engineNo: c2EngineNo},
					success: function (json){
							bc.msg.alert(json.msg);
					}
				});

			}
			
		});
		
		//发起出车流程
		$form.find("#startCarActive").click(function(){
			var $form = $("form",$form);
			//验证新车安排区中发起出车流程所需要的信息是否齐全
			if(!bc.validator.validate($form))
				return;
			//发起流程前先提交表单的信息进行保存后再发起流程
			if(bs.carPrepareForm.beforeSave($form)==false)
				return;
			//验证进度项目中“出车”项目前的所有项目都完成
			//找出进度项目中所有的进度项目
			var carPrepareItemsTr=$form.find("#carPrepareItemTables tr:gt(1)");
			//找出最后一个进度项目
			var lastCarPrepareItemsTr=carPrepareItemsTr.last();
			//排除最后一个进度项目后判断其状态
			carPrepareItemsTr.not(lastCarPrepareItemsTr).each(function(){
				var status = $(this).find("input[type='radio']:checked").val()
				if(status==0){
					bc.msg.alert("“出车”进度项目前存在没有完成的项目，请完成后再发起出车处理流程！");
					isReturn=true;
					return false;
				}
			});
			if(isReturn) return;
			//获取出车日期
			var carActiveDate = lastCarPrepareItemsTr.find("input[name='date']").val();
			var carPrepareItemsName = lastCarPrepareItemsTr.find("input[name='name']").val();
			if(carActiveDate.length==0){
				bc.msg.alert("请选择“"+carPrepareItemsName+"”进度项目中的更新日期后才能发起出车处理流程！");
				return;
			}
			
			
			//发起出车流程
			bs.carPrepareForm.startFlowing = true;
			var data = $form.serialize();
			bc.msg.confirm("确认发起驾驶员出车处理流程？"
					,function(){
						bc.ajax({
							url : bc.root + "/bc-business/carPrepare/startFlow",
							data : data,
							dataType : "json",
							success : function(json) {
								bc.msg.slide(json.msg);
								if(json.success){
									//bc.grid.reloadData($page);
									//bc.sidebar.refresh();
								}
								bs.carPrepareForm.startFlowing = false;
							}
						});
					},function(){
						bs.carPrepareForm.startFlowing = false;
					},"发起流程确认窗口"
			);
			
		});
		//选择公司时，查找该公司可以使用的车架号
		$form.find(":input[name='e.C2Company']").change(function(){
			//所选择的公司
			var company=$(this).find("option:selected").text();
			//根据不同的公司查找不同公司可用的车架号
			$.ajax({
				url: bc.root + "/bc-business/carPrepare/getVinByCompany",
				dataType:"json",
				data: {company: company},
				success: function (json){
					//清空车架下拉列表的值
					var $c2VinSelect =$($form.find(":input[name='e.C2CarId']"));
					$c2VinSelect.empty();
					if(json.success){
						//组装车架号下拉列表的Option
						var vinList=json.carVinList;
						for(var i=0;i<vinList.length;i++){
							var vin=vinList[i];
							if(i==0){
								$("<option value>-- 请选择 --</option>").appendTo($c2VinSelect);
							}
							$("<option value='"+vin.key+"'>"+vin.value+"</option>").appendTo($c2VinSelect);
						}
					}
				}
			});
			
		});
		//选择车架号
		$form.find(":input[name='e.C2CarId']").change(function(){
			$form.find(":input[name='e.C2Vin']").val($(this).find("option:selected").text());
		});
		
		//更新旧车信息
		$form.find(".updateCarInfo").click(function(){
			//获取旧车车牌号码
			var c1PlateNo=$form.find(":input[name='e.C1PlateNo']").val();
			if(c1PlateNo.trim()==''){
				bc.msg.alert("请输入车牌号码！");
			}else{
				//验证车牌号码
				if(c1PlateNo.length<5||!(/[A-Z_0-9]{5}$/.test(c1PlateNo))||c1PlateNo.length>5){
					bc.msg.alert("请输入正确格式的5位车牌号，如Q1B23！");
					return ;
				}

				//获取车辆的相关信息
				bc.msg.confirm("确定更新车牌号码为“"+c1PlateNo+"”的相关信息吗？",function(){
					$.ajax({
						url: bc.root + "/bc-business/car/getCarRelevantInfoByPlateNo",
						dataType:"json",
						data: {plateNo: c1PlateNo},
						success: function (json){
							if(json.success){
								$form.find(":input[name='e.C1BsType']").val(json.bsType);							
								$form.find(":input[name='e.code']").val(json.certNo2);							
								$form.find(":input[name='e.C1Scrapto']").val(json.scrapto);							
								$form.find(":input[name='e.planDate']").val(json.scrapDate);							
								$form.find(":input[name='e.C1RegisterDate']").val(json.registerDate);							
								$form.find(":input[name='e.C1Company']").val(json.company);							
								$form.find(":input[name='e.C1ContractEndDate']").val(json.contractEndDate);							
								$form.find(":input[name='e.C1Motorcade']").val(json.motorcadeId);							
								$form.find(":input[name='e.C1GreenslipEndDate']").val(json.greenslipEndDate);							
								$form.find(":input[name='e.C1CommeriaEndDate']").val(json.commerialEndDate);							
								bc.msg.slide(json.msg);
							}else{
								bc.msg.alert(json.msg);
							}
						}
					});
				});
			}
			
		});
//		if(readonly) return;
		
				
		//------------添加行-------------------
		var tableEl=$form.find("#carPrepareItemTables")[0];
		$form.find("#addCarPrepareItem").click(function() {
			//每添加一行，保证单选按钮组的name唯一
			var status4id = bc.nextId(1000);
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
			cell.setAttribute("name","status");
			cell.innerHTML='<input type="radio" name="status'+status4id+'" id="carPrepareItem_create_e_status0" checked="checked" value="0" style="width:auto;">'
				            +'<label for="carPrepareItem_create_e_status0">未完成</label>'
							+'<input type="radio" name="status'+status4id+'" id="carPrepareItem_create_e_status1" value="1" style="width:auto;margin-left:9.5px;">'
							+'<label for="carPrepareItem_create_e_status1">已完成</label>';//插入状态
			
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
	//保存之前的操作
	beforeSave:function($page){
		
		//验证进度表中的第一个项目为一定要为“交车”最后一个为“出车”或“迁入”
		var fristItem=$page.find("#carPrepareItemTables tr").eq(2).find(":input[name='name']").val();
		if(fristItem!='交车'){
			bc.msg.alert("更新进度信息表的第一个项目必须为“交车”！");
			return false;
		}
		var lastItem=$page.find("#carPrepareItemTables tr").last().find(":input[name='name']").val();
		if(!(lastItem=='出车'||lastItem=='迁入')){
			bc.msg.alert("更新进度信息表的最后一个项目必须为“出车”或“迁入”！");
			return false;
		}
		
		
		//收费明细合并到隐藏域
		var carPrepareItems=[];
		//将项目进度表中的内容添加到carPrepareItems里
		$page.find("#carPrepareItemTables tr:gt(1)").each(function(){
			var $inputs = $(this).find("td>:input");
			var $divInput= $(this).find("td>div>input");
			var $td= $(this).find("td:eq(3)");
			logger.info("name:"+$inputs[0].value);
			logger.info("date"+$divInput[0].value);
			logger.info("status:"+$td.find("input[type='radio']:checked").val());
			logger.info("desc:"+$inputs[3].value);
			var json = {
				name: $inputs[0].value,
				date: $divInput[0].value,
				status:$td.find("input[type='radio']:checked").val(),
				desc: $inputs[3].value
			};
			var id = $(this).attr("data-id");
			if(id && id.length > 0)
				json.id = id;
			carPrepareItems.push(json);
		});
		$page.find(":input[name='carPrepareItems']").val($.toJSON(carPrepareItems));
		//表单验证
		$carPrepareItemTables=$page.find("#carPrepareItemTables tr");
		
		if(!bc.validator.validate($carPrepareItemTables))
			return;

	},
	//保存并关闭
	saveAndClose:function(){
		var $form = $(this);
		bs.carPrepareForm.save.call($form,true);
	},
	//保存的处理
	save:function(isClose){
		var $form = $(this);
		//检验是否已存在车辆的更新记录
		var c1PlateType = $form.find(":input[name='e.C1PlateType']").val();
		var c1PlateNo = $form.find(":input[name='e.C1PlateNo']").val();
		var carPrepareId = $form.find(":input[name='e.id']").val();
		$.ajax({
			url: bc.root + "/bc-business/carPrepare/isExistingCarPrepare",
			dataType:"json",
			data: {plateType:c1PlateType,plateNo: c1PlateNo,id: carPrepareId},
			success: function (json){
				if(json.success){
					//表单验证 忽略新车域信息的必填验证
					if(!bc.validator.validate($form,['e.C2Company','e.C2PlateNo','e.C2Branch','e.C2CarId','e.C2Motorcade','e.C2ManageNo','e.C2CarCode','e.C2BsType','e.C2CarActiveType','e.C2Driver1','e.C2Driver2','e.C2CertFWZG4Driver1','e.C2CertFWZG4Driver2','e.C2Nature4Driver1','e.C2Nature4Driver2']))
						return;
					//保存之前
					if(bs.carPrepareForm.beforeSave($form)==false)
						return;
					//调用标准的方法执行保存
					bc.page.save.call($form,{callback: function(json){
						if(json.id){
							bc.msg.slide(json.msg);
							if(isClose==true){
								$form.dialog("close");
							}
						}else{
							bc.msg.alert(json.msg);
						}
						return false;
					}},false);
					
				}else{
					bc.msg.alert(json.msg);
				}
			}
		});
	},

};