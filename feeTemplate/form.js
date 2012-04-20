if(!window['bs'])window['bs']={};
bs.feeTemplateForm = {
	init : function(option,readonly)  {
		var $form = $(this);
		var type_fee=1;//费用
		var type_template=0;//模板
		
		//初始化时根据类型显示相应的input
		if($form.find(":radio[name='e.type']:checked").val()==type_template){
			bs.feeTemplateForm.hiddenFeeInput($form);
		}else{
			if($form.find("select[name='e.pid']:checked").val()!=''&&
				$form.find("input[name='e.module']").val()!=''){
				$form.find("input[name='e.module']").attr("readonly","readonly");
			}
		}
		if(readonly) return;
		
		//绑定所属模板事件，当费用选择了模板，所属模块的值必需与模板的所属模块的值相同，且不能修改所属模块的值
		$form.find("select[name='e.pid']").change(function(){
			var tid=$(this).find(":checked").val();
			var $module=$form.find("input[name='e.module']");
			var url=bc.root+"/bc-business/feeTemplate/getTemplateModule";
			if(tid==''){
				$module.removeAttr("readonly");
				return;
			}

			$.ajax({
				url:url,
				data:{tid:tid},
				dataType:"json",
				success:function(json){
					if(json.result!=""){
						$module.val(json.result);
						$module.attr("readonly","readonly");					
					}else{
						$module.removeAttr("readonly");
					}
				}
			});
		});
		
		if($form.find(":input[name='e.id']").val()!=''&&$form.find(":radio[name='e.type']:checked").val()==type_template){
			//当类型值改变时，页面内容改变
			$form.find(":radio[name='e.type']").change(function(){
				if($(this).val()==type_fee){
					var tid=$form.find(":input[name='e.id']").val();
					//ajax请求检测模板转为费用时，是否还有费用属于此模板
					var url=bc.root+"/bc-business/feeTemplate/isTemplateExistFee";
					$.ajax({
						url:url,
						data:{tid:tid},
						dataType:"json",
						success:function(json){
							if(json.result=="true"){
								$form.find(":radio[name='e.type'][value='"+type_template+"']").attr("checked",'checked');
								bc.msg.alert("有费用单属于此模板，不能修改类型，如需修改请清空或修改这些费用单的所属模板项！");
							}else{
								bs.feeTemplateForm.showFeeInput($form);
							}
						}
					});
				}else{
					bs.feeTemplateForm.hiddenFeeInput($form);
				}
			});
		}else{
			//当类型值改变时，输入框也改变
			$form.find(":radio[name='e.type']").change(function(){
				if($(this).val()==type_fee){
					bs.feeTemplateForm.showFeeInput($form);
				}else{
					bs.feeTemplateForm.hiddenFeeInput($form);
				}
			});
		}
	},
	/**
	 * 显示费用类型的input
	 */
	showFeeInput:function($form){
		$form.find(".feeInput").show();
		$form.find(":input[name='e.price']").attr("data-validate",'{required:true,type:"number"}');
		$form.find(":input[name='e.count']").attr("data-validate",'{required:true,type:"number"}');
		$form.find("select[name='e.payType']").attr("data-validate","required");
		$form.find(":input[name='e.price']").val(0);
		$form.find(":input[name='e.count']").val(0);
	},
	/**
	 * 隐藏费用类型的input
	 */
	hiddenFeeInput:function($form){
		$form.find(".feeInput").hide();
		$form.find("input[name='e.module']").removeAttr("readonly");
		$form.find("select[name='e.pid']").val('');
		$form.find(":input[name='e.price']").val('');
		$form.find(":input[name='e.price']").removeAttr("data-validate");
		$form.find(":input[name='e.count']").val('');
		$form.find(":input[name='e.count']").removeAttr("data-validate");
		$form.find("select[name='e.payType']").val('');
		$form.find("select[name='e.payType']").removeAttr("data-validate");
	}
};