<?php
    /**
     * @class  boardController
     * @author NHN (developers@xpressengine.com)
     * @brief  board 모듈의 Controller class
     **/

    class boardController extends board {

        /**
         * @brief 초기화
         **/
        function init() {
        }

        /**
         * @brief 문서 입력
         **/
        function procBoardInsertDocument() {

            // 권한 체크
			if($this->module_info->module != "board") return new Object(-1, "msg_invalid_request");
            if(!$this->grant->write_document) return new Object(-1, 'msg_not_permitted');
            $logged_info = Context::get('logged_info');
			
			/**
			* 11.3.29 -병웅
			* 확장변수 유효성 검사
			**/
			$mid = Context::get('mid');
			
			if ($mid == "restaurant_list"){
				$extra_vars6 = Context::get('extra_vars6');
				$extra_vars7 = Context::get('extra_vars7');
				if(!ereg("(^[0-9][0-9]:[0-9][0-9]$)",$extra_vars6)) return new Object(-1, '영업시작시간을 00:00 형식으로 작성하세요.');
				if(!ereg("(^[0-9][0-9]:[0-9][0-9]$)",$extra_vars7)) return new Object(-1, '영업마감시간을 00:00 형식으로 작성하세요.');

			}
			else if ($mid == "food_list"){
			/* 20110428. 음식에 영업시간 제거
				$extra_vars5 = Context::get('extra_vars5');
				$extra_vars6 = Context::get('extra_vars6');
				if(!ereg("(^[0-9][0-9]:[0-9][0-9]$)",$extra_vars5)) return new Object(-1, '영업시작시간을 00:00 형식으로 작성하세요.');
				if(!ereg("(^[0-9][0-9]:[0-9][0-9]$)",$extra_vars6)) return new Object(-1, '영업마감시간을 00:00 형식으로 작성하세요.');
			*/
			}
			
            // 글작성시 필요한 변수를 세팅
            $obj = Context::getRequestVars();
            $obj->module_srl = $this->module_srl;
            if($obj->is_notice!='Y'||!$this->grant->manager) $obj->is_notice = 'N';
			
            settype($obj->title, "string");
            if($obj->title == '') $obj->title = cut_str(strip_tags($obj->content),20,'...');
            //그래도 없으면 Untitled
            if($obj->title == '') $obj->title = 'Untitled';

            // 관리자가 아니라면 게시글 색상/굵기 제거
            if(!$this->grant->manager) {
                unset($obj->title_color);
                unset($obj->title_bold);
            }

            // document module의 model 객체 생성
            $oDocumentModel = &getModel('document');

            // document module의 controller 객체 생성
            $oDocumentController = &getController('document');

            // 이미 존재하는 글인지 체크
            $oDocument = $oDocumentModel->getDocument($obj->document_srl, $this->grant->manager);

            // 익명 설정일 경우 여러가지 요소를 미리 제거 (알림용 정보들 제거)
            if($this->module_info->use_anonymous == 'Y') {
                $obj->notify_message = 'N';
                $this->module_info->admin_mail = '';
                $obj->member_srl = -1*$logged_info->member_srl;
                $obj->email_address = $obj->homepage = $obj->user_id = '';
                $obj->user_name = $obj->nick_name = 'anonymous';
                $bAnonymous = true;
            }
            else
            {
                $bAnonymous = false;
            }

            // 이미 존재하는 경우 수정
            if($oDocument->isExists() && $oDocument->document_srl == $obj->document_srl) {
				if(!$oDocument->isGranted()) return new Object(-1,'msg_not_permitted');
                $output = $oDocumentController->updateDocument($oDocument, $obj);
                $msg_code = 'success_updated';
			
            // 그렇지 않으면 신규 등록
            } else {
                $output = $oDocumentController->insertDocument($obj, $bAnonymous);
                $msg_code = 'success_registed';
                $obj->document_srl = $output->get('document_srl');

                // 문제가 없고 모듈 설정에 관리자 메일이 등록되어 있으면 메일 발송
                if($output->toBool() && $this->module_info->admin_mail) {
                    $oMail = new Mail();
                    $oMail->setTitle($obj->title);
                    $oMail->setContent( sprintf("From : <a href=\"%s\">%s</a><br/>\r\n%s", getFullUrl('','document_srl',$obj->document_srl), getFullUrl('','document_srl',$obj->document_srl), $obj->content));
                    $oMail->setSender($obj->user_name, $obj->email_address);

                    $target_mail = explode(',',$this->module_info->admin_mail);
                    for($i=0;$i<count($target_mail);$i++) {
                        $email_address = trim($target_mail[$i]);
                        if(!$email_address) continue;
                        $oMail->setReceiptor($email_address, $email_address);
                        $oMail->send();
                    }
                }
                
                // orderlist에서 글썼을때만 해당내용 실행되도록! - 병웅
                if($mid == "order_list"){
                	/*--------------------------------------------
                	// 11.3.30 최근배송지주소 저장 - 병웅
                	----------------------------------------------*/
					if ($obj->extra_vars13 == '') return new Object(-1, '배달될 주소를 입력해주세요.');
										
					// 추가요구사항 처리 - 병웅
					$order_detail = $obj->order_detail;
					$enter = chr(13).chr(10);
					$order_detail=ereg_replace($enter,"",$order_detail);

					$order_detail = explode("|@|",$order_detail);

		            $oDB = &DB::getInstance();
		            $oDB->begin();
										
					$recent_address = explode("|",$logged_info->recentaddress);

					$recent_address[4] = $recent_address[3];
					$recent_address[3] = $recent_address[2];
					$recent_address[2] = $recent_address[1];
					$recent_address[1] = $recent_address[0];
					$recent_address[0] = $obj->extra_vars13;

					$args->recentaddress = "";
					for($i=0;$i < 5;$i++){
						$args->recentaddress .= $recent_address[$i]."|";
					}
					
				
		            // DB에 update
		            //if($args->password) $args->password = md5($args->password);
		            //else $args->password = $logged_info->password;
		            //if(!$args->user_name) $args->user_name = $logged_info->user_name;
					if(!$args->member_srl) $args->member_srl = $logged_info->member_srl;
					

					$all_args->cellphone = $logged_info->cellphone;
					$all_args->validationcode = $logged_info->validationcode;
					$all_args->address = $logged_info->address;
					$all_args->notification = $logged_info->notification;
					$all_args->opentime = $logged_info->opentime;
					$all_args->closetime = $logged_info->closetime;
					$all_args->recentaddress = $args->recentaddress;
	            
		            $args->extra_vars = serialize($all_args);

		            $oMemberController = &getController('member');

		            // member_srl의 값에 따라 insert/update
		            $output2 = $oMemberController->updateMember($args);
		            if(!$output2->toBool()) return $output2;                	
                	
	                //상점별 문자 발송을 위한 나의 노가다가 시작되었다.
	                $product_data = $obj->extra_vars1;
					$product_data2 = explode("&&", $product_data);
					$count_product = count($product_data2)-1;
	
					$span2 = $obj->extra_vars2;
					$span_sum2 = $obj->extra_vars8;
					$span = explode("|", $span2);
					
					$span_sum = explode("|", $span_sum2);
					
					$count_store = count($span)-1;
					
					for ($i=0; $i < $count_product; $i++){
							$product[$i] = explode("|", $product_data2[$i]);
					}
					
					
					// $product[상품하나하나][0:상품번호,1:상점이름,2:상품명,3:개수,4:가격,5:상점폰번호,6:결제방법,7:상점메일]
					// $span[] : 같은상점으로 몇개씩 묶여있는지 array로 되있음.
					// $span_sum[] : 같은상점별 총 주문가격 array로 되있음.
					// $count_product : 총 몇개의 상품이있는지
					// $count_store : 총 몇개의 상점에 보내야되는지 숫자
	 
	 				/*---------------------------------------------
	 				// 11.3.23 보안을 위한 데이터 유효성검사 - 병웅
	 				---------------------------------------------*/
		            // document module의 model 객체 생성
		            $ooDocumentModel = &getModel('document');
					$totalPrice = 0;
					$totalPrice2= 0;
		            
		            for ($i=0; $i < $count_product; $i++){
			            // 이미 존재하는 글인지 체크
			            $ooDocument = $ooDocumentModel->getDocument($product[$i][0]);
		
		                // 해당 문서가 존재할 경우 필요한 처리를 함
		                if(!($ooDocument->isExists())) {
		                    Context::set('document_srl','',true);
		                    $this->alertMessage('msg_not_founded');
		                }
		
						// 가격검사
						if($ooDocument->getExtraValue(1) != $product[$i][4]/$product[$i][3])	return new Object(-1, 'Error');
						
						//수량검사
						if($product[$i][3] <1)	return new Object(-1, 'Error');
						
						// 총 결제금액 검사
						$totalPrice += $ooDocument->getExtraValue(1)*$product[$i][3];
					}
	                
	                for ($i=0; $i < $count_store; $i++){
	                	$totalPrice2 += $span_sum[$i];
	                }
	                if($totalPrice != $totalPrice2) 	return new Object(-1, 'Error');
		               
					$extra_vars14 = Context::get('extra_vars14');

	                // 문자 내용을 만든다~!
	                $k=0;
	                for ($i=0; $i < $count_store; $i++)
	                {
						$strMessage = "[".$extra_vars14."]";
						
	                	for ($j=0; $j < $span[$i]; $j++)
	                	{
	                		$strMessage .= $product[$k][2]."-".$product[$k][4]/$product[$k][3]."원*".$product[$k][3]."개 ";
	                		$payment = $product[$k][6];
	                		$k++;
	                	}
	                	$strMessage .= "총 ".$span_sum[$i]."원 ";
	                	
	                	
	                	if($payment == "cash") $strMessage .="현금결제";
	                	else if ($payment == "card") $strMessage .="카드결제";
	                	
	                	$address = split("장안구",$recent_address[0]);
	                	if (!$address[1]) {
	                		$address[1] = $address[0];
	                	}
	                	$address[1] = str_replace("성균관대학교", "성대", $address[1]);
	                	$address[1] = str_replace("자연과학캠퍼스", "", $address[1]);
	                	$address[1] = str_replace("율전캠퍼스", "", $address[1]);

	                	$strMessage .= "/".$address[1];
						$strMessageCopy = $strMessage;

	                	if (mb_strlen($order_detail[$i],"EUC-KR") > 60)	{return new Object(-1, 'ERROR');}
	                	else {
	                		if($order_detail[$i] != "null" && $order_detail[$i] ) $strMessage .= "/요구사항:".$order_detail[$i];
	                		else {
	                		
	                		}
							
	                		if(mb_strlen($strMessage,"EUC-KR") <= 80){
//	                			$strMessages = mb_substr($strMessage,0,mb_strlen($order_detail[$i],"EUC-KR"));
								$strMessages = $strMessage;
	                		}
	                		else{
								preg_match_all('/[\xEA-\xED][\x80-\xFF]{2}|./', $strMessage, $match);

								$checkmb=true;
								$str=$strMessage;
								$len=80;

							    $m    = $match[0];
							    $slen = strlen($str);
							    $mlen = count($m);
							    
							    $ret   = array();
							    $count = 0;
							    
							    for ($j=0; $j < $len; $j++) {
								    $count += ($checkmb && strlen($m[$j]) > 1)?2:1;
								    if ($count > $len) {$start2=$j; break;}
								    $ret[] = $m[$j];
							    }
							    
							    $ret2   = array();
							    $count = 0;
							    
							    for ($j=$start2; $j < $slen; $j++) {
								    $count += ($checkmb && strlen($m[$j]) > 1)?2:1;
								    $ret2[] = $m[$j];
							    }

	                			$strMessages[0] = implode($ret);
	                			$strMessages[1] = implode($ret2);
	                				                			
	                			if(mb_strlen($strMessages[1],"EUC-KR") > 80){

									preg_match_all('/[\xEA-\xED][\x80-\xFF]{2}|./', $strMessages[1], $match);
	
									$checkmb=true;
									$str=$strMessages[1];
									$len=80;
	
								    $m    = $match[0];
								    $slen = strlen($str);
								    $mlen = count($m);
								    
								    $ret3   = array();
								    $count = 0;
								    
								    for ($j=0; $j < $len; $j++) {
									    $count += ($checkmb && strlen($m[$j]) > 1)?2:1;
									    if ($count > $len) {$start2=$j; break;}
									    $ret3[] = $m[$j];
								    }
								    
								    $ret4   = array();
								    $count = 0;
								    
								    for ($j=$start2; $j < $slen; $j++) {
									    $count += ($checkmb && strlen($m[$j]) > 1)?2:1;
									    if ($count > $len) break;
									    $ret4[] = $m[$j];
								    }

									$strMessages[1] = implode($ret3);
									$strMessages[2] = implode($ret4);
	                				$strMessages[1] = "[".$extra_vars14."]".$strMessages[1];
	                				$strMessages[2] = "[".$extra_vars14."]".$strMessages[2];
	                			}
	                			else {
	                				$strMessages[1] = "[".$extra_vars14."]".$strMessages[1];
	                			}
	                			
	                		}
	                	}
/*
			                    $oMail->setTitle('새로운 주문이 도착했습니다.');
			                    $oMail->setContent( strip_tags($obj->content, '') );
			                    $oMail->setSender($obj->user_name, $obj->email_address);
			
			                    $target_mail = $obj->restaurant_email;
			
			                    $email_address = trim($target_mail);
			                    if(!$email_address) continue;
			                    $oMail->setReceiptor($email_address, $email_address);

*/
						$nicknamefornoti = $product[$i][1];
	                	if ($this->module_info->sms_send=='Y') {
	                	
							$result = $oDB->_query("SELECT extra_vars from yman_member where nick_name = '$nicknamefornoti' limit 1;");
							$outDB = $oDB->_fetch($result);
							$extraV = (array)$outDB;
							
							$notification=1;
							if(strstr($extraV[extra_vars], 'SMS')) $notification*=2;
							if(strstr($extraV[extra_vars], 'MMS')) $notification*=3;
							if(strstr($extraV[extra_vars], 'E-MAIL')) $notification*=5;
																									
			                if (($notification%2)==0) {
				                	// mobilemessage모듈의 Controller 인스턴스를 얻어옵니다.
									$oMobilemessageController = &getController('mobilemessage');
									// sendMessage메서드에 넘겨질 인자들을 입력합니다.
									$args->type = 'SMS';     // 'LMS'로 변경하면 장문 2,000 바이트까지 전송됩니다. (기본 SMS)
									$args->recipient = $product[$k-1][5];  // 수신번호
									$args->callback = $obj->extra_vars4;   // 발신번호
									
									if(count($strMessages) == 1){
										$args->message = strip_tags($strMessages, '');  // 완성형한글 기준으로 80바이트 이상은 잘려서 80바이트 이하만 발송됩니다.
										// sendMessage를 호출합니다.
										$oMobilemessageController->sendMessage($args);
									}
									else if(count($strMessages) == 2) {
										$args->message = strip_tags($strMessages[0], '');
										// sendMessage를 호출합니다.
										$oMobilemessageController->sendMessage($args);
										
										$args->message = strip_tags($strMessages[1], '');
										// sendMessage를 호출합니다.
										$oMobilemessageController->sendMessage($args);
									}
									else if(count($strMessages) == 3) {
										$args->message = strip_tags($strMessages[0], '');
										// sendMessage를 호출합니다.
										$oMobilemessageController->sendMessage($args);
										
										$args->message = strip_tags($strMessages[1], '');
										// sendMessage를 호출합니다.
										$oMobilemessageController->sendMessage($args);
										
										$args->message = strip_tags($strMessages[2], '');
										// sendMessage를 호출합니다.
										$oMobilemessageController->sendMessage($args);
									}
			                }
			                if (($notification%3)==0) {
				                	// mobilemessage모듈의 Controller 인스턴스를 얻어옵니다.
									$oMobilemessageController = &getController('mobilemessage');
									// sendMessage메서드에 넘겨질 인자들을 입력합니다.
									$args->type = 'LMS';     // 'LMS'로 변경하면 장문 2,000 바이트까지 전송됩니다. (기본 SMS)
									$args->recipient = $product[$k-1][5];  // 수신번호
									$args->callback = $obj->extra_vars4;   // 발신번호

									if(count($strMessages) == 1){
										$args->message = strip_tags($strMessages, '');  // 완성형한글 기준으로 80바이트 이상은 잘려서 80바이트 이하만 발송됩니다.
										
										// sendMessage를 호출합니다.
										$oMobilemessageController->sendMessage($args);
									}
									else {
									
										$args->message = strip_tags($strMessages[0], '');
										// sendMessage를 호출합니다.
										$oMobilemessageController->sendMessage($args);
										
										$args->message = strip_tags($strMessages[1], '');
										// sendMessage를 호출합니다.
										$oMobilemessageController->sendMessage($args);
									}
			                }
			                if (($notification%5)==0) {
								// 상점의 이름으로부터 상점메일을 구한다.
								$result = $oDB->_query("SELECT email_address from yman_member where nick_name = '$nicknamefornoti' limit 1;");
								$outDB = $oDB->_fetch($result);
								$restaurant_email = (array)$outDB;	
			                			                
			                    $oMail = new Mail();
			                    $oMail->setTitle('새로운 주문이 도착했습니다.');
			                    $tempContents = strip_tags($obj->content, '<div><table><tr><td>');
			                    $tempContentsArr = explode("최근배송지",$tempContents);

			                    //$oMail->setContent( $tempContentsArr[0]."<br/>".$all_args->address[0].$all_args->address[1] );
			                    $oMail->setContent(strip_tags($strMessageCopy, ''));
			                    $oMail->setSender($obj->user_name, $obj->email_address);
			
			                    $target_mail = $restaurant_email[email_address];
			
			                    $email_address = trim($target_mail);
			                    if(!$email_address) continue;
			                    $oMail->setReceiptor($email_address, $email_address);
			                    $oMail->send();
			                }
			                if ($nicknamefornoti=="테스트상점") {
								$action_url = "http://air21.daum.net/air21/widget/sendMessage.daum?key="."vkaXgJftjHULHG9r380WPw%3D%3D"."&content=".urlencode($strMessageCopy)."&from=".$obj->extra_vars4;
								$result = @file($action_url);
			                }
		                }	
	                }
                }
            }

            // 오류 발생시 멈춤
            if(!$output->toBool()) return $output;

            // 결과를 리턴
            $this->add('mid', Context::get('mid'));
            $this->add('document_srl', $output->get('document_srl'));

            // 성공 메세지 등록
            $this->setMessage($msg_code);
        }
        

        /**
         * @brief 문서 삭제
         **/
        function procBoardDeleteDocument() {
            // 문서 번호 확인
            $document_srl = Context::get('document_srl');

            // 문서 번호가 없다면 오류 발생
            if(!$document_srl) return $this->doError('msg_invalid_document');

            // document module model 객체 생성
            $oDocumentController = &getController('document');

            // 삭제 시도
            $output = $oDocumentController->deleteDocument($document_srl, $this->grant->manager);
            if(!$output->toBool()) return $output;

            // 성공 메세지 등록
            $this->add('mid', Context::get('mid'));
            $this->add('page', $output->get('page'));
            $this->setMessage('success_deleted');
        }

        /**
         * @brief 추천
         **/
        function procBoardVoteDocument() {
            // document module controller 객체 생성
            $oDocumentController = &getController('document');

            $document_srl = Context::get('document_srl');
            return $oDocumentController->updateVotedCount($document_srl);
        }

        /**
         * @brief 코멘트 추가
         **/
        function procBoardInsertComment() {
            // 권한 체크
            if(!$this->grant->write_comment) return new Object(-1, 'msg_not_permitted');
            $logged_info = Context::get('logged_info');

            // 댓글 입력에 필요한 데이터 추출
            $obj = Context::gets('document_srl','comment_srl','parent_srl','content','password','nick_name','member_srl','email_address','homepage','is_secret','notify_message');
            $obj->module_srl = $this->module_srl;

            // 원글이 존재하는지 체크
            $oDocumentModel = &getModel('document');
            $oDocument = $oDocumentModel->getDocument($obj->document_srl);
            if(!$oDocument->isExists()) return new Object(-1,'msg_not_permitted');

            // For anonymous use, remove writer's information and notifying information
            if($this->module_info->use_anonymous == 'Y') {
                $obj->notify_message = 'N';
                $this->module_info->admin_mail = '';

                $obj->member_srl = -1*$logged_info->member_srl;
                $obj->email_address = $obj->homepage = $obj->user_id = '';
                $obj->user_name = $obj->nick_name = 'anonymous';
                $bAnonymous = true;
            }
            else
            {
                $bAnonymous = false;
            }

            // comment 모듈의 model 객체 생성
            $oCommentModel = &getModel('comment');

            // comment 모듈의 controller 객체 생성
            $oCommentController = &getController('comment');

            // comment_srl이 존재하는지 체크
            // 만일 comment_srl이 n/a라면 getNextSequence()로 값을 얻어온다.
            if(!$obj->comment_srl) {
                $obj->comment_srl = getNextSequence();
            } else {
                $comment = $oCommentModel->getComment($obj->comment_srl, $this->grant->manager);
            }

            // comment_srl이 없을 경우 신규 입력
            if($comment->comment_srl != $obj->comment_srl) {

                // parent_srl이 있으면 답변으로
                if($obj->parent_srl) {
                    $parent_comment = $oCommentModel->getComment($obj->parent_srl);
                    if(!$parent_comment->comment_srl) return new Object(-1, 'msg_invalid_request');

                    $output = $oCommentController->insertComment($obj, $bAnonymous);

                // 없으면 신규
                } else {
                    $output = $oCommentController->insertComment($obj, $bAnonymous);
                }

                // 문제가 없고 모듈 설정에 관리자 메일이 등록되어 있으면 메일 발송
                if($output->toBool() && $this->module_info->admin_mail) {
                    $oMail = new Mail();
                    $oMail->setTitle($oDocument->getTitleText());
                    $oMail->setContent( sprintf("From : <a href=\"%s#comment_%d\">%s#comment_%d</a><br/>\r\n%s", getFullUrl('','document_srl',$obj->document_srl),$obj->comment_srl, getFullUrl('','document_srl',$obj->document_srl), $obj->comment_srl, $obj->content));
                    $oMail->setSender($obj->user_name, $obj->email_address);

                    $target_mail = explode(',',$this->module_info->admin_mail);
                    for($i=0;$i<count($target_mail);$i++) {
                        $email_address = trim($target_mail[$i]);
                        if(!$email_address) continue;
                        $oMail->setReceiptor($email_address, $email_address);
                        $oMail->send();
                    }
                }

            // comment_srl이 있으면 수정으로
            } else {
				// 다시 권한체크
				if(!$comment->isGranted()) return new Object(-1,'msg_not_permitted');

                $obj->parent_srl = $comment->parent_srl;
                $output = $oCommentController->updateComment($obj, $this->grant->manager);
                $comment_srl = $obj->comment_srl;
            }
            if(!$output->toBool()) return $output;

            $this->setMessage('success_registed');
            $this->add('mid', Context::get('mid'));
            $this->add('document_srl', $obj->document_srl);
            $this->add('comment_srl', $obj->comment_srl);
        }

        /**
         * @brief 코멘트 삭제
         **/
        function procBoardDeleteComment() {
            // 댓글 번호 확인
            $comment_srl = Context::get('comment_srl');
            if(!$comment_srl) return $this->doError('msg_invalid_request');

            // comment 모듈의 controller 객체 생성
            $oCommentController = &getController('comment');

            $output = $oCommentController->deleteComment($comment_srl, $this->grant->manager);
            if(!$output->toBool()) return $output;

            $this->add('mid', Context::get('mid'));
            $this->add('page', Context::get('page'));
            $this->add('document_srl', $output->get('document_srl'));
            $this->setMessage('success_deleted');
        }

        /**
         * @brief 엮인글 삭제
         **/
        function procBoardDeleteTrackback() {
            $trackback_srl = Context::get('trackback_srl');

            // trackback module의 controller 객체 생성
            $oTrackbackController = &getController('trackback');
            $output = $oTrackbackController->deleteTrackback($trackback_srl, $this->grant->manager);
            if(!$output->toBool()) return $output;

            $this->add('mid', Context::get('mid'));
            $this->add('page', Context::get('page'));
            $this->add('document_srl', $output->get('document_srl'));
            $this->setMessage('success_deleted');
        }

        /**
         * @brief 문서와 댓글의 비밀번호를 확인
         **/
        function procBoardVerificationPassword() {
            // 비밀번호와 문서 번호를 받음
            $password = Context::get('password');
            $document_srl = Context::get('document_srl');
            $comment_srl = Context::get('comment_srl');

            $oMemberModel = &getModel('member');

            // comment_srl이 있을 경우 댓글이 대상
            if($comment_srl) {
                // 문서번호에 해당하는 글이 있는지 확인
                $oCommentModel = &getModel('comment');
                $oComment = $oCommentModel->getComment($comment_srl);
                if(!$oComment->isExists()) return new Object(-1, 'msg_invalid_request');

                // 문서의 비밀번호와 입력한 비밀번호의 비교
                if(!$oMemberModel->isValidPassword($oComment->get('password'),$password)) return new Object(-1, 'msg_invalid_password');

                $oComment->setGrant();
            } else {
                // 문서번호에 해당하는 글이 있는지 확인
                $oDocumentModel = &getModel('document');
                $oDocument = $oDocumentModel->getDocument($document_srl);
                if(!$oDocument->isExists()) return new Object(-1, 'msg_invalid_request');

                // 문서의 비밀번호와 입력한 비밀번호의 비교
                if(!$oMemberModel->isValidPassword($oDocument->get('password'),$password)) return new Object(-1, 'msg_invalid_password');

                $oDocument->setGrant();
            }
        }

        /**
         * @brief 아이디 클릭시 나타나는 팝업메뉴에 "작성글 보기" 메뉴를 추가하는 trigger
         **/
        function triggerMemberMenu(&$obj) {
            $member_srl = Context::get('target_srl');
            $mid = Context::get('cur_mid');

            if(!$member_srl || !$mid) return new Object();

            $logged_info = Context::get('logged_info');

            // 호출된 모듈의 정보 구함
            $oModuleModel = &getModel('module');
            $cur_module_info = $oModuleModel->getModuleInfoByMid($mid);

            if($cur_module_info->module != 'board') return new Object();

            // 자신의 아이디를 클릭한 경우
            if($member_srl == $logged_info->member_srl) {
                $member_info = $logged_info;
            } else {
                $oMemberModel = &getModel('member');
                $member_info = $oMemberModel->getMemberInfoByMemberSrl($member_srl);
            }

            if(!$member_info->user_id) return new Object();

            // 아이디로 검색기능 추가
            $url = getUrl('','mid',$mid,'search_target','nick_name','search_keyword',$member_info->nick_name);
            $oMemberController = &getController('member');
            $oMemberController->addMemberPopupMenu($url, 'cmd_view_own_document', './modules/member/tpl/images/icon_view_written.gif');

            return new Object();
        }

    }
?>
