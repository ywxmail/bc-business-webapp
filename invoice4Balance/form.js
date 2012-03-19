if(!window['bs'])window['bs']={};
bs.invoice4BalanceForm = {
	init : function(option,readonly){
		var $form = $(this);
		
		if(readonly) return;
		
	},
	select : function(){
		var $form = $(this);
		bc.validator.validate($form);
		
		var startDate=$form.find(":input[name='startDate']").val();
		var endDate=$form.find(":input[name='endDate']").val();
		var company=$form.find("select[name='company']").val();
		var type=$form.find("select[name='type']").val();
		
		logger.info(company+"~"+type);
		
		var url=bc.root + "/bc-business/invoice4Balance/select";
		$.ajax({
			url:url,
			data:{startDate:startDate,endDate:endDate,company:company,type:type},
			dataType:"json",
			success:function(json){
				//logger.info($.toJSON(json));
				var startCount=bs.invoice4BalanceForm.formatNumber(json.startCount);
				var buyCount=bs.invoice4BalanceForm.formatNumber(json.buyCount);
				var sellCount=bs.invoice4BalanceForm.formatNumber(json.sellCount);
				var endCount=bs.invoice4BalanceForm.formatNumber(json.endCount);
				$form.find(":input[name='startCount']").val(startCount);
				$form.find(":input[name='buyCount']").val(buyCount);
				$form.find(":input[name='sellCount']").val(sellCount);
				$form.find(":input[name='endCount']").val(endCount);
			}
		});
	},
	//格式化数字为1,111,111
	formatNumber : function(strSum){
		 var len;  
         var result = "";    
         var temp = "";       
         len = strSum.length;       
         while(len > 3){                  
             temp = ","+strSum.substring(len - 3,len);  
             strSum = strSum.substring(0,len - 3);                  
             result = temp + result;  
             len = strSum.length;  
         }  
         if(len > 0)  
         {  
             result = strSum + result;  
         }
         return result;
	}
};