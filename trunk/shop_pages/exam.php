
<?php


	$conn=mysql_connect("localhost", "yamnyam", "diasia");#연결은 앞서해서 중복될지도.
	mysql_select_db("yamnyam", $conn);
	mysql_query("SET NAMES 'utf8'");
	$query="select count(*) from yman_document_extra_vars where module_srl=76 and var_idx=1 and value like '%"."관리자"
."%'";

	$result=mysql_query($query,$conn);
	
	//쿼리체크
	
	$row=mysql_fetch_row($result);
	
	if($row[0]==NULL) {
		sleep(10);
		echo '0';
	}
	else if($row[0]>0) {
		sleep(10);
		echo $row[0];
	}
	else {
		header("HTTP/1.0 404 Not Found");
		die();
	}



?>
