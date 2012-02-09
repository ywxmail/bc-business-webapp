bc.carManForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		// 初始化多页签
		//$form.find('#formTabs').tabs(bc.page.defaultTabsOption);
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
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
	}
};