<? echo "<?xml version='1.0' encoding='utf-8'?>"; ?>
<lists>
<?
	$conn=mysql_connect("localhost", "yamnyam", "diasia");#연결은 앞서해서 중복될지도.
	mysql_select_db("yamnyam", $conn);
	mysql_query("SET NAMES 'utf8'");
	
	$step=$_GET['step'];
	$args=$_GET['args'];
	$payment=$_GET['payment'];
	$order=$_GET['order'];
	$searchToken=$_GET[''];			// 검색을 위해 추가 by ksj1501
	$page3=$_GET['page3'] * 8;		// 페이지 이용을 위해 추가 by ksj1501
	$page2=$_GET['page2'] * 5;
		
	// 가게 종류 가져오기
	if($step==1) {
		$query="select * from yman_document_categories where module_srl=141;";
		$result=mysql_query($query,$conn);
		while($row=mysql_fetch_array($result)) {
			echo ("<item>");
			echo ("<category_srl>".$row['category_srl']."</category_srl>");
			echo ("<title>".$row['title']."</title>");
			echo ("</item>");
		}
	}
	// 가게 목록 가져오기
	else if($step==2) {
		if($payment=='1') $payment='현금';
		else if($payment=='2') $payment='카드';
		else $payment='';
		
		if($order=='0') $order="rand(round(date_format( now() , '%i'), -1))";
		else if($order=='1') $order="yman_documents.title";
		else if($order=='2') $order="cast(yman_document_extra_vars2.value as unsigned)";

		// 가능한 시간에만 화면에 표시
		$today=mktime();
		$current_day = date('w', $today);
		$current_time = date('G', $today);
		
		//임시 시간 등록
		$current_day=3;
		$current_time=16;
		
		$temp_current = 0;
		$current_time_str = 0;
		
		for($temp_i=0; $temp_i<7; $temp_i++) {
			if($temp_i==$current_day) {
				for($temp_j=0; $temp_j<24; $temp_j++) {
					if ($temp_j==$current_time) {
						$temp_current++;
						$current_time_str = $temp_current;
					}
					else {
						$temp_current++;
					}
				}
			}
			else {
				for($temp_j=0; $temp_j<24; $temp_j++) {
					$temp_current++;
				}
			}
		}

		if($args==0) {
			$query="select count(*) from yman_documents, yman_document_extra_vars, yman_document_extra_vars as yman_document_extra_vars2, yman_document_extra_vars as yman_document_extra_vars3 where yman_documents.document_srl=yman_document_extra_vars.document_srl and yman_document_extra_vars.eid='paymentMethod' and yman_document_extra_vars.value like '%$payment%' and yman_documents.document_srl=yman_document_extra_vars2.document_srl and yman_document_extra_vars2.eid='minimumPrice' and yman_documents.module_srl=141 and yman_documents.document_srl=yman_document_extra_vars3.document_srl and yman_document_extra_vars3.eid='detailtime' and substr(yman_document_extra_vars3.value, '$current_time_str', 1) and yman_documents.title like '%$searchToken%' order by $order";
		}
		else {
			$query="select count(*) from yman_documents, yman_document_extra_vars, yman_document_extra_vars as yman_document_extra_vars2, yman_document_extra_vars as yman_document_extra_vars3 where yman_documents.document_srl=yman_document_extra_vars.document_srl and yman_document_extra_vars.eid='paymentMethod' and yman_document_extra_vars.value like '%$payment%' and yman_documents.document_srl=yman_document_extra_vars2.document_srl and yman_document_extra_vars2.eid='minimumPrice' and yman_documents.module_srl=141 and yman_documents.document_srl=yman_document_extra_vars3.document_srl and yman_document_extra_vars3.eid='detailtime' and substr(yman_document_extra_vars3.value, '$current_time_str', 1) and yman_documents.category_srl=$args and yman_documents.title like '%$searchToken%' order by $order";
		}
						
		$result=mysql_query($query,$conn);
		//쿼리체크
		
		$pageResult=mysql_fetch_array($result);
		
		$pageNum=ceil(($pageResult[0]/5)-1);
		
		echo ("<totalPage>".$pageNum."</totalPage>");
		echo ("<printCurrentPage>".(($page2/5)+1)."</printCurrentPage>");
		echo ("<printTotalPage>".($pageNum+1)."</printTotalPage>");
		echo ("<totalResult>".$pageResult[0]."</totalResult>");

		if($args==0) {
			$query="select yman_documents.document_srl, yman_documents.title, yman_documents.member_srl from yman_documents, yman_document_extra_vars, yman_document_extra_vars as yman_document_extra_vars2, yman_document_extra_vars as yman_document_extra_vars3 where yman_documents.document_srl=yman_document_extra_vars.document_srl and yman_document_extra_vars.eid='paymentMethod' and yman_document_extra_vars.value like '%$payment%' and yman_documents.document_srl=yman_document_extra_vars2.document_srl and yman_document_extra_vars2.eid='minimumPrice' and yman_documents.module_srl=141 and yman_documents.document_srl=yman_document_extra_vars3.document_srl and yman_document_extra_vars3.eid='detailtime' and substr(yman_document_extra_vars3.value, '$current_time_str', 1) and yman_documents.title like '%$searchToken%' order by $order limit $page2, 5";
		}
		else {
			$query="select yman_documents.document_srl, yman_documents.title, yman_documents.member_srl from yman_documents, yman_document_extra_vars, yman_document_extra_vars as yman_document_extra_vars2, yman_document_extra_vars as yman_document_extra_vars3 where yman_documents.document_srl=yman_document_extra_vars.document_srl and yman_document_extra_vars.eid='paymentMethod' and yman_document_extra_vars.value like '%$payment%' and yman_documents.document_srl=yman_document_extra_vars2.document_srl and yman_document_extra_vars2.eid='minimumPrice' and yman_documents.module_srl=141 and yman_documents.document_srl=yman_document_extra_vars3.document_srl and yman_document_extra_vars3.eid='detailtime' and substr(yman_document_extra_vars3.value, '$current_time_str', 1) and yman_documents.category_srl=$args and yman_documents.title like '%$searchToken%' order by $order limit $page2, 5";
		}
				
		$result=mysql_query($query,$conn);
		
		while($row=mysql_fetch_array($result)) {
			echo ("<item>");
			echo ("<document_srl>".$row['document_srl']."</document_srl>");
			echo ("<title>".$row['title']."</title>");
			echo ("<member_srl>".$row['member_srl']."</member_srl>");

			$query2="select eid, var_idx, value from yman_document_extra_vars where module_srl=141 and document_srl=".$row['document_srl'].";";
			$result2=mysql_query($query2,$conn);
			
			while($row2=mysql_fetch_array($result2)) {
				$var_idx=$row2['var_idx'];
				if($var_idx==1 || $var_idx==3 || $var_idx==6 || $var_idx==7 || $var_idx==9 || $var_idx==10) {
					if($row2['eid']=='minimumPrice') {
						echo ("<minimumPriceStr>".number_format($row2['value'])."</minimumPriceStr>");
					}
					echo ("<".$row2['eid'].">".$row2['value']."</".$row2['eid'].">");
				}
			}
			
			$query3="select uploaded_filename from yman_files where upload_target_srl=".$row['document_srl'].";";
			$result3=mysql_query($query3,$conn);
			$row3=mysql_fetch_array($result3);

			echo ("<uploaded_filename>".$row3['uploaded_filename']."</uploaded_filename>");

			echo ("</item>");
		}
	}
	// 음식 목록 가져오기
	else if($step==3) {	
		if($order=='0') $order="rand(round(date_format( now() , '%i'), -1))";
		else if($order=='1') $order="yman_documents.title";
		else if($order=='2') $order="cast(yman_document_extra_vars.value as unsigned)";
		
		$query="select count(*) from yman_documents, yman_document_extra_vars where yman_documents.document_srl=yman_document_extra_vars.document_srl and yman_document_extra_vars.eid='price' and yman_documents.module_srl=55 and yman_documents.member_srl=$args and yman_documents.title like '%$searchToken%' order by $order";
				
		$result=mysql_query($query,$conn);
		
		$pageResult=mysql_fetch_array($result);
		
		$pageNum=ceil(($pageResult[0]/8)-1);
		
		echo ("<totalPage>".$pageNum."</totalPage>");
		echo ("<printCurrentPage>".(($page3/8)+1)."</printCurrentPage>");
		echo ("<printTotalPage>".($pageNum+1)."</printTotalPage>");
		echo ("<totalResult>".$pageResult[0]."</totalResult>");

		$query="select yman_documents.document_srl, yman_documents.title, yman_documents.nick_name from yman_documents, yman_document_extra_vars where yman_documents.document_srl=yman_document_extra_vars.document_srl and yman_document_extra_vars.eid='price' and yman_documents.module_srl=55 and yman_documents.member_srl=$args and yman_documents.title like '%$searchToken%' order by $order limit $page3, 8";
		
		$result=mysql_query($query,$conn);
		//쿼리체크
		
		while($row=mysql_fetch_array($result)) {
			echo ("<item>");
			echo ("<document_srl>".$row['document_srl']."</document_srl>");
			echo ("<title>".$row['title']."1"."</title>");
			echo ("<nick_name>".$row['nick_name'].$searchToken."</nick_name>");
	
			$query2="select eid, var_idx, value from yman_document_extra_vars where module_srl=55 and document_srl=".$row['document_srl'].";";
					
			$result2=mysql_query($query2,$conn);
	
			while($row2=mysql_fetch_array($result2)) {
				$var_idx=$row2['var_idx'];
				if($var_idx==1 || $var_idx==3 || $var_idx==4) {
					if($row2['eid']=='price') {
						echo ("<priceStr>".number_format($row2['value'])."</priceStr>");
					}
					echo ("<".$row2['eid'].">".$row2['value']."</".$row2['eid'].">");
				}
			}
			$query3="select uploaded_filename from yman_files where upload_target_srl=".$row['document_srl'].";";
			$result3=mysql_query($query3,$conn);
			$row3=mysql_fetch_array($result3);

			echo ("<uploaded_filename>".$row3['uploaded_filename']."</uploaded_filename>");

			echo ("</item>");
		}
	}

	mysql_close($conn);
?>
</lists>