if(!window['bs'])window['bs']={};
bs.tempDriverForm = {
	searching: false,
	startFlowing:false,
	init : function(option,readonly) {
		var $form = $(this);
		
		//点击身份证input的灯泡自动生成籍贯、区域、生日
		$form.find("#autoLoadCarManIdentityInfo").click(function(){
			if(!bc.validator.validate($form.find(":input[name='e.certIdentity']").parent())){
				return;
			}
			var identityId=$form.find(":input[name='e.certIdentity']").val();
			var url=bc.root + "/bc-business/carMan/autoLoadCarManIdentityInfo?identityId="+identityId;
			$.ajax({
				url:url,
				dataType:"json",
				success:function(json){
					$form.find(":input[name='e.origin']").val(json.origin);
					$form.find("select[name='e.region']").val(json.area);
					$form.find(":input[name='e.birthdate']").val(json.birthday);
				}
			});
		});
		
		//绑定图片的修改
		$form.find("#portrait").click(function(){
			bc.image.edit({
				puid: $form.find(":input[name='e.uid']").val(),
				ptype: "portrait",
				onOk: function(json){
					//更新图片的连接地址，注意要添加时间戳，应浏览器会缓存img的请求
					var newImgUrl = bc.root + '/bc/image/download?id=' + json.id + "&ts=" + new Date().getTime();
					$form.find("#portrait").attr("src",newImgUrl);
				}
			});
		});
		
		//使用姓名查出租车协会司机信息
		$form.find("#selectCarManToTaxiNet4Name").click(function(){
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-showGroups").hide();
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-Groups").show();
			$(this).closest( ".bs-tempDriver-containers").find(".bs-tempDriver-hiddenGroups").show();
			var type="姓名";
			var value=$form.find(":input[name='e.name']").val();
			bs.tempDriverForm.doSearch.call($form,0,type,value);
			$form.find("#info").delegate("span.ui-icon-search","click",function(e) {
				bs.tempDriverForm.doSearch.call($form,$(this).attr("data-index"),type,value);
			});
		});
		
		//使用从业资格证查出租车协会司机信息
		$form.find("#selectCarManToTaxiNet4CYZG").click(function(){
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-showGroups").hide();
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-Groups").show();
			$(this).closest( ".bs-tempDriver-containers").find(".bs-tempDriver-hiddenGroups").show();
			var type="从业人员资格证";
			var value=$form.find(":input[name='e.certCYZG']").val();
			bs.tempDriverForm.doSearch.call($form,0,type,value);
			$form.find("#info").delegate("span.ui-icon-search","click",function(e) {
				bs.tempDriverForm.doSearch.call($form,$(this).attr("data-index"),type,value);
			});
		});
		
		//使用资格证查出租车协会司机信息
		$form.find("#selectCarManToTaxiNet4FWZG").click(function(){
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-showGroups").hide();
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-Groups").show();
			$(this).closest( ".bs-tempDriver-containers").find(".bs-tempDriver-hiddenGroups").show();
			var type="服务资格证";
			var value=$form.find(":input[name='e.certFWZG']").val();
			bs.tempDriverForm.doSearch.call($form,0,type,value);
			$form.find("#info").delegate("span.ui-icon-search","click",function(e) {
				bs.tempDriverForm.doSearch.call($form,$(this).attr("data-index"),type,value);
			});
		});
		
		//绑定反转内容信息区事件
		$form.delegate(".bs-tempDriver-reverse","click",function(){	
			$form.find(".bs-tempDriver-Groups").toggle("fast");
			$form.find(".bs-tempDriver-showGroups").toggle();
			$form.find(".bs-tempDriver-hiddenGroups").toggle();
		});
		
		//绑定展开事件
		$form.delegate(".bs-tempDriver-showGroups","click",function(){
			$(this).hide();
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-Groups").toggle('fast');
			$(this).closest( ".bs-tempDriver-containers").find(".bs-tempDriver-hiddenGroups").show();
		});
		
		//绑定隐藏事件
		$form.delegate(".bs-tempDriver-hiddenGroups","click",function(){
			$(this).toggle();
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-Groups").toggle('fast');
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-showGroups").toggle();
			$(this).closest(".bs-tempDriver-containers").find("tr.row").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
		});
		
		//----绑定发起流程事件---開始---
		var tableEl_tdwf=$form.find("#tdwfs")[0];
		//id: ,key:流程编码,flag：是否同步信息控制,name:流程名称,subject:主题名称
		function startFlow(id,key,flag,name,subject){
			bc.ajax({
				url : bc.root + "/bc-business/tempDriver/startFlow",
				data : {tdIds:id+',',flowKey:key,flagStatus:flag},
				dataType : "json",
				success : function(json) {
					bc.msg.slide(json.msg);
					if(json.success){
						//插入表格
						var newRow=tableEl_tdwf.insertRow(1);
						newRow.setAttribute("class","ui-widget-content row");
						var cell=newRow.insertCell(0);
						cell.style.padding="0";
						cell.style.textAlign="left";
						cell.setAttribute("class","id first");
						cell.innerHTML='<a class="bs-tempDriver-workFlow-processName" href="#">'
								+name
								+'</a>'
								+'<input type="hidden" class="bs-tempDriver-workFlow-procInstId" value="'
								+json.procInstId
								+'" />';
						
						cell=newRow.insertCell(1);
						cell.style.padding="0 0 0 5px";
						cell.style.textAlign="left";
						cell.setAttribute("class","middle");
						cell.innerHTML=subject;
						
						cell=newRow.insertCell(2);
						cell.style.padding="0 0 0 5px";
						cell.style.textAlign="left";
						cell.setAttribute("class","middle");
						cell.innerHTML=json.startTime;
						
						cell=newRow.insertCell(3);
						cell.style.padding="0 0 0 5px";
						cell.style.textAlign="left";
						cell.setAttribute("class","middle");
						cell.innerHTML='流转中';
						
						cell=newRow.insertCell(4);
						cell.style.padding="0";
						cell.style.textAlign="left";
						cell.setAttribute("class","last");
						
						$(newRow).dblclick(function(){
							bc.page.newWin({
								name: "工作空间",
								mid: "workspace"+json.procInstId,
								url: bc.root+ "/bc-workflow/workspace/open?id="+json.procInstId
							});
						});
						
						//流程名称超链接
						var $a=$(newRow).find(".bs-tempDriver-workFlow-processName");
						$a.click(function(){
							bc.page.newWin({
								name: "工作空间",
								mid: "workspace"+json.procInstId,
								url: bc.root+ "/bc-workflow/workspace/open?id="+json.procInstId
							});
						});
						
						$(newRow).hover(function(){
							$(this).toggleClass("ui-state-hover");
						});
						
						//更新司机的状态为审批中
						$form.find(":input[name='e.status']:eq(1)").attr("checked","checked");
						// 刷新边栏
						bc.sidebar.refresh();
						
						//打开工作空间
						bc.page.newWin({
							name: "工作空间",
							mid: "workspace"+json.procInstId,
							url: bc.root+ "/bc-workflow/workspace/open?id="+json.procInstId
						});
						
					}
					bs.tempDriverForm.startFlowing = false;
					return true;
				}
			});
		}
		
		$form.find("#startWorkFlow").click(function(){
			var id=$form.find(":input[name='e.id']").val();
			if(id == ''){
				bc.msg.alert("请先保存信息！");
				return;
			}

			var name=$form.find(":input[name='e.name']").val();
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-showGroups").hide();
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-Groups").show();
			$(this).closest( ".bs-tempDriver-containers").find(".bs-tempDriver-hiddenGroups").show();
			
			if(!bs.tempDriverForm.startFlowing){
				bs.tempDriverForm.startFlowing = true;
				bc.msg.confirm("确认发起<b>"+name+"</b>的<b>司机新入职、留用审批流程</b>？"
						,function(){
							startFlow(id,"CarManEntry",true,"司机新入职、留用审批流程","司机新入职、留用审批("+name+")");
						},function(){
							bs.tempDriverForm.startFlowing = false;
						},"发起流程确认窗口");
			}	
		});
		
		$form.find("#startWorkFlow4Cert").click(function(){
			bc.msg.alert("司机服务资格证办理流程开发中。。。。");
			return;
			
			var id=$form.find(":input[name='e.id']").val();
			if(id == ''){
				bc.msg.alert("请先保存信息！");
				return;
			}
			
			var name=$form.find(":input[name='e.name']").val();
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-showGroups").hide();
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-Groups").show();
			$(this).closest( ".bs-tempDriver-containers").find(".bs-tempDriver-hiddenGroups").show();
			
			if(!bs.tempDriverForm.startFlowing){
				bs.tempDriverForm.startFlowing = true;
				bc.msg.confirm("确认发起<b>"+name+"</b>的<b>司机服务资格证办理流程</b>？"
						,function(){
							startFlow(id,"RequestServiceCertificate",false,"司机服务资格证办理流程","司机服务资格证办理("+name+")");
						},function(){
							bs.tempDriverForm.startFlowing = false;
						},"发起流程确认窗口");
			}	
		});
		
		
		//鼠标单击流程名称事件
		$form.find("#tdwfs").delegate(".bs-tempDriver-workFlow-processName","click",function(){
			var $tr=$(this).closest("tr");
			var procInstId=$tr.find(".bs-tempDriver-workFlow-procInstId").val();
			bc.page.newWin({
				name: "工作空间",
				mid: "workspace"+procInstId,
				url: bc.root+ "/bc-workflow/workspace/open?id="+procInstId
			});
		});
		
		//----绑定发起流程事件---結束---
	
		//----工作经历表格事件---开始---
		var tableEl_we=$form.find("#wes")[0];
		$form.find("#addLine_we").click(function(){
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-showGroups").hide();
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-Groups").show();
			$(this).closest( ".bs-tempDriver-containers").find(".bs-tempDriver-hiddenGroups").show();
			var newRow=tableEl_we.insertRow(tableEl_we.rows.length);
			newRow.setAttribute("class","ui-widget-content row");
			var cell=newRow.insertCell(0);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","id first");
			cell.innerHTML='<span class="ui-icon"></span>';
			
			cell=newRow.insertCell(1);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML=
				'<div class="relative" style="display:inline;">'
					+'<input type="text" data-validate=\'{"type":"date"}\' '
						+'style="width:7em;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" '
						+'class="bc-date ui-widget-content"/>'
					+'<ul class="inputIcons">'
						+'<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>'
					+'</ul>'
				+'</div>'
				+'<div style="width:1em;display:inline;">'
					+'~'
				+'</div>'
				+'<div class="relative" style="display:inline;">'
					+'<input type="text" data-validate=\'{"type":"date"}\' '
						+'style="width:7em;height:100%;border:none;margin:0;padding:0 0 0 2px;background:none;" '
						+'class="bc-date ui-widget-content"/>'
					+'<ul class="inputIcons">'
						+'<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"></li>'
					+'</ul>'
				+'</div>';
			//绑定日期选择
			bc.form.initCalendarSelect($(cell));
			
			cell=newRow.insertCell(2);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input type="text" style="width:100%;height:100%;border:none;padding:0 0 0 2px;background:none;" class="ui-widget-content" data-validate="required"  />';
			
			cell=newRow.insertCell(3);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input type="text" style="width:100%;height:100%;border:none;padding:0 0 0 2px;background:none;" class="ui-widget-content"/>';
					
			cell=newRow.insertCell(4);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","last");
			cell.innerHTML='<input type="text" style="width:100%;height:100%;border:none;padding:0 0 0 2px;background:none;" class="ui-widget-content" data-validate=\'{"type":"phone"}\' />';
		
		});
		
		//点击选中行
		$form.find("#wes").delegate("tr.ui-widget-content.row>td.id","click",function(){
			$(this).parent().toggleClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").toggleClass("ui-icon-check");
		});
		$form.find("#wes").delegate("tr.ui-widget-content.row input","focus",function(){
			$(this).closest("tr.row").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
		});
		
		//删除表中选中的
		$form.find("#deleteLine_we").click(function() {
			var $trs = $form.find("#wes tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要删除的工作经历！");
				return;
			}
			bc.msg.confirm("确定要删除选定的 <b>"+$trs.length+"</b>条工作经历吗？",function(){
				for(var i=0;i<$trs.length;i++){
					$($trs[i]).remove();
				}
			});
			
		});
		
		//上移表中选中的明细项目
		$form.find("#upLine_we").click(function() {
			var $trs = $form.find("#wes tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要上移的！");
				return;
			}else{
				$trs.each(function(){
					var $tr = $(this);
					if($tr[0].rowIndex < 2){
						bc.msg.slide("选中的为第一条,不能再上移！");					
					}else{
						var $beroreTr=$tr.prev();
						$beroreTr.insertAfter($tr);
					}
				});
			}

		});
		//下移表中选中的明细项目
		$form.find("#downLine_we").click(function() {
			var $trs = $form.find("#wes tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要下移的！");
				return;
			}else{
				
				for(var i=$trs.length;i>0;i--){
					var $tr=$($trs[i-1]);
					var $beroreTr=$tr.next();
					if($beroreTr.length==0){
						bc.msg.slide("选中的为一条项目,不能再下移！");					
					}else{
						$beroreTr.insertBefore($tr);
					}
				}
			}
		});
		//----工作经历表格事件---结束---
		
		//----家庭成员表格事件---开始---
		var tableEl_fm=$form.find("#fms")[0];
		$form.find("#addLine_fm").click(function(){
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-showGroups").hide();
			$(this).closest(".bs-tempDriver-containers").find(".bs-tempDriver-Groups").show();
			$(this).closest( ".bs-tempDriver-containers").find(".bs-tempDriver-hiddenGroups").show();
			var newRow=tableEl_fm.insertRow(tableEl_fm.rows.length);
			newRow.setAttribute("class","ui-widget-content row");
			var cell=newRow.insertCell(0);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","id first");
			cell.innerHTML='<span class="ui-icon"></span>';
			
			cell=newRow.insertCell(1);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input type="text" style="width:100%;height:100%;border:none;padding:0 0 0 2px;background:none;" class="ui-widget-content" data-validate="required" />';
			
			cell=newRow.insertCell(2);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input type="text" style="width:100%;height:100%;border:none;padding:0 0 0 2px;background:none;" class="ui-widget-content" />';
					
			cell=newRow.insertCell(3);
			cell.style.padding="0";
			cell.style.textAlign="left";
			cell.setAttribute("class","middle");
			cell.innerHTML='<input type="text" style="width:100%;height:100%;border:none;padding:0 0 0 2px;background:none;" class="ui-widget-content" data-validate=\'{"type":"phone"}\' />';

			cell=newRow.insertCell(4);
			cell.style.minWidth="0.001em";
			cell.setAttribute("class","last");
			cell.innerHTML='<input type="text" style="width:100%;height:100%;border:none;padding:0 0 0 2px;background:none;" class="ui-widget-content" />';
		
		});
		
		//点击选中行
		$form.find("#fms").delegate("tr.ui-widget-content.row>td.id","click",function(){
			$(this).parent().toggleClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").toggleClass("ui-icon-check");
		});
		$form.find("#fms").delegate("tr.ui-widget-content.row input","focus",function(){
			$(this).closest("tr.row").removeClass("ui-state-highlight").find("td:eq(0)>span.ui-icon").removeClass("ui-icon-check");
		});
		
		//删除表中选中的
		$form.find("#deleteLine_fm").click(function() {
			var $trs = $form.find("#fms tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要删除的家庭成员信息！");
				return;
			}
			bc.msg.confirm("确定要删除选定的 <b>"+$trs.length+"</b>条家庭成员信息吗？",function(){
				for(var i=0;i<$trs.length;i++){
					$($trs[i]).remove();
				}
			});
			
		});
		
		//上移表中选中的明细项目
		$form.find("#upLine_fm").click(function() {
			var $trs = $form.find("#fms tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要上移的！");
				return;
			}else{
				$trs.each(function(){
					var $tr = $(this);
					if($tr[0].rowIndex < 2){
						bc.msg.slide("选中的为第一条,不能再上移！");					
					}else{
						var $beroreTr=$tr.prev();
						$beroreTr.insertAfter($tr);
					}
				});
			}

		});
		//下移表中选中的明细项目
		$form.find("#downLine_fm").click(function() {
			var $trs = $form.find("#fms tr.ui-state-highlight");
			if($trs.length == 0){
				bc.msg.slide("请先选择要下移的！");
				return;
			}else{
				
				for(var i=$trs.length;i>0;i--){
					var $tr=$($trs[i-1]);
					var $beroreTr=$tr.next();
					if($beroreTr.length==0){
						bc.msg.slide("选中的为一条项目,不能再下移！");					
					}else{
						$beroreTr.insertBefore($tr);
					}
				}
			}
		});
		//----家庭成员表格事件---结束---
	},
	//保存的处理
	save : function(){
		$page = $(this);
		//表单先验证一次
		if(!bc.validator.validate($page))
			return;
		
		//工作经历
		var workExperienceDetails=[];
		$page.find("#wes tr:gt(0)").each(function(){
			var $inputs = $(this).find(":input");
			var json = {
				startDate: $inputs[0].value,
				endDate: $inputs[1].value,
				unit: $inputs[2].value,
				certifier: $inputs[3].value,
				phone: $inputs[4].value
			};
			workExperienceDetails.push(json);
		});
		if(workExperienceDetails.length>0){
			$page.find(":input[name='e.listWorkExperience']").val($.toJSON(workExperienceDetails));
		}else{
			$page.find(":input[name='e.listWorkExperience']").val("");
		}
		
		//家庭信息
		var familyDetails=[];
		$page.find("#fms tr:gt(0)").each(function(){
			var $inputs = $(this).find(":input");
			var json = {
				name: $inputs[0].value,
				relation: $inputs[1].value,
				phone: $inputs[2].value,
				desc: $inputs[3].value
			};
			familyDetails.push(json);
		});
		if(familyDetails.length>0){
			$page.find(":input[name='e.listFamily']").val($.toJSON(familyDetails));
		}else{
			$page.find(":input[name='e.listFamily']").val("");
		}
		
		//身份证唯一性的验证
		var certIdentity=$page.find(":input[name='e.certIdentity']").val();
		var tdId=$page.find(":input[name='e.id']").val();
		bc.ajax({
			url: bc.root + "/bc-business/tempDriver/isUniqueCertIdentity",
			dataType: "json",
			data: {certIdentity: certIdentity,tdId:tdId},
			success: function(json){
				if(json.unique){ 
					//调用标准的方法执行保存
					bc.page.save.call($page);
					$page.find(":input[name='creditStatus']").val(1);
				}else{
					var str="系统已保存身份证号码:<br>";
					str +="<a id='tempDriverUnique' href=#>";
					str +=certIdentity;
					str +="</a><br>的招聘司机信息";
					var $a = bc.msg.alert(str);
					$a.find('#tempDriverUnique').click(function(){
						bc.page.newWin({
							url: bc.root + "/bc-business/tempDriver/open?id="+json.id,
							name: "查看招聘司机信息",
							mid:  "tempDriver.open." + json.id,
							afterClose: function(){
							}
						})
						$a.dialog("close");
					});
				}
			}
		});
		
	},
	//查找信誉档案
	doSearch : function(index,type,value) {
		if(bs.tempDriverForm.searching)
			return;
		
		if(value == ''){
			bc.msg.alert("请输入"+type+"!");
			return
		}
		
		var startTime = new Date().getTime();
		var $page = $(this);
		
		var $info = $page.find("#info");
		var $waste = $page.find("#waste");
		$info.html("");
		$waste.html("正在连接出租协会网，会比较耗时，请耐心等候...");
		bs.tempDriverForm.searching = true;
		bc.ajax({
			url : bc.root + "/bc-business/gztaxixh/findDriverInfo",
			data : {value: value,type:type,index: index || 0},
			dataType : "json",
			success : function(json) {
				$waste.html("(" + bc.getWasteTime(startTime) + ")");
				if (json.success && !json.msg) {
					//转为jquery对象
					var $detail=$(json.detail);
					//显示效果处理
					$detail.css("width","100%");
					$detail.find("tr:first>.boxRight:first").removeAttr("width");
					$detail.find("tr:first>.boxRight:first").css("width","auto");
					$detail.find("tr:first>.boxRight:last").removeAttr("width");
					$detail.find("tr:first>.boxRight:last").css("width","100px");
					$page.find(":input[name='creditStatus']").val(2);
					$page.find(":input[name='e.credit']").val($detail.get(0).outerHTML);
					$info.html(json.simple).append($detail);
				} else {
					$info.html("<div class='error ui-state-error'>" + json.msg + "</div>");
				}
				bs.tempDriverForm.searching = false;
			}
		});
	},
	/** 身份证验证方法:上下文为validate对象 */
	validateIndentity : function(element, $form){
		return /^(\d{15}|(\d{17}\w{1}))$/.test(element.value);
	},
	/** 从模板添加附件 */
	addAttachFromTemplate: function(){
		var $atm = $(this)
		var $page = $atm.closest(".bc-page");
		var id = $page.find(":input[name='e.id']").val();
		if(id == ""){
			bc.msg.alert("请先保存信息，再添加模板。");
			return;
		}
			
		bc.addAttachFromTemplate($atm, id, bc.root + "/bc-business/tempDriver/addAttachFromTemplate",{
			category: "营运系统/司机招聘附件",
			multiple: true
		});
	}
	
};