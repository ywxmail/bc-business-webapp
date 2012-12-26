if(!window['bs'])window['bs']={};

/**
 * 选择司机、责任人信息
 * @param {Object} option 配置参数
 * @option {Boolean} multiple [可选]是否允许多选，默认false
 * @option {Boolean} paging [可选]是否分页，默认true
 * @option {String} status [可选]车辆的状态，默认在案，设为空则代表所有状态
 * @option {String} types [可选]类型：0-司机、1-责任人2-司机和责任人，多个值用逗号连接，为空代表选择所有类型
 * @option {Function} onOk 选择完毕后的回调函数，函数第一个参数为选中的司机、责任人信息，
 * 							如果为多选则返回的是数组，每个司机、责任人的格式为{id:[id],name:[name],type:[type]}
 * @option {String} mid [可选]对话框的id
 * @option {String} title [可选]对话框的标题
 * @option {String} selecteds [可选]已选中司机、责任人的id值，多个值用逗号连接
 */
bs.selectCarMan = function(option) {
	// 构建默认参数
	option = jQuery.extend({
		mid: 'selectCarMan',
		paging: true,
		title: '选择司机责任人信息',
		types: '0,1,2'
	},option);
	
	// 将一些配置参数放到data参数内(这些参数是提交到服务器的参数)
	option.data = jQuery.extend({
		status: '0',
		multiple: false
	},option.data);
	if(option.types)
		option.data.types = option.types;
	if(option.title)
		option.data.title = option.title;
	if(option.selecteds)
		option.data.selecteds = option.selecteds;
	if(option.excludes)
		option.data.excludes = option.excludes;
	if(option.multiple === true)
		option.data.multiple = true;
	if(option.status)
		option.data.status = option.status;
	
	//弹出选择对话框
	bc.page.newWin(jQuery.extend({
		url: bc.root + "/bc-business/selectCarMan/" + (option.paging ? "paging" : "list"),
		name: option.title,
		mid: option.mid,
		afterClose: function(status){
			if(status && typeof(option.onOk) == "function"){
				option.onOk(status);
			}
		}
	},option));
};

/**
 * 选择司机信息
 * @param {Object} option 配置参数
 * @option {Boolean} multiple [可选]是否允许多选，默认false
 * @option {Function} onOk 选择完毕后的回调函数，函数第一个参数为选中的司机信息，
 * 							如果为多选则返回的是数组，每个司机的格式为{id:[id],name:[name],type:[type]}
 * @option {String} selecteds [可选]已选中司机的id值，多个值用逗号连接
 */
bs.selectDriver = function(option) {
	return bs.selectCarMan(jQuery.extend({
		mid: 'selectDriver',
		title: '选择司机信息',
		types: '0,2',
		status: '0,1'
	},option));
};

/**
 * 选择责任人信息
 * @param {Object} option 配置参数
 * @option {Boolean} multiple [可选]是否允许多选，默认false
 * @option {Function} onOk 选择完毕后的回调函数，函数第一个参数为选中的责任人信息，
 * 							如果为多选则返回的是数组，每个责任人的格式为{id:[id],name:[name],type:[type]}
 * @option {String} selecteds [可选]已选中责任人的id值，多个值用逗号连接
 */
bs.selectCharger = function(option) {
	return bs.selectCarMan(jQuery.extend({
		mid: 'selectCharger',
		title: '选择责任人信息',
		types: '1,2'
	},option));
};

/**
 * 选择车队信息
 * @param {Object} option 配置参数
 * @option {Boolean} multiple [可选]是否允许多选，默认false
 * @option {Function} onOk 选择完毕后的回调函数，函数第一个参数为选中的车队信息，
 * 							如果为多选则返回的是数组，每个车队的格式为{id:[id],name:[name]}
 * @option {String} selecteds [可选]已选中车队的id值，多个值用逗号连接
 */
bs.selectMotorcade = function(option) {
	// 构建默认参数
	option = jQuery.extend({
		mid: 'selectMotorcade',
		title: '选择车队信息'
	},option);
	
	// 将一些配置参数放到data参数内(这些参数是提交到服务器的参数)
	option.data = jQuery.extend({
		multiple: false
	},option.data);
	if(option.selecteds)
		option.data.selecteds = option.selecteds;
	if(option.multiple === true)
		option.data.multiple = true;
	
	//弹出选择对话框
	bc.page.newWin(jQuery.extend({
		url: bc.root + "/bc-business/motorcade/select",
		name: option.title,
		mid: option.mid,
		afterClose: function(status){
			if(status && typeof(option.onOk) == "function"){
				option.onOk(status);
			}
		}
	},option));
};

