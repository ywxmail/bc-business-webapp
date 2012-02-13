if(!window['bs'])window['bs']={};
bs.insuranceTypeSelectDialog = {
	/** 点击确认按钮后的处理函数 */
	clickOk : function() {
		var $page = $(this);
		
		// 获取选中的行的id单元格
		var $tds = $page.find(".bc-grid>.data>.left tr.ui-state-highlight>td.id");
		if($tds.length == 0){
			alert("请先选择！");
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
			if(type==1){
				pid=id+","+pid;
			}else{
				var name = $row.find("td:eq(3)").text();//险种名称
				var coverage = $row.find("td:eq(4)").text();//保额
				var description = $row.find("td:eq(5)").text();//备注
				datap.push({
					id: id,//险种id
					name:name,
					coverage:coverage,
					description:description
				});
			}
		});
		
		var datat=[];
		
		//选择模板后到服务器获取属于这一模板的险种
		var url=bc.root +"/bc-business/selectTemplateWithPlant/selectInsuranceTypes?pid="+pid;
		
		if(pid!=''){
			$.ajax({
				  url: url,
				  dataType:"json",
				  success: function(insuranceTypes) {
					  //logger.info("insuranceTypes="+$.toJSON(insuranceTypes));
					  if(insuranceTypes.length>0){
						  for(var i=0; i<insuranceTypes.length; i++){
						  	var id=insuranceTypes[i].id;
						  	var name=insuranceTypes[i].name;
						  	var coverage=insuranceTypes[i].coverage;
						  	var description=insuranceTypes[i].description;
						  	datat.push({
								id: id,//险种id
								name:name,
								coverage:coverage,
								description:description
							});
						}
						// 返回
						$page.data("data-status", datat.concat(datap));
						$page.dialog("close");
					  }    
				  }
			});
		}else{
			logger.info($.toJSON(datat));
			logger.info("---------------");
			logger.info($.toJSON(datap));
			// 返回
			$page.data("data-status", datap);
			$page.dialog("close");
		}
	}
};