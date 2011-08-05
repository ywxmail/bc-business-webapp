if (!bc.business)bc.business = {};
bc.business.modifyPhoto = {
		
		init : function (){
			
			$('#target').Jcrop({
				onChange : showCoords,
				onSelect : showCoords,
				onRelease : clearCoords
			});
			function showCoords(c) {
				$('#x1').val(c.x);
				$('#y1').val(c.y);
				$('#x2').val(c.x2);
				$('#y2').val(c.y2);
				$('#w').val(c.w);
				$('#h').val(c.h);
			};
			function clearCoords() {
				$('#coords input').val('');
				$('#h').css({
					color : 'red'
				});
				window.setTimeout(function() {
					$('#h').css({
						color : 'inherit'
					});
				}, 500);
			};
			
		},
		
		
		check : function() {
			var $form = $(this);
			var x1=$('#x1').val();
			var y1=$('#y1').val();
			var w=$('#w').val();
			var h=$('#h').val();
			var photoUrl=$form.find("img").attr("src");
			
			
            var url="/bc-business/modifyPhoto/modify?x1="+x1+"&y1="+y1+"&w="+w+"&h="+h+"&photoUrl="+photoUrl;
			$.ajax({ url: url,dataType:"json", success: update_page});
			function update_page(json){
				$("img").attr("src",json.photoUrl);
				$form.dialog("close");
				
			}
			
		}
		
		
		
		
}