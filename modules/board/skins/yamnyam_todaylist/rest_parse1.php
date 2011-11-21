
<?php
	$list_gb = 7;

/* 	학생식당 */
	$selected_date = $_GET['date_str'];
		
	$date_arr = explode("-", $selected_date);
	
	$year = $date_arr[0];	//yyyy 형식으로 표기
	$month = $date_arr[1];	//mm 형식으로 표기
	$date = $date_arr[2];	//dd 형식으로 표기
	
	$site = "http://www.skku.ac.kr/e-home-s/week_menu2/read.jsp?mode=view&list_gb=$list_gb&yyyy=$year&mm=$month&dd=$date";
	$fp = fopen($site, "r");

	$raw_contents = array();
	
	while( !feof($fp) ) {
		$buffer = fgets($fp);
		$raw_contents[] = $buffer;
	}
	$str = iconv("EUC-KR", "UTF-8", $raw_contents[115]);
//라인을 찾아서 파싱에는 무리가 있음.	
/*
	foreach( $raw_contents as $cont ) {
		//if ( in_array("<td height=\"130\" width=\"423\" valign=\"top\">", $cont) ) {
		if ( ereg("<td height=\"130\" width=\"423\" valign=\"top\">", $cont, $result) ) {
			next($cont);
			next($cont);
			echo $cont;
			//echo $result[0];
		}
		//echo $cont;
	}
*/
		
	fclose($fp);
?>
<!--
<script>


$(function() {
	$( "#tabs" ).tabs();
});
	
	
</script>


<div id="tabs">
	<ul>
		<li><a href="#tabs-1">Nunc tincidunt</a></li>
		<li><a href="#tabs-2">Proin dolor</a></li>
		<li><a href="#tabs-3">Aenean lacinia</a></li>
	</ul>
	<div id="tabs-1">
		<p>aaa</p>
	</div>
	<div id="tabs-2">
		<p>bbb</p>
	</div>
	<div id="tabs-3">
		<p>ccc</p>
	</div>
</div>
-->

<? echo($str); ?>
