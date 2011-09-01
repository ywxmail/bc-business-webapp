if (!bs) bs = {};

/**
 * 选择司机、责任人信息
 * @param {Object} option 配置参数
 * @option {Boolean} multiple [可选]是否允许多选，默认false
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
		title: '选择司机责任人信息'
	},option);
	
	// 将一些配置参数放到data参数内(这些参数是提交到服务器的参数)
	option.data = jQuery.extend({
		multiple: false,
		types: '0,1,2'
	},option.data);
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
		url: bc.root + "/bs-business/carman/select",
		name: option.title,
		mid: option.mid,
		afterClose: function(status){
			if(status && typeof(option.onOk) == "function"){
				option.onOk(status);
			}
		}
	},option);
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
	},option);
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
	return bs.selectCharger(jQuery.extend({
		mid: 'selectDriver',
		title: '选择责任人信息',
		types: '1,2'
	},option);
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
		mid: 'selectMotorcade'
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
		url: bc.root + "/bs-business/motorcade/select",
		name: option.title,
		mid: option.mid,
		afterClose: function(status){
			if(status && typeof(option.onOk) == "function"){
				option.onOk(status);
			}
		}
	},option);
};

/**
 * 选择车辆信息
 * @param {Object} option 配置参数
 * @option {Boolean} multiple [可选]是否允许多选，默认false
 * @option {Function} onOk 选择完毕后的回调函数，函数第一个参数为选中的车辆信息，
 * 							如果为多选则返回的是数组，每个车辆的格式为{id:[id],name:[name]}
 * @option {String} selecteds [可选]已选中车辆的id值，多个值用逗号连接
 */
bs.selectCar = function(option) {
	// 构建默认参数
	option = jQuery.extend({
		mid: 'selectCar'
		title: '选择车辆信息'
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
		url: bc.root + "/bs-business/car/select",
		name: option.title,
		mid: option.mid,
		afterClose: function(status){
			if(status && typeof(option.onOk) == "function"){
				option.onOk(status);
			}
		}
	},option);
};