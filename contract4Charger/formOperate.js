if(!window['bs'])window['bs']={};
bc.contract4ChargerFormOperate = {
	init : function(option,readonly) {
		var $form = $(this);
		
		/* 初始化多页签*/
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		/* 选择司机责任人*/
		//需要组装的li
		var liTpl = '<li class="horizontal ui-widget-content ui-corner-all ui-state-highlight" data-id="{0}">'+
		'<span class="text"><a href="#">{1}</a></span>'+
		'<span class="click2remove verticalMiddle ui-icon ui-icon-close" title={2}></span></li>';
		var ulTpl = '<ul class="horizontal"></ul>';
		var title = $form.find("#assignChargers").attr("data-removeTitle");
		
		$form.find("#addChargers").click(function() {
			var data = {};
			var $ul = $form.find("#assignChargers ul");
			var $lis = $ul.find("li");

			bs.selectCharger({
				status :'0,1',
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
									mid:  "viewCharger"+charger.id
								})
							});
						}
					});
				}
			});
		});
		
		//绑定查看责任人的按钮事件处理
		var $objs = $form.find('.horizontal').children('span.text');
		$.each($objs,function(i,obj){
			//绑定查看
			$(obj).click(function(){
				bc.page.newWin({
					url: bc.root + "/bc-business/carMan/edit?id="+$(obj).parent().attr('data-id'),
					name: "查看责任人信息",
					mid:  "viewCharger"+$(obj).parent().attr('data-id')
				})
			});
		});
		
		//只读权限控制
		if(readonly) return;
		
		//绑定删除责任人的按钮事件处理
		$.each($objs,function(i,obj){
			//绑定删除
			$(obj).next().click(function(){
				$(this).parent().remove();
			});
		});
		
		
		//日期控件设置日期范围
		//if($form.find(":input[name='e.id']").val().length <= 0){ //只能在新建时可以选择开始日期和结束日期
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
		//}
		
		//绑定失去焦点自编号唯一性检测
		var $code = $form.find(":input[name='e.code']");
		$code.bind("blur",function(){
			var code = $code.val();
			if(!code || code.length == 0)
				return false;
			
			bc.contract4ChargerFormOperate.checkCode($form.find(":input[name='e.id']").val(),$code,null);
		});
		
	},
	
	/** 编号的格式验证:上下文为validate对象,格式为CLHT+[yyyy]+[MM]+[两位流水号] */
	validateCode: function(element, $form){
		return /^CLHT\d{8}$/.test(element.value);
	},
	
	/**
	 * 绑定失去焦点自编号唯一性检测
	 */
	checkCode : function (excludeId,$code,callback){
		var url = bc.root + "/bc-business/contract4Charger/checkCodeIsExist";
		$.ajax({
			url: url,
			dataType:"json",
			data: {code : $code.val(),excludeId: excludeId},
			success: function (json){
				// 自定义回调函数
				if(typeof callback == "function"){
					return callback.call(this,json);
				}
				
				// 默认的处理
				if(json.isExist == "true"){ //合同编号存在
					//组装提示查看信息
					var tempAry = json.msg.split(" ");
					var str = tempAry[2];
					str = "<a id='chakan' href=#>"+str+"</a>";
					str = tempAry[0]+" "+tempAry[1]+" "+str+" "+tempAry[3];
					var $a = bc.msg.alert(str);
					$a.find('#chakan').click(function(){
						bc.page.newWin({
							url: bc.root + "/bc-business/contract4Charger/open?id="+json.id,
							name: "查看经济合同",
							mid:  "contract4Charger." + json.id,
							afterClose: function(){
								$code.focus();
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
		
//		var $code = $page.find(":input[name='e.code']");
//		var id = $page.find(":input[name='e.id']").val();
//		
//		if(id.length > 0){//新建id不为空做code格式检测
//			if($code.val().length > 0 && 
//			$code.val().toUpperCase().indexOf("C",0) != 0){//code不为空,并且满足代码验证
//				$code.removeAttr('data-validate');
//			}else if($code.val().length == 0 || $code.val().toUpperCase().indexOf("C",0) == 0){
//				$code.attr('data-validate','{"required":true,"method":"bc.contract4ChargerFormOperate.validateCode",'+
//				'"msg":"请输入正确的经济合同编号格式：<br/>CLHT+[4位年份]+[2位月份]+[2位流水号]"}');
//			}
//		}
		
		//先将角色的id合并到隐藏域
		var ids=[];
		var names=[];
		$page.find("#assignChargers li").each(function(){
			ids.push($(this).attr("data-id"));
			names.push($(this).find(".text").text());
		});
		if(names != null && names.length > 0){
			$page.find(":input[name=assignChargerIds]").val(ids.join(","));
			$page.find(":input[name=assignChargerNames]").val(names.join(","));
		}else{
			bc.msg.alert("最少选择一个责任人！");
			return false;
		}
		
		if($page.find(":hidden[name='isSaved']").val() == "true"){
			//唯一性检测
			var option = { callback : function (json){
					if(json.success){
						bc.msg.slide(json.msg);
					}else{
						bc.msg.alert(json.msg);
					}
					return false;
				}
			};
			//调用标准的方法执行保存
			bc.page.save.call(this,option);
		}else{
			//执行操作处理
			var $form = $("form",$page);
			var data = $form.serialize();
			if(!bc.validator.validate($form))
				return;
			bc.ajax({
				url: bc.root + "/bc-business/contract4ChargerOperate2/save",
				dataType: "json",
				data: data,
				success: function(json){
					logger.info("doLogout result=" + $.toJSON(json));
					//完成后提示用户
					if(json.success){
						bc.msg.alert(json.msg);
						$page.data("data-status","saved");
						$page.find(":hidden[name='isSaved']").val("true");
						$page.find(":hidden[name='e.id']").val(json.id);
					}else{
						bc.msg.info(json.msg);
					}
					return false;
				}
			});
		}

	},
	//保存并关闭
	saveAndClose:function(){
		$page = $(this);
		
//		var $code = $page.find(":input[name='e.code']");
//		var id = $page.find(":input[name='e.id']").val();
//		
//		if(id.length > 0){//新建id不为空做code格式检测
//			if($code.val().length > 0 && 
//			$code.val().toUpperCase().indexOf("C",0) != 0){//code不为空,并且满足代码验证
//				$code.removeAttr('data-validate');
//			}else if($code.val().length == 0 || $code.val().toUpperCase().indexOf("C",0) == 0){
//				$code.attr('data-validate','{"required":true,"method":"bc.contract4ChargerFormOperate.validateCode",'+
//				'"msg":"请输入正确的经济合同编号格式：<br/>CLHT+[4位年份]+[2位月份]+[2位流水号]"}');
//			}
//		}
		
		//先将角色的id合并到隐藏域
		var ids=[];
		var names=[];
		$page.find("#assignChargers li").each(function(){
			ids.push($(this).attr("data-id"));
			names.push($(this).find(".text").text());
		});
		if(names != null && names.length > 0){
			$page.find(":input[name=assignChargerIds]").val(ids.join(","));
			$page.find(":input[name=assignChargerNames]").val(names.join(","));
		}else{
			bc.msg.alert("最少选择一个责任人！");
			return false;
		}
		
		if($page.find(":hidden[name='isSaved']").val() == "true"){
			//唯一性检测
			var option = { callback : function (json){
					if(json.success){
						bc.msg.slide(json.msg);
						$page.dialog("close");
					}else{
						bc.msg.alert(json.msg);
					}
					return false;
				}
			};
			//调用标准的方法执行保存
			bc.page.save.call(this,option);
		}else{
			//执行操作处理
			var $form = $("form",$page);
			var data = $form.serialize();
			if(!bc.validator.validate($form))
				return;
			bc.ajax({
				url: bc.root + "/bc-business/contract4ChargerOperate2/save",
				dataType: "json",
				data: data,
				success: function(json){
					logger.info("doLogout result=" + $.toJSON(json));
					
					//完成后提示用户
					if(json.success){
						bc.msg.alert(json.msg);
						$page.data("data-status","saved");
						$page.find(":hidden[name='isSaved']").val("true");
						$page.find(":hidden[name='e.id']").val(json.id);
						$page.dialog("close");
					}else{
						bc.msg.info(json.msg);
					}
					return false;
				}
			});
		}
	}

};