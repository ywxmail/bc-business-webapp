bc.selectDateAndChargerForm = {
	init : function() {
		var $page = $(this);
		
		//默认就弹出日期选择框
		var $startDate = $page.find(":input[name='startDate']");
		if($startDate.val().length > 0)
			$page.find(":input[name='endDate']").focus();
		else
			$startDate.focus();
		
		/* 选择司机责任人*/
		//需要组装的li
		var liTpl = '<li class="horizontal ui-widget-content ui-corner-all ui-state-highlight" data-id="{0}">'+
		'<span class="text"><a href="#">{1}</a></span>'+
		'<span class="click2remove verticalMiddle ui-icon ui-icon-close" title={2}></span></li>';
		var ulTpl = '<ul class="horizontal"></ul>';
		var title = $page.find("#assignChargers").attr("data-removeTitle");
		
		$page.find("#addChargers").click(function() {
			var data = {};
			var $ul = $page.find("#assignChargers ul");
			var $lis = $ul.find("li");

			bs.selectCharger({
				multiple : true,
				onOk : function(chargers) {
					//var chargers = [charger];
					//添加司机责任人
					$.each(chargers,function(i,charger){
						if($lis.filter("[data-id='" + charger.id + "']").size() > 0){//已存在
							logger.info("duplicate select: id=" + charger.id + ",name=" + charger.name);
						}else{//新添加的
							if(!$ul.size()){//先创建ul元素
								$ul = $(ulTpl).appendTo($page.find("#assignChargers"));
							}
							//组装并加入对应的值
							var $liObj = $(liTpl.format(charger.id,charger.name,title)).appendTo($ul);
							//绑定删除事件
							$liObj.find("span.click2remove").click(function(){
								$(this).parent().remove();
							});
							//绑定查看事件
							$liObj.find("span.text").click(function(){
								bc.page.newWin({
									url: bc.root + "/bc-business/carMan/edit?id="+charger.id,
									name: "查看责任人信息",
									mid:  "viewCharger"
								})
							});
						}
					});
				}
			});
		});
		
		//绑定失去焦点自编号唯一性检测
		var $code = $page.find(":input[name='code']");
		$code.bind("blur",function(){
			var code = $code.val();
			if(!code || code.length == 0)
				return false;
			
			bc.contract4ChargerForm.checkCode($page,$code);
		});
		
	},
	clickOk : function(option) {
		var $page = $(this);
		
		//验证用户输入信息的正确性
		if(!bc.validator.validate($page)){
			return;
		}
		//先将角色的id合并到隐藏域
		var ids=[];
		var names=[];
		var assignChargerIds,assignChargerNames;
		$page.find("#assignChargers li").each(function(){
			ids.push($(this).attr("data-id"));
			names.push($(this).find(".text").text());
		});
		if(names != null && names.length > 0){
			assignChargerIds = ids.join(",");
			assignChargerNames = names.join(",");
		}else{
			bc.msg.alert("最少选择一个责任人！");
			return;
		}
		$page.data("data-status",{
			startDate: $page.find(":input[name='startDate']").val(),
			endDate: $page.find(":input[name='endDate']").val(),
			carId: $page.find(":input[name='carId']").val(),
			takebackOrigin: $page.find(":input[name='takebackOrigin']").val(),
			assignChargerIds: assignChargerIds,
			assignChargerNames: assignChargerNames,
			code : $page.find(":input[name='code']").val()
		});
		
		$page.dialog("close");
	}
};