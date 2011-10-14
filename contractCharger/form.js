if(!window['bs'])window['bs']={};
bc.contractChargerForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		/* 初始化多页签*/
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		if(readonly) return;
		
		/* 选择车辆车牌*/
		$form.find(":input[name='e.ext_str1']").click(function() {
			var selecteds = $form.find(":input[name='carId']").val();
			bs.selectCar({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(car) {
					$form.find(":input[name='e.ext_str1']").val(car.plate);
					$form.find(":input[name='carId']").val(car.id);
				}
			});
		});
		
		/* 选择经办人*/
		$form.find(":input[name='e.transactorName']").click(function(){
			bc.identity.selectUser({
				selecteds: $form.find(":input[name='e.transactorId']").val(),
				onOk : function(user) {
					$form.find(":input[name='e.transactorName']").val(user.name);
					$form.find(":input[name='e.transactorId']").val(user.id);
				}
			});
		});
		
		//日期控件设置日期范围
		var dates = $form.find(':input[name^="e.startDate"], :input[name^="e.endDate"]').datepicker({
			changeYear:     true,
			firstDay: 		7,
			dateFormat:		"yy-mm-dd",//yy4位年份、MM-大写的月份
			onSelect: function( selectedDate ) {
				var option = this.name == "e.startDate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
		
		/* 选择司机责任人*/
		//需要组装的li
		var liTpl = '<li class="horizontal ui-widget-content ui-corner-all ui-state-highlight" data-id="{0}">'+
		'<span class="text">{1}</span>'+
		'<span class="click2remove verticalMiddle ui-icon ui-icon-close" title={2}></span></li>';
		var ulTpl = '<ul class="horizontal"></ul>';
		var title = $form.find("#assignChargers").attr("data-removeTitle");
		
		$form.find("#addChargers").click(function() {
			var data = {};
			var $ul = $form.find("#assignChargers ul");
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
								$ul = $(ulTpl).appendTo($form.find("#assignChargers"));
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
		
		//绑定查看,删除责任人的按钮事件处理
		var $objs = $form.find('.horizontal').children('span.text');
		$.each($objs,function(i,obj){
			//绑定查看
			$(obj).click(function(){
				bc.page.newWin({
					url: bc.root + "/bc-business/carMan/edit?id="+$(obj).parent().attr('data-id'),
					name: "查看责任人信息",
					mid:  "viewCharger"
				})
			});
			//绑定删除
			$(obj).next().click(function(){
				$(this).parent().remove();
			});
		});
		
		
	},
	
	//保存的处理
	save:function(){
		$page = $(this);
		//先将角色的id合并到隐藏域
		var ids=[];
		var names=[];
		$page.find("#assignChargers li").each(function(){
			ids.push($(this).attr("data-id"));
			names.push($(this).text());
		});
		if(names != null && names.length > 0){
			$page.find(":input[name=assignChargerIds]").val(ids.join(","));
			$page.find(":input[name=assignChargerNames]").val(names.join(","));
		}else{
			bc.msg.slide("最少选择一个责任人！");
			return false;
		}
		
		//调用标准的方法执行保存
		bc.page.save.call(this);
	}
		
		
		

/**		
		// 选择司机责任人
		//需要组装的li
		var liTpl = '<li class="horizontal ui-widget-content ui-corner-all ui-state-highlight" data-id="{0}">'+
		'<span class="text">{1}</span>'+
		'<span class="click2remove verticalMiddle ui-icon ui-icon-close" title={2}></span></li>';
		var ulTpl = '<ul class="horizontal"></ul>';
		var title = $form.find("#assignChargers").attr("data-removeTitle");
		
		$form.find("#addChargers").click(function() {
			var $ul = $form.find("#assignChargers ul");
			var $lis = $ul.find("li");

			bs.selectCharger({
				multiple : true,
				onOk : function(chargers) {
					//onOk : function(charger) {  未修改选择司机责任人方法的时候chargers传进来是单个对象所以要转成数组遍历
					//var chargers = [charger];
					if(chargers.length > 2){
						bc.msg.slide("最多只能选择两个,请筛选!");
					}else if(chargers.length == 2){
						$ul.empty();
						$.each(chargers,function(i,charger){
							var index = i+1;
							var cid	 = "e.changerId"+index;
							var cname = "e.changerName"+index;
							//组装并加入对应的值
							var $liObj = $(liTpl.format(charger.id,charger.name,title)).appendTo($ul);
							
							bc.contractChargerForm.setup($form,$liObj,cid,cname);
							
							$form.find(":input[name='"+cid+"']").val(charger.id);
							$form.find(":input[name='"+cname+"']").val(charger.name);
							
							if(i == 1)
								return false;
						});
					}else if(chargers.length == 1){
						var $lis = $ul.children();
						var index;
						var cid,cname;
						if($lis.size() <= 1){
							//加一个
							index = $lis.size() ==0 ? 1 :2;
							cid	 = "e.changerId"+index;
							cname = "e.changerName"+index;
						}else{
							//删除最后那个
							index = 2;
							cid	 = "e.changerId"+index;
							cname = "e.changerName"+index;
							$($lis[1]).remove();
							$form.find(":input[name='"+cid+"']").val("");
							$form.find(":input[name='"+cname+"']").val("");
						}
						
						//加上去
						var charger = chargers[0];
						var $liObj = $(liTpl.format(charger.id,charger.name,title)).appendTo($ul);
						
						bc.contractChargerForm.setup($form,$liObj,cid,cname);
						
						$form.find(":input[name='"+cid+"']").val(charger.id);
						$form.find(":input[name='"+cname+"']").val(charger.name);
					}
						
				}
			});
		});
		
		//绑定查看,删除责任人的按钮事件处理
		var $objs = $form.find('.horizontal').children('span.text');
		$.each($objs,function(i,obj){
			//绑定查看
			$(obj).click(function(){
				bc.page.newWin({
					url: bc.root + "/bc-business/carMan/edit?id="+$(obj).parent().attr('data-id'),
					name: "查看责任人信息",
					mid:  "viewCharger"
				})
			});
			
			//绑定删除
			$(obj).next().click(function(){
				var id = $(this).parent().attr('data-id');
				$form.find(":input[value='"+id+"']").next().val("");
				$form.find(":input[value='"+id+"']").val("");
				$(this).parent().remove();
			});
		});
		
		//绑定删除责任人的按钮事件处理
		//$form.find("span.click2remove").click(function(){
		//	$(this).parent().remove();
		//});
		
	},
	//保存的处理
	save : function(){
		$page = $(this);
		if(($page.find(":input[name='e.changerId1']").val().length > 0 &&
			$page.find(":input[name='e.changerId1']").val().length != null) ||
			($page.find(":input[name='e.changerId2']").val().length > 0 &&
			$page.find(":input[name='e.changerId2']").val().length != null)
			){
			//调用标准的方法执行保存
			bc.page.save.call(this);
		}else{
			bc.msg.slide("最少选择一个责任人！");
		}
	},
	
	setup : function(page,obj,cid,cname){
		var $form  = page;
		var $liObj = obj;
		//绑定删除事件
		$liObj.find("span.click2remove").click(function(){
			$form.find(":input[name='"+cid+"']").val("");
			$form.find(":input[name='"+cname+"']").val("");
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
**/
};