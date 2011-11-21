<?php
    /**
     * @class  memberView
     * @author NHN (developers@xpressengine.com)
     * @brief  member module의 View class
     * @modification  yamNyam.com용으로 커스터마이징 (xenoz0718@skima.co.kr)
     **/

    class memberView extends member {

        var $group_list = NULL; ///< 그룹 목록 정보
        var $member_info = NULL; ///< 선택된 사용자의 정보
        var $skin = 'default';

        /**
         * @brief 초기화
         **/
        function init() {
            // 회원 관리 정보를 받음
            $oModuleModel = &getModel('module');
            $this->member_config = $oModuleModel->getModuleConfig('member');
            if(!$this->member_config->skin) $this->member_config->skin = "default";
            if(!$this->member_config->colorset) $this->member_config->colorset = "white";

            Context::set('member_config', $this->member_config);
            $skin = $this->member_config->skin;

            // template path 지정
            $tpl_path = sprintf('%sskins/%s', $this->module_path, $skin);
            if(!is_dir($tpl_path)) $tpl_path = sprintf('%sskins/%s', $this->module_path, 'default');
            $this->setTemplatePath($tpl_path);
        }

        /**
         * @brief 회원 정보 출력
         **/
        function dispMemberInfo() {
            $oMemberModel = &getModel('member');
            $logged_info = Context::get('logged_info');

            // 비회원일 경우 정보 열람 중지
            if(!$logged_info->member_srl) return $this->stop('msg_not_permitted');

            $member_srl = Context::get('member_srl');
            if(!$member_srl && Context::get('is_logged')) {
                $member_srl = $logged_info->member_srl;
            } elseif(!$member_srl) {
                return $this->dispMemberSignUpForm();
            }

            $site_module_info = Context::get('site_module_info');
            $member_info = $oMemberModel->getMemberInfoByMemberSrl($member_srl, $site_module_info->site_srl);
            unset($member_info->password);
            unset($member_info->email_id);
            unset($member_info->email_host);
            unset($member_info->email_address);

            if(!$member_info->member_srl) return $this->dispMemberSignUpForm();

            Context::set('member_info', $member_info);
            Context::set('extend_form_list', $oMemberModel->getCombineJoinForm($member_info));
            if ($member_info->member_srl == $logged_info->member_srl)
                Context::set('openids', $oMemberModel->getMemberOpenIDByMemberSrl($member_srl));

            $this->setTemplateFile('member_info');
        }

		/**	
         * @brief 회원 가입 종류 선택 화면 출력
         **/
        function dispMemberSelectType() {
            $oMemberModel = &getModel('member');

            // 로그인한 회원일 경우 해당 회원의 정보를 받음
            if($oMemberModel->isLogged()) return $this->stop('msg_already_logged');

            // before 트리거 호출
            $trigger_output = ModuleHandler::triggerCall('member.dispMemberSelectType', 'before', $this->member_config);
            if(!$trigger_output->toBool()) return $trigger_output;

            // 회원가입을 중지시켰을 때는 에러 표시
            if($this->member_config->enable_join != 'Y') return $this->stop('msg_signup_disabled');
            //Context::set('extend_form_list', $oMemberModel->getCombineJoinForm($member_info));

            //$member_config = $oMemberModel->getMemberConfig();
            //Context::set('member_config', $member_config);

            // 템플릿 파일 지정
            $this->setTemplateFile('select_type');
        }
        /**	
         * @brief 회원 가입 약관 동의 화면 출력
         **/
        function dispMemberAgreement() {
            $oMemberModel = &getModel('member');

            // 로그인한 회원일 경우 해당 회원의 정보를 받음 
            if($oMemberModel->isLogged()) return $this->stop('msg_already_logged');

            // before 트리거 호출
            $trigger_output = ModuleHandler::triggerCall('member.dispMemberAgreement', 'before', $this->member_config);
            if(!$trigger_output->toBool()) return $trigger_output;

            // 회원가입을 중지시켰을 때는 에러 표시
            if($this->member_config->enable_join != 'Y') return $this->stop('msg_signup_disabled');
            //Context::set('extend_form_list', $oMemberModel->getCombineJoinForm($member_info));

            $member_config = $oMemberModel->getMemberConfig();
            Context::set('member_config', $member_config);

            // 템플릿 파일 지정
            $this->setTemplateFile('agreement');
        }
		/**	
         * @brief 회원 가입 완료 화면 출력
         **/
        function dispMemberWelcome() {
            $oMemberModel = &getModel('member');

            // 로그인한 회원일 경우 해당 회원의 정보를 받음 
            if($oMemberModel->isLogged()) return $this->stop('msg_already_logged');

            // before 트리거 호출
            $trigger_output = ModuleHandler::triggerCall('member.dispMemberSignUpForm', 'before', $this->member_config);
            if(!$trigger_output->toBool()) return $trigger_output;

            // 회원가입을 중지시켰을 때는 에러 표시
            if($this->member_config->enable_join != 'Y') return $this->stop('msg_signup_disabled');
            //Context::set('extend_form_list', $oMemberModel->getCombineJoinForm($member_info));

            $member_config = $oMemberModel->getMemberConfig();
            Context::set('member_config', $member_config);

            // 템플릿 파일 지정
            $this->setTemplateFile('welcome');
        }

        /**
         * @brief 회원 가입 폼 출력
         **/
        function dispMemberSignUpForm() {
            $oMemberModel = &getModel('member');

            // 로그인한 회원일 경우 해당 회원의 정보를 받음
            if($oMemberModel->isLogged()) return $this->stop('msg_already_logged');

            // before 트리거 호출
            $trigger_output = ModuleHandler::triggerCall('member.dispMemberSignUpForm', 'before', $this->member_config);
            if(!$trigger_output->toBool()) return $trigger_output;

            // 회원가입을 중지시켰을 때는 에러 표시
            if($this->member_config->enable_join != 'Y') return $this->stop('msg_signup_disabled');
            Context::set('extend_form_list', $oMemberModel->getCombineJoinForm($member_info));

            $member_config = $oMemberModel->getMemberConfig();
            Context::set('member_config', $member_config);

            // 템플릿 파일 지정
            $this->setTemplateFile('signup_form');
        }
        /**
         * @brief 홍보용 회원 가입 폼 출력
         **/
        function dispMemberSignUpForm2() {
            $oMemberModel = &getModel('member');

            // 로그인한 회원일 경우 해당 회원의 정보를 받음
            if($oMemberModel->isLogged()) return $this->stop('msg_already_logged');

            // before 트리거 호출
            $trigger_output = ModuleHandler::triggerCall('member.dispMemberSignUpForm2', 'before', $this->member_config);
            if(!$trigger_output->toBool()) return $trigger_output;

            // 회원가입을 중지시켰을 때는 에러 표시
            if($this->member_config->enable_join != 'Y') return $this->stop('msg_signup_disabled');
            Context::set('extend_form_list', $oMemberModel->getCombineJoinForm($member_info));

            $member_config = $oMemberModel->getMemberConfig();
            Context::set('member_config', $member_config);

            // 템플릿 파일 지정
            $this->setTemplateFile('signup_form2');
        }
         /**
         * @brief 홍보용 회원 가입 폼 출력
         **/
        function dispMemberSignUpForm3() {
            $oMemberModel = &getModel('member');

            // 로그인한 회원일 경우 해당 회원의 정보를 받음
            if($oMemberModel->isLogged()) return $this->stop('msg_already_logged');

            // before 트리거 호출
            $trigger_output = ModuleHandler::triggerCall('member.dispMemberSignUpForm3', 'before', $this->member_config);
            if(!$trigger_output->toBool()) return $trigger_output;

            // 회원가입을 중지시켰을 때는 에러 표시
            if($this->member_config->enable_join != 'Y') return $this->stop('msg_signup_disabled');
            Context::set('extend_form_list', $oMemberModel->getCombineJoinForm($member_info));

            $member_config = $oMemberModel->getMemberConfig();
            Context::set('member_config', $member_config);

            // 템플릿 파일 지정
            $this->setTemplateFile('signup_form3');
        }
        /**
         * @brief 회원 정보 수정
         **/
        function dispMemberModifyInfo() {
            $oMemberModel = &getModel('member');
            $oModuleModel = &getModel('module');
            $memberModuleConfig = $oModuleModel->getModuleConfig('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            $logged_info = Context::get('logged_info');
            $member_srl = $logged_info->member_srl;

            $member_info = $oMemberModel->getMemberInfoByMemberSrl($member_srl);
            $member_info->signature = $oMemberModel->getSignature($member_srl);
            Context::set('member_info',$member_info);

            // 추가 가입폼 목록을 받음
            Context::set('extend_form_list', $oMemberModel->getCombineJoinForm($member_info));

            Context::set('openids', $oMemberModel->getMemberOpenIDByMemberSrl($member_srl));

            // 에디터 모듈의 getEditor를 호출하여 서명용으로 세팅
            if($member_info->member_srl) {
                $oEditorModel = &getModel('editor');
                $option->primary_key_name = 'member_srl';
                $option->content_key_name = 'signature';
                $option->allow_fileupload = false;
                $option->enable_autosave = false;
                $option->enable_default_component = true;
                $option->enable_component = false;
                $option->resizable = false;
                $option->disable_html = true;
                $option->height = 200;
                $option->skin = $this->member_config->editor_skin;
                $option->colorset = $this->member_config->editor_colorset;
                $editor = $oEditorModel->getEditor($member_info->member_srl, $option);
                Context::set('editor', $editor);
            }

            // 템플릿 파일 지정
            $this->setTemplateFile('modify_info');
        }


        /**
         * @brief 회원 작성글 보기
         **/
        function dispMemberOwnDocument() {
            $oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            $logged_info = Context::get('logged_info');
            $member_srl = $logged_info->member_srl;

            $module_srl = Context::get('module_srl');
            Context::set('module_srl',Context::get('selected_module_srl'));
            Context::set('search_target','member_srl');
            Context::set('search_keyword',$member_srl);

            $oDocumentAdminView = &getAdminView('document');
            $oDocumentAdminView->dispDocumentAdminList();

            Context::set('module_srl', $module_srl);
            $this->setTemplateFile('document_list');
        }
        
        /**
         * @brief 주문 내역 보기
         **/
        function dispMemberOwnOrder() {
            $oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            $logged_info = Context::get('logged_info');
            $member_srl = $logged_info->member_srl;

            $module_srl = Context::get('module_srl');
            Context::set('module_srl',76);
            Context::set('search_target','member_srl');
            Context::set('search_keyword',$member_srl);

            $oDocumentAdminView = &getAdminView('document');
            $oDocumentAdminView->dispDocumentAdminList();

            Context::set('module_srl','order_list');
            $this->setTemplateFile('order_list');
        }
        
         /**
         * @brief 주문된 위치 보기
         **/
        function dispMemberOrderedList() {
            $oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            $logged_info = Context::get('logged_info');
            $member_nick = $logged_info->nick_name;

            $month = Context::get('month');
            if (!$month) $month=date('n');
            Context::set('month',$month);


            $module_srl = Context::get('module_srl');
            Context::set('module_srl',76);
            Context::set('search_target','content');
            Context::set('search_keyword',$member_nick);

            $oDocumentAdminView = &getAdminView('document');
            $oDocumentAdminView->dispDocumentAdminList();

            Context::set('module_srl','ordered_list');
            $this->setTemplateFile('ordered_list');
        }

         /**
         * @brief 최근 주문된 위치 보기
         **/
        function dispMemberRecentOrderedList() {
            $oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            $logged_info = Context::get('logged_info');
            $member_nick = $logged_info->nick_name;

            $module_srl = Context::get('module_srl');
            Context::set('module_srl',76);
            Context::set('search_target','content');
            Context::set('search_keyword',$member_nick);

            $month = Context::get('month');
            if (!$month) $month=date('n');
            Context::set('month',$month);

			// 배송현황을 수정했을때
	            $delivery_modify = Context::get('delivery_modify');
	            $from = Context::get('delivery_from');
	            $to = Context::get('delivery_to');
	            $document_srl = Context::get('document_srl');
	
	            if($delivery_modify){
					$str= "";
				    $oDB = &DB::getInstance();
	
				    $result = $oDB->_query("select value from yman_document_extra_vars where document_srl=$document_srl and var_idx=3");
				    $output = $oDB->_fetch($result);
					
					$temp = (array)$output;
					$delivery = explode("|", $temp[value]);
					
					for ($i=$from; $i <= $to; $i++){
						if ($delivery[$i] == "1" || $delivery[$i] == "2"){
							$delivery[$i]++;
						}
					}
					for ($i=0; $i < count($delivery)-1; $i++){
						$str .= $delivery[$i]."|";
					}
					
   					$result = $oDB->_query("UPDATE yman_document_extra_vars SET value='$str' where document_srl=$document_srl and var_idx=3");						Context::set('test',$result);
	            }


            $oDocumentAdminView = &getAdminView('document');
            $oDocumentAdminView->dispDocumentAdminList();

            Context::set('module_srl','recent_ordered_list');
            $this->setTemplateFile('recent_ordered_list');
        }
        
        /**
         * @brief 얌냠 관리자 메인
         **/
		function dispMemberMain(){
			$oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            $logged_info = Context::get('logged_info');
            $member_srl = $logged_info->member_srl;
            $member_nick = $logged_info->nick_name;

            $start_day = Context::get('start_day');
            if (!$start_day) $start_day=date('Ym')."01";
            Context::set('start_day',$start_day);
            
            $end_day = Context::get('end_day');
            if (!$end_day) $end_day=date('Ym').date("t",time());
            Context::set('end_day',$end_day);
                        
            $unit = Context::get('unit');
            if (!$unit) $unit="day";
            Context::set('unit',$unit);
			
            $this->setTemplateFile('sales_graph');		
        }
        
        /**
         * @brief 매출 그래프 보기
         **/
        function dispMemberSalesGraph() {
            $oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            $logged_info = Context::get('logged_info');
            $member_srl = $logged_info->member_srl;
            $member_nick = $logged_info->nick_name;

            $start_day = Context::get('start_day');
            if (!$start_day) $start_day=date('Ym')."01";
            Context::set('start_day',$start_day);
            
            $end_day = Context::get('end_day');
            if (!$end_day) $end_day=date('Ym').date("t",time());
            Context::set('end_day',$end_day);
                        
            $unit = Context::get('unit');
            if (!$unit) $unit="day";
            Context::set('unit',$unit);
			
            $this->setTemplateFile('sales_graph');
        }

        /**
         * @brief 회원 스크랩 게시물 보기
         **/
        function dispMemberScrappedDocument() {
            $oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            $logged_info = Context::get('logged_info');
            $args->member_srl = $logged_info->member_srl;
            $args->page = (int)Context::get('page');

            $output = executeQuery('member.getScrapDocumentList', $args);
            Context::set('total_count', $output->total_count);
            Context::set('total_page', $output->total_page);
            Context::set('page', $output->page);
            Context::set('document_list', $output->data);
            Context::set('page_navigation', $output->page_navigation);

            $this->setTemplateFile('scrapped_list');
        }

        /**
         * @brief 회원의 저장함 보기
         **/
        function dispMemberSavedDocument() {
            $oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            // 저장함에 보관된 글을 가져옴 (저장함은 module_srl이 member_srl로 세팅되어 있음)
            $logged_info = Context::get('logged_info');
            $args->module_srl = $logged_info->member_srl;
            $args->page = (int)Context::get('page');

            $oDocumentModel = &getModel('document');
            $output = $oDocumentModel->getDocumentList($args, true);
            Context::set('total_count', $output->total_count);
            Context::set('total_page', $output->total_page);
            Context::set('page', $output->page);
            Context::set('document_list', $output->data);
            Context::set('page_navigation', $output->page_navigation);

            $this->setTemplateFile('saved_list');
        }

        /**
         * @brief 로그인 폼 출력
         **/
        function dispMemberLoginForm() {
            if(Context::get('is_logged')) {
                Context::set('redirect_url', getUrl('act',''));
                $this->setTemplatePath($this->module_path.'tpl');
                $this->setTemplateFile('redirect.html');
                return;
            }

            // 템플릿 파일 지정
            Context::set('referer_url', $_SERVER['HTTP_REFERER']);
            $this->setTemplateFile('login_form');
        }

        /**
         * @brief 회원 비밀번호 수정
         **/
        function dispMemberModifyPassword() {
            $oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            $logged_info = Context::get('logged_info');
            $member_srl = $logged_info->member_srl;

            $member_info = $oMemberModel->getMemberInfoByMemberSrl($member_srl);
            Context::set('member_info',$member_info);

            // 템플릿 파일 지정
            $this->setTemplateFile('modify_password');
        }

        /**
         * @brief 탈퇴 화면
         **/
        function dispMemberLeave() {
            $oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            $logged_info = Context::get('logged_info');
            $member_srl = $logged_info->member_srl;

            $member_info = $oMemberModel->getMemberInfoByMemberSrl($member_srl);
            Context::set('member_info',$member_info);

            // 템플릿 파일 지정
            $this->setTemplateFile('leave_form');
        }

        /**
         * @brief 오픈 아이디 탈퇴 화면
         **/
        function dispMemberOpenIDLeave() {
            $oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            $logged_info = Context::get('logged_info');
            $member_srl = $logged_info->member_srl;

            $member_info = $oMemberModel->getMemberInfoByMemberSrl($member_srl);
            Context::set('member_info',$member_info);

            // 템플릿 파일 지정
            $this->setTemplateFile('openid_leave_form');
        }

        /**
         * @brief 로그아웃 출력
         **/
        function dispMemberLogout() {
            $oMemberController = &getController('member');
            $oMemberController->procMemberLogout();

            Context::set('layout','none');
            $this->setTemplatePath($this->module_path.'/tpl');
            $this->setTemplateFile('logout');
        }

        /**
         * @brief 저장된 글 목록을 보여줌
         **/
        function dispSavedDocumentList() {
            $this->setLayoutFile('popup_layout');

            $oMemberModel = &getModel('member');

            // 로그인 되어 있지 않을 경우 로그인 되어 있지 않다는 메세지 출력
            if(!$oMemberModel->isLogged()) return $this->stop('msg_not_logged');

            // 저장함에 보관된 글을 가져옴 (저장함은 module_srl이 member_srl로 세팅되어 있음)
            $logged_info = Context::get('logged_info');
            $args->module_srl = $logged_info->member_srl;
            $args->page = (int)Context::get('page');
            $args->list_count = 10;

            $oDocumentModel = &getModel('document');
            $output = $oDocumentModel->getDocumentList($args, true);
            Context::set('total_count', $output->total_count);
            Context::set('total_page', $output->total_page);
            Context::set('page', $output->page);
            Context::set('document_list', $output->data);
            Context::set('page_navigation', $output->page_navigation);

            $this->setTemplateFile('saved_list_popup');
        }

        /**
         * @brief  아이디/ 비밀번호 찾기 기능
         **/
        function dispMemberFindAccount() {
            if(Context::get('is_logged')) return $this->stop('already_logged');

            $this->setTemplateFile('find_member_account');
        }

        /**
         * @brief  임시 비밀번호 발급
         **/
        function dispMemberGetTempPassword() {
            if(Context::get('is_logged')) return $this->stop('already_logged');

			$user_id = Context::get('user_id');
			$temp_password = $_SESSION['xe_temp_password_'.$user_id];
			unset($_SESSION['xe_temp_password_'.$user_id]);

			if(!$user_id||!$temp_password) return new Object(-1,'msg_invaild_request');

			Context::set('temp_password', $temp_password);

            $this->setTemplateFile('find_temp_password');
        }

        /**
         * @brief  인증 메일 재발송 페이지
         **/
        function dispMemberResendAuthMail() {
            if(Context::get('is_logged')) return $this->stop('already_logged');

            $this->setTemplateFile('resend_auth_mail');
        }
    }
?>
