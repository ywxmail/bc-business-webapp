if(!window['bs'])window['bs']={};
bs.feeTemplateSelectDialog = {
	/** 点击确认按钮后的处理函数 */
	clickOk : function() {
		var $page = $(this);
		
		// 获取选中的行的id单元格
		var $tds = $page.find(".bc-grid>.data>.left tr.ui-state-highlight>td.id");
		if($tds.length == 0){
			bc.msg.alert("请先选择！");
			return false;
		}
		
		//var $trs = $grid.find(">.data>.left tr.ui-state-highlight");
		var pid='';
		var datap=[];
		var $right = $($tds[0]).closest(".left").siblings();
		$tds.each(function(i){
			var $this = $(this);
			var index = $this.parent().index();
			var $row = $right.find("tr.row:eq("+index+")");
			var id=$this.attr("data-id");
			var $tdright =$row.find("td.first");
			var type=$tdright.attr("data-value");
			logger.info("索引:"+index+" 类型:"+type+" id:"+id);
			if(type==0){
				pid=id+","+pid;
			}else{
				var name = $row.find("td:eq(3)").text();
				var price = $row.find("td:eq(4)").text();
				var count = $row.find("td:eq(5)").text();
				var payType = $row.find("td:eq(6)").attr("data-value");
				var desc = $row.find("td:eq(7)").text();
				datap.push({
					id: id,
					name:name,
					price:price,
					count:count,
					payType:payType,
					desc:desc
				});
			}
		});
		
		var datat=[];
		
		//选择模板后到服务器获取属于这一模板的险种
		var url=bc.root +"/bc-business/selectTemplateWithFeeTemplate/selectFeeTemplates?pid="+pid;
		
		if(pid!=''){
			$.ajax({
				  url: url,
				  dataType:"json",
				  success: function(feeTemplates) {
					  if(feeTemplates.length>0){
						  for(var i=0; i<feeTemplates.length; i++){
						  	var id=feeTemplates[i].id;
						  	var name=feeTemplates[i].name;
						  	var price=feeTemplates[i].price;
						  	var count=feeTemplates[i].count;
						  	var payType=feeTemplates[i].payType;
						  	var desc=feeTemplates[i].desc;
						  	datat.push({
								id: id,//id
								name:name,
								price:price,
								count:count,
								payType:payType,
								desc:desc
							});
						}
						// 返回
						$page.data("data-status", datat.concat(datap));
						$page.dialog("close");
					  }    
				  }
			});
		}else{
			//logger.info($.toJSON(datat));
			//logger.info("---------------");
			//logger.info($.toJSON(datap));
			// 返回
			$page.data("data-status", datap);
			$page.dialog("close");
		}
	}
};