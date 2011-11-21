
<?php	
	$conn=mysql_connect("localhost", "yamnyam", "!diasia");#연결은 앞서해서 중복될지도.
	mysql_select_db("yamnyam", $conn);
	mysql_query("SET NAMES 'utf8'");
	
	$nickname = $_GET['nickname'];
	
	$nickname = urldecode($nickname);
	
	if($nickname=="admin"){	
		$query="select value from yman_document_extra_vars where module_srl=76 and var_idx=1;";
		$query1="select value from yman_document_extra_vars where module_srl=76 and document_srl in (select document_srl from yman_document_extra_vars where module_srl=76 and var_idx=1) and var_idx=3;";
	}else {
		$query="select value from yman_document_extra_vars where module_srl=76 and var_idx=1 and value like '%".$nickname."%';";
		$query1="select value from yman_document_extra_vars where module_srl=76 and document_srl in (select document_srl from yman_document_extra_vars where module_srl=76 and var_idx=1 and value like '%".$nickname."%') and var_idx=3;";
	}
	
	$result=mysql_query($query,$conn);
	$result1=mysql_query($query1,$conn);
	//쿼리체크
	
	$total_count=0;
	
	while($row=mysql_fetch_row($result)) {
		$row1=mysql_fetch_row($result1);

		$detail_value = explode("&&", $row[0]);
		$count_detail_value = count($detail_value)-1;

		$status_value = explode("|", $row1[0]);
		$count_status_value = count($status_value)-1;

		for($i=0; $i< $count_detail_value; $i++) {
			if((strstr($detail_value[$i], $nickname) || $nickname=="admin") && $status_value[$i]=='1') {
				$total_count++;
			}
		}

	}

	sleep(5);

	echo $total_count;
	/*
	if($row[0]==NULL) {
		sleep(2);
		echo '0';
	}
	else if($row[0]>0) {
		sleep(2);
		echo $row[0];
	}
	else {
		header("HTTP/1.0 404 Not Found");
		die();
	}*/



?>
