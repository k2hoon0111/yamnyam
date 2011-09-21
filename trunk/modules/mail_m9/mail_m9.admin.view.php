<?php
    /**
     * @class  mail_m9AdminView
     * @author mmx900 (mmx900@gmail.com)
     * @brief  mail_m9 모듈의 admin view class
     **/

    class mail_m9AdminView extends mail_m9 {

        /**
         * @brief 초기화
         **/
        function init() {
        }

        /**
         * @brief 설정
         **/
        function dispMail_m9AdminConfig() {
            // 설정 정보를 받아옴 (module model 객체를 이용)
            $oModuleModel = &getModel('module');
            $config = $oModuleModel->getModuleConfig('mail_m9');
            Context::set('config',$config);

            // 템플릿 파일 지정
            $this->setTemplatePath($this->module_path.'tpl');
            $this->setTemplateFile('send_mail');
        }


    }
?>
