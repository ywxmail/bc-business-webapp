if(!window['bs'])window['bs']={};
bc.caseAccidentForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		if(readonly) return;
		// 初始化多页签
        $form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		if(readonly) return;
		//绑定车队事件
		$form.find(":input[name='e.motorcadeId']").change(function(){
			var $select = $(this);
			var name = $select.find("option:selected").text();
			$form.find(":hidden[name='e.motorcadeName']").val(name);
		});
		
		// 选择车辆车牌
		$form.find("#carPlate").click(function() {
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
		$form.find("#driverName").click(function() {
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
		//经办人
		$form.find(":input[name='e.receiverName']").click(function(){
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
				$form.find('#deliverDate2Title').css("visibility","visible");
				$form.find('#deliverDate2Value').css("visibility","visible");
				$form.find('#deliverMoneyTitle').css("visibility","visible");
				$form.find('#deliverMoneyValue').css("visibility","visible");
			}else{
				$form.find('#deliverDate2Title').css("visibility","hidden");
				$form.find('#deliverDate2Value').css("visibility","hidden");
				$form.find('#deliverMoneyTitle').css("visibility","hidden");
				$form.find('#deliverMoneyValue').css("visibility","hidden");
			}
		});
		
		// 绑定是否保险公司是否赔款事件
		$form.find(":checkbox[name='e.claim']").change(function() {
			if(this.checked){
				$form.find('#claimDateTitle').css("visibility","visible");
				$form.find('#claimDateValue').css("visibility","visible");
				$form.find('#claimCodeTitle').css("visibility","visible");
				$form.find('#claimCodeValue').css("visibility","visible");
				$form.find('#claimNo1Title').css("visibility","visible");
				$form.find('#claimNo1Value').css("visibility","visible");
			}else{
				$form.find('#claimDateTitle').css("visibility","hidden");
				$form.find('#claimDateValue').css("visibility","hidden");
				$form.find('#claimCodeTitle').css("visibility","hidden");
				$form.find('#claimCodeValue').css("visibility","hidden");
				$form.find('#claimNo1Title').css("visibility","hidden");
				$form.find('#claimNo1Value').css("visibility","hidden");
			}
		});
		
		// 绑定签领日期事件
		$form.find(":checkbox[name='e.pay']").change(function() {
			if(this.checked){
				$form.find('#pay').css("visibility","visible");
			}else{
				$form.find('#pay').css("visibility","hidden");
			}
		});
	},
	
    closefile : function(){
		var $form = $(this);
		var $page = $(this).next();
	    bc.msg.confirm("确定要结案吗？",function(){
			var url =bc.root +"/bc-business/caseAccident/closefile";
			$.ajax({ url: url,dataType:"json", success: update_page});
			function update_page(json){
				if(json.status != null && json.status == 1){
					$form.find(":input[name='e.status']").val("1");
					$form.find(":input[name='e.closeDate']").val(json.closeDate);
					$form.find(":input[name='e.closerId']").val(json.closerId);
					$form.find(":input[name='e.closerName']").val(json.closerName);
					$form.find('#divTitle').css("visibility","visible");
					$form.find('#divValue').css("visibility","visible");
					$page.parent().find("#bcSaveDlgButton").button("disable");
					bc.msg.slide("结案成功,请保存！");

				}
			}
	    });
	}
};