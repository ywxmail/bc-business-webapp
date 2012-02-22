bc.namespace("bs");
bs.infoCenter = {
	ts: new Date().getTime(),
	init : function(option, readonly) {
		var $page = $(this);
		bs.infoCenter.currentCarId = null;

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
		
		// 车辆信息：点击更多按钮打开车辆表单
		var $main = $page.find("#main");
		$main.find("#seeMore").click(function(){
			if(!bs.infoCenter.currentCarId){
				bc.msg.slide("请先选择相应的车辆！");
			}else{
				bc.page.newWin({
					name: $main.find("#carTitle").text(),
					mid: "car" + bs.infoCenter.currentCarId,
					url: bc.root + "/bc-business/car/open",
					data: {id: bs.infoCenter.currentCarId}
				});
			}
			return false;
		});
		// 车辆信息、联系信息：点击折叠展开
		$page.find(".toggleShow").click(function(){
			var $this = $(this).toggleClass("ui-icon-triangle-1-s ui-icon-triangle-1-n");
			if($this.hasClass("ui-icon-triangle-1-s")){
				$this.closest(".header").next().show();
				$this.attr("title","点击折叠");
			}else{
				$this.closest(".header").next().hide();
				$this.attr("title","点击展开");
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
		logger.debug("sh=" + sh);
		$left.children(".results").css("top", sh);

		//搜索框回车执行搜索
		$left.find("#searchText").keyup(function(e) {
			if(e.which == 13){//按下回车键
				bs.infoCenter.doSearch.call($page);
			}
		});
	},

	/** 获取车辆列表信息并显示 */
	findCars : function($left,url,data) {
		// 显示正在查询动画
		var startTime = new Date().getTime();
		$left.find("#count").text(" (0)");
		$left.find("#results").html('<li class="empty busy"><span class="busy"></span><span class="text">正在查询...</span></li>');
		
		// 执行查询
		bc.ajax({
			url : url,
			data : data,
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
					lis.push('<li data-id="'+cars[i].id+'"'
						+' title="['+cars[i].code+']'+cars[i].plate
						+(cars[i].status == 1 ? ' - 此车已注销" class="ui-state-disabled"' : '"')
						+' data-json=\'' + $.toJSON(cars[i]) + '\''
						+'>[<span class="code ellipsis">'+cars[i].code
						+'</span>]<span class="plate">'+cars[i].plate+'</span></li>');
				}
				$results.empty().append(lis.join(""));
			}
		});
	},

	/** 执行模糊查询处理 */
	doSearch : function() {
		var $left = $(this).find("#left")
		
		// 检测查询条件
		var searchType = $left.find("#searchTypeValue").val();
		var searchText = $left.find("#searchText").val();
		logger.info("bs.infoCenter.doSearch:searchType=" + searchType + ",searchText=" + searchText);
		if($.trim(searchText) == ""){
			bc.msg.slide("查询条件不能为空");
			$left.find("#searchText").focus();
			return;
		}
		
		// 执行查询
		bs.infoCenter.findCars($left
			,bc.root + "/bc-business/infoCenter/findCarsBySearchText"
			,{searchType : searchType,searchText : searchText});
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
		
		// 执行查询
		bs.infoCenter.findCars($left
			,bc.root + "/bc-business/infoCenter/findCarsByUnitAndMotorcade"
			,{unitId : unitId,motorcadeId : motorcadeId});
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
		$right.find("input[type='checkbox']").each(function(){this.checked = false;});
		var $messages = $right.find("#messages").addClass("empty");
		$messages.find("#msgsBody > tr:not(.header)").remove();
		var $mans = $right.find("#mans").addClass("empty");
		$mans.find("#mansBody").empty();

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
				var $main = $right.children("#main");
				for(var key in json.car){
					$main.find(":input[name='main." + key + "']").val(json.car[key]);
				}
				if(json.car.includeCost) $main.find(":input[name='main.includeCost']")[0].checked = true;
				if(json.car.zb) $main.find(":input[name='main.zb']")[0].checked = true;

				
				// 显示提醒信息
				var msgs = json.messages;
				if(msgs.length > 0){
					$messages.removeClass("empty");
					var trs = [];
					for(var i=0;i<msgs.length;i++){
						trs.push('<tr class="ui-widget-content middle row'+(i%2 == 0 ? " odd" : " even") +'">'
							+'<td class="first ui-widget-content">' + msgs[i].module + '</td>'
							+'<td class="middle ui-widget-content">' + msgs[i].limit + '</td>'
							+'<td class="middle ui-widget-content">' + msgs[i].link + '</td>'
							+'<td class="middle ui-widget-content">' + msgs[i].subject + '</td>'
							+'<td class="last ui-widget-content">' + msgs[i].date + '</td>'
							+'</tr>');
					}
					$messages.find("#msgsBody").append(trs.join(""));
				}
				
				// 显示司机信息
				var mans = json.mans;
				if(mans.length > 0){
					$mans.removeClass("empty");
					var trs = [],man,ts = bs.infoCenter.ts; 
					for(var i=0;i<mans.length;i++){
						man = mans[i];
						// 抬头行
						trs.push('<tr class="top header'+(i==0 ? " first" : "") + (man.status!=0 ? " ui-state-disabled" : "") + '">'
							+'<td class="first aright ui-widget-content" style="width: 90px">' + man.type + ':</td>'
							+'<td class="middle aleft ui-widget-content" style="width: 80px">' + man.name + '(' + man.sex + ')' + '</td>'
							+'<td class="middle aright ui-widget-content" style="width: 40px">电话:</td>'
							+'<td class="last aleft ui-widget-content" style="width: 190px">' + man.phones + '</td>'
							+'<td class="middle aright ui-widget-content" style="width: 40px">状态:</td>'
							+'<td class="last aleft ui-widget-content">' + (man.classes.length > 0 ? man.classes + "，" : "") + man.moveType + '(' + man.moveDate + ')' + '</td>'
							+'</tr>');
						
						// 司机详细资料
						trs.push('<tr class="detail"><td colspan="6" style="padding:0;">'
							+'<table class="contentTable" cellspacing="2" cellpadding="0" style="height: auto;">'
							+'<tr>'
							+'<td rowspan="6" style="width: 87px;"><img style="width:86.4px;height:110px;cursor: pointer;" '
							+'src="'+bc.root+'/bc/image/download?ptype=portrait&puid=' + man.uid + '&ts=' + ts + '"></td>'
							
							+'<td class="label" style="width: 80px;">身份证号码:</td>'
							+'<td class="value" style="width: 250px;"><input type="text" class="ui-widget-content" readonly="readonly" value="' + man.identity + '"/></td>'
							
							+'<td rowspan="6" style="position: relative;"><textarea class="ui-widget-content noresize"' 
							+'style="position:absolute;left:0;right:0;bottom:-2px;top:-2px;" readonly="readonly">' + man.desc + '</textarea></td>'
							+'</tr>'
							
							+'<tr>'
							+'<td class="label">身份证地址:</td>'
							+'<td class="value"><input type="text" class="ui-widget-content" readonly="readonly" value="' + man.address1 + '"/></td>'
							+'</tr>'
							
							+'<tr>'
							+'<td class="label">暂住地址:</td>'
							+'<td class="value"><input type="text" class="ui-widget-content" readonly="readonly" value="' + man.address2 + '"/></td>'
							+'</tr>'
							
							+'<tr>'
							+'<td class="label">籍贯:</td>'
							+'<td class="value"><input type="text" class="ui-widget-content" readonly="readonly" value="' + man.origin + '"/></td>'
							+'</tr>'
							
							+'<tr>'
							+'<td class="label">资格证号:</td>'
							+'<td class="value"><input type="text" class="ui-widget-content" readonly="readonly" style="width:86px" value="' + man.cert4fwzg + '"/>'
							+'&nbsp;&nbsp;户口性质:&nbsp;<input type="text" class="ui-widget-content" readonly="readonly" style="width:86px" value="' + man.houseType + '"/></td>'
							+'</tr>'
							+'</table></td></tr>');
					}
					$mans.find("#mansBody").append(trs.join(""));
				}
			}
		});
	},
	currentCarId: null
};