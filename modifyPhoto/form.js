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
			
			

			$.ajax({ url: "/bc-business/modifyPhoto/data",  success: function(url){
				$this.data("data-status", url);
				$this.dialog("close");
			}});
		}
		
		
		
		
}