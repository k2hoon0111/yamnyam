<?php
    /**
     * @class  mail_m9AdminController
     * @author mmx900 (mmx900@gmail.com)
     * @brief  mail_m9 모듈의 admin controller class
     **/

    class mail_m9AdminController extends mail_m9 {

        /**
         * @brief 초기화
         **/
        function init() {
        }

        /**
         * @brief 설정
         **/
        function procMail_m9AdminSendMail() {
            // 기본 정보를 받음
            $args = Context::gets('sender_name','sender_email','receiptor_name','receiptor_email',
            						'send_to_all', 'title','content','content_type');
            
            
            $oMail = new Mail();
            $oMail->setTitle($args->title);
            $oMail->setContent($args->content);
            $oMail->setSender($args->sender_name, $args->sender_email);
            
            $cnt = 0;
            
            if($args->send_to_all == 'Y'){

            // 모듈 정보를 가져옴
            $oModuleModel = &getModel('module');
            $config = $oModuleModel->getModuleConfig('mail_m9');

            
            // Email List를 가져옴
//            $args->is_mailing = 'Y';
            $output = executeQueryArray('mail_m9.getEmailAddrList');
            
            
            if(!$output->toBool()) {
            	  return $output;
            }
	            
	           if($output->data){
            		$member_list = $output->data;
				    foreach($member_list as $m){
				    	if($m->allow_mailing == 'Y'){
	            			$oMail->setReceiptor($m->user_name, $m->email_address);
				            $oMail->send();
				            $cnt++;
			            }
				    	if($m->allow_mailing == 'N'){
	            			$oMail->setReceiptor($m->user_name, $m->email_address);
				            $oMail->send();
				            $cnt++;
			            } // 만약 체크안한사람에게도 메일 보내기를 원할경우
				    }
	            }
            }else{
            	$oMail->setReceiptor($args->receiptor_name, $args->receiptor_email);
	            $oMail->send();
	            $cnt++;
            }
            
            $this->setMessage( sprintf(Context::getLang('msg_send_success'), $cnt) );
        }
        
    }
?>
