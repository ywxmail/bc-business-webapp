if (!bc.business)
bc.business = {};
bc.business.chuLiDingBan= {
		create: function(){
			var $page = $(this);
			var url=bc.root +"/bc-business/shiftworkByDriver/create";
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
		
//		save: function(){
//			var $page = $(this);
//			var $select = $page.find(":input[name='plates']");
//			var url=bc.root +"/bc-business/shiftworkByDriver/save";
//			var driverId = $page.find(":input[name='driverId']").val();
//			//var carList =$select[0].options;
//			var status = $page.find(":input[name='status']:checked").val();
//			var description = $page.find(":input[name='description']").val();
//			var data = jQuery.extend({
//				driverId: driverId,
//				status: status,
//				//carList: carList,
//				status: status,
//				description: description,
//			},data);
//			$.ajax({
//				   type: "POST",
//				   url: url,
//				   data: data,
//				   success: function(){
//					   bc.msg.slide("保存成功！");  					   }
//
//				});
//		}
};

