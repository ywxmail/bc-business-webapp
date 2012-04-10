if (!bc.business)
bc.business = {};
bc.business.piLiangXiuGai= {
		create: function(){
			var $page = $(this);
			var data=null;
			var $tds = $page.find(".bc-grid>.data>.left tr.ui-state-highlight>td.id");
			if($tds.length == 1){
				data = "id=" + $tds.attr("data-id");
			}else if($tds.length > 1){
				data = "ids=";
				$tds.each(function(i){
					data += $(this).attr("data-id") + (i == $tds.length-1 ? "" : ",");
				});
			}
			if(logger.infoEnabled) logger.info("bc.page.delete_: data=" + data);
			var url=bc.root +"/bc-business/batchChange/create";
			var option = jQuery.extend({
				url: url,
				data:data,
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

