<?php
    /**
     * @class  mail_m9
     * @author mmx900 (mmx900@gmail.com)
     * @brief  mail_m9 module의 view class
     **/

    class mail_m9 extends ModuleObject {

        /**
         * @brief 설치시 추가 작업이 필요할시 구현
         **/
        function moduleInstall() {
            // action forward에 등록 (관리자 모드에서 사용하기 위함)
            $oModuleController = &getController('module');
            $oModuleController->insertActionForward('mail_m9', 'view', 'dispMail_m9AdminConfig');

            return new Object();
        }

        /**
         * @brief 설치가 이상이 없는지 체크하는 method
         **/
        function checkUpdate() {
            $oModuleModel = &getModel('module');
            $act = $oModuleModel->getActionForward('dispMail_m9AdminConfig');
            if(!$act) return true;
            
            return false;
        }

        /**
         * @brief 업데이트 실행
         **/
        function moduleUpdate() {
        	$this->moduleInstall();
            return new Object(0, 'success_updated');
        }

        /**
         * @brief 캐시 파일 재생성
         **/
        function recompileCache() {
        }
    }
?>