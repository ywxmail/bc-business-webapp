if (!bc.business)
bc.business = {};
bc.business.chuLiDingBan= {
		create: function(){
			var $page = $(this);
			var extras=$page.data("extras");
			var carManId;
			if(typeof extras == "object"){
				carManId=extras.carManId;
			}
			var url=bc.root +"/bc-business/shiftworkByDriver/create";
			if(carManId)
				url+="?carManId=" + carManId;
			var option = jQuery.extend({
				url: url,
				name:"顶班迁移记录",
				mid: "shiftworkByDriver",
				afterClose: function(){
					//重新加载列表
					bc.grid.reloadData($page);
				}
			},option);
			bc.page.newWin(option);
		
		},

};

