bc.carManForm = {
	init : function() {
		var $form = $(this);
		
		// 初始化多页签
		$form.find('#formTabs').tabs({
			cache: true, 
			fx: "fast",
			create: function(event, ui) {
				//统一设置页签内容区的高度，而不是默认的自动高度，比设置内容区内容溢出时显示滚动条
				var $tabs = $(this);
				var $tabPanels = $tabs.children(".ui-tabs-panel");
				logger.info("create tabs:" + $tabs.attr("class"));
				var $nav = $tabs.children(".ui-tabs-nav");
				var ch = $tabs.height() - $nav.outerHeight(true) - ($tabPanels.outerHeight(true) - $tabPanels.height());
				$tabPanels.addClass("bc-autoScroll").height(ch);
			},
			load: function(event, ui) {
				var $gridPage = $(ui.panel).find(".bc-grid");
				logger.info("load:" + $gridPage.size());
				//对grid执行额外的初始化
			}
		});
		
		
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