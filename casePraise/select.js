bc.selectSubject = {
	init : function() {
		var $page = $(this);
	},
	clickOk : function(option) {
		var $page = $(this);
		var select = $page.find("select")[0];
		if(select.selectedIndex == -1){
			alert("必须先选投诉项目！");
			return false;
		}
		var item;
		if(select.multiple){//多选
			item=[];
			// 循环选定的每一个项目，将该项添加到列表中
			for (var i = 0; i < select.length; i++){
				if (select.options[i].selected){
					var value = select.options[i].value.split(",");
					item.push({id: value[0],name: value[1],fname: select.options[i].text});
				}
			}
		}
		$page.data("data-status",item);
		$page.dialog("close");
	}
}