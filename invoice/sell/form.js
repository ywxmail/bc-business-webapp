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
		
		
		var tableEl=$form.find("#sellDetailTables")[0];
		
		//------------绑定选择车辆按钮事件开始-------------------
		$form.find("#selectCar").click(function() {
			var selecteds = $form.find(":input[name='e.carPlate']").val();
			bs.selectCar({
				status: '0,1,-1',
				onOk : function(car) {
					$form.find(":input[name='e.carId']").val(car.id);
					$form.find(":input[name='e.carPlate']").val(car.plate);
					$form.find("select[name='e.motorcadeId.id']").val(car.motorcadeId);
					$form.find("select[name='e.company']").val(car.company);
					bs.invoice4SellForm.addDetailLine(tableEl, car.company);
					//选择司机信息
					bs.findInfoByCar({
						carId: car.id,
						status: '-1,0',
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
		$form.find("#addLine").click(function() {
			var company=$form.find("select[name='e.company']").val();
			bs.invoice4SellForm.addDetailLine(tableEl, company);
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
			bs.selectCarMan({
				status: '0,1,-1',
				onOk : function(carMan) {
					$form.find(":input[name='e.buyerId']").val(carMan.id);
					$form.find(":input[name='e.buyerName']").val(carMan.name);
				}
			});
		});
		
		//动态绑定事件  输入结束号，得出数量和合计
		$form.find("#sellDetailTables").delegate(".bs-i4sell-detail-endNo","blur",function(){;
			//向上找到tr父级元素
			var $tr=$(this).closest("tr");
			bs.invoice4SellForm.autoCountNmberAndAmount($tr,'endNo');
		});
		
		//动态绑定事件   输入数量，得出结束号和合计
		$form.find("#sellDetailTables").delegate(".bs-i4sell-detail-count","blur",function(){;
			//向上找到tr父级元素
			var $tr=$(this).closest("tr");
			bs.invoice4SellForm.autoCountNmberAndAmount($tr,'count');
		});
		
		//动态绑定事件   计算合计
		$form.find("#sellDetailTables").delegate(".bs-i4sell-detail-amount","blur",function(){;
			//向上找到tr父级元素
			var $tr=$(this).closest("tr");
			bs.invoice4SellForm.autoCountNmberAndAmount($tr,'amount');
		});
		
		//动态绑定事件 修改单价后  计算合计
		$form.find("#sellDetailTables").delegate(".bs-i4sell-detail-price","blur",function(){;
			//向上找到tr父级元素
			var $tr=$(this).closest("tr");
			bs.invoice4SellForm.autoCountNmberAndAmount($tr,'price');
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
		
		// 因车号输入域打开就自动聚焦，需要触发一下click事件让其支持富文本输入
		$form.find(":input[name='e.carPlate']").click();
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
			bc.msg.alert("销售单至少需要一条明细！");
		
		//调用标准的方法执行保存
		bc.page.save.call($page,{callback: function(json){
			if(!json.success){
				var str = json.msg+'<br>';
				str +="销售明细:<br>"+json.code;
				str +="("+json.save_startNo+"~"+json.save_endNo+")<br>";
				str +="采购单:<br>";
				str +="<a id='chakan4Sell' href=#>";
				str +=json.code+"("+json.data_startNo+"~"+json.data_endNo+")";
				str +="</a>";
				var $a = bc.msg.alert(str);
				$a.find('#chakan4Sell').click(function(){
					bc.page.newWin({
						url: bc.root + "/bc-business/invoice4Buy/open?id="+json.data_buyId,
						name: "查看采购单",
						mid:  "invoice4Buy." + json.data_buyId,
						afterClose: function(){
						}
					})
					$a.dialog("close");
				});
				return false;
			}else{
				$page.find(":input[name='e.id']").val(json.id);
				$page.find(":input[name='e.codeNo']").val(json.codeNo);
			}
		}});
	},
	//保存并关闭
	saveAndClose:function(){
		$page=$(this);
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
			bc.msg.alert("销售单至少需要一条明细！");
		
		//调用标准的方法执行保存
		bc.page.save.call($page,{callback: function(json){
			if(!json.success){
				var str = json.msg+'<br>';
				str +="销售明细:<br>"+json.code;
				str +="("+json.save_startNo+"~"+json.save_endNo+")<br>";
				str +="采购单:<br>";
				str +="<a id='chakan4Sell' href=#>";
				str +=json.code+"("+json.data_startNo+"~"+json.data_endNo+")";
				str +="</a>";
				var $a = bc.msg.alert(str);
				$a.find('#chakan4Sell').click(function(){
					bc.page.newWin({
						url: bc.root + "/bc-business/invoice4Buy/open?id="+json.data_buyId,
						name: "查看采购单",
						mid:  "invoice4Buy." + json.data_buyId,
						afterClose: function(){
						}
					})
					$a.dialog("close");
				});
				return false;
			}else{
				$page.dialog("close");
			}
		}});
	},
	/** 维护 */
	doMaintenance : function() {
		var $page = $(this);
		bc.msg.confirm("是否对发票销售单进行维护？",function(){
			// 关闭当前窗口
			$page.dialog("close");
			// 重新打开可编辑表单
			bc.page.newWin({
				name: "维护发票销售单",
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
			//修改单价后计算合计
			else if($type=='price'&&isNumber($count)&&isNumber($price)){
				var float_price=parseFloat($price.val().trim());
				var int_count=parseInt($count.val().trim(),10);
				$amount.val(bc.formatNumber(int_count*float_price,"###,###.00"));
			}
		}
	},
	/**
	 * 自定义打印
	 */
	print : function(){
		var $page = $(this);
		var id=$page.find(":input[name='e.id']").val();
		if(id){
			var url =bc.root+"/bc/templatefile/inline?code=invoice.sell.excel";
			var dataObj={};
			dataObj.id=id;
			url += "&formatSqlJsons="+$.toJSON(dataObj);
			var win = window.open(url, "_blank");
		}else
			bc.page.print.call($page);
	},
	
	/** 根据指定的公司增加一条明细行 */
	addDetailLine: function (tableEl, company){
		var url=bc.root + "/bc-business/invoice4Sell/autoLoadInvoice4BuyCode";
		if(company != '' && company.length>0){
			url+="?company="+company;
		}
			
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
	},
	
	/** 选择车辆后 */
	afterSelectCar: function(event, ui){
		var $form = $(this).closest(".bc-page");
		if(logger.infoEnabled){
			logger.info("afterSelectCar=" + $.toJSON(ui.item));
			logger.info("p=" + $form.attr("class"));
		}
		
		$form.find(":input[name='e.carId']").val(ui.item.id);// 车辆ID
		$form.find(":input[name='e.company']").val(ui.item.company);// 公司
		$form.find(":input[name='e.motorcadeId.id']").val(ui.item.motorcadeId);// 公司
		
		// 添加一条销售明细
		bs.invoice4SellForm.addDetailLine($form.find("#sellDetailTables")[0], ui.item.company);
		
		//选择司机信息
		bs.findInfoByCar({
			carId: ui.item.id,
			status: '-1,0',
			emptyMsg: "该车辆还没有被任何司机驾驶！",
			success: function(info){
				logger.info("info=" + $.toJSON(info));
				if(info.driver){
					$form.find(":input[name='e.buyerId']").val(info.driver.id);
					$form.find(":input[name='e.buyerName']").val(info.driver.name);
				}else{
					$form.find(":input[name='e.buyerId']").val('');
					$form.find(":input[name='e.buyerName']").val('');
				}
			}
		});
		
		// 记得返回false，否则车辆域信息会被清空
		return false;
	}
};