/**
 * 选择车辆信息
 * @param {Object} option 配置参数
 * @option {Boolean} multiple [可选]是否允许多选，默认false
 * @option {Boolean} paging [可选]是否分页，默认true
 * @option {String} status [可选]车辆的状态，默认在案，设为空则代表所有状态
 * @option {Function} onOk 选择完毕后的回调函数，函数第一个参数为选中的车辆信息，
 * 							如果为多选则返回的是数组，每个车辆的格式为：
 * 							{id:[id],plate:[plate],plateType:[plateType],plateNo:[plateNo],company:[company]}
 * @option {String} selecteds [可选]已选中车辆的id值，多个值用逗号连接
 */
bs.selectCar = function(option) {
	// 构建默认参数
	option = jQuery.extend({
		mid: 'selectCar',
		paging: true,
		title: '选择车辆信息'
	},option);

	// 将一些配置参数放到data参数内(这些参数是提交到服务器的参数)
	option.data = jQuery.extend({
		status: '0,1',
		multiple: false
	},option.data);
	if(option.selecteds)
		option.data.selecteds = option.selecteds;
	if(option.multiple === true)
		option.data.multiple = true;
	if(option.status)
		option.data.status = option.status;
	
	//弹出选择对话框
	bc.page.newWin(jQuery.extend({
		url: bc.root + "/bc-business/selectCar/" + (option.paging ? "paging" : "list"),
		name: option.title,
		mid: option.mid,
		afterClose: function(status){
			if(status && typeof(option.onOk) == "function"){
				option.onOk(status);
			}
		}
	},option));
};

/**
 * 通过车辆id或车牌号查询相关信息
 * @param {Object} option 配置参数
 * @option {String} carId 车辆id
 * @option {String} carPlate 车牌号，如"粤A.E1P11"，如果指定了carId将忽略该参数
 * @option {String} emptyMsg 如找不到司机时对应的自定义提示信息
 * @option {String} multMsg 如找到多个司机时对应的自定义提示信息
 * @option {Function} success 信息获取成功后的回调函数，函数第一个参数为返回的相关信息，格式为
 * 	{
 * 		car:{id:[id],plate:[plate],status:[status],registerDate:[registerDate],company:[company],bsType:[bsType]},
 * 		motorcade:{
 * 			id: [id],						-- 车队id
 * 			name: [name]					-- 车队名称
 * 		},
 * 		driver:{
 * 			id: [id],						-- 司机id
 * 			name: [name],					-- 司机姓名
 * 			sex: [sex],						-- 司机性别
 * 			classes: [classes],				-- 司机营运班次
 * 			cert4FWZG: [cert4FWZG],			-- 司机的服务资格证
 * 			cert4IDENTITY: [cert4IDENTITY],	-- 司机身份证
 *			origin： [origin],				-- 籍贯
 *			houseType： [houseType],			-- 户口类型
 *			birthDate： [birthDate],			-- 出生日期
 *			age： [age],						-- 年龄
 * 			icId: [icId]					-- 司机IC卡的id
 *          classes:[classes]               --营运班次
 * 		}
 * 	}
 */
