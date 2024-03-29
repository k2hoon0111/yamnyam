<?php
    /**
     * @class  krzip_poup
     * @author 러키군 (admin@barch.kr)
     * @brief  krzip_popup 모듈의 high class
     **/

    class krzip_popup extends ModuleObject {

        /**
         * @brief 설치시 추가 작업이 필요할시 구현
         **/
        function moduleInstall() {
            return new Object();
        }

        /**
         * @brief 설치가 이상이 없는지 체크하는 method
         **/
        function checkUpdate() {
        }

        /**
         * @brief 업데이트 실행
         **/
        function moduleUpdate() {
            return new Object(0, 'success_updated');
        }

		function moduleUninstall() {
            return new Object();
		}

        /**
         * @brief 캐시 파일 재생성
         **/
        function recompileCache() {
        }

    }
?>
