bs.selectMoreCar = {
	init : function() {
		var $page = $(this);
		//绑定双击事件
		$page.find("select").dblclick(function(){
			bs.selectMoreCar.clickOk.call($page[0]);
		});
		
	},
	clickOk : function() {
		var $page = $(this);
		var select = $page.find("select")[0];
		if(select.selectedIndex == -1){
			alert("必须先选择车辆信息！");
			return false;
		}
		var selectArray=select.value.split(",");
		var item=[];
		//单选
		var item={
				id: selectArray[0],
				motorcadeId:selectArray[1],
				motorcadeName:selectArray[2],
				company:selectArray[3],
				name: select.options[select.selectedIndex].text};
		$page.data("data-status",item);
		$page.dialog("close");
	}
}