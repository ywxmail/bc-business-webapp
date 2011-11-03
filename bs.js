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
		types: '0,2'
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
 * 							如果为多选则返回的是数组，每个车辆的格式为{id:[id],name:[name]}
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
		status: '0',
		multiple: false
	},option.data);
	if(option.selecteds)
		option.data.selecteds = option.selecteds;
	if(option.multiple === true)
		option.data.multiple = true;
	
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
 * @option {Function} success 信息获取成功后的回调函数，函数第一个参数为返回的相关信息，格式为
 * 	{
 * 		car:{id:[id],plate:[plate],status:[status]},
 * 		motorcade:{
 * 			id: [id],						-- 车队id
 * 			name: [name]					-- 车队名称
 * 		},
 * 		dirver:{
 * 			id: [id],					-- 司机id
 * 			name: [name],				-- 司机姓名
 * 			sex: [sex],					-- 司机性别
 * 			classes: [classes],			-- 司机营运班次
 * 			cert4FWZG: [cert4FWZG],		-- 司机的服务资格证
 * 			icId: [icId]				-- 司机IC卡的id
 * 		}
 * 	}
 */
bs.findInfoByCar = function(option) {
	var data = {};
	if(option.carId) data.carId = option.carId;
	if(option.carPlate) data.carPlate = option.carPlate;
	bc.ajax({
		dataType: "json", data: data,
		url: bc.root + "/bc-business/findInfoByCar",
		success: function(json){
			logger.info("json=" + $.toJSON(json));
			if(json.drivers.length == 0){
				//提示用户此不正常现象
				alert("没有找到所选车辆对应的营运司机信息，无法处理，请联系管理员！");
				
				//直接调用回调函数,但没有司机信息
				option.success.call(json,{
					car: json.car,
					motorcade: json.motorcade
				});
			}else if(json.drivers.length == 1){
				//直接调用回调函数，返回司机信息
				option.success.call(json,{
					car: json.car,
					motorcade: json.motorcade,
					dirver: json.drivers[0]
				});
			}else{
				//--让用户选择司机后再调用回调函数
				//生成对话框的html代码
				var html = [];
				html.push('<div class="bc-page" data-type="dialog">');
				html.push('<div style="margin: 4px;">');
				html.push('<select id="drivers" size="10" style="width:100%;height:100%;">');
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
					//调用回调函数，返回司机信息
					option.success.call(json,{
						car: json.car,
						motorcade: json.motorcade,
						dirver: drivers[driversEl.selectedIndex]
					});
					//销毁对话框
					html.dialog("destroy").remove();
				}
				var driversEl = html.find("#drivers").dblclick(onSelectDriver)[0];
				
				//弹出对话框让用户选择司机
				html.dialog({
					id: "selectDriver4findInfoByCar",
					title: "此车辆有多个营运司机，请选择一个",
					dialogClass: 'bc-ui-dialog ui-widget-header',
					width:300,modal:true,
					buttons:[{text:"确定",click: onSelectDriver}]
				});				
			}
		}
	});
};