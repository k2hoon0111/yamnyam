<link href="css/menu.css" rel="stylesheet" type="text/css">

<!--<script type="text/javascript" src="js/interface.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>-->

<?php
	$menu = "images/student.png";
	$menu2 = "images/gongsic_c.png";
	$menu3 = "images/staff.png";
	$menu_title = "images/title_2.png";
	$list_gb = 6;

/* 	$list_gb = "7";	//6이면 공대식당, 7이면 학생식당 */
	$year = date("Y");	//yyyy 형식으로 표기
	$month = date("m");	//mm 형식으로 표기
	$date = date("d");	//dd 형식으로 표기
	
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

<div class="today_menu_header">
		<a href="/~yamnyam/?mid=today_menu_board"><img src=<?=$menu;?>></a>
		<a href="/~yamnyam/?mid=today_menu_board2"><img src=<?=$menu2;?>></a>
		<a href="/~yamnyam/?mid=today_menu_board3"><img src=<?=$menu3;?>></a>
</div>
<div class="menu_top">
</div>
<div class="contents_box">
	<div class="forbackground">
	<div class="menu_">
		<h3 style="vetical-align:top;"><img src="images/menu_icon.png">&nbsp&nbsp<img src=<?=$menu_title?>></h3>
		<div class="lower_content">
				<? echo($str); ?>
			<div class="upper_content">
			</div>
		</div>
	</div>
	</div>
</div>
<div class="menu_footer">
</div>