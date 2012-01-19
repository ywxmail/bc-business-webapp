bc.selectContract = {
	init : function() {
		var $page = $(this);
		//绑定双击事件
		$page.find("select").dblclick(function(){
			bc.selectContract.clickOk.call($page[0]);
		});
	},
	clickOk : function(option) {
		var $page = $(this);
		var select = $page.find("select")[0];
		if(select.selectedIndex == -1){
			alert("必须先选合同类型！");
			return false;
		}else{
			var item;
			item={id: select.value,name: select.options[select.selectedIndex].text};
			$page.data("data-status",item);
			$page.dialog("close");
		}
	}
}