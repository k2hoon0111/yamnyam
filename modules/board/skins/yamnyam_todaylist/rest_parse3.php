<!--<script type="text/javascript" src="js/interface.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>-->

<link href="css/menu.css" rel="stylesheet" type="text/css">

<?php
	$list_gb = 5;

/* 	������ �Ĵ� */
	$selected_date = $_GET['date_str'];
		
	$date_arr = explode("-", $selected_date);
	
	$year = $date_arr[0];	//yyyy �������� ǥ��
	$month = $date_arr[1];	//mm �������� ǥ��
	$date = $date_arr[2];	//dd �������� ǥ��
	
	$site = "http://www.skku.ac.kr/e-home-s/week_menu2/read.jsp?mode=view&list_gb=$list_gb&yyyy=$year&mm=$month&dd=$date";
	$fp = fopen($site, "r");

	$raw_contents = array();
	
	while( !feof($fp) ) {
		$buffer = fgets($fp);
		$raw_contents[] = $buffer;
	}
	$str = iconv("EUC-KR", "UTF-8", $raw_contents[115]);
//������ ã�Ƽ� �Ľ̿��� ������ ����.	
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