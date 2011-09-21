(function($){
    $(function(){
    	$(document).ready(function() {
			$("#buttonLogin").click(function(e) {
				e.preventDefault();
				
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				
				$("#mask").fadeTo("slow", 0.3);
				
				$('#mask').css({'width':maskWidth,'height':maskHeight});
				
				var winH = $(window).height();
		        var winW = $(window).width();
	
		        $("#divLogin").css('top',  winH/2-$("#divLogin").height()/2);
		        $("#divLogin").css('left', winW/2-$("#divLogin").width()/2);
	
		        $("#divLogin").fadeIn(1000); 
			});
			$("#buttonLogin2").click(function(e) {
				e.preventDefault();
				
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				
				$("#mask").fadeTo("slow", 0.3);
				
				$('#mask').css({'width':maskWidth,'height':maskHeight});
				
				var winH = $(window).height();
		        var winW = $(window).width();
	
		        $("#divLogin").css('top',  winH/2-$("#divLogin").height()/2);
		        $("#divLogin").css('left', winW/2-$("#divLogin").width()/2);
	
		        $("#divLogin").fadeIn(1000); 
			});

			
		    $('#boxes .window .close').click(function (e) {
		        e.preventDefault();
		        $("#mask").hide();
		        $('.window').hide();
		    });     
		    
		    $('#mask').click(function () {
		        $(this).hide();
		        $('.window').hide();
		    }); 
		    
		    
		    $('#layoutHeader .logo').click(function() {
		    	document.location = "./?mid=shop_main";
		    });
		});
    });
})(jQuery);