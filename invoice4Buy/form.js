if(!window['bs'])window['bs']={};
bs.invoice4BuyForm = {
	init : function(option,readonly)  {
		var $form = $(this);
		//加载一次单位显示
		$form.find("#eachCountName").html($form.find("select[name='e.unit']")[0]
			.options[$form.find("select[name='e.unit']")[0].selectedIndex].text);
		
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
		
		//当选择打印票时，单位为卷，但选择手撕票时，单位为本
		$form.find("select[name='e.type']").change(function(){
			var unit=$form.find("select[name='e.unit']")[0];
			for(var i=0;i<unit.options.length;i++){
				if(unit.options[i].value == this.value){
					unit.options[i].selected = true;
					$form.find("#eachCountName").html(unit.options[i].text);
					break;
				}
			}
		});
		
		//当选择打印票时，单位为卷，但选择手撕票时，单位为本
		$form.find("select[name='e.unit']").change(function(){
			$form.find("#eachCountName").html(this.options[this.selectedIndex].text);
		});
		
	},
	save:function(){
		$page = $(this);
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
							//调用标准的方法执行保存
							bc.page.save.call($page);
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
						bc.msg.alert("你好，你填写的开始号和结束号之差不能整除每份每份数量，请修正！");
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