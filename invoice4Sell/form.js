if(!window['bs'])window['bs']={};
bs.invoice4SellForm = {
	init : function(option,readonly){
		var $form = $(this);
		
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
			var driverId=$form.find(":input[name='e.buyerId']").val();
			var url= bc.root +"/bc-business/selectMoreCarWithCarMan/selectCars?carManId="+driverId;
			var optionCar = {
				url: url,
				name: "选择车辆信息",
				mid: "selectCar",
				afterClose: function(car){
					if(car != null){
						$form.find(":input[name='e.carId']").val(car.id);
						$form.find(":input[name='e.carPlate']").val(car.plate);
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
		if($form.find(":input[name='isMoreCarMan']").val()=="true"){
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
		if($form.find(":input[name='isNullCarMan']").val()=="true"){
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
					var codeRow='<select name="code" class="ui-widget-content" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px"'
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
						+'type="text" class="ui-widget-content"  data-validate="required">';
					
					//插入结束号
					cell=newRow.insertCell(3);
					cell.style.padding="0";
					cell.style.textAlign="left";
					cell.setAttribute("class","middle");
					cell.innerHTML='<input name="endNo" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
						+'type="text" class="ui-widget-content" data-validate="required">';
					
					//插入数量
					cell=newRow.insertCell(4);
					cell.style.padding="0";
					cell.style.textAlign="left";
					cell.setAttribute("class","middle");
					cell.innerHTML='<input name="count" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
						+'type="text" class="ui-widget-content" data-validate="required">';
					
					//插入单价
					cell=newRow.insertCell(5);
					cell.style.padding="0";
					cell.style.textAlign="left";
					cell.setAttribute("class","middle");
					cell.innerHTML='<input name="price" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
						+'type="text" class="ui-widget-content" data-validate="required">';
					
					//插入合计
					cell=newRow.insertCell(6);
					cell.style.padding="0";
					cell.style.textAlign="left";
					cell.setAttribute("class","middle");
					cell.innerHTML='<input name="amount" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
									+'type="text" class="ui-widget-content" >';	
					
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
		//删除表中选中的险种
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
		
		//选择采购单预加载单价，每份数量的信息
		$form.find("select[name='code']").change(function(){
			var buyId=$(this).select().val();
			if(buyId!=''){
				var url=bc.root + "/bc-business/invoice4Sell/findOneInvoice4Buy";
				$.ajax({
					url:url,
					data:{buyId:buyId},
					dataType:"json",
					success:function(json){
						logger.info($.toJSON(json));
						if(json){
							$form.find("#startNo").val(json.startNo);
							$form.find("#endNo").val(json.endNo);
							$form.find("#count").val(json.count);
							$form.find("#eachCount").val(json.eachCount);
							$form.find("#price").val(json.sellPrice);
							$form.find("#amount").val(json.amount);
						}
					}
				});
			}
		});
		
		//新建时
		if($form.find(":input[name='e.id']").val()==''){
			//失去焦点时，自动填上明细的结束号和合计
			$form.find("#count").blur(function(){
				bs.invoice4SellForm.autoCountEndNoAndAmount($form);
			});
			
			//失去焦点时，自动填上明细的结束号和合计
			$form.find("#startNo").blur(function(){
				bs.invoice4SellForm.autoCountEndNoAndAmount($form);
			});
			//失去焦点时，自动计算合计
			$form.find("#price").blur(function(){
				bs.invoice4SellForm.autoCountEndNoAndAmount($form);
			});
		}
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
				price: $inputs[3].value
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
		var url=bc.root + "/bc-business/invoice4Sell/checkSell4Detail";
		$.ajax({
			url:url,
			data:{sellId:sellId,sellDetailsStr:sellDetailsStr},
			dataType: "json",
			success:function(json){		
				if(json){
					bc.msg.alert(json.checkResult);
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
	/**
	 * 将数值四舍五入(保留2位小数)后格式化成金额形式
	 *
	 * @param num 数值(Number或者String)
	 * @return 金额格式的字符串,如'1,234,567.45'
	 * @type String
	 */
	formatNumberToMoney : function(num) {
	    num = num.toString().replace(/\$|\,/g,'');
	    if(isNaN(num))
	    num = "0";
	    sign = (num == (num = Math.abs(num)));
	    num = Math.floor(num*100+0.50000000001);
	    cents = num%100;
	    num = Math.floor(num/100).toString();
	    if(cents<10)
	    cents = "0" + cents;
	    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
	    num = num.substring(0,num.length-(4*i+3))+','+
	    num.substring(num.length-(4*i+3));
	    return (((sign)?'':'-') + num + '.' + cents);
	},
	//自动填上明细的结束号和合计
	autoCountEndNoAndAmount : function($form){
		var count=$form.find("#count").val();
		var startNo=$form.find("#startNo").val();
		var eachCount=$form.find("#eachCount").val();
		var price=$form.find("#price").val();
		//判断数量和开始号是否为数字
		if(count!=''&&!isNaN(count)&&startNo!=''&&!isNaN(startNo)&&eachCount!=null&&price!=null&&!isNaN(price)){
			var a=parseInt(count*eachCount-1);
			var b=parseInt(startNo);
			//计算结束号
			var endNo=a+b;
			if(endNo.toString().length>=b.toString().length){
				$form.find("#endNo").val(endNo); 
			}else{//当开始号是‘0’开始时，结束号补回前边的0
				var zoreStr=startNo.substring(0,startNo.length-endNo.toString().length)
				$form.find("#endNo").val(zoreStr+endNo); 
			}
			//计算合计
			var amount=bs.invoice4SellForm.formatNumberToMoney(count*price);
			$form.find("#amount").val(amount);
		}
	}
	
	
};