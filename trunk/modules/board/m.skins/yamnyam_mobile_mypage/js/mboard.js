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
					currentRestaurant = 3;
				}
				
				for (i=1; i<=3; i++) {
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
				if(currentRestaurant > 3) {
					currentRestaurant = 1;
				}
				
				for (i=1; i<=3; i++) {
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


function completeInsertComment(ret_obj) {
    var error = ret_obj['error'];
    var message = ret_obj['message'];
    var mid = ret_obj['mid'];
    var document_srl = ret_obj['document_srl'];
    var comment_srl = ret_obj['comment_srl'];

    var url = current_url.setQuery('mid',mid).setQuery('document_srl',document_srl).setQuery('act','');
    if(comment_srl) url = url.setQuery('rnd',comment_srl)+"#comment_"+comment_srl;

    //alert(message);

    location.href = url;
}

function completeDocumentInserted(ret_obj) {
    var error = ret_obj['error'];
    var message = ret_obj['message'];
    var mid = ret_obj['mid'];
    var document_srl = ret_obj['document_srl'];
    var category_srl = ret_obj['category_srl'];

    //alert(message);

    var url;
    if(!document_srl)
    {
        url = current_url.setQuery('mid',mid).setQuery('act','');
    }
    else
    {
        url = current_url.setQuery('mid',mid).setQuery('document_srl',document_srl).setQuery('act','');
    }
    if(category_srl) url = url.setQuery('category',category_srl);
    location.href = url;
}

function completeGetPage(ret_val) {
	jQuery("#cl").remove();
	jQuery("#clpn").remove();
	jQuery("#clb").parent().after(ret_val['html']);
}

function loadPage(document_srl, page) {
	var params = {};
	params["cpage"] = page; 
	params["document_srl"] = document_srl;
	params["mid"] = current_mid;
	exec_xml("board", "getBoardCommentPage", params, completeGetPage, ['html','error','message'], params);
}

function completeDeleteComment(ret_obj) {
    var error = ret_obj['error'];
    var message = ret_obj['message'];
    var mid = ret_obj['mid'];
    var document_srl = ret_obj['document_srl'];
    var page = ret_obj['page'];

    var url = current_url.setQuery('mid',mid).setQuery('document_srl',document_srl).setQuery('act','');
    if(page) url = url.setQuery('page',page);

    //alert(message);

    location.href = url;
}

function completeDeleteDocument(ret_obj) {
    var error = ret_obj['error'];
    var message = ret_obj['message'];
    var mid = ret_obj['mid'];
    var page = ret_obj['page'];

    var url = current_url.setQuery('mid',mid).setQuery('act','').setQuery('document_srl','');
    if(page) url = url.setQuery('page',page);

    //alert(message);

    location.href = url;
}

