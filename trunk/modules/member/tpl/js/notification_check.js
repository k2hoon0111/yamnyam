/**
 * @brief 회원 가입시나 정보 수정시 각 항목의 중복 검사등을 하는 기능을 구현
 * @author NHN (developer@xpressengine.com)
 **/

// 입력이 시작된 것과 입력후 정해진 시간동안 내용이 변하였을 경우 서버에 ajax로 체크를 하기 위한 변수 설정
var memberCheckObj = { target:null, value:null }

// domready시에 특정 필드들에 대해 이벤트를 걸어 놓음
jQuery(document).ready(memberCheckValue());

var soundfile ="./notification.mp3"

function addmsg(type, msg){
    /* Simple helper to add a div.
    type is the name of a CSS class (old/new/error).
    msg is the contents of the div */
    $("#notification").empty();
    $("#notification").append(msg+"개의 미배송이 있습니다.");
    $("#notification").append("<embed src='./notification.mp3' loop=1 autostart='true' hidden='true'/>");
}

//function waitForMsg(){
//    /* This requests the url "msgsrv.php"
//    When it complete (or errors)*/
//        	alert('1');
//
//    $.ajax({
//        type: "GET",
//        url: "notification.php",
//
//        async: true, /* If set to non-async, browser shows page as "Loading.."*/
//        cache: false,
//        timeout:50000, /* Timeout in ms */
//
//        success: function(data){ /* called when request to barge.php completes */
//            addmsg("new", data); /* Add response to a .msg div (with the "new" class)*/
//            setTimeout(
//                'waitForMsg()', /* Request next message */
//                1000 /* ..after 1 seconds */
 //           );
//        },
//        error: function(XMLHttpRequest, textStatus, errorThrown){
//            addmsg("error", textStatus + " (" + errorThrown + ")");
//            setTimeout(
//                'waitForMsg()', /* Try again after.. */
 //               "15000"); /* milliseconds (15seconds) */
 //       },
 //   });
//            alert('2');
//};


// 실제 서버에 특정 필드의 value check를 요청하고 이상이 있으면 메세지를 뿌려주는 함수
function memberCheckValue() {
alert('1');
	var field  = event.target;
	var _name  = field.name;
	var _value = field.value;
	var _group = field.getAttribute("class");
	
	if(!_name || !_value) return;

	var params = {name:_name, value:_value, group:_group};
	var response_tags = ['error','message'];

	exec_xml('member','procNotification', params, completeMemberCheckValue, response_tags, field);
}

// 서버에서 응답이 올 경우 이상이 있으면 메세지를 출력
function completeMemberCheckValue(ret_obj, response_tags, field) {
	var _id   = 'dummy_check'+field.name;
	var dummy = jQuery('#'+_id);
   
    if(ret_obj['message']=='success') {
        dummy.html('').hide();
        return;
    }

	if (!dummy.length) {
		dummy = jQuery('<div class="checkValue" />').attr('id', _id).appendTo(field.parentNode);
	}

	dummy.html(ret_obj['message']).show();
}

// 결과 메세지를 정리하는 함수
function removeMemberCheckValueOutput(dummy, obj) {
    dummy.style.display = "none";
}
*/