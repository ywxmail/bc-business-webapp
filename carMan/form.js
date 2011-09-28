bc.carManForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		// 初始化多页签
		//$form.find('#formTabs').tabs(bc.page.defaultTabsOption);
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		
		if(readonly) return;
		
		//绑定选择上级的按钮事件处理
		$form.find("#selectBelong,:input[name='e.extFZJG']").click(function(){
			var data = {};
			var selected = $form.find(":input[name='e.extFZJG']").val();
			if(selected && selected.length > 0)
				data.selected = selected;
			
			bc.identity.selectUnitOrDepartment({
				data: data,
				onOk: function(actor){
					$form.find(":input[name='e.extFZJG']").val(actor.name);
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
	}
};