if (!bc.business)
bc.business = {};
bc.business.MoveTypeList = {
		select: function(){
			var $page = $(this);
			var url=bc.root +"/bc-business/selectMoveType";
			var option = jQuery.extend({
				url: url,
				name: "选择迁移类型",
				mid: "MoveType",
				afterClose: function(MoveType){
					var url=bc.root +"/bc-business/carByDriverHistory/create?moveType="+MoveType.id;
					var option = jQuery.extend({
						url: url,
						name: "迁移记录",
						mid: "carByDriverHistory",
						afterClose: function(MoveType){
							//重新加载列表
							bc.grid.reloadData($page);
						}
					},option);
					bc.page.newWin(option);
					
				}
			},option);
			bc.page.newWin(option);
		}
};

