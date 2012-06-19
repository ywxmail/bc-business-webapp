if(!window['bs'])window['bs']={};
bs.invoice4BalanceForm = {
	init : function(option,readonly){
		var $form = $(this);
		
		if(readonly) return;
		
		$form.find("select[name='company']")[0].focus();

		var startDate=$form.find(":input[name='startDate']").val();
		var endDate=$form.find(":input[name='endDate']").val();
		var company=$form.find("select[name='company']").val();

		var url=bc.root + "/bc-business/invoice4Balance/select";
		$.ajax({
			url:url,
			data:{startDate:startDate,endDate:endDate,company:company},
			dataType:"json",
			success:function(json){
				//logger.info($.toJSON(json));
				$form.find(":input[name='startCount']").val(json.startCount);
				$form.find(":input[name='buyCount']").val(json.buyCount);
				$form.find(":input[name='sellCount']").val(json.sellCount);
				$form.find(":input[name='endCount']").val(json.endCount);
			}
		});
		
		$form.find("select[name='type']").change(function(){
			if($(this).val()==''){
				$form.find("#unitName").text('');
			}else if($(this).val()=='2'){
				$form.find("#unitName").text('(卷)');
			}else{
				$form.find("#unitName").text('(本)');
			}
		});
		
		
	},
	select : function(){
		var $form = $(this);
		bc.validator.validate($form);
		
		var startDate=$form.find(":input[name='startDate']").val();
		var endDate=$form.find(":input[name='endDate']").val();
		var company=$form.find("select[name='company']").val();
		var type=$form.find("select[name='type']").val();
		
		var url=bc.root + "/bc-business/invoice4Balance/select";
		$.ajax({
			url:url,
			data:{startDate:startDate,endDate:endDate,company:company,type:type},
			dataType:"json",
			success:function(json){
				//logger.info($.toJSON(json));
				$form.find(":input[name='startCount']").val(json.startCount);
				$form.find(":input[name='buyCount']").val(json.buyCount);
				$form.find(":input[name='sellCount']").val(json.sellCount);
				$form.find(":input[name='endCount']").val(json.endCount);
			}
		});
	}
};