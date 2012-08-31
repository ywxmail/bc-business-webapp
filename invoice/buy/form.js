if(!window['bs'])window['bs']={};
bs.invoice4BuyForm = {
	init : function(option,readonly)  {
		var $form = $(this);
		//加载一次单位显示
		$form.find("#eachCountName").html($form.find(":input[name='unitName']").val());
		
		//加载一次单位显示
		$form.find(":input[name='e.buyerId.name']")[0].focus();
		
		if(readonly) return;
		//验收入库
		$form.find("#selectBuyer").click(function(){
			bc.identity.selectUser({
				onOk : function(user) {
					$form.find(":input[name='e.buyerId.id']").val(user.id);
					$form.find(":input[name='e.buyerId.name']").val(user.name);
				}
			});
		});
		
		//当开始和结束号失去焦点时触发事件
		$form.find(":input[name='e.endNo']").blur(function(){
			bs.invoice4BuyForm.autoCheckStartNoAndEndNo($form);
		});
		$form.find(":input[name='e.startNo']").blur(function(){
			bs.invoice4BuyForm.autoCheckStartNoAndEndNo($form);
		});
		$form.find(":input[name='e.eachCount']").blur(function(){
			bs.invoice4BuyForm.autoCheckStartNoAndEndNo($form);
		});
		
		//采购单价失去焦点时出发事件
		$form.find(":input[name='e.buyPrice']").blur(function(){
			var count=$.trim($form.find(":input[name='e.count']").val());
			if(count!=0&&count!=''){
				if(!isNaN(count)){
					var int_count=parseInt(count,10);
					//计算合计
					var buyPrice=$form.find(":input[name='e.buyPrice']").val();
					if(buyPrice!=''&&!isNaN(buyPrice)){
						var amount=bc.formatNumber(int_count*buyPrice,"###,###.00");
						$form.find(":input[name='amount']").val(amount);
					}
				}else{
					bc.msg.alert("你好，你输入的采购数量不是数值");
					return false;
				}
			}
		});
		
		//采购数量失去早点触发事件
		$form.find(":input[name='e.count']").blur(function(){
			var startNo=$.trim($form.find(":input[name='e.startNo']").val());
			var eachCount=$.trim($form.find(":input[name='e.eachCount']").val());
			var count=$.trim($form.find(":input[name='e.count']").val());
			if(startNo!=''&&count!=0&&count!=''&&eachCount!=''){
				if(!isNaN(startNo)&&!isNaN(count)&&!isNaN(eachCount)){
					var int_startNo=parseInt(startNo,10);
					var int_count=parseInt(count,10);
					var int_eachCount=parseInt(eachCount,10);
					var int_endNo=int_startNo+int_count*int_eachCount-1;
					
					if(int_endNo.toString().length>=startNo.length){
						$form.find(":input[name='e.endNo']").val(int_endNo);
					}else{
						var zoreStr=startNo.substring(0,startNo.length-int_endNo.toString().length);
						$form.find(":input[name='e.endNo']").val(zoreStr+int_endNo);
					}
					//计算合计
					var buyPrice=$form.find(":input[name='e.buyPrice']").val();
					if(buyPrice!=''&&!isNaN(buyPrice)){
						var amount=bc.formatNumber(int_count*buyPrice,"###,###.00");
						$form.find(":input[name='amount']").val(amount);
					}
				}else{
					bc.msg.alert("你好，你输入的开始号、采购数量、每份数量不是数值");
					return false;
				}
			}
		});
		
		//当选择打印票时，单位为卷，但选择手撕票时，单位为本
		$form.find("select[name='e.type']").change(function(){
			var val=$(this).find(":selected").val();
			if(val=='2'){
				$form.find(":input[name='unitName']").val("卷");
				$form.find(":input[name='e.unit']").val("2");
				$form.find("#eachCountName").html($form.find(":input[name='unitName']").val());
			}else if(val=='1'){
				$form.find(":input[name='unitName']").val("本");
				$form.find(":input[name='e.unit']").val("1");
				$form.find("#eachCountName").html($form.find(":input[name='unitName']").val());
			}
		});	
	},
	save:function(){
		$page = $(this);
		if(!bc.validator.validate($page))
			return;
		if(!bs.invoice4BuyForm.autoCheckStartNoAndEndNo($page))
			return;
		//调用标准的方法执行保存
		bc.page.save.call($page,{callback: function(json){
			if(!json.success){
				if(!json.isShowBuyInfo){
					bc.msg.alert(json.msg);
				}else{
					var str = json.msg+'<br>';
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
				}
				return false;
			}
		}});	
	},
	//保存并关闭按钮
	saveAndClose:function(){
		$page = $(this);
		if(!bc.validator.validate($page))
			return;
		if(!bs.invoice4BuyForm.autoCheckStartNoAndEndNo($page))
			return;
		//调用标准的方法执行保存
		bc.page.save.call($page,{callback: function(json){
			if(!json.success){
				if(!json.isShowBuyInfo){
					bc.msg.alert(json.msg);
				}else{
					var str = json.msg+'<br>';
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
				}
				return false;
			}else{
				$page.dialog("close");
			}
		}});
	},
	/** 维护 */
	doMaintenance : function() {
		var $page = $(this);
		bc.msg.confirm("是否对发票采购单进行维护？",function(){
			// 关闭当前窗口
			$page.dialog("close");
			// 重新打开可编辑表单
			bc.page.newWin({
				name: "维护发票采购单",
				mid: "invoice4Buy" + $page.find(":input[name='e.id']").val(),
				url: bc.root + "/bc-business/invoice4Buy/edit",
				data: {id: $page.find(":input[name='e.id']").val()},
				afterClose: function(status){
					if(status) bc.grid.reloadData($page);
				}
			});
		});
	},
	//判断开始号和结束号逻辑，根据两号计算出数量，并计算出合计
	autoCheckStartNoAndEndNo : function($form){
		var ok=true;
		var startNo=$.trim($form.find(":input[name='e.startNo']").val());
		var endNo=$.trim($form.find(":input[name='e.endNo']").val());
		var eachCount=$.trim($form.find(":input[name='e.eachCount']").val());
		if(startNo!=''&&endNo!=''&&eachCount!=''){
			//是否为数字
			if(!isNaN(startNo)&&!isNaN(endNo)&&!isNaN(eachCount)){
				//结束号大于开始号
				if(startNo<endNo){
					if((endNo-startNo+1)%eachCount==0){
						//两数之差除以100得出采购的数量 多分份（卷/本）
						var count=(endNo-startNo+1)/eachCount;
						$form.find(":input[name='e.count']").val(count);
						//计算合计
						var buyPrice=$form.find(":input[name='e.buyPrice']").val();
						if(buyPrice!=''&&!isNaN(buyPrice)){
							var amount=bc.formatNumber(count*buyPrice,"###,###.00");
							$form.find(":input[name='amount']").val(amount);
						}
					}else{
						bc.msg.alert("你好，你填写的开始号到结束号数值范围不能整除"+eachCount+"，请修正！");
						return false;
					}
				}else if(startNo>endNo){
					bc.msg.alert("你好，你填写的开始号大于结束号！");
					return false;
				}else if(startNo=endNo){
					bc.msg.alert("你好，你填写的开始号等于结束号！");
					return false;
				}else{
					bc.msg.alert("你好，你填写的开始号或结束号不正确，请修正！");
					return false;
				}
			}else{
				bc.msg.alert("你好，你输入的开始号、结束号、每份数量不是数值");
				return false;
			}
		}
		return ok;
	},
	/**
	 * 自定义打印
	 */
	print : function(){
		var $page = $(this);
		var id=$page.find(":input[name='e.id']").val();
		if(id){
			var url =bc.root+"/bc/templatefile/inline?code=invoice.buy.excel";
			var dataObj={};
			var dataArr=[];
			dataObj.key="id";
			dataObj.value=id;	
			dataArr.push(dataObj);
			url += "&formatSqlJsons="+$.toJSON(dataArr);
			var win = window.open(url, "_blank");
		}else
			bc.page.print.call($page);
	}
};