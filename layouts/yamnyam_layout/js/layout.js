// <![CDATA[

/*
	11.4.2 병웅
	익스 패치라고 올라온 코드긴한데 정말 되나?
*/
if (/msie/i.test (navigator.userAgent)){
    document.getElementsByName = function(name){
        var objAll = document.getElementsByTagName("*");
        var result = new Array();
        var arrayIndex = 0;
        for(i = 0; i < objAll.length; i++) {
            objAttribute = objAll[i].getAttribute("name");
            if(objAttribute == name) {
                result[arrayIndex] = objAll[i];
                arrayIndex++;
            }
        }
        return result;
    }
}

(function($){
    $(function(){
    	$(document).ready(function() {
    	
			$("#buttonLogin").click(function(e) {
				e.preventDefault();

				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				
				//인터넷 익스플로러에서 오류남
				//How to fix this problem : http://www.kevinleary.net/jquery-fadein-fadeout-problems-in-internet-explorer/
				$("#mask").fadeTo("slow", 0.3);
				
			
				$('#mask').css('width', maskWidth);
				$('#mask').css('height', maskHeight);


				$("#mask").show();
				

				var winH = $(window).height();
		        var winW = $(window).width();

				$("#divLogin").css('top',  winH/2-$("#divLogin").height()/2);
		        $("#divLogin").css('left', winW/2-$("#divLogin").width()/2);

				//인터넷 익스플로러에서 오류남
				$("#divLogin").fadeIn(1000, function(){
					//$(this).css('filter','');
				});
				//$("#divLogin").show();
				$("#id_box").focus();			
			});

			$("#buttonLogin2").click(function(e) {
				e.preventDefault();
				
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				
				$("#mask").fadeTo("slow", 0.3);
				
				$('#mask').css('width', maskWidth);
				$('#mask').css('height', maskHeight);
				
				var winH = $(window).height();
		        var winW = $(window).width();
	
		        $("#divLogin").css('top',  winH/2-$("#divLogin").height()/2);
		        $("#divLogin").css('left', winW/2-$("#divLogin").width()/2);
	
		        $("#divLogin").fadeIn(1000); 
			});

			$("#buttonLogin3").click(function(e) {
				e.preventDefault();
				
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				
				$("#mask").fadeTo("slow", 0.3);
				
				$('#mask').css('width', maskWidth);
				$('#mask').css('height', maskHeight);
				
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
		    	document.location = "http://skku.yamnyam.com/";
		    });
		    
		    // 마우스 드래그 막음
		    jQuery.extend(jQuery.fn, {
			  unselectable: function(){
			    this.bind("selectstart.jq", function(){return false;}).css({
			      "MozUserSelect": "none",
			      "KhtmlUserSelect": "none"
			    }).get(0).unselectable = "on";
			  },
			  selectable: function(){
			    this.unbind("selectstart.jq").css({
			      "MozUserSelect": "text",
			      "KhtmlUserSelect": "text"
			    }).get(0).unselectable = "off";
			  }
			});
			jQuery(document).unselectable();
		});
    });
})(jQuery);
// ]]>