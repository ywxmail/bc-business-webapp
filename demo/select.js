bs.selectTest = {
	init : function() {
		var $page = $(this);
		
		//选择车辆(分页单选)
		$page.find("#selectPageCar").click(function(){
			bs.selectCar({
				onOk: function(car){
					logger.info($.toJSON(car));
				}
			});
		});
		
		//选择车辆(分页多选)
		$page.find("#selectPageCars").click(function(){
			bs.selectCar({
				multiple: true,
				onOk: function(cars){
					logger.info($.toJSON(cars));
				}
			});
		});
		
		//选择车辆(单选)
		$page.find("#selectCar").click(function(){
			bs.selectCar({
				paging: false,
				onOk: function(car){
					logger.info($.toJSON(car));
				}
			});
		});
		
		//选择车辆(多选)
		$page.find("#selectCars").click(function(){
			bs.selectCar({
				paging: false,
				multiple: true,
				onOk: function(cars){
					logger.info($.toJSON(cars));
				}
			});
		});
		
		//选择司机(分页单选)
		$page.find("#selectPageDriver").click(function(){
			bs.selectDriver({
				onOk: function(car){
					logger.info($.toJSON(car));
				}
			});
		});
		
		//选择司机(分页多选)
		$page.find("#selectPageDrivers").click(function(){
			bs.selectDriver({
				multiple: true,
				onOk: function(cars){
					logger.info($.toJSON(cars));
				}
			});
		});
		
		//选择司机(单选)
		$page.find("#selectDriver").click(function(){
			bs.selectDriver({
				paging: false,
				onOk: function(car){
					logger.info($.toJSON(car));
				}
			});
		});
		
		//选择司机(多选)
		$page.find("#selectDrivers").click(function(){
			bs.selectDriver({
				paging: false,
				multiple: true,
				onOk: function(cars){
					logger.info($.toJSON(cars));
				}
			});
		});
	}
};