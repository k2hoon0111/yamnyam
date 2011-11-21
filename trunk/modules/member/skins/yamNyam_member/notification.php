<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js" type="text/javascript" charset="utf-8"></script>

<style type="text/css" media="screen">
	body{ background:#000;color:#fff;font-size:.9em; }
	.msg{ background:#aaa;padding:.2em; border-bottom:1px #000 solid}
	.old{ background-color:#246499;}
	.new{ background-color:#3B9957;}
	.error{ background-color:#992E36;}
</style>

<script type="text/javascript" charset="utf-8">
    var soundfile ="./notification.mp3"

    function addmsg(type, msg){
        /* Simple helper to add a div.
        type is the name of a CSS class (old/new/error).
        msg is the contents of the div */
        $("#notification").empty();
        $("#notification").append("<div class="+type+">"+msg+"개의 미배송이 있습니다.</div>");
        if (msg>0)
	        $("#notification").append("<embed src='./notification.mp3' loop=1 autostart='true' hidden='true'/>");
    }
    
    tmp=window.location; //호출된 현재창의 주소 ex) http://kr.yahoo.com/1.html?a=1&b=1;
	tmp=String(tmp).split('?'); //? 이후가 배열에 담김
	tmp=tmp[1].split('&');//변수를 각각을 배열로 담고

	for(k in tmp) {
		tmp2=tmp[k].split('='); //키와 값분리
		eval("var "+tmp2[0]+"=tmp2[1]");
		// document.write(tmp2[0]+' '+tmp2[1]+'<br>');
	}

    function waitForMsg(){
        /* This requests the url "msgsrv.php"
        When it complete (or errors)*/
        $.ajax({
            type: "GET",
            url: "notification_process.php?nickname="+encodeURI(tmp2[1]), 

            async: true, /* If set to non-async, browser shows page as "Loading.."*/
            cache: false,
            timeout:50000, /* Timeout in ms */

            success: function(data){ /* called when request to barge.php completes */
                addmsg("new", data); /* Add response to a .msg div (with the "new" class)*/
                setTimeout(
                    'waitForMsg()', /* Request next message */
                    1000 /* ..after 1 seconds */
                );
            },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                addmsg("error", textStatus + " (" + errorThrown + ")");
                setTimeout(
                    'waitForMsg()', /* Try again after.. */
                    "15000"); /* milliseconds (15seconds) */
            }
        });
    };

    $(document).ready(function(){
        waitForMsg(); /* Start the inital request */
    });
</script>

<div id="messages">
    <div class="msg old">
        배송상태 확인.
    </div>
    <div id="notification">
    </div>
</div>
