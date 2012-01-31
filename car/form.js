bc.carForm = {
	init : function(option,readonly) {
		var $form = $(this);
		// 初始化多页签
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		if(readonly) return;
		
		//绑定选择上级的按钮事件处理
		$form.find("#selectBelong,:input[name='e.unit.name']").click(function(){
			var data = {};
			var selected = $form.find(":input[name='e.unit.id']").val();
			//var myId = $form.find(":input[name='e.id']").val();
			if(selected && selected.length > 0)
				data.selected = selected;//当前选择的
			//if(myId && myId.length > 0)
			//	data.exclude = myId;//排除选择自己
			
			bc.identity.selectUnit({
				data: data,
				onOk: function(actor){
					//if(myId != actor.id){
						$form.find(":input[name='e.unit.name']").val(actor.name);
						$form.find(":input[name='e.unit.id']").val(actor.id);
					//}else{
					//	alert("不能选择自己作为自己的上级！");
					//}
				}
			});
		});
		
		//绑定选择厂牌编号自动选择相应域
		$form.find("#carModels").change(function(){
			if($form.find("#carModels").val() == null || $form.find("#carModels").val() == ""){
				return;
			}
			var url = bc.root + "/bc-business/car/carModelInfo";
			$.ajax({
				url: url,
				dataType:"json",
				data: {factoryModel : $form.find("#carModels").val()},
				success: function (json){
					$form.find(":input[name='e.factoryType']").val(json.factoryType);
					$form.find(":input[name='e.engineType']").val(json.engineType);
					$form.find(":input[name='e.fuelType']").val(json.fuelType);
					$form.find(":input[name='e.displacement']").val(json.displacement);
					$form.find(":input[name='e.power']").val(json.power);
					$form.find(":input[name='e.turnType']").val(json.turnType);
					$form.find(":input[name='e.tireCount']").val(json.tireCount);
					$form.find(":input[name='e.tireFrontDistance']").val(json.tireFrontDistance);
					$form.find(":input[name='e.tireBehindDistance']").val(json.tireBehindDistance);
					$form.find(":input[name='e.tireStandard']").val(json.tireStandard);
					$form.find(":input[name='e.axisDistance']").val(json.axisDistance);
					$form.find(":input[name='e.axisCount']").val(json.axisCount);
					$form.find(":input[name='e.pieceCount']").val(json.pieceCount);
					$form.find(":input[name='e.dimLen']").val(json.dimLen);
					$form.find(":input[name='e.dimWidth']").val(json.dimWidth);
					$form.find(":input[name='e.dimHeight']").val(json.dimHeight);
					$form.find(":input[name='e.totalWeight']").val(json.totalWeight);
					$form.find(":input[name='e.accessWeight']").val(json.accessWeight);
					$form.find(":input[name='e.accessCount']").val(json.accessCount);
				}
			});
		});
		
		//绑定自动生成原车号按钮
		$form.find("#selectOriginNo").click(function(){
			if($form.find(":input[name='e.code']").val() == ""){
				bc.msg.alert("请先填写自编号!");
				return;
			}
			var url = bc.root + "/bc-business/car/autoSetOriginNo";
			$.ajax({
				url: url,
				dataType:"json",
				data: {code : $form.find(":input[name='e.code']").val()},
				success: function (json){
					$form.find(":input[name='e.originNo']").val(json.plateNo);
					if($form.find(":input[name='e.originNo']").val() != ""){
						bc.msg.slide("自动原车号获取成功!");
					}else{
						bc.msg.slide("没有找到相应的原车号!");
					}
				}
			});
		});
	}
};