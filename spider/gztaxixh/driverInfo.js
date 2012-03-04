bc.namespace("bs");
bs.gztaxixhDriverInfo = {
	searching: false,
	init : function() {
		var $page = $(this);

		// 回车执行搜索
		var $value = $page.find("#value").keyup(function(e) {
			if (e.which == 13) {// 按下回车键
				bs.gztaxixhDriverInfo.doSearch.call($page);
			}
		});
		$page.find("#info").delegate("span.ui-icon-search","click",function(e) {
			bs.gztaxixhDriverInfo.doSearch.call($page,$(this).attr("data-index"));
		});
		$page.find("#goBtn").click(function(e) {
			bs.gztaxixhDriverInfo.doSearch.call($page);
		});

		// 预搜索
		if ($value.val().length > 0) {
			bs.gztaxixhDriverInfo.doSearch.call($page);
		}
	},

	doSearch : function(index) {
		if(bs.gztaxixhDriverInfo.searching)
			return;
		
		var startTime = new Date().getTime();
		var $page = $(this);
		var value = $page.find("#header #value").val()
		if(value.length == 0){
			bc.msg.slide("必须输入要查询的值！");
			return;
		}
		
		var $info = $page.find("#info");
		var $waste = $page.find("#waste");
		$info.html("");
		$waste.html("正在连接出租协会网，会比较耗时，请耐心等候...");
		bs.gztaxixhDriverInfo.searching = true;
		bc.ajax({
			url : bc.root + "/bc-business/gztaxixh/findDriverInfo",
			data : {value: value,type: $page.find("#header #type").val(),index: index || 0},
			dataType : "json",
			success : function(json) {
				$waste.html("(" + bc.getWasteTime(startTime) + ")");
				if (json.success && !json.msg) {
					$info.html(json.simple + json.detail);
				} else {
					$info.html("<div class='error ui-state-error'>" + json.msg + "</div>");
				}
				bs.gztaxixhDriverInfo.searching = false;
			}
		});
	}
};