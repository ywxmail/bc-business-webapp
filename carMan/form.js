bc.carManForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		// 初始化多页签
		//$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		if(readonly) return;
		
		//新建时，输入身份证号，驾驶证号自动跟随其变化
		$form.find(":input[name='e.cert4Indentity']").keyup(function(){		
			if($form.find(":input[name='e.id']").val()==''){
				$form.find(":input[name='e.cert4Driving']").val($form.find(":input[name='e.cert4Indentity']").val());
			}
		});
		//点击身份证input的灯泡自动生成籍贯、区域、生日
		$form.find("#autoLoadCarManIdentityInfo").click(function(){
			if(!bc.validator.validate($form.find(":input[name='e.cert4Indentity']").parent())){
				return;
			}
			var identityId=$form.find(":input[name='e.cert4Indentity']").val();
			var url=bc.root + "/bc-business/carMan/autoLoadCarManIdentityInfo?identityId="+identityId;
			$.ajax({
				url:url,
				dataType:"json",
				success:function(json){
					$form.find(":input[name='e.origin']").val(json.origin);
					$form.find("select[name='e.region']").val(json.area);
					$form.find(":input[name='e.birthdate']").val(json.birthday);
				}
			});
			
			
		});
		
		//绑定图片的修改
		$form.find("#portrait").click(function(){
			bc.image.edit({
				puid: $form.find(":input[name='e.uid']").val(),
				ptype: "portrait",
				onOk: function(json){
					//更新图片的连接地址，注意要添加时间戳，应浏览器会缓存img的请求
					var newImgUrl = bc.root + '/bc/image/download?id=' + json.id + "&ts=" + new Date().getTime();
					$form.find("#portrait").attr("src",newImgUrl);
				}
			});
		});
		
		//鼠标移到司机头上像显示跳转到出租车协会网的按键
		$form.delegate("img",{
			mouseover : function() {
				$(this).next().show();
			},
			mouseout : function() {
				var $ul = $(this).next();
				$ul.data("hiding",true);
				setTimeout(function(){
					if($ul.data("hiding"))
						$ul.hide();
				},100);
			}
		});
		$form.delegate("ul.inputIcons.operators",{
			mouseover : function() {
				$(this).data("hiding",false);
			},
			mouseout : function() {
				var $this = $(this);
				$this.hide(600);
				$this.data("hiding",false);
			}
		});
		//点击跳转到出租车协会网的按键跳转到出租车协会网
		$form.delegate("li.toTaxiNet",{
			click : function() {
				var $this = $(this);
				var v=$this.attr("data-cert4fwzg");
				// 打开查询窗口
				bc.page.newWin({
					mid: "gztaxixhDriverInfo" + v,
					name: "出租协会" + (v ? " - " + v : ""),
					url: bc.root + "/bc-business/gztaxixh/driverInfo",
					data: {value: (v ? v : "")}
				});				
				return false;
			},
			mouseout : function() {
				$(this).parent().hide();
			}
		});
		
		// 服务资格证唯一性检测
		var $cert4FWZG = $form.find(":input[name='e.cert4FWZG']");
		$cert4FWZG.bind("blur",function(){
			var cert4FWZG = $cert4FWZG.val();
			if(!cert4FWZG || cert4FWZG.length == 0)
				return false;
			
			var $this = $(this);
			$.ajax({
				url: bc.root + "/bc-business/carMan/checkCert4FWZGIsExists",
				dataType:"json",
				data: {cert4FWZG: cert4FWZG, excludeId: $form.find(":input[name='e.id']").val()},
				success: function (json){
					if(json.isExists == "true"){ // 已被占用
						bc.msg.alert(json.msg, null ,function(){
							//$this.focus();// 重新获取焦点
						});
					}
				}
			});
		});
	},
	/** 身份证验证方法:上下文为validate对象 */
	validateIndentity: function(element, $form){
		return /^(\d{15}|(\d{17}\w{1}))$/.test(element.value);
	},
	
	//第 一次保存时重新打开表单
	save : function() {
		var $form = $(this);
		// 
		var isNew = $form.find(":input[name='e.id']").val()=="";
			
		//调用标准的方法执行保存
		bc.page.save.call($form,{callback:function(json){
			if(!isNew) return;
			
			// 关闭当前窗口
			$form.dialog("close");
			
			// 重新打开可编辑表单
			bc.page.newWin({
				name: $form.find(":input[name='e.name']").val(),
				mid: "carMan" + json.id,
				url: bc.root + "/bc-business/carMan/edit",
				data: {id: json.id},
				afterClose: function(status){
					if(status) bc.grid.reloadData($form);
				}
			});
		}});
	},
	//保存并关闭
	saveAndClose:function(){
		var $form = $(this);
		//调用标准的方法执行保存
		bc.page.save.call($form,{callback: function(json){
				$form.dialog("close");
		}});
	}
	

};