
var minimumPrice = new Object();
// 페이드인효과
function FadeIn(id){
	$("#cart_"+id).css("opacity","0");
	$("#cart_"+id).animate({
	    opacity: 1.0}, 300);
	    
	$("#divCartBt").css("opacity","0");
	$("#divCartBt").animate({
	    opacity: 1.0,
	    
	    }, 300);
}
/* 장바구니 추가 */
function toCart(id,nickname,name,price,num,thumb){
	var i = 0;	
	for (var x in cookieData){i++;}
	
	price = parseInt(price);
	num = parseInt(num);

	var str="";

	// 상품을 새로 추가시
	if($("#cart_"+id).html() == null){
		str=toCart_html(id,nickname,name,price,num,thumb);
		cookieData[id] = new Node();
		cookieData[id].nickname = nickname;
		cookieData[id].name = name;
		cookieData[id].price = price;
		cookieData[id].num=1;
		cookieData[id].thumb=thumb;
	}
	// 이미 상품이 존재할시
	else {
		$("#num_"+id).html(cookieData[id].num+1);
		$("#price_"+id).html(parseInt($("#price_"+id).html())+price);
		cookieData[id].num++;
	}
	
	// html 태그를 추가하는 부분
	$("#divCart").append(str);
	// 삭제버튼 클릭 이벤트를 추가하는 부분
	$("#divCart:last-child").find(".delete").click(function () {
		delCart("+id+");
		
		return false;
	});
	
	// 반짝효과
	FadeIn(id);
	
	// 총수량 추가
	AddCartSum(1);
	
	// 쿠키 기록
	var str="";
	var str2="";
	var str3="";
	var str4="";
	var str5="";
	for (var x in cookieData){
		str+=x+":"+cookieData[x].num+"|";
		str2+=cookieData[x].nickname+"|";
		str3+=cookieData[x].name+"|";
		str4+=cookieData[x].price+"|";
		str5+=cookieData[x].thumb+"|";
	}
	
	localStorage["product_data"] = str;
	localStorage["nickname"] = str2;
	localStorage["title"] = str3;
	localStorage["price"] = str4;
	localStorage["thumb"] = str5;
}


/* 장바구니 삭제 */
function delCart(id){


	// 반짝효과
	FadeIn(id);
	
	// 총수량 감소
	AddCartSum(-1);
	
	if(cookieData[id].num>1){
		cookieData[id].num -= 1;
		
		$("#num_"+id).html(cookieData[id].num);
		$("#price_"+id).html(cookieData[id].price*cookieData[id].num);
	}
	else{
		$("#cart_"+id).remove();
		delete cookieData[id];
	}
	
	// 쿠키 기록
	var str="";
	var str2="";
	var str3="";
	var str4="";
	var str5="";
	for (var x in cookieData){
		str+=x+":"+cookieData[x].num+"|";
		str2+=cookieData[x].nickname+"|";
		str3+=cookieData[x].name+"|";
		str4+=cookieData[x].price+"|";
		str5+=cookieData[x].thumb+"|";
	}
	
	localStorage["product_data"] = str;
	localStorage["nickname"] = str2;
	localStorage["title"] = str3;
	localStorage["price"] = str4;
	localStorage["thumb"] = str5;
}

// Cart html코드 리턴
function toCart_html(id, nickname,name, price, num, thumb){
	var str="";
	str+="<div id=cart_"+id+" class=product_class>";
	str+="<div class=divCellClickZone><div class=thumb><img src="+thumb+"></div><div class=subjects><div class=product_name>"+name+"</div>";
	str+="<div class=product_nickname>"+nickname+"</div>";
	str+="<span class=product_price><span id=price_"+id+" class=number>"+price+"</span>원</span> x ";
	str+="<span class=product_amount>"+"<span id=num_"+id+" class=number>"+num+"</span>개</span>";
	str+="</div></div><div class='delete'><a onclick='delCart("+id+");'><img src=./m.layouts/yamnyam_mobile/images/btDel.png width=52 height=32></a></div></div>";
	
	return str;
}


// 총수량 추가
function AddCartSum(num){
	var cartnum = parseInt($(".cart_sum_num").html());
	cartnum+=num;
	
	$(".cart_sum_num").html(cartnum);
	if(cartnum==0){
		$(".cart_sum").css("display","none");
	}
	else{
		$(".cart_sum").css("display","inline");
	}
	
}