bs.findInfoByCar = function(option) {
	var data = {};
	if(option.carId) data.carId = option.carId;
	if(option.carPlate) data.carPlate = option.carPlate;
	if(option.status) data.status = option.status;
	bc.ajax({
		dataType: "json", data: data,
		url: bc.root + "/bc-business/findInfoByCar",
		success: function(json){
			logger.info("json=" + $.toJSON(json));
			if(json.drivers.length == 0){
				//提示用户此不正常现象
				bc.msg.alert(option.emptyMsg || "没有找到所选车辆对应的营运司机信息！",null,function(){
					//直接调用回调函数,但没有司机信息
					option.success.call(json,{
						car: json.car,
						motorcade: json.motorcade
					});
				});

			}else if(json.drivers.length == 1){
				if(option.multiple==true){
					var carMans =[];
					carMans.push({
						id: json.drivers[0].id,
						name: json.drivers[0].name,
						classes: json.drivers[0].classes,
						cert4FWZG:json.drivers[0].cert4FWZG,
						certDrivingFirstDate:json.drivers[0].certDrivingFirstDate,
						workDate:json.drivers[0].workDate
					});
					//调用回调函数，返回司机信息
					option.success.call(json,{
						car: json.car,
						motorcade: json.motorcade,
						driver: carMans
					});
					}
				//直接调用回调函数，返回司机信息
				option.success.call(json,{
					car: json.car,
					motorcade: json.motorcade,
					driver: json.drivers[0]
				});
			}else{
				//--让用户选择司机后再调用回调函数
				//生成对话框的html代码
				var html = [];
				html.push('<div class="bc-page" data-type="dialog">');
				html.push('<div style="margin: 4px;">');
				html.push('<select id="drivers" size="10" style="width:100%;height:100%;" multiple='+option.multiple+'>');
				var drivers = json.drivers;
				for(var i=0; i<drivers.length; i++){
					html.push('<option value="' + drivers[i].id + '"');
					if(i == 0){
						//默认选中第一个司机
						html.push(' selected="selected"');
					}
					html.push('>' + drivers[i].name + '</option>');
				}
				html.push('</select>');
				html.push('</div>');
				html.push('</div>');
				html = $(html.join("")).appendTo("body");
				
				//绑定双击事件
				function onSelectDriver(){
					if(driversEl.selectedIndex == -1){
						alert("请先选择司机！");
						return false;
					}
					//多选时返回的司机信息为数组
					if(option.multiple==true){
						var len = driversEl.length;
						var carMans =[];
						var o;
						for(var i=len-1; i>=0; i--){
							o = driversEl.options[i];
							if(o.selected){
								carMans.push({
									id: o.value,
									name: o.text,
									classes: drivers[i].classes,
									cert4FWZG:json.drivers[i].cert4FWZG,
									certDrivingFirstDate:json.drivers[i].certDrivingFirstDate,
									workDate:json.drivers[i].workDate
								});
							}
						}
						//调用回调函数，返回司机信息
						option.success.call(json,{
							car: json.car,
							motorcade: json.motorcade,
							driver: carMans
						});
						}else{
						//调用回调函数，返回司机信息
						option.success.call(json,{
							car: json.car,
							motorcade: json.motorcade,
							driver: drivers[driversEl.selectedIndex]
						});
					}
					//销毁对话框
					html.dialog("destroy").remove();
				}
				var driversEl = html.find("#drivers").dblclick(onSelectDriver).keyup(function(e){
					if (e.which == 13) { //按下回车键
						onSelectDriver();
					}
				})[0];
				
				//弹出对话框让用户选择司机
				html.dialog({
					id: "selectDriver4findInfoByCar",
					title: option.multMsg || "此车辆有多个营运司机，请选择一个",
					dialogClass: 'bc-ui-dialog ui-widget-header',
					width:300,modal:true,
					buttons:[{text:"确定",click: onSelectDriver}]
				});				
			}
		}
	});
};

/**
 * 通过司机id或姓名查询相关信息
 * @param {Object} option 配置参数
 * @option {String} driverId 司机id
 * @option {String} driverName 姓名
 * @option {Function} success 信息获取成功后的回调函数，函数第一个参数为返回的相关信息，格式为
 * 	{
 * 		car:{id:[id],plate:[plate],registerDate:[registerDate]bsType:[bsType]},
 * 		motorcade:{
 * 			id: [id],						-- 车队id
 * 			name: [name]					-- 车队名称
 * 		},
 * 		driver:{
 * 			id: [id],						-- 司机id
 * 			name: [name],					-- 司机姓名
 * 			sex: [sex],						-- 司机性别
 * 			classes: [classes],				-- 司机营运班次
 * 			cert4FWZG: [cert4FWZG],			-- 司机的服务资格证
 * 			cert4IDENTITY: [cert4IDENTITY],	-- 司机身份证
 *			origin： [origin],				-- 籍贯
 *			houseType： [houseType],			-- 户口类型
 *			birthDate： [birthDate],			-- 出生日期
 *			age： [age],						-- 年龄
 * 			icId: [icId]					-- 司机IC卡的id
 *            status: [status]                --司机状态
 * 		}
 * 	}
 */
