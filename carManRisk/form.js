if(!window['bs'])window['bs']={};
bc.carManRiskForm = {
	init : function(option,readonly) {
		var $form = $(this);
		
		$form.delegate(".showItem","click",function(){
			var $li=$(this);
			var $item=$li.closest(".item");
			var status=$li.attr("data-show-status");
			$li.toggleClass("ui-icon-carat-1-s ui-icon-carat-1-n");
			var $table=$item.find("table");
			$table.toggle("fast",function(){
				if(status=="1"){
					$li.attr("data-show-status","2");
					$li.attr('title','点击展出内容');
				}else{
					$li.attr("data-show-status","1");
					$li.attr('title','点击隐藏内容');
				}
			});
		});
		
		$form.delegate(".carManName","click",function(){
			var $tr=$(this).closest("tr");
			bc.page.newWin({
				name: "司机信息",
				mid: "carMan."+$tr.attr("data-id"),
				url: bc.root+ "/bc-business/carMan/edit?id="+$tr.attr("data-id")
			});
		});
		
		//只读权限控制
		if(readonly) return;
		
		$form.find("#addCarMan").click(function() {
			var selecteds = $form.find(":input[name='e.driverName']").val();
			bs.selectDriver({
				selecteds : (selecteds && selecteds.length > 0) ? selecteds : null,
				onOk : function(carMan) {
					$form.find(":input[name='e.driverId']").val(carMan.id);
					$form.find(":input[name='e.driverName']").val(carMan.name);
				}
			});
					
		});
		
		//添加行
		$form.find(".addItem").click(function(){
			var $item=$(this).closest(".item");
			var name=$item.attr("data-item-name");
			var type=$item.attr("data-item-type");
			var tableEl=$item.find("table")[0];
			if(type == null || type == '')return;
			//根据类型调用相应添加行的处理方法
			if(type == "carman"){
				addCarMans(tableEl);
			}else if(type == "item"){
				addItem(tableEl);	
			}
		});
		
		//点击选中行
		$form.find(".item").delegate("tr.ui-widget-content.row>td.id","click",function(){
			$(this).parent().toggleClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").toggleClass("ui-icon-check");
		});
		$form.find(".item").delegate("tr.ui-widget-content.row input","focus",function(){
			$(this).closest("tr.row").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
		});
		//删除表中选中的
		$form.find(".deleteItem").click(function() {
			var $item=$(this).closest(".item");
			var name=$item.attr("data-item-name");
			
			var $trs = $item.find("tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要删除的信息！");
				return;
			}
			bc.msg.confirm("确定要删除选定的 <b>"+$trs.length+"</b>条"+name+"信息吗？",function(){
				for(var i=0;i<$trs.length;i++){
					$($trs[i]).remove();
				}
			});
			
		});
		
		//上移表中选中的明细项目
		$form.find(".upItem").click(function() {
			var $item=$(this).closest(".item");
			var $trs = $item.find("tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要上移的！");
				return;
			}else{
				$trs.each(function(){
					var $tr = $(this);
					if($tr[0].rowIndex < 2){
						bc.msg.slide("选中的为第一条信息,不能再上移！");					
					}else{
						var $beroreTr=$tr.prev();
						$beroreTr.insertAfter($tr);
					}
				});
			}

		});
		//下移表中选中的明细项目
		$form.find(".downItem").click(function() {
			var $item=$(this).closest(".item");
			var $trs = $item.find("tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要下移的！");
				return;
			}else{
				for(var i=$trs.length;i>0;i--){
					var $tr=$($trs[i-1]);
					var $beroreTr=$tr.next();
					if($beroreTr.length==0){
						bc.msg.slide("选中的为一条信息,不能再下移！");					
					}else{
						$beroreTr.insertBefore($tr);
					}
				}
			}
		});
		
		
		//添加司机
		function  addCarMans(tableEl){
			var $row=$(tableEl).find("tr.row");
			
			bs.selectCarMan ({
				multiple : true,
				status : "0,1,-1",
				onOk : function(carMans) {
					
					for(var i=0;i <carMans.length;i++){
						var insert=true;
						//重复的不再插入
						if($row.size()>0){
							$row.each(function(index){
								if($(this).attr("data-id")==carMans[i].id){
									insert=false;
								}
							});
						}
						if(!insert)continue;
						
						//插入行
						var newRow=tableEl.insertRow(tableEl.rows.length);
						newRow.setAttribute("class","ui-widget-content row");
						newRow.setAttribute("data-id",carMans[i].id);
						
						//插入列
						var cell=newRow.insertCell(0);
						cell.style.padding="0";
						cell.style.textAlign="left";
						cell.setAttribute("class","id first");
						cell.innerHTML='<span class="ui-icon"></span>';
						
						//插入姓名
						insertMiddleCell(newRow,1,'<a class="carManName" href="#">'
							+carMans[i].name
							+'</a>');
						
						//插入状态
						if(carMans[i].status=="0"){
							insertMiddleCell(newRow,2,"在案");
						}else if(carMans[i].status=="1"){
							insertMiddleCell(newRow,2,"注销");
						}else if(carMans[i].status=="-1"){
							insertMiddleCell(newRow,2,"草稿");
						}else{
							insertMiddleCell(newRow,2,"");
						}
						
						//插入身份证号
						insertMiddleCell(newRow,3,carMans[i].certIdentity);

						//插入空白列
						cell=newRow.insertCell(4);
						cell.style.minWidth="0.001em";
						cell.setAttribute("class","last");
						
						$(newRow).find(".carManMane").click(function(){
							bc.page.newWin({
								name: "司机信息",
								mid: "carMan."+carMans[i].id,
								url: bc.root+ "/bc-business/carMan/edit?id="+carMans[i].id
							});
						});
					}		
				}
			});
			
		}
		
		//添加险种
		function addItem(tableEl){
			//插入行
			var newRow=tableEl.insertRow(tableEl.rows.length);
			newRow.setAttribute("class","ui-widget-content row");
			
			//插入列
			var cell=newRow.insertCell(0);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","id first");
			cell.innerHTML='<span class="ui-icon"></span>';

			insertMiddleCell(newRow,1
					,'<input type="text" style="width:100%;height:100%;padding:0;margin:0;border:none;background:none;" data-validate="required" />');
			
			insertMiddleCell(newRow,2
					,'<input type="text" style="width:100%;height:100%;padding:0;margin:0;border:none;background:none;" data-validate="required" />');
			
			insertMiddleCell(newRow,3
					,'<input type="text" style="width:100%;height:100%;padding:0;margin:0;border:none;background:none;" data-validate="required" />');
			
			cell=newRow.insertCell(4);
			cell.style.minWidth="0.001em";
			cell.setAttribute("class","last");
			cell.innerHTML='<input type="text" style="width:100%;height:100%;padding:0;margin:0;border:none;background:none;"/>';
		}
		
		//插入中间的行
		function insertMiddleCell(newRow,index,innerHtml){
			var cell=newRow.insertCell(index);
			cell.style.padding="0 0 0 2px";
			cell.setAttribute("class","middle");
			cell.innerHTML=innerHtml;
		}
	

	},
	//保存的处理
	save : function(){
		var $form = $(this);
		//先验证 必须有参保司机的信息
		var $insurantsTableTr=$form.find("#insurantsTable tr");
		if($insurantsTableTr.size()==1){
			bc.msg.alert("必须添加参保司机信息");
			return;
		}
		
		bc.carManRiskForm.saveCarMans.call(this);
		bc.carManRiskForm.saveItems.call(this);
		
		//调用标准的方法执行保存
		bc.page.save.call(this);
		
	},
	//保存并关闭处理
	saveAndClose : function(){
		var $form = $(this);
		//先验证 必须有参保司机的信息
		var $insurantsTableTr=$form.find("#insurantsTable tr");
		if($insurantsTableTr.size()==1){
			bc.msg.alert("必须添加参保司机信息");
			return;
		}
		
		bc.carManRiskForm.saveCarMans.call(this);
		bc.carManRiskForm.saveItems.call(this);
		
		//调用标准的方法执行保存
		bc.page.save.call(this,{callback:function(){
			$form.dialog("close");
		}});
		
	},
	//处理保存的参保司机信息
	saveCarMans : function(){
		var $form = $(this);
		var $row = $form.find("#insurantsTable .row");
		var detail="";
		$row.each(function(index){
			detail+=$(this).attr("data-id");
			if(index+1<$row.size())
				detail+=",";
		});
		$form.find("input:[name='insurants']").val(detail);
	},
	//处理保存的险种信息
	saveItems : function(){
		var $form = $(this);
		var $row = $form.find("#itemsTable .row");
		var items=[];
		$row.each(function(index){
			var $inputs = $(this).find(":input");
			var json = {
					name: $inputs[0].value,
					coverage: $inputs[1].value,
					premium: $inputs[2].value,
					description: $inputs[3].value	
				};
			var id = $(this).attr("data-id");
			if(id && id.length > 0)
				json.id = id;
			items.push(json);
		});
		$form.find("input:[name='items']").val($.toJSON(items));
	}
};