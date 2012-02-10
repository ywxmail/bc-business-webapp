bc.carForm = {
	init : function(option,readonly) {
		var $form = $(this);
		// 初始化多页签
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		if(readonly) return;
		
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
						bc.msg.slide("自动获取原车号成功!");
					}else{
						bc.msg.slide("没有找到相应的原车号!");
					}
				}
			});
		});
		
		// 车牌号唯一性检测
		var $plateNo = $form.find(":input[name='e.plateNo']");
		$plateNo.bind("blur",function(){
			var plateNo = $plateNo.val();
			if(!plateNo || plateNo.length == 0)
				return false;
			
			bc.carForm.checkPlateNo($form,$plateNo);
		});
	},
	
	checkPlateNo:function($form,$plateNo){
		$.ajax({
			url: bc.root + "/bc-business/car/checkPlateIsExists",
			dataType:"json",
			data: {plateNo: $plateNo.val(), plateType: $form.find(":input[name='e.plateType']").val(), excludeId: $form.find(":input[name='e.id']").val()},
			success: function (json){
				if(json.isExists == "true"){ // 已被占用
					//组装提示查看信息
					var tempAry = json.msg.split(" ");
					var str = tempAry[2];
					str = "<a id='chakan' href=#>"+str+"</a>";
					str = tempAry[0]+" "+tempAry[1]+" "+str+" "+tempAry[3];
					var $a = bc.msg.alert(str);
					$a.find('#chakan').click(function(){
						bc.page.newWin({
							url: bc.root + "/bc-business/car/edit?id="+json.id,
							name: "编辑车辆",
							mid:  "edit4Car",
							afterClose: function(){
								$plateNo.focus();
							}
						})
						$a.dialog("close");
					});
				}
			}
		});
	},
	
	//保存的处理
	save:function(){
		$page = $(this);
		
		//唯一性检测
		var option = { callback : function (json){
				bc.msg.slide(json.msg);
				return false;
			}
		};
		//调用标准的方法执行保存
		bc.page.save.call(this,option);
	}
};