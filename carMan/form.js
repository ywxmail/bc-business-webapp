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
	}
};