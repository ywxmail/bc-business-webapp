if (!bc.business)
bc.business = {};
bc.business.piLiangXiuGai= {
		create: function(){
			var $page = $(this);
			var url=bc.root +"/bc-business/batchChange/create";
			var option = jQuery.extend({
				url: url,
				name:"批量修改",
				mid: "batchChange",
				afterClose: function(){
					//重新加载列表
					bc.grid.reloadData($page);
				}
			},option);
			bc.page.newWin(option);
		
		},

};

