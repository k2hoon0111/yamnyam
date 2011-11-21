<?php
    /**
     * @class  krzip_popupView
     * @author 러키군 (admin@barch.kr)
     * @brief  krzip_popup 모듈의 view class
     **/

    class krzip_popupView extends krzip_popup {

        /**
         * @brief 초기화
         *
         **/
        function init() {
            // template path지정
            $this->setTemplatePath($this->module_path.'tpl');
        }

        function dispKrzip_popupIndex() {
            $this->setLayoutFile('popup_layout');

            // 브라우저 타이틀 추가
            Context::addBrowserTitle("우편번호 검색");

            // column_name
            $column_name = Context::get('column_name');
            Context::set('column_name',$column_name);

            // 템플릿 파일 지정
            $this->setTemplateFile('index');
        }
    }
?>
