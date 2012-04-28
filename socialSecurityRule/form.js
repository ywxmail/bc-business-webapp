if(!window['bs'])window['bs']={};
bc.socialSecurityRuleForm = {
	init : function(option,readonly) {
		var $form=$(this);
		//只读状态就不需要执行其它初始化，直接返回
		if(readonly) return;
		
		//绑定使用区域小按钮事件
		$form.find("#selectArea").click(function(){
			bs.selectPlaceOrigin({
				types:'2',
				onOk: function(json){
					$form.find(":input[name='e.areaName']").val(json.fullname);
					$form.find(":input[name='e.areaId']").val(json.id);
				}
			});
		});
		
		//------------添加行-------------------
		var tableEl=$form.find("#socialSecurityRuleTables")[0];
		$form.find("#addLine").click(function() {
			//插入行
			var newRow=tableEl.insertRow(tableEl.rows.length);
			newRow.setAttribute("class","ui-widget-content row");
			//插入列
			var cell=newRow.insertCell(0);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","id first");
			cell.innerHTML='<span class="ui-icon"></span>';//空白头列

			cell=newRow.insertCell(1);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.style.position="relative";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input type="text" name="name" style="width:99%;height:100%;border:none;margin:0;padding:0 0 0 2px;'
				+'background:none;" class="bc-select ui-widget-content" data-validate="required" data-maxheight="150px" '
				+'data-source='+$form.find(":input[name='nameLists']").val()+'>'
				+'<ul class="inputIcons">'
				+'	<li class="bc-select inputIcon ui-icon ui-icon-triangle-1-s" title="点击选择"></li>'
				+'</ul>';//
		
			cell=newRow.insertCell(2);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="unitRate" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
				           +'type="text" data-validate={"required":true,"type":"number"} value="0" class="ui-widget-content">';//单位缴率
			
			cell=newRow.insertCell(3);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="personalRate" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
							+'type="text" data-validate={"required":true,"type":"number"} value="0" class="ui-widget-content">';//个人缴率
			
			cell=newRow.insertCell(4);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="baseNumber" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
							+'type="text" data-validate={"required":true,"type":"number"} value="0" class="ui-widget-content">';//插入基数
			
			cell=newRow.insertCell(5);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input name="desc" style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;"'
				           +'type="text"  class="ui-widget-content">';//插入备注
			
		});
		//点击选中行
		$form.find("#socialSecurityRuleTables").delegate("tr.ui-widget-content.row>td.id","click",function(){
			$(this).parent().toggleClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").toggleClass("ui-icon-check");
		});
		$form.find("#socialSecurityRuleTables").delegate("tr.ui-widget-content.row input","focus",function(){
			$(this).closest("tr.row").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
		});
		//删除表中选中的险种
		$form.find("#deleteLine").click(function() {
			var $trs = $form.find("#socialSecurityRuleTables tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要删除保险信息！");
				return;
			}
			bc.msg.confirm("确定要删除选定的 <b>"+$trs.length+"</b>个保险信息吗？",function(){
				for(var i=0;i<$trs.length;i++){
					$($trs[i]).remove();
				}
			});
			
		});
		
	},
	/**保存的处理*/
	save:function(){
		$page = $(this);
		//表单验证
		$socialSecurityRuleTables=$page.find("#socialSecurityRuleTables tr");
		if(!bc.validator.validate($socialSecurityRuleTables))
			return;
		
		//先将证件合并到隐藏域
		var details=[];
		//将补办证件表中的内容添加到certs里
		$page.find("#socialSecurityRuleTables tr:gt(0)").each(function(){
			var $inputs = $(this).find("td>input");
			var json = {
				name: $inputs[0].value,
				unitRate: $inputs[1].value,
				personalRate: $inputs[2].value,
				baseNumber: $inputs[3].value,
				desc: $inputs[4].value,	
			};
			var id = $(this).attr("data-id");
			if(id && id.length > 0)
				json.id = id;
			details.push(json);
		});
		$page.find(":input[name='details']").val($.toJSON(details));
		
		//调用标准的方法执行保存
		bc.page.save.call(this);
	}
};