bc.namespace("bs");
bs.infoCenter = {
	init : function(option, readonly) {
		var $page = $(this);

		// 默认聚焦到查询输入框
		$page.find("input#searchText").focus();

		// 车辆列表的样式控制
		$page.find("ul#results").delegate("li:not(.empty)",{
			mouseover : function() {
				$(this).addClass("ui-state-hover");
			},
			mouseout : function() {
				$(this).removeClass("ui-state-hover");
			},
			click : function() {
				var $this = $(this);
				$this.toggleClass("ui-state-highlight", true).siblings(
						".ui-state-highlight").toggleClass(
						"ui-state-highlight", false);
				bs.infoCenter.showCar.call($this,$this.attr("data-id"));
			}
		});

		// 提醒信息列表的样式控制
		$page.find("table#messages").delegate("tr:not(.header)",{
			mouseover : function() {
				$(this).addClass("ui-state-hover");
			},
			mouseout : function() {
				$(this).removeClass("ui-state-hover");
			},
			click : function() {
				var $this = $(this);
				$this.toggleClass("ui-state-highlight", true).siblings(
						".ui-state-highlight").toggleClass(
						"ui-state-highlight", false);
			}
		});

		// 定位左侧最下面的元素的top位置
		var sh = 0;
		var $left = $page.find("#left");
		$left.children(".block").each(function() {
			sh += $(this).outerHeight(true);
		});
		logger.info("sh=" + sh);
		$left.children(".results").css("top", sh);

	},

	/** 执行模糊查询处理 */
	doSearch : function() {
		var $page = $(this);
		logger.info("bs.infoCenter.doSearch");
	},

	/** 选择分公司或车队后的回调处理 */
	doSearchByUnitAndMotorcade : function() {
		var $left = $(this).closest("#left");
		var unitId = $left.find("#unitId").val();
		var motorcadeId = $left.find("#motorcadeId").val();
		logger.info("unitId=" + unitId + ",motorcadeId=" + motorcadeId);
		
		if(unitId.length == 0 && motorcadeId.length == 0){//清空处理
			$left.find("#count").text(" (0)");
			$left.find("#results").html('<li class="empty">(无匹配项)</li>');
			return false;
		}
		
		// 显示正在查询动画
		var startTime = new Date().getTime();
		$left.find("#count").text(" (0)");
		$left.find("#results").html('<li class="empty busy"><span class="busy"></span><span class="text">正在查询...</span></li>');

		// 获取车辆信息
		bc.ajax({
			url : bc.root + "/bc-business/infoCenter/findCarsByUnitAndMotorcade",
			data : {unitId : unitId,motorcadeId : motorcadeId},
			dataType : "json",
			success : function(cars) {
				$left.find("#count").html(" (" + cars.length +"台)<span class='wasteTime'> " + bc.getWasteTime(startTime) + "</span>");
				var $results = $left.find("#results");

				// 如果找不到就提示
				if(cars.length == 0){
					bc.msg.slide("没有找到符合条件的车辆信息！");
					$results.html('<li class="empty">(无匹配项)</li>');
					return;
				}
				
				// 显示返回的车辆列表信息
				var lis = [];
				for(var i=0;i<cars.length;i++){
					lis.push('<li data-id="'+cars[i].id+'" title=["'+cars[i].code+"]"+cars[i].plate+'">[<span class="code ellipsis">'+cars[i].code+'</span>]<span class="plate">'+cars[i].plate+'</span></li>');
				}
				$results.empty().append(lis.join(""));
			}
		});
	},
	
	/** 显示车辆的详细信息
	 * 上下文为li元素
	 */
	showCar: function(carId){
		if(carId == bs.infoCenter.currentCarId)
			return;
		logger.info("carId=" + carId + ",preCarId=" + bs.infoCenter.currentCarId);
		bs.infoCenter.currentCarId = carId;// 记录当前正在处理的车辆id，避免重复点击的请求
		
		var $li = $(this);
		var $right = $li.closest("#left").siblings("#right");
		
		// 显示正在查询动画
		var startTime = new Date().getTime();
		var $carHeader = $right.find("#carHeader").addClass("loading");
		var $carTitle = $carHeader.find("#carTitle").html('正在查询...');
		
		// 清空内容
		$right.find("input[type='text'],textarea").val("");
		var $messages = $right.find("#messages").addClass("empty");
		$messages.find("tr:not(.header)").remove();
		$right.find("#mans>.content").remove();

		// 获取车辆详细信息
		bc.ajax({
			url : bc.root + "/bc-business/infoCenter/findCarDetail",
			data : {carId : carId},
			dataType : "json",
			success : function(json) {
				if(json.id != bs.infoCenter.currentCarId)
					return;
				
				// 关闭加载动画
				$carHeader.removeClass("loading");
				
				// 失败就提示
				if(!json.success){
					bc.msg.slide("没有找到车辆的相关信息！");
					return;
				}
				
				// 显示车牌及查询时间
				$carTitle.text($li.children(".plate").text());
				$carTitle.next().text(" (" + bc.getWasteTime(startTime) + ")");
				
				// 显示车辆信息
				
				// 显示提醒信息
				//$messages.removeClass("empty");
				
				// 显示司机信息
			}
		});
	},
	currentCarId:0
};