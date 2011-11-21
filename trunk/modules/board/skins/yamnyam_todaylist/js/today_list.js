// <![CDATA[

var currentRestaurant = 1;

(function($){
    $(function(){
    	$(document).ready(function() {
		    
  		    $('#tab_list_item_1').click(function () {
  		    	$('#tab_list_item_1').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_1').addClass('tab_list_item_check');
  		    	$('#tab_list_item_2').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_2').addClass('tab_list_item');
  		    	$('#tab_list_item_3').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_3').addClass('tab_list_item');
  		    	$('#tab_list_item_4').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_4').addClass('tab_list_item');

  		    	$('.food_list_item_1').css('display','inline');
  		    	$('.food_list_item_2').css('display','none');
  		    	$('.food_list_item_3').css('display','none');  		    	  		    	
  		    	$('.food_list_item_4').css('display','none');  		    	  		    	
		    });
  		    $('#tab_list_item_2').click(function () {
  		    	$('#tab_list_item_1').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_1').addClass('tab_list_item');
  		    	$('#tab_list_item_2').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_2').addClass('tab_list_item_check');
  		    	$('#tab_list_item_3').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_3').addClass('tab_list_item');
  		    	$('#tab_list_item_4').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_4').addClass('tab_list_item');

  		    	$('.food_list_item_1').css('display','none');
  		    	$('.food_list_item_2').css('display','inline');
  		    	$('.food_list_item_3').css('display','none');  		    	  		    	
  		    	$('.food_list_item_4').css('display','none');  		    	  		    	
			});
  		    $('#tab_list_item_3').click(function () {
  		    	$('#tab_list_item_1').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_1').addClass('tab_list_item');
  		    	$('#tab_list_item_2').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_2').addClass('tab_list_item');
  		    	$('#tab_list_item_3').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_3').addClass('tab_list_item_check');
  		    	$('#tab_list_item_4').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_4').addClass('tab_list_item');

  		    	$('.food_list_item_1').css('display','none');
  		    	$('.food_list_item_2').css('display','none');
  		    	$('.food_list_item_3').css('display','inline');  		    	  		    	
  		    	$('.food_list_item_4').css('display','none');  		    	  		    	
		    });
  		    $('#tab_list_item_4').click(function () {
  		    	$('#tab_list_item_1').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_1').addClass('tab_list_item');
  		    	$('#tab_list_item_2').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_2').addClass('tab_list_item');
  		    	$('#tab_list_item_3').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_3').addClass('tab_list_item');
  		    	$('#tab_list_item_4').removeClass('tab_list_item tab_list_item_check');
  		    	$('#tab_list_item_4').addClass('tab_list_item_check');

  		    	$('.food_list_item_1').css('display','none');
  		    	$('.food_list_item_2').css('display','none');
  		    	$('.food_list_item_3').css('display','none');
  		    	$('.food_list_item_4').css('display','inline');  		    	  		    	
		    });
			
			
			//단축키 : 키보드 위로
			$(document).bind('keydown', 'up', function(evt) {
				
				currentRestaurant--;
				if(currentRestaurant < 1) {
					currentRestaurant = 4;
				}
				
				for (i=1; i<=4; i++) {
					if(currentRestaurant == i) {
						$('#tab_list_item_' + i).removeClass('tab_list_item tab_list_item_check');
						$('#tab_list_item_' + i).addClass('tab_list_item_check');

						$('.food_list_item_' + i).css('display','inline');  
					}
					else {
						$('#tab_list_item_' + i).removeClass('tab_list_item tab_list_item_check');
						$('#tab_list_item_' + i).addClass('tab_list_item');

						$('.food_list_item_' + i).css('display','none');  						
					}
				}
				
				return false;
			});
			
			//단축키 : 키보드 아래로
			$(document).bind('keydown', 'down', function(evt) {
				
				currentRestaurant++;
				if(currentRestaurant > 4) {
					currentRestaurant = 1;
				}
				
				for (i=1; i<=4; i++) {
					if(currentRestaurant == i) {
						$('#tab_list_item_' + i).removeClass('tab_list_item tab_list_item_check');
						$('#tab_list_item_' + i).addClass('tab_list_item_check');

						$('.food_list_item_' + i).css('display','inline');  
					}
					else {
						$('#tab_list_item_' + i).removeClass('tab_list_item tab_list_item_check');
						$('#tab_list_item_' + i).addClass('tab_list_item');

						$('.food_list_item_' + i).css('display','none');  						
					}
				}
				
				return false;
			});
		

		});
    });
})(jQuery);
// ]]>
