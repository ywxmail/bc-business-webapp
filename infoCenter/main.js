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
				$this.toggleClass("ui-state-active", true).siblings(
						".ui-state-active").toggleClass(
						"ui-state-active", false);
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
		$page.find("#msgsBody").delegate("tr:not(.header)",{
			mouseover : function() {
				$(this).addClass("ui-state-hover");
			},
			mouseout : function() {
				$(this).removeClass("ui-state-hover");
			},
			/** 单击高亮 */
			click : function() {
				var $this = $(this);
				$this.toggleClass("ui-state-active", true).siblings(
						".ui-state-active").toggleClass(
						"ui-state-active", false);
			},
			/** 双击打开查看 */
			dblclick : function() {
				var $this = $(this);
				var id = $this.attr("data-id");
				if(!id || id.length == 0){
					bc.msg.alert("此信息不支持打开查看！");
					return false;
				}
				var type = $this.attr("data-type");
				var plate = $this.attr("data-plate");
				var url = bc.root;
				if (type == "黑名单") {
					url += "/bc-business/blacklist/edit";
				} else if (type == "车辆保单") {
					url += "/bc-business/policy/open";
				} else if (type == "经济合同") {
					url += "/bc-business/contract4Charger/open";
				} else {
					bc.msg.alert("此信息不支持打开查看！");
					return false;
				}

				// 打开
				bc.page.newWin({
					name : type + " " + plate,
					mid : type + id,
					url : url,
					data : {
						id : id
					}
				});
			}
		});

		// 司机信息列表的样式控制
		var $mansBody = $page.find("#mansBody").delegate("tr.header",{
			mouseover : function() {
				$(this).addClass("ui-state-hover");
			},
			mouseout : function() {
				$(this).removeClass("ui-state-hover");
			},
			click : function() {
				var $this = $(this);
				$this.toggleClass("ui-state-active", true).siblings(
						".ui-state-active").toggleClass(
						"ui-state-active", false);
			}
		});

		// 包含注销司机的控制
		var loaded = false;
		bs.infoCenter.includeLogoutEl = $page.find("#mans #includeLogout input").change(function() {
			$(this).closest("#mansHeader").next().toggleClass("showDisabled unshowDisabled");
			
			// 加载注销司机的图片
			if(!loaded){
				loaded = true;
				$mansBody.find("img.notLoaded").each(function(){
					var _$this = $(this);
					_$this.removeClass("notLoaded").attr("src",_$this.attr("data-src"));
				});
			}
		})[0];
		var loaded = bs.infoCenter.includeLogoutEl.checked;

		// 点击司机图片打开
		$mansBody.delegate("img",{
			click : function() {
				var $this = $(this);
				bc.page.newWin({
					name: $this.attr("data-name"),
					mid: "carman" + $this.attr("data-id"),
					url: bc.root + "/bc-business/carMan/edit",
					data: {id: $this.attr("data-id")}
				});
				return false;
			}
		});

		// 修改司机的联系电话
		$mansBody.delegate("span.updatePhone","click", function() {
			var $this = $(this);
			var driverId = $this.attr("data-did");// 司机id
			var phone1 = $this.attr("data-phone1");// 电话1
			var phone2 = $this.attr("data-phone2");// 电话2
			logger.info("driverId=" + driverId + ",phone1=" + phone1 + ",phone2=" + phone2);
			bc.page.newWin({
				name: "修改联系电话",
				modal: true,
				mid: "updatePhone" + driverId,
				url: bc.root + "/bc-business/carMan/updatePhonePage",
				data: {id: driverId, phone1: phone1, phone2: phone2},
				afterClose: function(json){
					//  更新界面显示的电话为新的电话信息
					if(json){
					$this.attr("data-phone1",json.phone1);
					$this.attr("data-phone2",json.phone2);
					if(json.phone2){
						$this.parent().parent().next().text(json.phone1+","+json.phone2)
						}else{
						$this.parent().parent().next().text(json.phone1)
						}
					}
				}
			});
		});
		
		// 非webkit浏览器的特殊处理
		if(!$.browser.safari)
			$page.find("#specalTD").toggleClass("desc-webkit desc");

		// 定位左侧最下面的元素的top位置
		var sh = 0;
		var $left = $page.find("#left");
		$left.find(".block").each(function() {
			sh += $(this).outerHeight(true);
		});
		logger.debug("sh=" + sh);
		var $leftLast = $left.find("#last");
		sh = $leftLast.position().top + $leftLast.outerHeight(true);
		logger.debug("sh2=" + sh);
		$left.find(".results").css("top", sh).show();

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
				
				// 如果查询结果为1台车就直接显示
				if(cars.length == 1){
					var $li = $results.find("li").addClass("ui-state-active");
					bs.infoCenter.showCar.call($li,$li.attr("data-id"));
				}
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
		// 避免迅速点击多次的重复请求
		if(bs.infoCenter.processing && carId == bs.infoCenter.currentCarId){
			return;
		}else{
			bs.infoCenter.processing = true;
			// 指定秒数后重置
			window.setTimeout(function(){bs.infoCenter.processing = false;}, 2000);
		}
		
		//if(carId == bs.infoCenter.currentCarId) return;
		logger.info("carId=" + carId + ",preCarId=" + bs.infoCenter.currentCarId);
		bs.infoCenter.currentCarId = carId;// 记录当前正在处理的车辆id，避免重复点击的请求
		
		var $li = $(this);
		var lj = $li.data("json");
		var $right = $li.closest("#left").siblings("#right");
		
		// 显示正在查询动画
		var startTime = new Date().getTime();
		var $carHeader = $right.find("#carHeader").addClass("loading");
		var $carTitle = $carHeader.find("#carTitle").html('正在查询' + lj.plate + '...');
		
		// 清空内容
		$right.find("#main input[type='text'],textarea").val("");
		$right.find("#main input[type='checkbox']").each(function(){this.checked = false;});
		var $messages = $right.find("#messages").addClass("empty");
		$messages.find("#msgsBody > tr:not(.header)").remove();
		var $mans = $right.find("#mans").addClass("empty");
		$mans.find("#mansBody").empty();
		$mans.find("#disabledManCount").empty();

		// 获取车辆详细信息
		bc.ajax({
			url : bc.root + "/bc-business/infoCenter/findCarDetail",
			data : {carId : carId},
			dataType : "json",
			success : function(json) {
				// 关闭加载动画
				$carHeader.removeClass("loading");
				
				// 显示车牌及查询时间
				$carTitle.text(lj.plate + ($li.hasClass("ui-state-disabled") ? " - 此车已注销，交车日期为 " + lj.returnDate : ""));
				$carTitle.next().text(" (" + bc.getWasteTime(startTime) + ")");
				
				// 失败就提示
				if(!json.success){
					bc.msg.slide("没有找到车辆的相关信息！");
					return;
				}
				
				if(json.id != bs.infoCenter.currentCarId)
					return;
				
				// 显示车辆信息
				var $main = $right.find("#main");
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
						trs.push('<tr class="ui-widget-content middle row'+(i%2 == 0 ? " odd" : " even") 
								+'" data-plate="' + lj.plate +'" data-type="' + msgs[i].module + '" data-id="' + msgs[i].id + '">'
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
					var disabledManCount = 0,isLogoutMan,imgUrl;
					for(var i=0;i<mans.length;i++){
						man = mans[i];
						isLogoutMan = bs.infoCenter.isLogoutMan(man);
						// 累计注销司机的数量
						if(isLogoutMan) disabledManCount++;
						
						// 抬头行
						trs.push('<tr class="ui-widget-content ui-state-highlight top header'+(i==0 ? " first" : "") + (isLogoutMan ? " ui-state-disabled disabled" : "") + '">'
							+'<td class="first aright ui-widget-content" style="width: 7em;">' + man.judgeType + ':</td>'
							+'<td class="middle aleft ui-widget-content" style="width: 7em;">' + man.name + '(' + man.sex + ')' + '</td>'
							+'<td class="middle aright ui-widget-content" style="width: 4em;">'
							+'<div class="relative"><span class="ui-icon ui-icon-arrowthick-1-n updatePhone" title="点击修改联系电话信息"'
							+' data-phone1="' + man.phone1 + '" data-phone2="' + man.phone2 + '" data-did="' + man.id + '"></span>'
							+'<span class="phoneLabel">电话:</span></div></td>'
							+'<td class="last aleft ui-widget-content" style="width: 15em;">' + man.phones + '</td>'
							+'<td class="middle aright ui-widget-content" style="width: 3em;">状态:</td>'
							+'<td class="last aleft ui-widget-content">' + (man.judgeClasses.length > 0 ? man.judgeClasses + "," : "")
							+ (man.moveTypeDesc.length > 0 ? man.moveTypeDesc + '(' + man.moveDate + ')' : "") + '</td>'
							+'</tr>');
						
						// 司机详细资料
						trs.push('<tr data-json="'+$.toJSON(man)+'" class="detail' + (isLogoutMan ? " ui-state-disabled disabled" : "") + '"><td colspan="6" style="padding:0;">'
							+'<table class="contentTable" cellspacing="2" cellpadding="0" style="height: auto;">'
							+'<tr>'
							+'<td rowspan="6" style="width: 87px;vertical-align: top;"><img style="width:86.4px;height:110px;cursor: pointer;" data-id="' + man.id + '" data-name="' + man.name + '" ');
						
						// 延时加载注销司机图片的处理
						imgUrl = bc.root+'/bc-business/cacheImage/download?ptype=portrait&puid=' + man.uid + '&ts=' + ts;
						if(isLogoutMan && !bs.infoCenter.includeLogoutEl.checked){
							trs.push('class="notLoaded" data-src="' + imgUrl + '" src="' + bc.root+'/bc-business/infoCenter/notLoaded.png'+ '"');
						}else{
							trs.push('src="' + imgUrl + '"');
						}
						
						trs.push('></td>'
							+'<td class="label" style="width: 6em;">身份证号码:</td>'
							+'<td class="value" style="width: 20em;"><input type="text" class="ui-widget-content ui-state-default" readonly="readonly" value="' + man.identity + '"/></td>'
							
							+'<td rowspan="6" class="' + ($.browser.safari ? "desc-webkit" : "desc2") + '"><textarea class="ui-widget-content noresize ui-state-default"' 
							+' readonly="readonly">' + man.desc + bs.infoCenter.getAutoInfo(man.autoInfo) + '</textarea></td>'
							+'</tr>'
							
							+'<tr>'
							+'<td class="label">身份证地址:</td>'
							+'<td class="value"><input type="text" class="ui-widget-content ui-state-default" readonly="readonly" value="' + man.address1 + '"/></td>'
							+'</tr>'
							
							+'<tr>'
							+'<td class="label">暂住地址:</td>'
							+'<td class="value"><input type="text" class="ui-widget-content ui-state-default" readonly="readonly" value="' + man.address2 + '"/></td>'
							+'</tr>'
							
							+'<tr>'
							+'<td class="label">籍贯:</td>'
							+'<td class="value"><input type="text" class="ui-widget-content ui-state-default" readonly="readonly" value="' + man.origin + '"/></td>'
							+'</tr>'
							
							+'<tr>'
							+'<td class="label">资格证号:</td>'
							+'<td class="value"><input type="text" class="ui-widget-content ui-state-default" readonly="readonly" style="width:6em" value="' + man.cert4fwzg + '"/>'
							+'&nbsp;&nbsp;户口性质:&nbsp;<input type="text" class="ui-widget-content ui-state-default" readonly="readonly" style="width:6em" value="' + man.houseType + '"/></td>'
							+'</tr>'
							+'</table></td></tr>');
					}
					$mans.find("#mansBody").append(trs.join(""));
					if(disabledManCount > 0)$mans.find("#disabledManCount").text("(" + disabledManCount + "个)");
				}
			}
		});
	},
	currentCarId: null,
	isLogoutMan: function(man){
		return man.judgeStatus!=0;
	},
	getAutoInfo: function(autoInfo){
		if(! autoInfo) return "";
		
		return "\r\n==以下为系统自动生成数据=="
				+ (autoInfo.status != 0 ? "\r\n劳动合同状态：已注销" : "")
				+"\r\n劳动合同期限：" + autoInfo.startDate + "～" + autoInfo.endDate
				+"\r\n社保参保日期：" + autoInfo.joinDate
				+"\r\n社保个人编号：" + autoInfo.insurcode
				+"\r\n社保参保险种：" + autoInfo.insuranceType
				+ (autoInfo.remark.length > 0 ? "\r\n劳动合同备注：" + autoInfo.remark : "");
	}	
};