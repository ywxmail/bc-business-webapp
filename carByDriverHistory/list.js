if (!bc.business)
bc.business = {};
bc.business.MoveTypeList = {
		select: function(){
			var $page = $(this);
			var extras=$page.data("extras");
			var carManId;
			var carId;
			if(typeof extras == "object"){
				carManId=extras.carManId;
				carId=extras.carId;
			}
			var url=bc.root +"/bc-business/selectMoveType";
			if(carManId)
				url+="?carManId=" + carManId;
			var option = jQuery.extend({
				url: url,
				name: "选择迁移类型",
				mid: "MoveType",
				afterClose: function(MoveType){
					if(!MoveType) return;
					
					if(MoveType.id==7){
						//迁移类型为顶班时，转化到另一个ShiftworkByDriverAction里进行处理
						var url=bc.root +"/bc-business/shiftworkByDriver/create?moveType="+MoveType.id;
						if(carManId){
							url+="&carManId=" + carManId;
						}
						var option = jQuery.extend({
							url: url,
							name:"迁移记录",
							mid: "carByDriverHistory",
							afterClose: function(MoveType){
								//重新加载列表
								bc.grid.reloadData($page);
							}
						},option);
						bc.page.newWin(option);	
					}else{
						
					var url=bc.root +"/bc-business/carByDriverHistory/create?moveType="+MoveType.id;
					if(carManId){
						url+="&carManId=" + carManId;
					}
					if(carId){
						url+="&carId=" + carId;
					}

					var option = jQuery.extend({
						url: url,
						name:"迁移记录",
						mid: "carByDriverHistory",
						afterClose: function(MoveType){
							//重新加载列表
							bc.grid.reloadData($page);
						}
					},option);
					bc.page.newWin(option);
					}	
				}
			},option);
			bc.page.newWin(option);
		}
};

