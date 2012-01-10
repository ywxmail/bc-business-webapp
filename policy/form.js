if(!window['bs'])window['bs']={};
bc.policyForm = {
	init : function(option,readonly) {
		var $form=$(this);
		/* 初始化多页签*/
		$form.find('#formTabs').bctabs(bc.page.defaultBcTabsOption);
		//只读状态就不需要执行其它初始化，直接返回
		if(readonly) return;
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
		//如果选中强制险是否与商业险同期选择框则将强制险的保险期限隐藏
		if($form.find(":checkbox[name='e.greenslipSameDate']")[0].checked==true){
			$form.find('#greenslipSameDateFieldset').css("visibility","hidden");
		}
		
		var tableEl=$form.find("#buyPlantTables")[0];
	
		/**购买险种表格中插入input控件
		 * @option {string} name 单元格的name属性值
		 * @option {Object} value 单元格的json值
		 * @option {Boolean} readonly 单元格是否只读
		 * @option {Boolean} isFirst 单元格是列头
		 */
		function buildInput(name,value,readonly,isFirst){
			var s = '<input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;';
			if(isFirst){
				s='<span class="ui-icon"></span><input style="width:100%;height:100%;border:none;margin:0;padding:0 0 0 2px;'
				s += 'background:none;';
			}
			if(name=="coverage"||name=="premium"){
				s += '" name="' + name + '" type="text" class="ui-widget-content" data-validate="number" value="' + value + '"';
			}else{
				s += '" name="' + name + '" type="text" class="ui-widget-content" value="' + value + '"';
			}

			s += '" name="' + name + '" type="text" class="ui-widget-content" value="' + value + '"';
			if(readonly){
				s += ' readonly="' + readonly + '"';
			}
			s += '/>';
			return s;
		}
		// 选择车辆保单险种
		$form.find("#selectInsuranceType").click(function() {
			bs.selectInsuranceType({
				multiple: true,
				onOk : function(selectInsuranceTypes) {
					for(var i=0;i<selectInsuranceTypes.length;i++){
						//插入行
						var newRow=tableEl.insertRow(tableEl.rows.length);
						newRow.setAttribute("class","ui-state-default row");
						//插入列
						var cell=newRow.insertCell(0);
						cell.style.padding="0";
						cell.style.textAlign="left";
						cell.setAttribute("class","id first");
						cell.innerHTML=buildInput("name",selectInsuranceTypes[i].name,true,true);//插入名称
						
						cell=newRow.insertCell(1);
						cell.style.padding="0";
						cell.style.textAlign="left";
						cell.setAttribute("class","middle");
						cell.innerHTML=buildInput("coverage",selectInsuranceTypes[i].coverage);//插入保额
						
						cell=newRow.insertCell(2);
						cell.style.padding="0";
						cell.style.textAlign="left";
						cell.setAttribute("class","middle");
						cell.innerHTML=buildInput("premium",selectInsuranceTypes[i].premium);//插入保费
						
						cell=newRow.insertCell(3);
						cell.style.padding="0";
						cell.style.textAlign="left";
						cell.setAttribute("class","middle");
						cell.innerHTML=buildInput("description",selectInsuranceTypes[i].description);//插入备注
					}
				}
			});
		});
		//添加选中险种
		$form.find("#buyPlantTables").delegate("tr:gt(0)","click",function(){
			$(this).toggleClass("ui-state-default ui-state-focus").find("td:eq(0)>span.ui-icon").toggleClass("ui-icon-check");
		});
		//删除表中选中的险种
		$form.find("#deleteInsuranceType").click(function() {
			var $trs = $form.find("#buyPlantTables tr.ui-state-focus");
			if($trs.length == 0){
				bc.msg.slide("请先选择要删除的险种！");
				return;
			}
			bc.msg.confirm("确定要删除选定的 <b>"+$trs.length+"</b>个险种吗？",function(){
				for(var i=0;i<$trs.length;i++){
					$($trs[i]).remove();
				}
			});
			
		});
		
		
	},
	/**保存的处理*/
	save:function(){
		$page = $(this);
		//先将购买险种合并到隐藏域
		var buyPlants=[];
		//将购买险种表中的内容添加到buyPlants里
		$page.find("#buyPlantTables tr:gt(0)").each(function(){
			var $inputs = $(this).find("td>input");
			var json = {
				name: $inputs[0].value,
				coverage: $inputs[1].value,
				premium: $inputs[2].value,
				description: $inputs[3].value
			};
			var id = $(this).attr("data-id");
			if(id && id.length > 0)
				json.id = id;
			buyPlants.push(json);
		});
		$page.find(":input[name='buyPlants']").val($.toJSON(buyPlants));
		//表单验证
		$buyPlantTables=$page.find("#buyPlantTables tr");
		
		if(!bc.validator.validate($buyPlantTables))
			return;
		//调用标准的方法执行保存
		bc.page.save.call(this);
	},
	/** 续保处理 */
	doRenew : function() {
		var $page = $(this);
		bc.msg.confirm("是否对"+$page.find("#carInfo").text() + "进行续保？",function(){
			// 关闭当前窗口
			$page.dialog("close");
			// 续保表单
			bc.page.newWin({
				name: $page.find("#carInfo").text()+"  续保",
				mid: "policyDoRenew" + $page.find(":input[name='e.id']").val(),
				url: bc.root + "/bc-business/policy4CarOperate/doRenew",
				data: {id: $page.find(":input[name='e.id']").val()},
				afterClose: function(status){
					$page.data("data-status","saved");
				}
			});
		});
	},
	/** 停保处理 */
	doSurrender : function() {
		var $page = $(this);
		// 让用户输入离职日期，默认为当前时间
		bc.page.newWin({
			name:"车辆停保处理",
			mid: "surrenderPolicy4CarOperate",
			url: bc.root + "/bc/common/selectDate",
			data: {title:"请输入停保日期"},
			afterClose: function(data){
				logger.info("data=" + $.toJSON(data));
				if(!data) return;
				//执行离职处理
				bc.ajax({
					url: bc.root + "/bc-business/policy4CarOperate/doSurrender",
					dataType: "json",
					data: {surrenderDate: data,id: $page.find(":input[name='e.id']").val()},
					success: function(json){
						//完成后提示用户
						bc.msg.info(json.msg);
						$page.dialog("close");
					}
				});
			}
		});
	},

	/** 维护处理 */
	doMaintenance : function() {
		var $page = $(this);
		bc.msg.confirm("是否对"+$page.find("#carInfo").text() + "的保单进行维护？",function(){
			// 关闭当前窗口
			$page.dialog("close");
			// 重新打开可编辑表单
			bc.page.newWin({
				name: "维护" + $page.find("#carInfo").text() + "的保单",
				mid: "policy" + $page.find(":input[name='e.id']").val(),
				url: bc.root + "/bc-business/policy/edit",
				data: {id: $page.find(":input[name='e.id']").val()}
			});
		});

	},


		
};