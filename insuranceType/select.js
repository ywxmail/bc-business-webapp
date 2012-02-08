if(!window['bs'])window['bs']={};
bs.insuranceTypeSelectDialog = {
	/** 点击确认按钮后的处理函数 */
	clickOk : function() {
		var $page = $(this);
		
		// 获取选中的行的id单元格
		var $tds = $page.find(".bc-grid>.data>.left tr.ui-state-focus>td.id");
		if($tds.length == 0){
			alert("请先选择！");
			return false;
		}
		
		//选择模板后到服务器获取属于这一模板的险种
		var url=bc.root +"/bc-business/selectTemplateWithPlant/selectInsuranceTypes";
		var data;
		$.ajax({
			  url: url,
			  dataType:"json",
			  data:{pid:$tds.attr("data-id")},
			  success: function(insuranceTypes) {
				  logger.info("insuranceTypes="+$.toJSON(insuranceTypes));
				  if(insuranceTypes.length>0){
					  data = [];
					  for(var i=0; i<insuranceTypes.length; i++){
					  	var id=insuranceTypes[i].id;
					  	var name=insuranceTypes[i].name;
					  	var coverage=insuranceTypes[i].coverage;
					  	var description=insuranceTypes[i].description;
					  	data.push({
							id: id,//险种id
							name:name,
							coverage:coverage,
							description:description
						});
					}
						
					logger.info($.toJSON(data));
					
					// 返回
					$page.data("data-status", data);
					$page.dialog("close");
					  
				  }else{
					  bc.msg.info('此模板还没配置险种');
					  $page.dialog("close");
				  }	    
			  }
			});
	}
};