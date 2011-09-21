/*********************
	툴바 숨기기
***********************/
window.addEventListener('load',function(){
	setTimeout(scrollTo, 0, 0, 1);
	}, false);


function Node(){
	var nickname,name,price,num,thumb;
}
var cookieData = new Object();
	
/********************
* food_list 코드
********************/

	/* 쿠키 관련 */
	function getCookie( cookieName ) {
		var search = cookieName + "=";
		var cookie = document.cookie;

		if( cookie.length > 0 ) {
			startIndex = cookie.indexOf( cookieName );
			
			if( startIndex != -1 ) {
				startIndex += cookieName.length;
				endIndex = cookie.indexOf( ";", startIndex );
				
				if( endIndex == -1) endIndex = cookie.length;
				
				return unescape( cookie.substring( startIndex + 1, endIndex ) );
			}
			else {
				return ;
			}
		}
		else {
			return ;
		}
	}


	function setCookie( cookieName, cookieValue, expireDate ) {
		var today = new Date();
		today.setDate( today.getDate() + parseInt( expireDate ) );
		document.cookie = cookieName + "=" + escape( cookieValue ) + "; path=/; expires=" + today.toGMTString() + ";";
	 }
 
	function getMyCookie( cookieName ) {
		return getCookie( cookieName ) ;
	 }
 
	function deleteCookie( cookieName ) {
		var expireDate = new Date();
		
		//어제 날짜를 쿠키 소멸 날짜로 설정한다.
		expireDate.setDate( expireDate.getDate() - 1 );
		document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
	 }
 
	function delCookie() {
		deleteCookie('product_data');
	}
	
	function selectCategory(category){
		$(".food_category").attr({value:category});
	}
