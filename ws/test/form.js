bc.wstest = {
	init : function() {
		var $form = $(this);
	},
	doOK : function() {
		var $form = $(this);
		
		//绑定选择上级的按钮事件处理
		var data = {};
		var t = $form.find(":input[name='soapAction']").val();
		if(t && t.length > 0)
			data.soapAction = t;
		
		t = $form.find(":input[name='bodyXml']").val();
		if(t && t.length > 0)
			data.bodyXml = t;
		
		t = $form.find(":input[name='idKey']").val();
		if(t && t.length > 0)
			data.idKey = t;
		
		var row = $form.find(":checked").val();
		var url = bc.root + "/bc-business/ws/test/" + (row == "1" ? "dataset":"xml");
		
		$form.find(".bc-grid").remove();
		bc.ajax({
			data:data,
			url:url,
			success:function(html){
				if(row == "1"){//grid
					//$form.find(".bc-grid").remove();
					$form.append(html);
					bc.grid.init($form);
				}else{//xml
					html =  html.replace(/</g,"&lt;").replace(/>/g,"&gt;");
					$form.find("#respone").css("height","200px").html(html);
				}
			}
		});
	}
};