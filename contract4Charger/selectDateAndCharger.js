bc.selectDateAndChargerForm = {
	init : function() {
		var $page = $(this);
		
		// 聚焦到合同编号框
		$page.find(":input[name='code']").focus();
		
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
		
		//检测编号的唯一性
		var $code = $page.find(":input[name='code']");
		bc.contract4ChargerForm.checkCode("",$code,function(json){
			if(json.isExist == "true"){ 
				//合同编号存在
				bc.msg.alert("所输入的合同编号已经被占用，请重新输入！");
			}else{
				// 返回
				$page.data("data-status",{
					startDate: $page.find(":input[name='startDate']").val(),
					endDate: $page.find(":input[name='endDate']").val(),
					carId: $page.find(":input[name='carId']").val(),
					takebackOrigin: $page.find(":input[name='takebackOrigin']").val(),
					assignChargerIds: assignChargerIds,
					assignChargerNames: assignChargerNames,
					code : $code.val()
				});
				$page.dialog("close");
			}
		});
	}
};