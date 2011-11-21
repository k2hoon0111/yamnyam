/* 2011/04/05 빠르게 주문하기 - 카테고리 - 세부카테고리 일단 미적용. 새로운 방법을 찾아야 할듯함.

(function($){
    $(function(){
    	$(document).ready(function() {
			$(".dock-item>img").hover(
				function() {
					$("#divCategory_57").hide();
					$("#divCategory_59").hide();
					$("#divCategory_61").hide();
					$("#divCategory_63").hide();
					$("#divCategory_191").hide();
					$("#divCategory_507").hide();
					$("#divCategory_509").hide();
					$("#divCategory_511").hide();
					$("#divCategory_513").hide();
					$("#divCategory_193").hide();

					if(this.id == "category_57") {
				        $("#divCategory_57").fadeIn(200);
			        }
			        else if(this.id == "category_59") {
				        $("#divCategory_59").fadeIn(200);
			        }
			        else if(this.id == "category_61") {
				        $("#divCategory_61").fadeIn(200);
			        }
			        else if(this.id == "category_63") {
				        $("#divCategory_63").fadeIn(200);
			        }
			        else if(this.id == "category_191") {
				        $("#divCategory_191").fadeIn(200);
			        }
			        else if(this.id == "category_507") {
				        $("#divCategory_507").fadeIn(200);
			        }
			        else if(this.id == "category_509") {
				        $("#divCategory_509").fadeIn(200);
			        }
			        else if(this.id == "category_511") {
				        $("#divCategory_511").fadeIn(200);
			        }
			        else if(this.id == "category_513") {
				        $("#divCategory_513").fadeIn(200);
			        }
			        else if(this.id == "category_193") {
				        $("#divCategory_193").fadeIn(200);
			        }
			    },
				function() {
				}
			);
			
			$(".divFoodCategory_window").hover(
				function() {
				},
				function() {
					if(this.id == "divCategory_57") {
				        $("#divCategory_57").fadeOut(200);
			        }
			        else if(this.id == "divCategory_59") {
				        $("#divCategory_59").fadeOut(200);
			        }
			        else if(this.id == "divCategory_61") {
				        $("#divCategory_61").fadeOut(200);
			        }
			        else if(this.id == "divCategory_63") {
				        $("#divCategory_63").fadeOut(200);
			        }
			        else if(this.id == "divCategory_191") {
				        $("#divCategory_191").fadeOut(200);
			        }
			        else if(this.id == "divCategory_507") {
				        $("#divCategory_507").fadeOut(200);
			        }
			        else if(this.id == "divCategory_509") {
				        $("#divCategory_509").fadeOut(200);
			        }
			        else if(this.id == "divCategory_511") {
				        $("#divCategory_511").fadeOut(200);
			        }
			        else if(this.id == "divCategory_513") {
				        $("#divCategory_513").fadeOut(200);
			        }
			        else if(this.id == "divCategory_193") {
				        $("#divCategory_193").fadeOut(200);
			        }
				}
			)
			
			$("#StoreCategoryOpen").click(function(e) {
				e.preventDefault();	        
		        $("#divStoreCategory").fadeOut(200); 
		        
		        var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				
				$("#mask2").fadeTo("slow", 0.3);
				
				$('#mask2').css({'width':maskWidth,'height':maskHeight});

			});
			
		    $('.divFoodCategory_window .FoodCategoryClose').click(function (e) {
		        e.preventDefault();
		        $("#divFoodCategory").fadeOut(200); 
   		        $("#mask2").fadeOut(200); 

		        //$('.divFoodCategory_window').hide();
		    });     
		    
		    $('.divStoreCategory_window .StoreCategoryClose').click(function (e) {
		        e.preventDefault();
		        $("#divStoreCategory").fadeOut(200); 
   		        $("#mask2").fadeOut(200); 
		        //$('.divStoreCategory_window').hide();
		    });

  		    $('#mask2').click(function () {
		        $("#divFoodCategory").fadeOut(200); 
  		        $("#divStoreCategory").fadeOut(200); 
		        $("#mask2").fadeOut(200); 
		    }); 
		});
								
    });
    
})(jQuery);*/

function doChangeCategory(category_srl) {
	window.location="./?mid=food_list&category="+category_srl;
}

function doSelectShopName(shopName) {
	window.location="./?mid=food_list&search_keyword="+shopName;
}
function doChangeRestaurantCategory(category_srl) {
	window.location="./?mid=restaurant_list&category="+category_srl;
}