// 주문하기
function Order(){
	var i = 0;
	var sumPrice = new Object();
	for (var x in cookieData){
		i++;
		sumPrice[cookieData[x].nickname]=0;
	}
	for (var x in cookieData){
		sumPrice[cookieData[x].nickname]+= cookieData[x].price * cookieData[x].num;	
	}
	if(sumPrice[cookieData[x].nickname] < minimumPrice[cookieData[x].nickname]){
		alert(cookieData[x].nickname+"의 최소배달가격은 "+minimumPrice[cookieData[x].nickname]+"입니다.");
		return 0;
	}
	if(!i){alert("주문서에 음식을 추가해주세요.");return 0;}
	else{
		var str="";
		for (var x in cookieData){str+=x+":"+cookieData[x].num+"|";}
		go_page(str);
	}
}



function create_form(nm,mt,ac,tg) {
	 var fm = document.createElement("form");
	 fm.name = nm;
	 fm.method = mt;
	 fm.action = ac;
	 fm.target = tg;
	 
	 return fm;
}
function add_input(fm,nm,vu){
	 var input = document.createElement("input");
	 input.type = "hidden";
	 input.name = nm;
	 input.value =  vu;
	 fm.insertBefore(input,null);
	 return fm
}
function go_page(data){
	 var fm=create_form("page_from", "POST", "./?mid=order_list&act=dispOrderConfirmMobile", "");
	 
	 fm = add_input(fm,'orderData',data);
	 
	 document.body.insertBefore(fm,null);
	 fm.submit();
}

function delCookie() {
		localStorage.clear();
	}


$(document).ready(function() {

	var toggle=1;
	$("#divCartWrap").css("height",$(window).height()-60+"px");

// 장바구니 애니메이션효과
	$("#footer #divCartBt,#header_cart #divLogo").click(function(){
		if(toggle) {//주문서 열릴때
			if(android_flag){
//				$("#footer").css("top",$(window).height() - 70);
//				$(window).scrollTop(80);
	
			 
				scroll_flag=0;
				$("#divUpper").hide();
				$("#divCartWrap").show();
				//$("#divCartWrap").slideToggle(500);
	
				toggle=0;
				
				/*
				//기존을 변경
				$("#footer").attr("id","footer2");
				$("#scroller").attr("id","scroller2");
				$("#wrapper").attr("id","wrapper2");
				
				//새로변경
				$("#divCartWrap").attr("id","wrapper");
				$("#footer_cart").attr("id","footer");
				$("#header_cart").attr("id","header");
				$("#scroller_cart").attr("id","scroller");
				$("#footer").css("height","100%");
				*/
				
				$("#mainBody").hide();
				
				
				$("#divCartBt").css("border-top", "0px solid transparent");
				
				
				var myScroll;
				var a = 0;
				var footerH = $('#footer').height()
				var headerCartH = $('#header_cart').height() + 80;
				
				var wrapperH = window.innerHeight - footerH;
				
				$('#wrapper').height(wrapperH);
				$('#wrapper_cart').height(wrapperH - headerCartH);

				myScroll = new iScroll('scroller_cart', {desktopCompatibility:false});
			}
			else{
			scroll_flag=0;
			$("#divUpper").hide();
			$("#divCartWrap").show();
			//$("#divCartWrap").slideToggle(500);

			toggle=0;
			
			/*
			//기존을 변경
			$("#footer").attr("id","footer2");
			$("#scroller").attr("id","scroller2");
			$("#wrapper").attr("id","wrapper2");
			
			//새로변경
			$("#divCartWrap").attr("id","wrapper");
			$("#footer_cart").attr("id","footer");
			$("#header_cart").attr("id","header");
			$("#scroller_cart").attr("id","scroller");
			$("#footer").css("height","100%");
			*/
			
			$("#mainBody").hide();
			
			
			$("#divCartBt").css("border-top", "0px solid transparent");
			
			
			var myScroll;
			var a = 0;
			
			//var headerH = $('#header').offset().height;
			//var	footerH = $('#footer').offset().height;
			//var wrapperH = window.innerHeight - footerH - headerH;

			//$("#wrapper").height(wrapperH);

 			// Please note that the following is the only line needed by iScroll to work. Everything else here is to make this demo fancier.
			myScroll = new iScroll('scroller_cart', {desktopCompatibility:false});

			// Check screen size on orientation change
			//window.addEventListener('onorientationchange' in window ? 'orientationchange' : 'resize', setHeight, false);
			 
			// Prevent the whole screen to scroll when dragging elements outside of the scroller (ie:header/footer).
			// If you want to use iScroll in a portion of the screen and still be able to use the native scrolling, do *not* preventDefault on touchmove.
			//document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
			//$("#yamNyamMobileMain").live('touchmove', function (e) { e.preventDefault(); }, false);
			//$("#footer").live('touchmove', function (e) { e.preventDefault(); }, false); 			
			 
			// Load iScroll when DOM content is ready.
			//document.addEventListener('DOMContentLoaded', loaded, false);
			}
			
		}
		else {//주문서 닫힐때	
			scroll_flag=1;
			
			$("#divUpper").show();
			//$("#divCartWrap").slideToggle(500);
			$("#divCartWrap").hide();			
			
			$("#divCartBt").css("border-top", "1px solid #999;");
			
			/*					
			//새로변경
			$("#wrapper").attr("id","divCartWrap");
			$("#footer").attr("id","footer_cart");
			$("#header").attr("id","header_cart");
			$("#scroller").attr("id","scroller_cart");
			//기존을 변경
			$("#footer2").attr("id","footer");
			$("#scroller2").attr("id","scroller");
			$("#wrapper2").attr("id","wrapper");

			$("#divCartWrap").slideToggle(500);
			$("#footer").css("height","70px");
			$("#divUpper").css("display","block");
			*/
			
			$("#mainBody").show();
			
			toggle=1;
			
/*			if(android_flag){
				$("#footer").css("margin-top","0");
				$("#wrapper").height($(document).height());
				$("#footer").css("top", $(window).height() - 70 + apple_padding);	
			}
			else{
*/				
			/*
				var myScroll;
				var a = 0;
				function loaded() {
					setHeight();	// Set the wrapper height. Not strictly needed, see setHeight() function below.
				 
					// Please note that the following is the only line needed by iScroll to work. Everything else here is to make this demo fancier.
					myScroll = new iScroll('scroller', {desktopCompatibility:false});
				}
				 
				// Change wrapper height based on device orientation. Not strictly needed by iScroll, you may also use pure CSS techniques.
				//var footerH = document.getElementById('footer').offsetHeight,
				//	wrapperH = window.innerHeight - footerH;
				//$("#wrapper").height(wrapperH);
				 
				// Check screen size on orientation change
				window.addEventListener('onorientationchange' in window ? 'orientationchange' : 'resize', setHeight, false);
				 
				// Prevent the whole screen to scroll when dragging elements outside of the scroller (ie:header/footer).
				// If you want to use iScroll in a portion of the screen and still be able to use the native scrolling, do *not* preventDefault on touchmove.
				document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
				//$("#yamNyamMobileMain").live('touchmove', function (e) { e.preventDefault(); }, false);
				//$("#footer").live('touchmove', function (e) { e.preventDefault(); }, false);
				
				
				// Load iScroll when DOM content is ready.
				document.addEventListener('DOMContentLoaded', loaded, false);

			*/

//			}
		}
	});	
});



