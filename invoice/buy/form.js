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
		bs.invoice4BuyForm.saveInfo($page,0);
		
	},
	//保存并关闭按钮
	saveAndClose:function(){
		$page = $(this);
		bs.invoice4BuyForm.saveInfo($page,1);
	},
	//保存
	saveInfo:function($page,saveStatus){
		//验证表单必填
		if(bc.validator.validate($page)){
			//验证逻辑
			if(bs.invoice4BuyForm.autoCheckStartNoAndEndNo($page)){
				var code=$page.find(":input[name='e.code']").val();
				var startNo=$page.find(":input[name='e.startNo']").val();
				var endNo=$page.find(":input[name='e.endNo']").val();
				var id4Buy=$page.find(":input[name='e.id']").val();
				var status=$page.find("input:radio[name='e.status']:checked").val();
				var url=bc.root + "/bc-business/invoice4Buy/checkSameCode4StartNoAndEndNo";
				//验证是否可以保存
				$.ajax({
					url:url,
					dataType: "json",
					data: {code:code,startNo:startNo,endNo:endNo,id4Buy:id4Buy,status:status},
					success: function(json){
						var str="你好，保存的采购单,";
						str+="发票代码:";
						str+=code;
						str+=",";
						str+="范围[";
						str+=startNo;
						str+="-";
						str+=endNo;
						str+="]";
						if(json.checkResult==0){
							
							if(saveStatus=='0'){
								//调用标准的方法执行保存
								bc.page.save.call($page);
							}else{
								//调用标准的方法执行保存
								bc.page.save.call($page,{callback: function(json){
									$page.dialog("close");
								}});
							}
						}else if(json.checkResult==1){
							str+="和系统中相同代码的采购单范围重叠，不能保存！";
							bc.msg.confirm(str);
						}else if(json.checkResult==2){
							str+="，有相应的销售单，这采购单号码范围不能比这些销售单号码范围要少！";
							bc.msg.confirm(str);
						}else if(json.checkResult==3){
							str+="，有相应的销售单，不能作废，若作废此采购单必须先作废相应销售单！";
							bc.msg.confirm(str);
						}
					}
				});
			}
		}
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
	}
};