bc.namespace("bs");
bs.gztaxixhDriverInfo = {
	searching: false,
	init : function() {
		var $page = $(this);

		// 回车执行搜索
		var $v = $page.find("#v").keyup(function(e) {
			if (e.which == 13) {// 按下回车键
				bs.gztaxixhDriverInfo.doSearch.call($page);
			}
		});
		$page.find("#goBtn").click(function(e) {
			bs.gztaxixhDriverInfo.doSearch.call($page);
		});

		// 预搜索
		if ($v.val().length > 0) {
			bs.gztaxixhDriverInfo.doSearch.call($page);
		}
	},

	doSearch : function() {
		if(bs.gztaxixhDriverInfo.searching)
			return;
		
		var $page = $(this);
		var v = $page.find("#header #v").val()
		if(v.length == 0){
			bc.msg.slide("必须输入服务资格证号！");
			return;
		}
		
		var $info = $page.find("#info");
		var $waste = $page.find("#waste");
		$info.html("");
		$waste.html("正在连接出租协会网，会比较耗时，请耐心等候...");
		bs.gztaxixhDriverInfo.searching = true;
		bc.ajax({
			url : bc.root + "/bc-business/gztaxixh/findDriverInfo",
			data : {
				v : v
			},
			dataType : "json",
			success : function(json) {
				$waste.html("(" + json.waste + ")");
				if (json.success && !json.msg) {
					$info.html(json.detail ? json.detail : json.simple);
				} else {
					$info.html("<div class='error ui-state-error'>" + json.msg + "</div>");
				}
				bs.gztaxixhDriverInfo.searching = false;
			}
		});
	}
};