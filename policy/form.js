if(!window['bs'])window['bs']={};
bc.policyForm = {
	init : function(option,readonly,page) {
		
		var $form;
		
		if(page == null){
			$form = $(this);
		}else{
			$form = page;
		}
		/* 初始化多页签*/
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		if(readonly){
			$form.parent().find('#bcSaveBtn').hide();
			return;
		}else{
			$form.parent().find('#bcOpBtn').hide();
			$form.parent().find('#bcSaveBtn').show();
		}
		//if(readonly) return;
		//是否购买强制险
		$form.find(":checkbox[name='e.greenslip']").change(function() {
			if(this.checked){
				$form.find('#greenslipFieldset').css("visibility","visible");
				$form.find('#greenslipSameDateFieldset').css("visibility","visible");
				$form.find(":checkbox[name='e.greenslipSameDate']")[0].checked = false;
			}else{
				$form.find('#greenslipFieldset').css("visibility","hidden");
				$form.find('#greenslipSameDateFieldset').css("visibility","hidden");
				$form.find(":checkbox[name='e.greenslipSameDate']")[0].checked = false;
			}
		});
		// 强制险是否与商业险同期
		$form.find(":checkbox[name='e.greenslipSameDate']").change(function() {
			if(this.checked){
				$form.find('#greenslipSameDateFieldset').css("visibility","hidden");
			}else{
				$form.find('#greenslipSameDateFieldset').css("visibility","visible");
			}
		});
		if($form.find(":checkbox[name='e.greenslipSameDate']")[0].checked==true){
			$form.find('#greenslipSameDateFieldset').css("visibility","hidden");
		}
		
	},
	/**
	 * 上下文为按钮所在窗口，第一个参数为选中的项({text:[text]},value:[value])
	 * 
	 */
	selectMenuButtonItem : function(option) {
		logger.info("selectMenuButtonItem:option=" + $.toJSON(option));
		
		var $page = $(this);
		//可编辑表单的处理
		$page.find(":input:visible").each(function(){
			logger.debug("disabled:" + this.name);
			this.disabled=false;
		});
		$page.find("ul.inputIcons,span.selectButton").each(function(){
			$(this).show();
		});
		//重新设定附件
		var attuId = $page.find(":hidden[name='e.uid']").val();
		$page.find("#attachment").html(
			'<div data-extensions="bat,sh,reg,zip,rar,7z,gz,tar,pdf,txt,doc,xls,docx,xlsx,ppt,pptx,png,psd,jpg,jpeg,gif,tif,tiff,mp3,mid,wma,swf,avi,wmv,mkv,apk" data-maxsize="1048576000" data-maxcount="6" data-ptype="contractLabour.main" data-puid='+attuId+' class="attachs formAttachs">' 
			+	'<table cellspacing="0" cellpadding="0" class="header">'
			+		'<tbody>'
			+		'<tr>'
			+			'<td class="summary">'
			+			'<span id="totalCount">0</span>&nbsp;个附件共&nbsp;<span data-size="0" id="totalSize">0Bytes</span>'
			+			'</td>'
			+			'<td class="uploadFile">添加附件<input type="file" multiple="" name="uploadFile" id="fid1322123360263" class="uploadFile">'
			+			'</td>'
			+			'<td><a data-action="downloadAll" class="operation" href="#">打包下载</a><a data-action="deleteAll" class="operation" href="#">全部删除</a>'
			+			'</td>'
			+		'</tr>'
			+		'</tbody>'
			+	'</table>'
			+'</div>'
		);
		//bc.policyForm.init(null,false,$page);
		
		switch(option.value){
			case "2":	//维护
				bc.policyForm.setData(2,$page,false);
				break;
			case "3":	//续保
				bc.policyForm.setData(3,$page,true);
				break;
			case "4":	//停保
				bc.msg.confirm("确定此劳动合同的持有人离职吗？",function(){
					$page.find(":input[name='e.status']").val("1");
					$page.find(":input[name='e.opType']").val("4");
					$page.data("data-status","saved");
					var option = { callback : function (){
							$page.dialog("close");
						}
					};
					//调用标准的方法执行保存
					bc.page.save.call($page,option);
				});
				break;
		}

	},
	
	//维护,续保处理
	setData : function (opType,context,flag){
		var $page = context;
		//清空id新增一份维护操作类型的合同
		var verMajor = $page.find(":input[name='e.verMajor']").val();
	    $page.find(":input[name='e.verMajor']").val(verMajor++);
	    alert(verMajor++);
		var eId = $page.find(":input[name='e.id']").val();
		if(eId.length > 0){
			$page.find(":input[name='e.pid']").val(eId);
		}
		$page.find(":input[name='e.id']").val('');
		$page.find(":input[name='e.uid']").val('');
		$page.find(":input[name='e.opType']").val(opType);
		$page.parent().find('#bcSaveBtn').show();
		$page.parent().find('#bcOpBtn').hide();
	}
		
};