bs.findInfoByDriver = function(option) {
	var data = {};
	if(option.driverId) data.driverId = option.driverId;
	if(option.driverName) data.driverName = option.driverName;
	bc.ajax({
		dataType: "json", data: data,
		url: bc.root + "/bc-business/findInfoByDriver",
		success: function(json){
			logger.info("json=" + $.toJSON(json));
			if(json.cars.length == 0){
				//提示用户此不正常现象
				bc.msg.alert("没有找到所选司机对应的营运车辆信息，无法处理！",null,function(){
					//直接调用回调函数,但没有司机信息
					option.success.call(json,{
						driver: json.driver,
						motorcade: json.motorcade
					});
				});
			}else if(json.cars.length == 1){
				//直接调用回调函数，返回车辆信息
				option.success.call(json,{
					driver: json.driver,
					motorcade: json.motorcade,
					car: json.cars[0]
				});
			}else{
				//--让用户选择车辆后再调用回调函数
				//生成对话框的html代码
				var html = [];
				html.push('<div class="bc-page" data-type="dialog">');
				html.push('<div style="margin: 4px;">');
				html.push('<select id="cars" size="10" style="width:100%;height:100%;">');
				var cars = json.cars;
				for(var i=0; i<cars.length; i++){
					html.push('<option value="' + cars[i].id + '"');
					if(i == 0){
						//默认选中第一辆车
						html.push(' selected="selected"');
					}
					html.push('>' + cars[i].plate + '</option>');
				}
				html.push('</select>');
				html.push('</div>');
				html.push('</div>');
				html = $(html.join("")).appendTo("body");
				
				//绑定双击事件
				function onSelectCar(){
					if(carsEl.selectedIndex == -1){
						alert("请先选择车辆！");
						return false;
					}
					//调用回调函数，返回车辆信息
					option.success.call(json,{
						driver: json.driver,
						motorcade: json.motorcade,
						car: cars[carsEl.selectedIndex]
					});
					//销毁对话框
					html.dialog("destroy").remove();
				}
				var carsEl = html.find("#cars").dblclick(onSelectCar)[0];
				
				//弹出对话框让用户选择车辆
				html.dialog({
					id: "selectcar4findInfoByDriver",
					title: "此司机营运多辆车，请选择一辆",
					dialogClass: 'bc-ui-dialog ui-widget-header',
					width:300,modal:true,
					buttons:[{text:"确定",click: onSelectCar}]
				});				
			}
		}
	});
};

var $document = $(document);

/**
 * 打开所选择的车辆的表单的自动处理
 * 需要在dom元素中配置data-cfg属性，格式为：data-cfg='<s:property value="e.car.id" />'
 * <s:property value="e.car.id" />为车辆Id
 */
$document.delegate(".showCar",{
	click: function() {
		var $this = $(this);
		var carId = $this.attr("data-cfg");
		if(!carId){
			alert("没有配置dom元素data-cfg属性的值，无法处理！");
			return;
		}
		
		var url=bc.root +"/bc-business/car/edit?id="+carId;
		var option = jQuery.extend({
			url: url,
			name: $this.text(),
			mid: "car" + carId,
		},option);
		bc.page.newWin(option);
	}
});

/**
 * 选择车辆的自动处理。
 * 需要在dom元素中配置data-cfg属性，格式为：域1name=id|text,域2name=name"
 * 如"e.car.id=id,carInfo=plate|text"
 */
$document.delegate(".selectCar",{
	click: function() {
		var $this = $(this);
		var cfg = $this.data("cfg");
		var status =$this.attr("data-status");
		if(!cfg){
			alert("没有配置dom元素data-cfg属性的值，无法处理！");
			return;
		}
		if(typeof cfg == "string")
			cfg = {mapping:cfg};
		
		var $form = $this.closest("form");
		bs.selectCar({
				status : (status !=null ? status : "0,1"),
			onOk : function(car) {
				var mapping = cfg.mapping.split(",");
				var c,c1;
				for(var i=0; i<mapping.length; i++){
					c = mapping[i].split("=");
					if(c.length != 2){
						alert("mapping的格式配置错误，无法处理！请检查dom元素data-cfg的配置,mapping=" + mapping[i]);
						return;
					}
					c1 = c[1].split(/\|/);
					logger.info(c1.join(","));
					if(c1.length == 1){
						$form.find(":input[name='" + c[0] + "']").val(car[c[1]]);
					}else{
						if(c1[1]=="text"){
							$form.find("#" + c[0]).text(car[c1[0]]);
						}else if(c1[1]=="html"){
							$form.find("#" + c[0]).html(car[c1[0]]);
						}else if(c1[1]=="attr"){
							$form.find("#" + c[0]).attr("data-cfg",car[c1[0]]);
						}
					}
				}
				
				// 自定义函数处理特殊情况
				if(cfg.callback){
					if(typeof cfg.callback == "string")
						cfg.callback = bc.getNested(cfg.callback);
					if(typeof cfg.callback == "function")
						cfg.callback.call($this,car);
				}
			}
		});
	}
});

