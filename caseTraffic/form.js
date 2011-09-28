if(!window['bs'])window['bs']={};
bc.caseTrafficForm = {
	init : function() {
		var $form = $(this);
		
		// 初始化多页签
		//$form.find('#formTabs').tabs();
		
		//绑定车队事件
		$form.find(":input[name='e.motorcadeId']").change(function(){
			var $select = $(this);
			var name = $select.find("option:selected").text();
			$form.find(":hidden[name='e.motorcadeName']").val(name);
		});
		
		// 选择车辆车牌
		$form.find(":input[name='e.carPlate']").click(function() {
			var selecteds = $form.find(":input[name='e.carPlate']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.carId']").val(car.id);
					$form.find(":input[name='e.carPlate']").val(car.plate);
				}
			});
		});
		
		// 选择司机
		$form.find(":input[name='e.driverName']").click(function() {
			var selecteds = $form.find(":input[name='e.driverName']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(carMan) {
					$form.find(":input[name='e.driverId']").val(carMan.id);
					$form.find(":input[name='e.driverName']").val(carMan.name);
				}
			});
					
		});
		
		
		// 责任人
		$form.find(":input[name='e.chargerName']").click(function() {
			var selecteds = $form.find(":input[name='e.chargerName']").val();
			bs.selectCharger({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(carMan) {
					$form.find(":input[name='e.chargerId']").val(carMan.id);
					$form.find(":input[name='e.chargerName']").val(carMan.name);
				}
			});
		});
		
		// 绑定邮递日期事件
		$form.find(":checkbox[name='e.deliver']").change(function() {
			if(this.checked){
				$form.find('#tdTitle1').css("visibility","visible");
				$form.find('#tdValue1').css("visibility","visible");
			}else{
				$form.find('#tdTitle1').css("visibility","hidden");
				$form.find('#tdValue1').css("visibility","hidden");
			}
		});
		
		// 绑定签领日期事件
		$form.find(":checkbox[name='e.sign']").change(function() {
			if(this.checked){
				$form.find('#tdTitle2').css("visibility","visible");
				$form.find('#tdValue2').css("visibility","visible");
			}else{
				$form.find('#tdTitle2').css("visibility","hidden");
				$form.find('#tdValue2').css("visibility","hidden");
			}
		});
	},
	
    closefile : function(){
		var $form = $(this);
	    bc.msg.confirm("确定要结案吗？",function(){
			var url = "/bc-business/caseTraffic/closefile";
			$.ajax({ url: url,dataType:"json", success: update_page});
			function update_page(json){
				if(json.status != null && json.status == 1){
					$form.find(":input[name='e.status']").val("1");
					$form.find(":input[name='e.closeDate']").val(json.closeDate);
					$form.find('#divTitle').css("visibility","visible");
					$form.find('#divValue').css("visibility","visible");
					bc.msg.slide("结案成功,请保存！");
//					alert('当前上下文:   \n'+ $form.html());
//					var $button = $("span:contains('结案')").parent();
//					alert('结案的爸爸:   \n'+$button.html());
//					alert('结案的爸爸的爸爸:   \n'+$button.parent().html());
//					return false;
				}
			}
	    });
	}
};