$(document).ready(function() {
// 장바구니 초기세팅
// 로컬스토리지에서 값을 가져와서 변수에 정렬
	var LS_data = localStorage["product_data"];
	var LS_data2 = localStorage["nickname"];
	var LS_data3 = localStorage["title"];
	var LS_data4 = localStorage["price"];
	var LS_data5 = localStorage["thumb"];
	var temp_data;
	var nickname;
	var name;
	var price;
	var thumb;
	
	if (LS_data) {
		temp_data = LS_data.split("|");
		nickname = LS_data2.split("|");
		name = LS_data3.split("|");
		price = LS_data4.split("|");
		thumb = LS_data5.split("|");
		var temp_data2;
		
		for(var i=0; i<temp_data.length-1; i++){
			temp_data2 = temp_data[i].split(":");
			cookieData[temp_data2[0]] = new Node();
			cookieData[temp_data2[0]].num=parseInt(temp_data2[1]);
			cookieData[temp_data2[0]].nickname = nickname[i];
			cookieData[temp_data2[0]].name = name[i];
			cookieData[temp_data2[0]].price = price[i];
			cookieData[temp_data2[0]].thumb = thumb[i];
			var str = toCart_html(temp_data2[0],nickname[i],name[i],price[i]*cookieData[temp_data2[0]].num,cookieData[temp_data2[0]].num, thumb[i]);

			$("#divCart").append(str);

			// 삭제버튼 클릭 이벤트를 추가하는 부분
			$("#divCart:last-child").find(".delete").click(function () {
				delCart("+id+");
				
				return false;
			});
			
			//AddCartSum(cookieData[temp_data2[0]].num);
		}
	}
});