/**
 * 打开所选择的司机的表单的自动处理
 * 需要在dom元素中配置data-cfg属性，格式为：data-cfg='<s:property value="e.carMan.id" />'
 * <s:property value="e.carMan.id" />为司机Id
 */
$document.delegate(".showCarMan",{
	click: function() {
		var $this = $(this);
		var carManId = $this.attr("data-cfg");
		if(!carManId){
			alert("没有配置dom元素data-cfg属性的值，无法处理！");
			return;
		}
		
		var url=bc.root +"/bc-business/carMan/edit?id="+carManId;
		var option = jQuery.extend({
			url: url,
			name: $this.text(),
			mid: "carMan" + carManId,
		},option);
		bc.page.newWin(option);
	}
});

/**
 * 选择司机的自动处理。
 * 需要在dom元素中配置data-cfg属性，格式为：域1name=id|text,域2name=name"
 * 如"e.carMan.id=id,carManInfo=plate|text"
 */
$document.delegate(".selectCarMan",{
	click: function() {
		var $this = $(this);
		var cfg = $this.data("cfg");
		if(!cfg){
			alert("没有配置dom元素data-cfg属性的值，无法处理！");
			return;
		}
		if(typeof cfg == "string")
			cfg = {mapping:cfg};
		
		var $form = $this.closest("form");
		bs.selectCarMan({
			onOk : function(carMan) {
				var mapping = cfg.mapping.split(",");
				var c,c1;
				for(var i=0; i<mapping.length; i++){
					c = mapping[i].split("=");
					if(c.length != 2){
						alert("mapping的格式配置错误，无法处理！请检查dom元素data-cfg的配置,mapping=" + mapping[i]);
						return;
					}
					c1 = c[1].split(/\|/);
					logger.info(c1.join(","));
					if(c1.length == 1){
						$form.find(":input[name='" + c[0] + "']").val(carMan[c[1]]);
					}else{
						if(c1[1]=="text"){
							$form.find("#" + c[0]).text(carMan[c1[0]]);
						}else if(c1[1]=="html"){
							$form.find("#" + c[0]).html(carMan[c1[0]]);
						}else if(c1[1]=="attr"){
							$form.find("#" + c[0]).attr("data-cfg",carMan[c1[0]]);
						}
					}
				}
			}
		});
	}
});

/**
 * 选择车辆保单险种信息
 * @param {Object} option 配置参数
 * @option {Boolean} multiple [可选]是否允许多选，默认false
 * @option {Boolean} paging [可选]是否分页，默认true
 * @option {String} status [可选]车辆保单险种的状态，默认在案，设为空则代表所有状态
 * @option {Function} onOk 选择完毕后的回调函数，函数第一个参数为选中的车辆保单险种信息，
 * 							如果为多选则返回的是数组，每个车辆的格式为{id:[id],name:[name]}
 * @option {String} selecteds [可选]已选中车辆保单险种的id值，多个值用逗号连接
 */
bs.selectInsuranceType = function(option) {
	// 构建默认参数
	option = jQuery.extend({
		mid: 'selectInsuranceType',
		paging: true,
		title: '选择车辆保单险种信息'
	},option);
	
	// 将一些配置参数放到data参数内(这些参数是提交到服务器的参数)
	option.data = jQuery.extend({
		status: '0',
		multiple: false
	},option.data);
	if(option.selecteds)
		option.data.selecteds = option.selecteds;
	if(option.multiple === true)
		option.data.multiple = true;
	
	//弹出选择对话框
	bc.page.newWin(jQuery.extend({
		url: bc.root + "/bc-business/selectInsuranceType/list",
		name: option.title,
		mid: option.mid,
		afterClose: function(status){
			if(status && typeof(option.onOk) == "function"){
				option.onOk(status);
			}
		}
	},option));
};


