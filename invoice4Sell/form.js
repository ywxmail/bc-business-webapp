if(!window['bs'])window['bs']={};
bs.invoice4SellForm = {
	init : function(option,readonly){
		var $form = $(this);
		
		//计算合计
		$form.find(".bs-i4sell-detail-amount").each(function(index){
			  $tr=$(this).closest("tr");
			  var $count=$tr.find(".bs-i4sell-detail-count");
			  var $price=$tr.find(".bs-i4sell-detail-price");
			  //判断是否有值且是否输数字
			  function isNumber($val){
					if($val.val()&&!isNaN($val.val())){
						return true;
					}else{
						return false;
					}
			  }
			  if(isNumber($count)&&isNumber($price)){
					var float_price=parseFloat($price.val().trim());
					var int_count=parseInt($count.val().trim(),10);
					$(this).val(bc.formatNumber(int_count*float_price,"###,###.00"));
			  }
		});
		
		
		if(readonly) return;
		//绑定销售员按钮事件
		// 销售员
		$form.find("#selectCashier").click(function(){
			bc.identity.selectUser({
				history: true,
				selecteds: $form.find(":input[name='e.cashierId.name']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.cashierId.id']").val(user.id);
					$form.find(":input[name='e.cashierId.name']").val(user.name);
				}
			});
		});
		
		//预加载一个司机关联多台车的对话框选择
		if($form.find(":input[name='isMoreCar']").val()=="true"){
			logger.info("isMoreCar");
			var driverId=$form.find(":input[name='e.buyerId']").val();
			var url= bc.root +"/bc-business/selectMoreCarWithCarMan/selectCars?carManId="+driverId;
			var optionCar = {
				url: url,
				name: "选择车辆信息",
				mid: "selectCar",
				afterClose: function(car){
					logger.info("info=" + $.toJSON(car));
					if(car != null){
						$form.find(":input[name='e.carId']").val(car.id);
						$form.find(":input[name='e.carPlate']").val(car.name);
						$form.find("select[name='e.motorcadeId.id']").val(car.motorcadeId);
						$form.find("select[name='e.company']").val(car.company);
					}
				}
			};
			bc.page.newWin(optionCar);
		};
		if($form.find(":input[name='isNullCar']").val()=="true"){	
			bc.msg.alert("此司机没有驾驶任何车辆！");	
		};
		
		//预加载一台车关联多个司机的对话框选择
		if($form.find(":input[name='isMoreBuyer']").val()=="true"){	
			var carId=$form.find(":input[name='e.carId']").val();
			bs.findInfoByCar({
				carId: carId,
				success: function(info){
					logger.info("info=" + $.toJSON(info));
					if(info.driver){
						$form.find(":input[name='e.buyerId']").val(info.driver.id);
						$form.find(":input[name='e.buyerName']").val(info.driver.name);
					}else{
						$form.find(":input[name='e.buyerId']").val('');
						$form.find(":input[name='e.buyerName']").val('');
						bc.msg.alert("该车辆还没有被任何司机驾驶！");
					}
				}
			});
		};
		if($form.find(":input[name='isNullBuyer']").val()=="true"){
			bc.msg.alert("此车辆没有被任何司机驾驶！");	
		};
		
		//------------绑定选择车辆按钮事件开始-------------------
		$form.find("#selectCar").click(function() {
			var selecteds = $form.find(":input[name='e.carPlate']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.carId']").val(car.id);
					$form.find(":input[name='e.carPlate']").val(car.plate);
					$form.find("select[name='e.motorcadeId.id']").val(car.motorcadeId);
					$form.find("select[name='e.company']").val(car.company);
					//选择司机信息
					bs.findInfoByCar({
						carId: car.id,
						success: function(info){
							logger.info("info=" + $.toJSON(info));
							if(info.driver){
								$form.find(":input[name='e.buyerId']").val(info.driver.id);
								$form.find(":input[name='e.buyerName']").val(info.driver.name);
							}else{
								$form.find(":input[name='e.buyerId']").val('');
								$form.find(":input[name='e.buyerName']").val('');
								bc.msg.alert("该车辆还没有被任何司机驾驶！");
							}
						}
					});
				}
			});
		});
		//------------绑定选择车辆按钮事件结束-------------------
		
		//------------添加行-------------------
		var tableEl=$form.find("#sellDetailTables")[0];
		$form.find("#addLine").click(function() {
			var url=bc.root + "/bc-business/invoice4Sell/autoLoadInvoice4BuyCode";
			$.ajax({
				url:url,
				dataType: "json",
				success:function(jsonArray){
					
					//插入行
					var newRow=tableEl.insertRow(tableEl.rows.length);
					newRow.setAttribute("class","ui-widget-content row");
					//插入列
					var cell=newRow.insertCell(0);
					cell.style.padding="0";
					cell.style.textAlign="left";
					cell.setAttribute("class","id first");
					cell.innerHTML='<span class="ui-icon"></span>';//空白头列

					//插入发票代码
					cell=newRow.insertCell(1);
					cell.style.padding="0";
					cell.style.textAlign="left";
					cell.setAttribute("class","middle");
					var codeRow='<select name="code" class="ui-widget-content bs-i4sell-detail-code" style="width:100%;height:100%;border:none;margin:0;padding:0 10px 0 2px"'
						codeRow+='data-validate="required">';
					codeRow+='<option value=" "></option>';
					//logger.info($.toJSON(jsonArray));
					for(var i=0;i<jsonArray.length;i++){
						codeRow+='<option value="';
						codeRow+=jsonArray[i].key;
						codeRow+='">';
						codeRow+=jsonArray[i].value;
						codeRow+='</option>';
					}
					codeRow+='</select>';
					cell.innerHTML=codeRow;
					
					//插入开始号
					cell=newRow.insertCell(2);
					cell.style.padding="0";
					cell.style.textAlign="left";
					cell.setAttribute("class","middle");
					cell.innerHTML='<input name="startNo" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
						+'type="text" class="ui-widget-content bs-i4sell-detail-startNo"  data-validate="required">';
					
					//插入结束号
					cell=newRow.insertCell(3);
					cell.style.padding="0";
					cell.style.textAlign="left";
					cell.setAttribute("class","middle");
					cell.innerHTML='<input name="endNo" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
						+'type="text" class="ui-widget-content bs-i4sell-detail-endNo" data-validate="required">';
					
					//插入数量
					cell=newRow.insertCell(4);
					cell.style.padding="0";
					cell.style.textAlign="left";
					cell.setAttribute("class","middle");
					cell.innerHTML='<input name="count" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
						+'type="text" class="ui-widget-content bs-i4sell-detail-count" data-validate="required">'
					//每份数量
						+'<input name="eachCount" class="bs-i4sell-detail-eachCount" type="hidden"/>';
					
					//插入单价
					cell=newRow.insertCell(5);
					cell.style.padding="0";
					cell.style.textAlign="left";
					cell.setAttribute("class","middle");
					cell.innerHTML='<input name="price" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
						+'type="text" class="ui-widget-content bs-i4sell-detail-price" data-validate="required">';
					
					//插入合计
					cell=newRow.insertCell(6);
					cell.style.padding="0";
					cell.style.textAlign="left";
					cell.setAttribute("class","middle");
					cell.innerHTML='<input name="amount" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
									+'type="text" class="ui-widget-content bs-i4sell-detail-amount" >';	
					
				}
			});
		});
		//点击选中行
		$form.find("#sellDetailTables").delegate("tr.ui-widget-content.row>td.id","click",function(){
			$(this).parent().toggleClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").toggleClass("ui-icon-check");
		});
		$form.find("#sellDetailTables").delegate("tr.ui-widget-content.row input","focus",function(){
			$(this).closest("tr.row").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
		});
		//删除表中选中的
		$form.find("#deleteLine").click(function() {
			var $trs = $form.find("#sellDetailTables tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要删除的销售明细！");
				return;
			}
			bc.msg.confirm("确定要删除选定的 <b>"+$trs.length+"</b>个销售明细吗？",function(){
				for(var i=0;i<$trs.length;i++){
					$($trs[i]).remove();
				}
			});
			
		});
				
		//绑定选择购买人按钮事件
		$form.find("#selectBuyer").click(function() {
			var selecteds = $form.find(":input[name='e.buyerId']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(carMan) {
					$form.find(":input[name='e.buyerId']").val(carMan.id);
					$form.find(":input[name='e.buyerName']").val(carMan.name);
				}
			});
		});
		
		//动态绑定事件  输入结束号，得出数量和合计
		$form.find("#sellDetailTables").delegate(".bs-i4sell-detail-endNo","blur",function(){;
			logger.info("进入 输入结束号，得出数量和合计");
			//向上找到tr父级元素
			var $tr=$(this).closest("tr");
			bs.invoice4SellForm.autoCountNmberAndAmount($tr,'endNo');
		});
		
		//动态绑定事件   输入数量，得出结束号和合计
		$form.find("#sellDetailTables").delegate(".bs-i4sell-detail-count","blur",function(){;
			logger.info("进入  输入数量，得出结束号和合计");
			//向上找到tr父级元素
			var $tr=$(this).closest("tr");
			bs.invoice4SellForm.autoCountNmberAndAmount($tr,'count');
		});
		
		//动态绑定事件   计算合计
		$form.find("#sellDetailTables").delegate(".bs-i4sell-detail-amount","blur",function(){;
			logger.info("进入 计算合计");
			//向上找到tr父级元素
			var $tr=$(this).closest("tr");
			bs.invoice4SellForm.autoCountNmberAndAmount($tr,'amount');
		});
		
		//动态绑定事件   结束号失去焦点时
		$form.find("#sellDetailTables").delegate(".bs-i4sell-detail-code","change",function(){
			var $codeList=$(this)
			var buyId=$codeList.select().val();
			//向上找到tr父级元素
			var $tr= $codeList.closest("tr");
			if(buyId){
				var url=bc.root + "/bc-business/invoice4Sell/findOneInvoice4Buy";
				$.ajax({
					url:url,
					data:{buyId:buyId},
					dataType:"json",
					success:function(json){
						logger.info($.toJSON(json));
						if(json){
							$tr.find(".bs-i4sell-detail-startNo").val(json.startNo);
							$tr.find(".bs-i4sell-detail-eachCount").val(json.eachCount);
							$tr.find(".bs-i4sell-detail-price").val(json.sellPrice);
							$tr.find(".bs-i4sell-detail-count").val('');
							$tr.find(".bs-i4sell-detail-endNo").val('');
							$tr.find(".bs-i4sell-detail-amount").val('');
						}else{
							$tr.find(".bs-i4sell-detail-startNo").val('');
							$tr.find(".bs-i4sell-detail-eachCount").val('');
							$tr.find(".bs-i4sell-detail-price").val('');
							$tr.find(".bs-i4sell-detail-count").val('');
							$tr.find(".bs-i4sell-detail-endNo").val('');
							$tr.find(".bs-i4sell-detail-amount").val('');	
						}
					}
				});
			}
		});
		
		//采购单新建时
		var buyId_create=$form.find(":input[name='buyId']").val();
		var eid=$form.find(":input[name='e.id']").val();
		if(buyId_create!=''&&eid==''){
			var $tr= $form.find(".bs-i4sell-detail-code").closest("tr");
			var url=bc.root + "/bc-business/invoice4Sell/findOneInvoice4Buy";
				$.ajax({
					url:url,
					data:{buyId:buyId_create},
					dataType:"json",
					success:function(json){
						logger.info($.toJSON(json));
						if(json){
							$tr.find(".bs-i4sell-detail-startNo").val(json.startNo);
							$tr.find(".bs-i4sell-detail-eachCount").val(json.eachCount);
							$tr.find(".bs-i4sell-detail-price").val(json.sellPrice);
							$tr.find(".bs-i4sell-detail-count").val('');
							$tr.find(".bs-i4sell-detail-endNo").val('');
							$tr.find(".bs-i4sell-detail-amount").val('');
						}
					}
			});
		}
		
		//去除select中的属性，防止相同的name名称导致保存出错。
		$form.find("select[name='buyId']").each(function(){
			$(this).removeAttr("name");
		});
	},
	save : function(){
		$page = $(this);
		//表单先验证一次
		if(!bc.validator.validate($page))
			return;
		
		//先将销售合并到隐藏域
		var sellDetails=[];

		$page.find("#sellDetailTables tr:gt(0)").each(function(){
			var $inputs = $(this).find("td>input");
			var $selects= $(this).find("td>select");
			var $divInput= $(this).find("td>div>input");
			var json = {
				buyId: $selects[0].value,
				startNo: $inputs[0].value,
				endNo: $inputs[1].value,
				count: $inputs[2].value,
				price: $inputs[4].value
			};
			var id = $(this).attr("data-id");
			if(id && id.length > 0)
				json.id = id;
			sellDetails.push(json);
		});
		$page.find(":input[name='sellDetails']").val($.toJSON(sellDetails));
		//表单验证
		$sellDetailTables=$page.find("#sellDetailTables tr");
		if(!bc.validator.validate($sellDetailTables))
			return;
		
		var sellDetailsStr=$page.find(":input[name='sellDetails']").val();
		if(sellDetailsStr=='[]')
			bc.msg.alert("你好，销售单至少需要一条发票明细！");
		
		//检测销售明细的正确性
		var sellId=$page.find(":input[name='e.id']").val();
		var status=$page.find(":radio[name='e.status']:checked").val();
		var url=bc.root + "/bc-business/invoice4Sell/checkSell4Detail";
		$.ajax({
			url:url,
			data:{sellId:sellId,status:status,sellDetailsStr:sellDetailsStr},
			dataType: "json",
			success:function(json){		
				if(json.checkResult){
					bc.msg.alert(json.checkResult);
				}else if(json.checkResult4Sell){
					logger.info(json.checkResult4Sell.code);
					
					//组装提示查看信息
					var str = "保存的销售明细"+json.checkResult4Sell.code;
						str +="("+json.checkResult4Sell.save_startNo+"~"+json.checkResult4Sell.save_endNo+")";
						str +="与系统中销售单";
						str +="<a id='chakan4Sell' href=#>";
						str +=json.checkResult4Sell.code+"("+json.checkResult4Sell.data_startNo+"~"+json.checkResult4Sell.data_endNo+")";
						str +="</a>";
						str +="范围重叠!";
					var $a = bc.msg.alert(str);
					$a.find('#chakan4Sell').click(function(){
						bc.page.newWin({
							url: bc.root + "/bc-business/invoice4Sell/open?id="+json.checkResult4Sell.data_sellId,
							name: "查看销售单",
							mid:  "invoice4Sell." + json.checkResult4Sell.data_sellId,
							afterClose: function(){

							}
						})
						$a.dialog("close");
					});
				}else if(json.checkResult4Buy){
					//组装提示查看信息
					var str = "保存的销售明细"+json.checkResult4Buy.code;
						str +="("+json.checkResult4Buy.save_startNo+"~"+json.checkResult4Buy.save_endNo+")";
						str +="不在或超出系统中的采购单";
						str +="<a id='chakan4Buy' href=#>";
						str +=json.checkResult4Buy.code+"("+json.checkResult4Buy.data_startNo+"~"+json.checkResult4Buy.data_endNo+")";
						str +="</a>";
						str +="范围!";
					var $a = bc.msg.alert(str);
					$a.find('#chakan4Buy').click(function(){
						bc.page.newWin({
							url: bc.root + "/bc-business/invoice4Buy/open?id="+json.checkResult4Buy.data_buyId,
							name: "查看采购单",
							mid:  "invoice4Buy." + json.checkResult4Buy.data_buyId,
							afterClose: function(){

							}
						})
						$a.dialog("close");
					});
				}else{
					//调用标准的方法执行保存
					bc.page.save.call($page);
				}		
			}
		});
	},
	/** 维护 */
	doMaintenance : function() {
		var $page = $(this);
		bc.msg.confirm("是否对发票销售单进行维护？",function(){
			// 关闭当前窗口
			$page.dialog("close");
			// 重新打开可编辑表单
			bc.page.newWin({
				name: "维护发票采购单",
				mid: "invoice4Sell" + $page.find(":input[name='e.id']").val(),
				url: bc.root + "/bc-business/invoice4Sell/edit",
				data: {id: $page.find(":input[name='e.id']").val()},
				afterClose: function(status){
					if(status) bc.grid.reloadData($page);
				}
			});
		});
	},
	
	/*
	 * 根据情况自动填上明细的各项
	 * $tr:保存当行明细
	 * $type:类型，如$type="endNo",通过结束号计算数量，合计
	 */
	autoCountNmberAndAmount : function($tr,$type){
		var $startNo=$tr.find(".bs-i4sell-detail-startNo");
		var $count=$tr.find(".bs-i4sell-detail-count");
		var $eachCount=$tr.find(".bs-i4sell-detail-eachCount");
		var $price=$tr.find(".bs-i4sell-detail-price");
		var $endNo=$tr.find(".bs-i4sell-detail-endNo");
		var $amount=$tr.find(".bs-i4sell-detail-amount");
		
		//判断是否有值且是否输数字
		function isNumber($val){
			if($val.val()&&!isNaN($val.val())){
				return true;
			}else{
				return false;
			}
		}
		
		if(isNumber($startNo)){

			//通过结束号计算数量和合计
			if($type=='endNo'&&isNumber($endNo)&&isNumber($eachCount)){
				var int_startNo=parseInt($startNo.val().trim(),10);
				var int_endNo=parseInt($endNo.val().trim(),10);
				var int_eachCount=parseInt($eachCount.val(),10);
				if(int_startNo<int_endNo){
					//开始号必需要整除结束号
					if((int_endNo-int_startNo+1)%int_eachCount==0){
						$count.val((int_endNo-int_startNo+1)/int_eachCount);
						if(isNumber($price)){
							var float_price=parseFloat($price.val().trim());
							$amount.val(bc.formatNumber((int_endNo-int_startNo+1)/int_eachCount*float_price,"###,###.00"))
						}
					}else{
						bc.msg.alert("明细中开始号到结束号数值范围不能整除"+$eachCount.val());
					}
				}else{
					bc.msg.alert("你输入的明细结束号小于或等于开始号");
				}
				
			//通过数量计算结束号，合计
			}else if($type=='count'&&isNumber($count)&&isNumber($eachCount)){
				var int_startNo=parseInt($startNo.val().trim(),10);
				var int_count=parseInt($count.val().trim(),10);
				var int_eachCount=parseInt($eachCount.val(),10);
				var int_endNo=int_startNo+int_count*int_eachCount-1;
				
				if(int_endNo.toString().length>=$startNo.val().trim().length){
					$endNo.val(int_endNo);
				}else{
					var zoreStr=$startNo.val().trim().substring(0,$startNo.val().trim().length-int_endNo.toString().length);
					$endNo.val(zoreStr+int_endNo);
				}
				
				if(isNumber($price)){
					var float_price=parseFloat($price.val().trim());
					$amount.val(bc.formatNumber(int_count*float_price,"###,###.00"));
				}
			}else if($type=='amount'&&isNumber($count)&&isNumber($price)){
				var float_price=parseFloat($price.val().trim());
				var int_count=parseInt($count.val().trim(),10);
				$amount.val(bc.formatNumber(int_count*float_price,"###,###.00"));
			}
		}
	}
};