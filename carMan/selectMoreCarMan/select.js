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
		//多选
		if(select.multiple==true){
		var len = select.length;
		var item =[];
		for(var i=len-1; i>=0; i--){
			if(select.options[i].selected){
				var selectArray=select.options[i].value.split(",");
				item.push({
					　id:selectArray[0],
						cert4FWZG:selectArray[1],
						   region:selectArray[2],
						   origin:selectArray[3],
						birthDate:selectArray[4],
						 workDate:selectArray[5],
					drivingStatus:selectArray[6],
						　　　　type:selectArray[7],
						　　　　name:select.options[i].text
					});
				}
			}
		}else{
			//单选
			var selectArray=select.value.split(",");
			var item=[];
			//单选
			var item={　　　　id:selectArray[0],
					cert4FWZG:selectArray[1],
					   region:selectArray[2],
					   origin:selectArray[3],
					birthDate:selectArray[4],
					 workDate:selectArray[5],
				drivingStatus:selectArray[6],
					　　　　type:selectArray[7],
					　　　　name:select.options[select.selectedIndex].text};
		}
		$page.data("data-status",item);
		$page.dialog("close");
	}
}