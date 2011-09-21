<?php
    /**
     * vi:set sw=4 ts=4 expandtab enc=utf8:
     * @class  mobilemessageModel
     * @author diver(diver@coolsms.co.kr)
     * @brief  mobilemessageModel
     */
    class mobilemessageModel extends mobilemessage {
        function mobilemessageModel() {
        }

        /**
         * 모듈 환경설정값 가져오기
         */
        function getModuleConfig() {
            $oModuleModel = &getModel('module');
            $config = $oModuleModel->getModuleConfig('mobilemessage');

            // country code
            if (!$config->default_country) $config->default_country = '82';
            if ($config->default_country == '82') $config->limit_bytes = 80;
            else $config->limit_bytes = 160;

            // callback
            $callback = explode("|@|", $config->callback); // source
            $config->a_callback = $callback;        // array
            $config->s_callback = join($callback);  // string

            // admin_phone
            if (!is_array($config->admin_phones))
                $config->admin_phones = explode("|@|", $config->admin_phones);

            return $config;
        }

        /**
         * 환경값 읽어오기
         */
        function getConfig() {
            $config = $this->getModuleConfig();

            // 캐쉬, 포인트, 문자방울 잔량 가져오기
            $config->cs_cash=0;
            $config->cs_point=0;
            $config->cs_mdrop=0;

            require_once($this->module_path.'coolsms.php');
            $sms = new coolsms();
            $sln_reg_key = $this->getSlnRegKey();
            if ($sln_reg_key) $sms->enable_resale();
            $sms->appversion("MXE/" . $this->version . " XE/" . __ZBXE_VERSION__);
            if ($config->cs_userid && $config->cs_passwd) {
                $sms->setuser($config->cs_userid, $config->cs_passwd);
                if ($sms->connect()) {
                    $remain = $sms->remain();
                    $config->cs_cash = $remain['CASH'];
                    $config->cs_point = $remain['POINT'];
                    $config->cs_mdrop = $remain['DROP'];
                    if ($remain['RESULT-CODE'] != '00')
                    {
                        Context::set('cs_is_logged', false);
                        switch ($remain['RESULT-CODE'])
                        {
                            case '20':
                                Context::set('cs_error_message', '<font color="red">존재하지 않는 아이디이거나 패스워드가 틀립니다.</font>');
                                break;
                            case '30':
                                Context::set('cs_error_message', '<font color="red">사용가능한 SMS 건수가 없습니다.</font>');
                                break;
                            default:
                                Context::set('cs_error_message', '<font color="red">오류코드:'.$remain['RESULT-CODE'].'</font>');
                        }
                    }
                    else
                    {
                        Context::set('cs_is_logged', true);
                    }
                    $sms->disconnect();
                } else {
                    Context::set('cs_is_logged', false);
                    Context::set('cs_error_message', '<font color="red">서비스 서버에 연결할 수 없습니다.<br />일부 웹호스팅에서 외부로 나가는 포트 접속을 허용하지 않고 있습니다.<br /><a href="http://message.xpressengine.net/18243690">사용불가 웹호스팅</a> 문서를 참고하시고 목록에 없다면 신고하여 주세요.</font>');
                }
            }
            Context::set('cs_cash', $config->cs_cash);
            Context::set('cs_point', $config->cs_point);
            Context::set('cs_mdrop', $config->cs_mdrop);

            return $config;
        }

        function getConfigValue(&$obj, $key) {
            $config = $this->getModuleConfig();

            debugPrint('key:' . $key);
            debugPrint('config: ' . serialize($config));
            $fieldname = $config->{$key};
            if (!$fieldname) return null;
            debugPrint('fieldname:' . $fieldname);

            debugPrint('value:' . $obj->{$fieldname});
            // 기본필드에서 확인
            if ($obj->{$fieldname}) return $obj->{$fieldname};

            // 확장필드에서 확인
            if ($obj->extra_vars) {
                $extra_vars = unserialize($obj->extra_vars);
                if ($extra_vars->{$fieldname}) {
                    return $extra_vars->{$fieldname};
                }
            }

            return null;
        }

        function getMobilemessageList() {
            $query_id = 'mobilemessage.getMobilemessageList';

            $args->page = Context::get('page');
            $args->list_count = 40;
            $args->page_count = 10;

            return executeQuery($query_id, $args);
        }

        function getMobilemessageMessageInfo($args) {
            $query_id = 'mobilemessage.getMobilemessage';
            return executeQuery($query_id, $args);
        }

        function getMobilemessagesInGroup($args) {
            $query_id = 'mobilemessage.getMobilemessagesInGroup';

            if (!$args->page)
                $args->page = Context::get('page');
            if (!$args->list_count)
                $args->list_count = 40;
            if (!$args->page_count)
                $args->page_count = 10;

            return executeQuery($query_id, $args);
        }

        function getMobilemessageGrouping($args) {
            $db_info = Context::getDBInfo();
            if (strtolower(substr($db_info->db_type, 0, 5)) == 'mysql')
                $query_id = 'mobilemessage.getMobilemessageGrouping_MySQL';
            else
                $query_id = 'mobilemessage.getMobilemessageGrouping';

            if (!$args->page)
                $args->page = Context::get('page');
            if (!$args->list_count)
                $args->list_count = 40;
            if (!$args->page_count)
                $args->page_count = 10;

            $output = executeQueryArray($query_id, $args);
            if (!$output->toBool() || !$output->data) return $output;

            if (strtolower(substr($db_info->db_type, 0, 5)) != 'mysql') {
                foreach ($output->data as $no => $row) {
                    unset($args);
                    $args->gid = $row->gid;
                    $msginfo = executeQueryArray('mobilemessage.getMobilemessageGroupMsgInfo', $args);
                    $output->data[$no]->regdate = $msginfo->data[1]->regdate;
                    $output->data[$no]->userid = $msginfo->data[1]->userid;
                    $output->data[$no]->content = $msginfo->data[1]->content;
                    $output->data[$no]->reservdate = $msginfo->data[1]->reservdate;
                }
            }
            return $output;
        }

        function getPurplebookList($args) {
            $query_id = 'mobilemessage.getPurplebookList';
            return executeQueryArray($query_id, $args);
        }

        function getPurplebookListPaging($args) {
            $query_id = 'mobilemessage.getPurplebookListPaging';
            return executeQueryArray($query_id, $args);
        }

        function getUserIDsByPhoneNumber($phone_num, $country_code='82') {
            $args = new StdClass();
            $args->phone_num = $phone_num;
            $args->country = $country_code;
            $query_id = 'mobilemessage.getMapping';
            $output = executeQueryArray($query_id, $args);
            if (!$output->toBool()) return false; // 오류

            $userid_array = array();
            if (!$output->data) return $userid_array; // No Data

            foreach ($output->data as $row) {
                $userid_array[] = $row->user_id;
            }

            return $userid_array;
        }

        function getValCode($phonenum, $country='82')
        {
            $query_id = 'mobilemessage.getValCode';
            $args = new StdClass();
            $args->callno = $phonenum;
            $args->country = $country;
            $output = executeQuery($query_id, $args);
            if ($output->toBool() && $output->data) $output->valcode = $output->data->valcode;
            return $output;
        }

        /**
         * @brief 인증번호 인증
         *  $args->callno
         *  $args->valcode
         *  $args->country
         **/
        function validateValCode($args) {
            if (!$args->callno || !$args->valcode) return false;

            $output = $this->getValCode($args->callno, $args->country);
            if (!$output->toBool() || !$output->data) return false;
            // comparison
            if ($output->data->valcode == $args->valcode) return true;
            return false;
        }


        /**
         * @brief check whether the phone number is prohibited or not.
         * @return true if prohibited, otherwise return false
         **/
        function isProhibitedNumber($phonenum, $country='82') {
            $query_id = 'mobilemessage.getProhibit';
            $args = new StdClass();
            $args->phone_num = $phonenum;
            $args->country = $country;
            $output = executeQueryArray($query_id, $args);
            if (!$output->toBool() || !$output->data) return false;
            if (count($output->data) > 0) {
                $limit_date = $output->data[0]->limit_date;
                // check limit date.
                if (!$limit_date) return true;
                // compare the limit date to today.
                else if ($limit_date >= date("Ymd")) return true;
                // prohibition expired
                return false;
            }
            return false;
        }

        /**
         * @brief Group List
         **/
        function getMobilemessageGroupList() {
            $site_srl = Context::get('site_srl');
            if (!$site_srl) $site_srl = 0;
		    $oMemberModel = &getModel('member');
		    $group_list = $oMemberModel->getGroups($site_srl);
            $this->add('grouplist', $group_list);
	    }

        /**
         * @brief 주소록
         **/
        function getMobilemessagePurplebookList() {
            $logged_info = Context::get('logged_info');
            if (!$logged_info)
                return new Object(-1, 'msg_not_logged');

            $args->user_id = $logged_info->user_id;
            $args->node_route = Context::get('node_route');
            $args->node_type = Context::get('node_type');

            $oMobilemessageModel = &getModel('mobilemessage');
            $output = $oMobilemessageModel->getPurplebookList($args);

            if ((!is_array($output->data) || !count($output->data)) && $args->node_type == '1' && $args->node_route == '.') {
                return;
            }

            $data = array();

            if (is_array($output->data)) {
                foreach ($output->data as $no => $row) {
                    $obj = new StdClass();
                    $obj->attributes = new StdClass();
                    $obj->attributes->id = $row->node_id;
                    $obj->attributes->node_id = $row->node_id;
                    $obj->attributes->node_name = $row->node_name;
                    $obj->attributes->node_route = $row->node_route;
                    $obj->attributes->phone_num = $row->phone_num;
                    $obj->data = $row->node_name;
                    $obj->state = "closed";
                    $data[] = $obj;
                }
            }
            $this->add('total_count', $output->total_count);
            $this->add('data', $data);
            $this->add('base_url', Context::get('base_url'));
        }

        function getMobilemessagePurplebookSearch() {
            $searchkey = Context::get('searchkey');
            $searchword = Context::get('searchword');
            $logged_info = Context::get('logged_info');
            if (!$logged_info) return new Object(-1, 'msg_invalid_request');

            $args->user_id = $logged_info->user_id;
            switch ($searchkey) {
                case "name":
                    $args->node_name = $searchword;
                    break;
                case "phone":
                    $args->phone_num = $searchword;
                    break;
            }
            $output = executeQueryArray('mobilemessage.getPurplebookSearch', $args);
            $this->add('data', $output->data);
        }

        function getNotiDocInfos($module_srl) {
            if (!$module_srl) return array();
            $query_id = "mobilemessage.getNotiDocInfoByModuleSrl";
            $args->module_srl = $module_srl;
            $output = executeQueryArray($query_id, $args);
            if (!$output->toBool() || !$output->data) return array();

            foreach ($output->data as $no => $row) {
                $extra_vars = unserialize($output->data[$no]->extra_vars);
                if ($extra_vars) {
                    foreach ($extra_vars as $key => $val) {
                        $output->data[$no]->{$key} = $val;
                    }
                }
            }

            return $output->data;
        }

        function getNotiComInfo($module_srl) {
            if (!$module_srl) return false;
            $query_id = "mobilemessage.getNotiComInfoByModuleSrl";
            $args->module_srl = $module_srl;
            $output = executeQuery($query_id, $args);
            if (!$output->toBool() || !$output->data) return false;

            $extra_vars = unserialize($output->data->extra_vars);
            if ($extra_vars) {
                foreach ($extra_vars as $key => $val) {
                    $output->data->{$key} = $val;
                }
            }

            return $output->data;
        }

        function getMobilemessageFilePickerPath($mobilemessage_file_srl){
            return sprintf("./files/attach/mobilemessage/%s",getNumberingPath($mobilemessage_file_srl,3));
        }

        function getSlnRegKey() {
            if (!file_exists($this->module_path.'resale.info.php')) return false;
            require_once($this->module_path.'resale.info.php');
            return __SOLUTION_REGISTRATION_KEY__;
        }
    }
?>
