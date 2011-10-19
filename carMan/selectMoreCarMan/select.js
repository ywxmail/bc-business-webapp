bs.selectMoreCarMan = {
	init : function() {
		var $page = $(this);
		//绑定双击事件
		$page.find("select").dblclick(function(){
			bs.selectMoreCarMan.clickOk.call($page[0]);
		});
		
	},
	clickOk : function() {
		var $page = $(this);
		var select = $page.find("select")[0];
		if(select.selectedIndex == -1){
			alert("必须先选择司机信息！");
			return false;
		}
		var item;
		var item=[];
		//单选
		var item={id: select.value.split(",")[0],cert4FWZG:select.value.split(",")[1],region:select.value.split(",")[2],
				drivingStatus:select.value.split(",")[3],name: select.options[select.selectedIndex].text};
		$page.data("data-status",item);
		$page.dialog("close");
	}
}