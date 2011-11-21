<!--<script type="text/javascript" src="js/interface.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>-->

<link href="css/menu.css" rel="stylesheet" type="text/css">

<?php
	$list_gb = 5;

/* 	교직원 식당 */
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

<? echo($str); ?>