bc.namespace("bs");
bs.infoForm = {
	init : function() {
		var $form = $(this);
		
		// 初始化Redactor编辑器
		var buttons = ['html', '|', 'formatting', '|', 'bold', 'italic', 'underline', 'deleted', '|', 
	       'unorderedlist', 'orderedlist', 'outdent', 'indent', '|',
	       'image', 'video', 'file', 'table', 'link', '|',
	       'fontcolor', 'backcolor', '|', 'alignment', '|', 'horizontalrule'];
		var type = $form.find("input[name='e.type']").val();
		var uid = $form.find("input[name='e.uid']").val()
		$form.find(".bc-redactor").redactor({
			lang: 'zh_cn',
			fixed: true,
			focus: false,
			autoresize: false,
			plugins: ['fullscreen'],
			minHeight: 80,
			buttons: buttons,
			imageUpload: bc.root + "/upload/?a=1&type=img&sp=editor&fn=file&ptype=info." + type + ".editor&puid=" + uid
		});
	},
	
	/** 预览 */
	preview: function(){
		var $page = $(this);
		var id = $page.find("input[name='e.id']").val();
		if(!id || id.length == 0){
			bc.msg.info("请先保存信息！");
			return;
		}
		
		bc.page.newWin({
			name: $page.find("input[name='e.subject']").val(),
			mid: "info.preview."+id,
			url: bc.root+ "/bc-business/info/open?id="+id
		});
	}
};