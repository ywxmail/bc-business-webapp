if (!bc.business)
bc.business = {};
bc.business.chuLiDingBan= {
		create: function(){
			var $page = $(this);
			var url=bc.root +"/bc-business/shiftworkByDriver/create";
			var option = jQuery.extend({
				url: url,
				name:"批量处理顶班",
				mid: "shiftworkByDriver",
				afterClose: function(MoveType){
					//重新加载列表
					bc.grid.reloadData($page);
				}
			},option);
			bc.page.newWin(option);
			
		
		}
};

