bc.selectCert = {
	init : function() {
		var $page = $(this);
	},
	clickOk : function(option) {
		var $page = $(this);
		var select = $page.find("select")[0];
		if(select.selectedIndex == -1){
			alert("必须先选证件类型！");
			return false;
		}else{
			var item;
			item={id: select.value,name: select.options[select.selectedIndex].text};
			$page.data("data-status",item);
			$page.dialog("close");
		}
	}
}