/**
 * 选择费用模板信息
 * @param {Object} option 配置参数
 * @option {String} module[可选]费用模板的所属模，默认为空，可设置单个或多个，单个：例如'经济合同',多个：逗号连接 如'经济合同,劳动合同'					
 * @option {Boolean} multiple [可选]是否允许多选，默认false
 * @option {Boolean} paging [可选]是否分页，默认false
 * @option {String} status [可选]模板的状态，默认正常，设为空则代表所有状态
 * @option {Function} onOk 选择完毕后的回调函数，
 * 单选返回一个对象 格式为{
 * 					id:[id],				--id
 * 					name:[name],			--名称
 * 					price:[price],			--金额
 * 					code:[code],			--编码
 * 					count:[count],			--数量
 * 					desc:[desc],			--描述
 * 					spec:[spec]				--特殊配置
 * 					}
 * 如果为多选则返回的是对象集合，[对象1,对象2]。
 */
bs.selectFeeTemplate = function(option) {
	// 构建默认参数
	option = jQuery.extend({
		mid: 'selectFeeTemplate',
		paging: true,
		title: '选择费用模板信息'
	},option);
	
	// 将一些配置参数放到data参数内(这些参数是提交到服务器的参数)
	option.data = jQuery.extend({
		status: '0',
		multiple: false,
		module:option.module||''
	},option.data);
	if(option.selecteds)
		option.data.selecteds = option.selecteds;
	if(option.multiple === true)
		option.data.multiple = true;
	
	//弹出选择对话框
	bc.page.newWin(jQuery.extend({
		url: bc.root + "/bc-business/selectFeeTemplate/list",
		name: option.title,
		mid: option.mid,
		afterClose: function(status){
			if(status && typeof(option.onOk) == "function"){
				option.onOk(status);
			}
		}
	},option));
};

/**
 * 选择司机招聘信息
 * @param {Object} option 配置参数
 * @option {Boolean} multiple [可选]是否允许多选，默认false
 * @option {Boolean} paging [可选]是否分页，默认true
 * @option {String} status [可选]车辆的状态，默认待聘，设为空则代表所有状态
 * @option {Function} onOk 选择完毕后的回调函数，函数第一个参数为选中的招聘司机的信息，
 * 							如果为多选则返回的是数组，每个的格式为{id:[id],name:[name],certIdentity:[certIdentity]}
 * @option {String} mid [可选]对话框的id
 * @option {String} title [可选]对话框的标题
 * @option {String} selecteds [可选]已选中的id值，多个值用逗号连接
 */
bs.selectTempDriver = function(option) {
	// 构建默认参数
	option = jQuery.extend({
		mid: 'selectTempDriver',
		paging: true,
		title: '选择司机招聘信息',
	},option);
	
	// 将一些配置参数放到data参数内(这些参数是提交到服务器的参数)
	option.data = jQuery.extend({
		status: '0',
		multiple: false
	},option.data);
	if(option.types)
		option.data.types = option.types;
	if(option.title)
		option.data.title = option.title;
	if(option.selecteds)
		option.data.selecteds = option.selecteds;
	if(option.excludes)
		option.data.excludes = option.excludes;
	if(option.multiple === true)
		option.data.multiple = true;
	if(option.status)
		option.data.status = option.status;
	
	//弹出选择对话框
	bc.page.newWin(jQuery.extend({
		url: bc.root + "/bc-business/selectTempDriver/" + (option.paging ? "paging" : "list"),
		name: option.title,
		mid: option.mid,
		afterClose: function(status){
			if(status && typeof(option.onOk) == "function"){
				option.onOk(status);
			}
		}
	},option));
};

/** bs的自定义模板 */
bc.namespace("TPL.BS");
TPL.BS = {
		CAR_SELECT_ITEM: '<a><table cellspacing="0" cellpadding="0" style="width:100%;border:0;"><tr><td style="text-align:left">{{plateType}}.{{plateNo}}</td><td style="text-align:right">[{{motorcadeName}} {{statusCN}}]</td></tr></table></a>',
		CARMAN_SELECT_ITEM: '<a><table cellspacing="0" cellpadding="0" style="width:100%;border:0;"><tr><td style="text-align:left">{{name}}</td><td style="text-align:right">[{{statusCN}}]</td></tr></table></a>'
};




