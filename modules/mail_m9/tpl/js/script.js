/**
 * @file   modules/mail_m9/js/board.js
 * @author mmx900 (mmx900@gmail.com)
 * @brief  mail_m9 모듈의 javascript
 **/

function completeSend(ret_obj) {
    var error = ret_obj['error'];
    var message = ret_obj['message'];
    alert(message);
    location.href = location.href;
}

function changeOption(send_to_all){
	var rn = document.forms[0].receiptor_name;
	var re = document.forms[0].receiptor_email;
	if(send_to_all){
		rn.value = "========";
		rn.disabled = true;
		re.value = "========";
		re.disabled = true;
	}else{
		rn.value = "";
		rn.disabled = false;
		re.value = "";
		re.disabled = false;
	}
}