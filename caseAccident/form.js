if(!window['bs'])window['bs']={};
bc.caseAccidentForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
        //初始化是根据二次送保的状态是否显示其内容
		if($form.find(":checkbox[name='e.deliverSecond']")[0].checked==false){
			$form.find("#idSecondDeliver").css("display","none");
		}else{
			$form.find("#idSecondDeliver").css("display","block");
		}
		//初始化时显示相关保单
		bc.caseAccidentForm.accAddPolicyInfo($form);
		//根据厂修状态是否显示维修费
		if($form.find(":input[name='e.innerFix']")[0].checked==false){
			$form.find("#fixCostText").hide();
			$form.find(":input[name='e.fixCost']").hide();
		}
		
		//损失情况
		$form.find('#ShowGroups1').css("display","none");		
		//绑定点击按钮内容展出事件
		$form.find('#ShowGroups1').click(function(){
			$form.find('#Groups1').css("display","block");
			$(this).css("display","none");
			$form.find('#HiddenGroups1').css("display","block");
		});
		//绑定点击按钮内容隐藏事件
		$form.find('#HiddenGroups1').click(function(){
			$form.find('#Groups1').css("display","none");
			$(this).css("display","none");
			$form.find('#ShowGroups1').css("display","block");
		});
		
		//理赔情况
		$form.find('#ShowGroups2').css("display","none");		
		//绑定点击按钮内容展出事件
		$form.find('#ShowGroups2').click(function(){
			$form.find('#Groups2').css("display","block");
			$(this).css("display","none");
			$form.find('#HiddenGroups2').css("display","block");
		});
		//绑定点击按钮内容隐藏事件
		$form.find('#HiddenGroups2').click(function(){
			$form.find('#Groups2').css("display","none");
			$(this).css("display","none");
			$form.find('#ShowGroups2').css("display","block");
		});
		
		//事故截图
		$form.find('#ShowGroups3').css("display","none");		
		//绑定点击按钮内容展出事件
		$form.find('#ShowGroups3').click(function(){
			$form.find('#Groups3').css("display","block");
			$(this).css("display","none");
			$form.find('#HiddenGroups3').css("display","block");
		});
		//绑定点击按钮内容隐藏事件
		$form.find('#HiddenGroups3').click(function(){
			$form.find('#Groups3').css("display","none");
			$(this).css("display","none");
			$form.find('#ShowGroups3').css("display","block");
		});
		
		
		if(readonly) return;
		//绑定厂修按钮事件
		$form.find(":input[name='e.innerFix']").change(function(){
			var check=$form.find(":input[name='e.innerFix']")[0].checked;
			if(check){
				$form.find("#fixCostText").show();
				$form.find(":input[name='e.fixCost']").show();
			}else{
				$form.find("#fixCostText").hide();
				$form.find(":input[name='e.fixCost']").hide();
				$form.find(":input[name='e.fixCost']").val('');
			}
		});
		
		if($form.find(":input[name='isMoreCar']").val()=="true"){
			var carManId=$form.find(":input[name='carManId']").val();
			var url=bc.root +"/bc-business/selectMoreCarWithCarMan/selectCars?carManId="+carManId;
			var option = jQuery.extend({
				url: url,
				name: "选择车辆信息",
				mid: "selectCar",
				afterClose: function(car){
					if(car){
						$form.find(":input[name='e.carId']").val(car.id);
						$form.find(":input[name='e.carPlate']").val(car.name);
						$form.find("select[name='e.motorcadeId']").val(car.motorcadeId);
						
					}
				}
			},option);
			bc.page.newWin(option);
		};
		if($form.find(":input[name='isNullCar']").val()=="true"){
			bc.msg.alert("该司机还没有驾驶任何车辆！");
		};
		if($form.find(":input[name='isMoreCarMan']").val()=="true"){
			var carId=$form.find(":input[name='carId']").val();
			var url=bc.root +"/bc-business/selectMoreCarManWithCar/selectCarMans?carId="+carId;
			var option = jQuery.extend({
				url: url,
				name: "选择司机信息",
				mid: "selectCarMan",
				afterClose: function(carMan){
					if(carMan){
						$form.find(":input[name='e.driverId']").val(carMan.id);
						$form.find(":input[name='e.driverName']").val(carMan.name);
						$form.find(":input[name='e.driverCert']").val(carMan.cert4FWZG);
						$form.find(":input[name='e.driverArea']").val(carMan.region);
						$form.find(":input[name='e.driverClasses']").val(carMan.drivingStatus);
						$form.find(":input[name='e.origin']").val(carMan.origin);
					}
				}
			},option);
			bc.page.newWin(option);
		};
		if($form.find(":input[name='isNullCarMan']").val()=="true"){
			bc.msg.alert("该车辆还没有被任何司机驾驶！");	
			$form.find(":input[name='e.carId']").val("");
			$form.find(":input[name='e.carPlate']").val("");
			$form.find(":input[name='e.motorcadeId']").val("");
		};
		
		//绑定车队事件
		$form.find("select[name='e.motorcadeId']").change(function(){
			var $select = $(this);
			var name = $select.find("option:selected").text();
			$form.find(":hidden[name='e.motorcadeName']").val(name);
		});
		
		//------------绑定选择车辆按钮事件开始-------------------
		$form.find("#selectCar").click(function() {
			var selecteds = $form.find(":input[name='e.carPlate']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.carId']").val(car.id);
					$form.find(":input[name='e.carPlate']").val(car.plate);
					$form.find("select[name='e.motorcadeId']").val(car.motorcadeId);
					$form.find(":input[name='e.motorcadeName']").val(car.motorcadeName);
					$form.find(":input[name='e.company']").val(car.company);
					//按照司机信息更新表单相应的域
					function updateFieldsFromDriver(driver){
						$form.find(":input[name='e.driverId']").val(driver.id);
						$form.find(":input[name='e.driverName']").val(driver.name);
						$form.find(":input[name='e.driverCert']").val(driver.cert4FWZG);
						$form.find(":input[name='e.driverArea']").val(driver.region);
						$form.find(":input[name='e.driverClasses']").val(driver.drivingStatus);
						$form.find(":input[name='e.origin']").val(driver.origin);
						//司机类型 0:'',1:'司机',2:'车主',3:'非编'
						if(driver.type==0){
							$form.find("select[name='e.driverType']").val(1);
						//carman类型是责任人或者（司机和责任人）都为车主
						}else if(driver.type==1||driver.type==2){
							$form.find("select[name='e.driverType']").val(2);
						}else if(driver.type==3){
							$form.find("select[name='e.driverType']").val(driver.type);
						}
						
					};
					
					//添加车辆相关保单信息开始
					bc.caseAccidentForm.accAddPolicyInfo($form);
					
					//根据选择的车辆信息获取相应的营运司机信息
					var url=bc.root +"/bc-business/caseAccident/selectCarMansInfo?carId="+car.id;
					$.ajax({
						url:url,
						dataType:"json",
						success: function(drivers){
							logger.info("drivers=" + $.toJSON(drivers));
							if(drivers.length==0){
								$form.find(":input[name='e.driverId']").val("");
								$form.find(":input[name='e.driverName']").val("");
								$form.find(":input[name='e.driverCert']").val("");
								$form.find(":input[name='e.driverArea']").val("");
								$form.find(":input[name='e.driverClasses']").val("");
								$form.find(":input[name='e.origin']").val("");
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
								
								//绑定双击事件
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
		
		// 负责人
		$form.find("#selectPrincipal").click(function() {
			var selecteds = $form.find(":input[name='e.chargerName']").val();
			bc.identity.selectUser({
				history: false,
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(user) {
					$form.find(":input[name='e.chargerId']").val(user.id);
					$form.find(":input[name='e.chargerName']").val(user.name);
				}
			});
		});
		
		//经办人
		$form.find("#selectReceiver").click(function(){
			bc.identity.selectUser({
				history: false,
				selectdes:$form.find(":input[name='e.receiverId']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.receiverId']").val(user.id);
					$form.find(":input[name='e.receiverName']").val(user.name);
				}
			});
		});
		
	
		
		
		// 绑定是否送保事件
		$form.find(":checkbox[name='e.deliver']").change(function() {
			if(this.checked){
				$form.find('#deliver').css("display","block");
			}else{
				$form.find('#deliver').css("display","none");
			}
		});
		
		// 绑定是否保险公司是否赔款事件
		$form.find(":checkbox[name='e.claim']").change(function() {
			if(this.checked){
				$form.find('#claim').css("display","block");
			}else{
				$form.find('#claim').css("display","none");
			}
		});
		
		// 绑定签领日期事件
		$form.find(":checkbox[name='e.pay']").change(function() {
			if(this.checked){
				$form.find('#pay').css("display","block");
			}else{
				$form.find('#pay').css("display","none");
			}
		})
		
		// 绑定是否送保事件 二次送保
		$form.find(":checkbox[name='e.deliverTwo']").change(function() {
			if(this.checked){
				$form.find('#deliverTwo').css("display","block");
			}else{
				$form.find('#deliverTwo').css("display","none");
			}
		});
		
		// 绑定是否保险公司是否赔款事件 二次送保
		$form.find(":checkbox[name='e.claimTwo']").change(function() {
			if(this.checked){
				$form.find('#claimTwo').css("display","block");
			}else{
				$form.find('#claimTwo').css("display","none");
			}
		});
		
		// 绑定签领日期事件 二次送保
		$form.find(":checkbox[name='e.payTwo']").change(function() {
			if(this.checked){
				$form.find('#payTwo').css("display","block");
			}else{
				$form.find('#payTwo').css("display","none");
			}
		});
		
		//绑定送保 隐藏保险公司赔付和受款司机内容
		$form.find(":checkbox[name='e.deliver']").change(function(){
			if($(this)[0].checked==false){
				$form.find(":checkbox[name='e.claim']")[0].checked=false;
				$form.find(":checkbox[name='e.pay']")[0].checked=false;
				$form.find(":checkbox[name='e.deliverSecond']")[0].checked=false;
				$form.find(":checkbox[name='e.deliverTwo']")[0].checked=false;
				$form.find(":checkbox[name='e.claimTwo']")[0].checked=false;
				$form.find(":checkbox[name='e.payTwo']")[0].checked=false;
				$form.find('#claim').css("display","none");
				$form.find('#pay').css("display","none");
				$form.find("#idSecondDeliver").css("display","none");
				$form.find('#deliverTwo').css("display","none");
				$form.find('#claimTwo').css("display","none");
				$form.find('#payTwo').css("display","none");
			}
		});
		
		//绑定保险公司赔付 隐藏受款司机内容
		$form.find(":checkbox[name='e.claim']").change(function(){
			if($(this)[0].checked==false){
				$form.find(":checkbox[name='e.pay']")[0].checked=false;
				$form.find('#pay').css("display","none");
			}
		});
		
		//绑定二次送保按钮  显示或隐藏二次送保的内容
		$form.find(":checkbox[name='e.deliverSecond']").change(function(){
			if($(this)[0].checked==false){
				$form.find("#idSecondDeliver").css("display","none");
				$form.find(":checkbox[name='e.deliverTwo']")[0].checked=false;
				$form.find(":checkbox[name='e.claimTwo']")[0].checked=false;
				$form.find(":checkbox[name='e.payTwo']")[0].checked=false;
				$form.find('#deliverTwo').css("display","none");
				$form.find('#claimTwo').css("display","none");
				$form.find('#payTwo').css("display","none");
			}else if($(this)[0].checked==true){
				$form.find("#idSecondDeliver").css("display","block");
				
			}
			
		});
		//绑定送保 隐藏保险公司赔付和受款司机内容  （二次送保）
		$form.find(":checkbox[name='e.deliverTwo']").change(function(){
			if($(this)[0].checked==false){
				$form.find(":checkbox[name='e.claimTwo']")[0].checked=false;
				$form.find(":checkbox[name='e.payTwo']")[0].checked=false;
				$form.find('#claimTwo').css("display","none");
				$form.find('#payTwo').css("display","none");
			}
		});
		
		
		//绑定保险公司赔付 隐藏受款司机内容（二次送保）
		$form.find(":checkbox[name='e.claimTwo']").change(function(){
			if($(this)[0].checked==false){
				$form.find(":checkbox[name='e.payTwo']")[0].checked=false;
				$form.find('#payTwo').css("display","none");
			}
		});
		
		//绑定按钮点击获取相关保单
		$form.find("#loadPolicy").click(function(){
			bc.caseAccidentForm.accAddPolicyInfo($form);
		});
	},
	//结案 
	closefile : function(){
		var $form = $(this);
		if(	$form.find(":checkbox[name='e.deliverSecond']")[0].checked==false){
			//首次送保信息未填写好时，弹出相应的提示性信息
			if($form.find(":checkbox[name='e.deliver']")[0].checked==false||
					$form.find(":checkbox[name='e.claim']")[0].checked==false||
					$form.find(":checkbox[name='e.pay']")[0].checked==false
			){
				bc.msg.confirm("送保相关的信息未完成，确定要结案吗？",function(){
					$form.find(":input[name='isClosed']").val("1");
					//调用标准的方法执行保存
					bc.page.save.call($form,{callback:function(){
						$form.dialog("close");
						//显示结案成功提示信息
						bc.msg.slide("结案成功");
						
						//返回false，禁止默认的“保存成功”提示信息的显示
						return false;
					}});
				});
			}else{
				bc.msg.confirm("确定要结案吗？",function(){
					$form.find(":input[name='isClosed']").val("1");
					//调用标准的方法执行保存
					bc.page.save.call($form,{callback:function(){
						$form.dialog("close");
						//显示结案成功提示信息
						bc.msg.slide("结案成功");
						
						//返回false，禁止默认的“保存成功”提示信息的显示
						return false;
					}});
				});
			}
		}else{
			if($form.find(":checkbox[name='e.deliver']")[0].checked==false||
					$form.find(":checkbox[name='e.claim']")[0].checked==false||
					$form.find(":checkbox[name='e.pay']")[0].checked==false||
					$form.find(":checkbox[name='e.deliverTwo']")[0].checked==false||
					$form.find(":checkbox[name='e.claimTwo']")[0].checked==false||
					$form.find(":checkbox[name='e.payTwo']")[0].checked==false
			){
				bc.msg.confirm("送保或二次送保相关的信息未完成，确定要结案吗？",function(){
					$form.find(":input[name='isClosed']").val("1");
					//调用标准的方法执行保存
					bc.page.save.call($form,{callback:function(){
						$form.dialog("close");
						//显示结案成功提示信息
						bc.msg.slide("结案成功");
						//返回false，禁止默认的“保存成功”提示信息的显示
						return false;
					}});
				});
			}else{
				bc.msg.confirm("确定要结案吗？",function(){
					$form.find(":input[name='isClosed']").val("1");
					//调用标准的方法执行保存
					bc.page.save.call($form,{callback:function(){
						$form.dialog("close");
						//显示结案成功提示信息
						bc.msg.slide("结案成功");
						//返回false，禁止默认的“保存成功”提示信息的显示
						return false;
					}});
				});
			}
		}
	},//保存时触发相关事件
	save: function(){
		$page=$(this);
		logger.info("save");
		if(($page.find(":checkbox[name='e.pay']")[0].checked==true
				&&$page.find(":checkbox[name='e.deliverSecond']")[0].checked==false)
				||($page.find(":checkbox[name='e.pay']")[0].checked==true
						&&$page.find(":checkbox[name='e.payTwo']")[0].checked==true)
				){
				logger.info("save2");
				bc.msg.confirm("你好，已勾选受款司机，确定要结案吗？",function(){
					$page.find(":input[name='isClosed']").val("1");
					//调用标准的方法执行保存
					bc.page.save.call($page,{callback:function(){
						$page.dialog("close");
						//显示结案成功提示信息
						bc.msg.slide("结案成功");
						//返回false，禁止默认的“保存成功”提示信息的显示
						return false;
					}});
				});
		}else{
			//调用标准的方法执行保存
			bc.page.save.call(this);
		}
	}
	,
	//添加车辆相关保单信息
	accAddPolicyInfo: function($form){
		var happenTime=$form.find(":input[name='e.happenDate']").val();
		var carId=$form.find(":input[name='e.carId']").val();
		if(carId!='' && happenTime!=''){
			var urlLoadPolicy=bc.root +"/bc-business/caseAccident/loadPolicyInfo?carId="+carId;
				urlLoadPolicy+="&happenTime=";
				urlLoadPolicy+=happenTime;
				$.ajax({
					url: urlLoadPolicy,
					dataType : "json",
					success : function(policies) {
						logger.info("policies.length=" + policies.length);
						if(policies.length==0){
							var $bpTable=$form.find("#buildPolicyTable");
							$bpTable.children().replaceWith('');
							$bpTable.html('<textarea rows="3" Class="ui-widget-content noresize"/>');
						}
						if(policies.length==1){
							var ct="";
							ct=bc.caseAccidentForm.accBuildPolicyInfo(policies[0]);
							var $bpTable=$form.find("#buildPolicyTable");
							$bpTable.children().replaceWith('');
							$bpTable.html(ct);
						}else if(policies.length>1){
							for(var i=0; i<policies.length; i++){
								var ct="";
								ct+='<div>';
									ct+='保单';
									var j=i+1;
									ct+=j;
								ct+='</div>';
								var policy=policies[i];
								ct+=bc.caseAccidentForm.accBuildPolicyInfo(policy);
								if(i==0){
									var $bpTable=$form.find("#buildPolicyTable");
									$bpTable.children().replaceWith('');
									$bpTable.html(ct);
								}else{
									$form.find("#buildPolicyTable").append(ct);
								}
							}
						}
					}
				});
		}
	},
	//生成构建相关保单的字符串
	accBuildPolicyInfo: function(policy){
			var ct='<table class="ui-widget-content" cellspacing="3" cellpadding="0" style="width:700px;">';
			ct+='<tbody>';
				ct+='<tr style="line-height: 1px;">';
					ct+='<td style="width: 80px;">&nbsp;</td>';
					ct+='<td style="width: 180px;">&nbsp;</td>';
					ct+='<td style="width: 80px;">&nbsp;</td>';
					ct+='<td style="width: 200px;">&nbsp;</td>';
					ct+='<td style="width: 80px;">&nbsp;</td>';
					ct+='<td >&nbsp;</td>';
				ct+='</tr>';
				ct+='<tr>';
					ct+='<td class="label">商业险号:</td>';
					ct+='<td class="value">';
					ct+=policy.commerialNo;
					ct+='</td>';
					ct+='<td class="label">期限:</td>';
					ct+='<td class="value">';
					ct=ct+policy.commerialStartDate+'至'+policy.commerialEndDate;
					ct+='</td>';
					ct+='<td class="label">险司:</td>';
					ct+='<td class="value">';
					ct+=policy.commerialCompany;
					ct+='</td>';
				ct+='</tr>';
				ct+='<tr>';
					ct+='<td class="label">强制险号:</td>';
					ct+='<td class="value">';
					ct+=policy.greenslipNo;
					ct+='</td>';
					ct+='<td class="label">期限:</td>';
					ct+='<td class="value">';
					ct=ct+policy.greenslipStartDate+'至'+policy.greenslipEndDate;
					ct+='</td>';
					ct+='<td class="label">险司:</td>';
					ct+='<td class="value">';
					ct+=policy.greenslipCompany;
					ct+='</td>';
				ct+='</tr>';
				ct+='<tr>';
					ct+='<td class="label">责任险号:</td>';
					ct+='<td class="value">';
					ct+=policy.liabilityNo;
					ct+='</td>';
				ct+='</tr>';
		//险种 
		ct+='<tr>';
			ct+='<td class="topLabel">购买险种:</td>';
			ct+='</td>';
			ct+='<td class="value" colspan="5">';
				ct+='<table  cellspacing="3" cellpadding="0" >';
					ct+='<tbody>';
						ct+='<tr style="line-height: 1px;">';
							ct+='<td style="width: 100px;">&nbsp;</td>';
							ct+='<td style="width: 160px;">&nbsp;</td>';
							ct+='<td >&nbsp;</td>';
						ct+='</tr>';
						ct+='<tr>';
							ct+='<td class="value" >险种名称</td>';
							ct+='<td class="value" >保额</td>';
							ct+='<td class="value" >描述</td>';
						ct+='</tr>';
						var buyPlants=policy.buyPlant;
						for(var i=0;i<buyPlants.length;i++){
							ct+='<tr>';
								ct+='<td class="value">';
								ct+=buyPlants[i].name;
								ct+='</td>';
								ct+='<td class="value">';
								ct+=buyPlants[i].coverage;
								ct+='</td>';
								ct+='<td class="value">';
								ct+=buyPlants[i].description;
								ct+='</td>';
							ct+='</tr>';
						}
					ct+='</tbody>';
				ct+='</tadble>';
			ct+='</td>';
		ct+='</tr>';
		
			ct+='</tbody>';
		ct+='</table>';
		return ct;
	}
};