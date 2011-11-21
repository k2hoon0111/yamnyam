SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


CREATE TABLE IF NOT EXISTS `test_session` (
  `session_key` varchar(255) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `expired` varchar(14) default NULL,
  `val` longtext,
  `ipaddress` varchar(128) NOT NULL,
  `last_update` varchar(14) default NULL,
  `cur_mid` varchar(128) default NULL,
  PRIMARY KEY  (`session_key`),
  KEY `idx_session_member_srl` (`member_srl`),
  KEY `idx_session_expired` (`expired`),
  KEY `idx_session_update` (`last_update`),
  KEY `idx_session_cur_mid` (`cur_mid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `test_session` VALUES('pi1ivluc9aav09bku3itp2hfo7', 0, '20110317063901', 'is_logged|b:0;logged_info|s:0:"";', '67.195.115.116', '20110317013901', '');

CREATE TABLE IF NOT EXISTS `test_sites` (
  `site_srl` bigint(11) NOT NULL,
  `index_module_srl` bigint(11) default '0',
  `domain` varchar(255) NOT NULL,
  `default_language` varchar(255) default NULL,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`site_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `test_sites` VALUES(0, 0, 'skima.skku.edu/test/', 'ko', '20110317013901');

CREATE TABLE IF NOT EXISTS `yman_action_forward` (
  `act` varchar(80) NOT NULL,
  `module` varchar(60) NOT NULL,
  `type` varchar(15) NOT NULL,
  UNIQUE KEY `idx_foward` (`act`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_addons` (
  `addon` varchar(250) NOT NULL,
  `is_used` char(1) NOT NULL default 'Y',
  `is_used_m` char(1) NOT NULL default 'N',
  `extra_vars` text,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`addon`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_addons` VALUES('captcha', 'N', 'N', NULL, '20110202031528');
INSERT INTO `yman_addons` VALUES('phonenumber_validator', 'Y', 'N', 'O:8:"stdClass":10:{s:7:"_filter";s:11:"setup_addon";s:8:"callback";s:1:"-";s:7:"content";s:84:"[yamNyam] 다음의 인증코드를 입력해주세요.%new_line%[%validation_code%]";s:12:"encode_utf16";s:1:"A";s:8:"timeover";s:2:"60";s:6:"unique";s:1:"N";s:13:"hide_checkbox";s:1:"Y";s:16:"display_authcode";s:1:"Y";s:9:"mandatory";s:1:"Y";s:6:"global";s:1:"N";}', '20110202100424');
INSERT INTO `yman_addons` VALUES('favicon', 'N', 'N', 'O:8:"stdClass":2:{s:7:"_filter";s:11:"setup_addon";s:3:"pcp";s:12:"/favicon.ico";}', '20110405131354');

CREATE TABLE IF NOT EXISTS `yman_addons_site` (
  `site_srl` bigint(11) NOT NULL default '0',
  `addon` varchar(250) NOT NULL,
  `is_used` char(1) NOT NULL default 'Y',
  `is_used_m` char(1) NOT NULL default 'N',
  `extra_vars` text,
  `regdate` varchar(14) default NULL,
  UNIQUE KEY `unique_addon_site` (`site_srl`,`addon`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_ai_installed_packages` (
  `package_srl` bigint(11) NOT NULL default '0',
  `version` varchar(255) default NULL,
  `current_version` varchar(255) default NULL,
  `need_update` char(1) default 'N',
  KEY `idx_package_srl` (`package_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_ai_remote_categories` (
  `category_srl` bigint(11) NOT NULL default '0',
  `parent_srl` bigint(11) NOT NULL default '0',
  `title` varchar(250) NOT NULL,
  PRIMARY KEY  (`category_srl`),
  KEY `idx_parent_srl` (`parent_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_autoinstall_packages` (
  `package_srl` bigint(11) NOT NULL default '0',
  `category_srl` bigint(11) default '0',
  `path` varchar(250) NOT NULL,
  `updatedate` varchar(14) default NULL,
  `latest_item_srl` bigint(11) NOT NULL default '0',
  `version` varchar(255) default NULL,
  UNIQUE KEY `unique_path` (`path`),
  KEY `idx_package_srl` (`package_srl`),
  KEY `idx_category_srl` (`category_srl`),
  KEY `idx_regdate` (`updatedate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_comments` (
  `comment_srl` bigint(11) NOT NULL,
  `module_srl` bigint(11) NOT NULL default '0',
  `document_srl` bigint(11) NOT NULL default '0',
  `parent_srl` bigint(11) NOT NULL default '0',
  `is_secret` char(1) NOT NULL default 'N',
  `content` longtext NOT NULL,
  `voted_count` bigint(11) NOT NULL default '0',
  `blamed_count` bigint(11) NOT NULL default '0',
  `notify_message` char(1) NOT NULL default 'N',
  `password` varchar(60) default NULL,
  `user_id` varchar(80) default NULL,
  `user_name` varchar(80) NOT NULL,
  `nick_name` varchar(80) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `email_address` varchar(250) NOT NULL,
  `homepage` varchar(250) NOT NULL,
  `uploaded_count` bigint(11) NOT NULL default '0',
  `regdate` varchar(14) default NULL,
  `last_update` varchar(14) default NULL,
  `ipaddress` varchar(128) NOT NULL,
  `list_order` bigint(11) NOT NULL,
  PRIMARY KEY  (`comment_srl`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_document_srl` (`document_srl`),
  KEY `idx_voted_count` (`voted_count`),
  KEY `idx_blamed_count` (`blamed_count`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_uploaded_count` (`uploaded_count`),
  KEY `idx_regdate` (`regdate`),
  KEY `idx_last_update` (`last_update`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_comments_list` (
  `comment_srl` bigint(11) NOT NULL,
  `document_srl` bigint(11) NOT NULL default '0',
  `head` bigint(11) NOT NULL default '0',
  `arrange` bigint(11) NOT NULL default '0',
  `module_srl` bigint(11) NOT NULL default '0',
  `regdate` varchar(14) default NULL,
  `depth` bigint(11) NOT NULL default '0',
  PRIMARY KEY  (`comment_srl`),
  KEY `idx_list` (`document_srl`,`head`,`arrange`),
  KEY `idx_date` (`module_srl`,`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_comment_declared` (
  `comment_srl` bigint(11) NOT NULL,
  `declared_count` bigint(11) NOT NULL default '0',
  PRIMARY KEY  (`comment_srl`),
  KEY `idx_declared_count` (`declared_count`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_comment_declared_log` (
  `comment_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `ipaddress` varchar(128) NOT NULL,
  `regdate` varchar(14) default NULL,
  KEY `idx_comment_srl` (`comment_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_comment_voted_log` (
  `comment_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `ipaddress` varchar(128) NOT NULL,
  `regdate` varchar(14) default NULL,
  `point` bigint(11) NOT NULL,
  KEY `idx_comment_srl` (`comment_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_counter_log` (
  `site_srl` bigint(11) NOT NULL default '0',
  `ipaddress` varchar(250) NOT NULL,
  `regdate` varchar(14) default NULL,
  `user_agent` varchar(250) default NULL,
  KEY `idx_site_counter_log` (`site_srl`,`ipaddress`),
  KEY `idx_counter_log` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_counter_site_status` (
  `site_srl` bigint(11) NOT NULL,
  `regdate` bigint(11) NOT NULL,
  `unique_visitor` bigint(11) default '0',
  `pageview` bigint(11) default '0',
  UNIQUE KEY `site_status` (`site_srl`,`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_counter_status` (
  `regdate` bigint(11) NOT NULL,
  `unique_visitor` bigint(11) default '0',
  `pageview` bigint(11) default '0',
  PRIMARY KEY  (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_documents` (
  `document_srl` bigint(11) NOT NULL,
  `module_srl` bigint(11) NOT NULL default '0',
  `category_srl` bigint(11) NOT NULL default '0',
  `lang_code` varchar(10) NOT NULL default '',
  `is_notice` char(1) NOT NULL default 'N',
  `is_secret` char(1) NOT NULL default 'N',
  `title` varchar(250) default NULL,
  `title_bold` char(1) NOT NULL default 'N',
  `title_color` varchar(7) default NULL,
  `content` longtext NOT NULL,
  `readed_count` bigint(11) NOT NULL default '0',
  `voted_count` bigint(11) NOT NULL default '0',
  `blamed_count` bigint(11) NOT NULL default '0',
  `comment_count` bigint(11) NOT NULL default '0',
  `trackback_count` bigint(11) NOT NULL default '0',
  `uploaded_count` bigint(11) NOT NULL default '0',
  `password` varchar(60) default NULL,
  `user_id` varchar(80) default NULL,
  `user_name` varchar(80) NOT NULL,
  `nick_name` varchar(80) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `email_address` varchar(250) NOT NULL,
  `homepage` varchar(250) NOT NULL,
  `tags` text,
  `extra_vars` text,
  `regdate` varchar(14) default NULL,
  `last_update` varchar(14) default NULL,
  `last_updater` varchar(80) default NULL,
  `ipaddress` varchar(128) NOT NULL,
  `list_order` bigint(11) NOT NULL,
  `update_order` bigint(11) NOT NULL,
  `allow_comment` char(1) NOT NULL default 'Y',
  `lock_comment` char(1) NOT NULL default 'N',
  `allow_trackback` char(1) NOT NULL default 'Y',
  `notify_message` char(1) NOT NULL default 'N',
  PRIMARY KEY  (`document_srl`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_category_srl` (`category_srl`),
  KEY `idx_is_notice` (`is_notice`),
  KEY `idx_is_secret` (`is_secret`),
  KEY `idx_readed_count` (`readed_count`),
  KEY `idx_voted_count` (`voted_count`),
  KEY `idx_blamed_count` (`blamed_count`),
  KEY `idx_comment_count` (`comment_count`),
  KEY `idx_trackback_count` (`trackback_count`),
  KEY `idx_uploaded_count` (`uploaded_count`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_regdate` (`regdate`),
  KEY `idx_last_update` (`last_update`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_list_order` (`list_order`),
  KEY `idx_update_order` (`update_order`),
  KEY `idx_module_list_order` (`module_srl`,`list_order`),
  KEY `idx_module_update_order` (`module_srl`,`update_order`),
  KEY `idx_module_readed_count` (`module_srl`,`readed_count`),
  KEY `idx_module_voted_count` (`module_srl`,`voted_count`),
  KEY `idx_module_notice` (`module_srl`,`is_notice`),
  KEY `idx_module_document_srl` (`module_srl`,`document_srl`),
  KEY `idx_module_blamed_count` (`module_srl`,`blamed_count`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_document_aliases` (
  `alias_srl` bigint(11) NOT NULL default '0',
  `module_srl` bigint(11) NOT NULL default '0',
  `document_srl` bigint(11) NOT NULL default '0',
  `alias_title` varchar(250) NOT NULL,
  PRIMARY KEY  (`alias_srl`),
  UNIQUE KEY `idx_module_title` (`module_srl`,`alias_title`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_document_srl` (`document_srl`),
  KEY `idx_alias_title` (`alias_title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_document_categories` (
  `category_srl` bigint(11) NOT NULL default '0',
  `module_srl` bigint(11) NOT NULL default '0',
  `parent_srl` bigint(12) NOT NULL default '0',
  `title` varchar(250) default NULL,
  `expand` char(1) default 'N',
  `document_count` bigint(11) NOT NULL default '0',
  `regdate` varchar(14) default NULL,
  `last_update` varchar(14) default NULL,
  `list_order` bigint(11) NOT NULL,
  `group_srls` text,
  `color` varchar(11) default NULL,
  PRIMARY KEY  (`category_srl`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_document_categories` VALUES(57, 55, 0, '한식', 'N', 170, '20110202032313', '20110917173416', 57, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(59, 55, 0, '중식', 'N', 28, '20110202032321', '20110518023912', 63, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(61, 55, 0, '일식', 'N', 0, '20110202032326', '20110428214456', 69, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(63, 55, 0, '양식', 'N', 13, '20110202032355', '20110518023912', 74, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(528, 55, 61, '초밥', 'N', 0, '20110204172209', '20110309171938', 69, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(2027, 2025, 0, '학생식당', 'N', 41, '20110315205409', '20110609162357', 2027, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(525, 55, 59, '짜장면', 'N', 1, '20110204172156', '20110509192740', 63, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(521, 55, 57, '김밥', 'N', 0, '20110204172126', '20110404101004', 57, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(511, 55, 0, '보쌈', 'N', 7, '20110204170126', '20110918095843', 516, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(191, 55, 0, '분식', 'N', 1, '20110202070425', '20110411210844', 196, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(193, 55, 0, '기타/주류', 'N', 12, '20110202070433', '20110509175817', 519, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(509, 55, 0, '피자', 'N', 55, '20110204170119', '20110518023913', 514, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(507, 55, 0, '치킨', 'N', 124, '20110204170054', '20110620205557', 200, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(199, 141, 0, '한식', 'N', 6, '20110202070520', '20110918024550', 199, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(201, 141, 0, '중식', 'N', 2, '20110202070525', '20110518023913', 203, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(203, 141, 0, '양식', 'N', 2, '20110202070530', '20110518023913', 208, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(205, 141, 0, '일식', 'N', 0, '20110202070534', '20110428214456', 204, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(207, 141, 0, '분식', 'N', 0, '20110202070538', '20110404100551', 216, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(2029, 2025, 0, '공대식당', 'N', 39, '20110315205421', '20110609162453', 2029, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(2031, 2025, 0, '교직원식당', 'N', 34, '20110315205429', '20110609162630', 2031, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(2921, 141, 0, '치킨', 'N', 11, '20110331212751', '20110518023913', 2922, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(2923, 141, 0, '피자', 'N', 2, '20110331212800', '20110518023913', 2924, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(2925, 141, 0, '기타/주류', 'N', 1, '20110331212809', '20110918051655', 2927, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(2927, 141, 0, '보쌈', 'N', 2, '20110331212846', '20110918051655', 2925, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(530, 55, 61, '돈까스', 'N', 0, '20110204172214', '20110428214456', 69, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(523, 55, 57, '비빔밥', 'N', 0, '20110204172149', '20110312140158', 57, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(3249, 234, 0, '서비스소식', 'N', 4, '20110405215129', '20110910170722', 3249, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(3251, 234, 0, '공지사항', 'N', 1, '20110405215138', '20110418035531', 3251, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(4296, 3261, 0, '회원가입', 'N', 5, '20110411020909', '20110412015450', 4296, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(4298, 3261, 0, '로그인', 'N', 0, '20110411020915', '20110411020915', 4298, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(4300, 3261, 0, '회원정보', 'N', 4, '20110411020925', '20110411024914', 4300, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(4302, 3261, 0, '주문하기', 'N', 4, '20110411020932', '20110411024547', 4302, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(4304, 3261, 0, '문의사항', 'N', 4, '20110411020938', '20110411024841', 4304, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(8468, 8430, 0, '111', 'N', 0, '20110416034156', '20110416034156', 8468, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(8470, 8430, 0, '222', 'N', 0, '20110416034201', '20110416034201', 8470, '', 'transparent');
INSERT INTO `yman_document_categories` VALUES(9593, 2025, 0, '기숙사식당', 'N', 21, '20110428214302', '20110531085034', 9593, '', 'transparent');

CREATE TABLE IF NOT EXISTS `yman_document_declared` (
  `document_srl` bigint(11) NOT NULL,
  `declared_count` bigint(11) NOT NULL default '0',
  PRIMARY KEY  (`document_srl`),
  KEY `idx_declared_count` (`declared_count`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_document_declared_log` (
  `document_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `ipaddress` varchar(128) NOT NULL,
  `regdate` varchar(14) default NULL,
  KEY `idx_document_srl` (`document_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_document_extra_keys` (
  `module_srl` bigint(11) NOT NULL,
  `var_idx` bigint(11) NOT NULL,
  `var_name` varchar(250) NOT NULL,
  `var_type` varchar(50) NOT NULL,
  `var_is_required` char(1) NOT NULL default 'N',
  `var_search` char(1) NOT NULL default 'N',
  `var_default` text,
  `var_desc` text,
  `eid` varchar(40) default NULL,
  UNIQUE KEY `unique_module_keys` (`module_srl`,`var_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_document_extra_keys` VALUES(55, 1, '가격', 'text', 'Y', 'N', '', '', 'price');
INSERT INTO `yman_document_extra_keys` VALUES(76, 3, '수량', 'text', 'Y', 'N', '', '', 'product_amount');
INSERT INTO `yman_document_extra_keys` VALUES(141, 6, '영업시작', 'text', 'Y', 'N', '', '영업 시작 시간을 hh:mm 형식으로 입력 바랍니다.', 'opentime');
INSERT INTO `yman_document_extra_keys` VALUES(141, 1, '최소주문가격', 'text', 'Y', 'Y', '', '', 'minimumPrice');
INSERT INTO `yman_document_extra_keys` VALUES(141, 2, '주문가능지역', 'text', 'Y', 'Y', '', '', 'orderAvailableZone');
INSERT INTO `yman_document_extra_keys` VALUES(141, 3, '결제방식', 'checkbox', 'Y', 'Y', '현금,신용카드', '', 'paymentMethod');
INSERT INTO `yman_document_extra_keys` VALUES(76, 2, '가격', 'text', 'Y', 'N', '', '', 'product_price');
INSERT INTO `yman_document_extra_keys` VALUES(76, 1, '상품명', 'text', 'Y', 'N', '', '', 'product_name');
INSERT INTO `yman_document_extra_keys` VALUES(76, 4, '내번호', 'text', 'Y', 'N', '', '', 'callback');
INSERT INTO `yman_document_extra_keys` VALUES(55, 10, '행사전가격', 'text', 'N', 'N', '', '', 'pre_price');
INSERT INTO `yman_document_extra_keys` VALUES(76, 6, '상호', 'text', 'Y', 'N', '', '', 'restaurant');
INSERT INTO `yman_document_extra_keys` VALUES(55, 9, '선택옵션', 'text', 'N', 'N', '', '', 'select_opt');
INSERT INTO `yman_document_extra_keys` VALUES(76, 8, '주문번호', 'text', 'N', 'N', '111', '', 'order_no');
INSERT INTO `yman_document_extra_keys` VALUES(76, 9, '총합', 'text', 'Y', 'N', '', '', 'sum_price');
INSERT INTO `yman_document_extra_keys` VALUES(141, 4, '위도', 'text', 'Y', 'N', '', '지도에 표시하기 위한 가게의 위도를 입력합니다.', 'latitude');
INSERT INTO `yman_document_extra_keys` VALUES(141, 5, '경도', 'text', 'Y', 'N', '', '지도에 표시하기 위한 가게의 경도를 입력합니다.', 'longitude');
INSERT INTO `yman_document_extra_keys` VALUES(76, 10, '알림', 'text', 'N', 'N', '', '', 'notification');
INSERT INTO `yman_document_extra_keys` VALUES(76, 11, '위도', 'text', 'N', 'N', '', '', 'latitude');
INSERT INTO `yman_document_extra_keys` VALUES(76, 12, '경도', 'text', 'N', 'N', '', '', 'longitude');
INSERT INTO `yman_document_extra_keys` VALUES(713, 1, '위도', 'text', 'N', 'N', '', '', 'latitudes');
INSERT INTO `yman_document_extra_keys` VALUES(713, 2, '경도', 'text', 'N', 'N', '', '', 'longitudes');
INSERT INTO `yman_document_extra_keys` VALUES(300, 1, '세트상품', 'text', 'N', 'N', '', '', 'set_food');
INSERT INTO `yman_document_extra_keys` VALUES(300, 3, '할인율', 'text', 'N', 'N', '', '', 'percentage');
INSERT INTO `yman_document_extra_keys` VALUES(300, 4, '할인가격', 'text', 'N', 'N', '', '', 'discount');
INSERT INTO `yman_document_extra_keys` VALUES(300, 2, '할인방법', 'select', 'N', 'N', '할인율,가격할인', '', 'event_type');
INSERT INTO `yman_document_extra_keys` VALUES(55, 3, '가게번호', 'text', 'N', 'N', '', '', 'cellphone');
INSERT INTO `yman_document_extra_keys` VALUES(76, 13, '배송지 주소', 'text', 'Y', 'N', '', '', 'address');
INSERT INTO `yman_document_extra_keys` VALUES(55, 4, '칼로리', 'text', 'N', 'N', '500', '', 'calorie');
INSERT INTO `yman_document_extra_keys` VALUES(1078, 1, 'abc', 'text', 'N', 'N', '', '', 'abc');
INSERT INTO `yman_document_extra_keys` VALUES(141, 7, '영업종료', 'text', 'Y', 'N', '', '영업 종료 시간을 hh:mm 형식으로 입력 바랍니다.', 'closetime');
INSERT INTO `yman_document_extra_keys` VALUES(12311, 1, '시작기한', 'text', 'Y', 'N', '', '시간기한을 yyyy/mm/dd/hh/ii로 입력 바랍니다.', 'start_social');
INSERT INTO `yman_document_extra_keys` VALUES(55, 8, '추천점수', 'text', 'N', 'N', '0', '', 'vote_point');
INSERT INTO `yman_document_extra_keys` VALUES(55, 7, 'item_label', 'checkbox', 'N', 'N', 'hot, new', '추천상품 이미지를 옆에 붙여줄수 있습니다.', 'item_label');
INSERT INTO `yman_document_extra_keys` VALUES(141, 8, '추천점수', 'text', 'N', 'N', '0', '', 'vote_point');
INSERT INTO `yman_document_extra_keys` VALUES(1078, 2, 'test', 'checkbox', 'Y', 'N', '', '', 'test');
INSERT INTO `yman_document_extra_keys` VALUES(1078, 3, 'item', 'checkbox', 'N', 'N', 'hot, new', '', 'item');
INSERT INTO `yman_document_extra_keys` VALUES(76, 14, '실제주문번호', 'text', 'Y', 'N', '', '', 'real_no');
INSERT INTO `yman_document_extra_keys` VALUES(141, 9, '세부영업시간', 'text', 'Y', 'N', '', '', 'detailtime');
INSERT INTO `yman_document_extra_keys` VALUES(141, 10, '음식점 전화번호', 'text', 'N', 'N', '', '', 'telephone');
INSERT INTO `yman_document_extra_keys` VALUES(12311, 2, '종료기한', 'text', 'Y', 'N', '', '종료기한을 yyyy/mm/dd/hh/ii로 입력 바랍니다', 'end_social');
INSERT INTO `yman_document_extra_keys` VALUES(12311, 3, '목표인원', 'text', 'Y', 'N', '', '몇명 이상 구매하여야 되는지 지정 바랍니다.', 'limit_social');
INSERT INTO `yman_document_extra_keys` VALUES(12311, 4, '허용여부', 'checkbox', 'Y', 'N', '출력', '사용자에게 보여 줄지를 결정합니다.', 'allow_social');
INSERT INTO `yman_document_extra_keys` VALUES(55, 11, '소셜상품기한', 'text', 'N', 'N', '', '판매기한을 yyyymmddhhii 로 적어주세요', 'social_date');
INSERT INTO `yman_document_extra_keys` VALUES(55, 12, '소셜상품목표', 'text', 'N', 'N', '', '목표 인원 수를 적어주세요', 'social_to');

CREATE TABLE IF NOT EXISTS `yman_document_extra_vars` (
  `module_srl` bigint(11) NOT NULL,
  `document_srl` bigint(11) NOT NULL,
  `var_idx` bigint(11) NOT NULL,
  `lang_code` varchar(10) NOT NULL,
  `value` longtext,
  `eid` varchar(40) default NULL,
  UNIQUE KEY `unique_extra_vars` (`module_srl`,`document_srl`,`var_idx`,`lang_code`),
  KEY `idx_document_list_order` (`document_srl`,`module_srl`,`var_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_document_histories` (
  `history_srl` bigint(11) NOT NULL default '0',
  `module_srl` bigint(11) NOT NULL default '0',
  `document_srl` bigint(11) NOT NULL default '0',
  `content` longtext,
  `nick_name` varchar(80) NOT NULL,
  `member_srl` bigint(11) default NULL,
  `regdate` varchar(14) default NULL,
  `ipaddress` varchar(128) NOT NULL,
  PRIMARY KEY  (`history_srl`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_document_srl` (`document_srl`),
  KEY `idx_regdate` (`regdate`),
  KEY `idx_ipaddress` (`ipaddress`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_document_readed_log` (
  `document_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `ipaddress` varchar(128) NOT NULL,
  `regdate` varchar(14) default NULL,
  KEY `idx_document_srl` (`document_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_document_trash` (
  `trash_srl` bigint(11) NOT NULL default '0',
  `document_srl` bigint(11) NOT NULL default '0',
  `module_srl` bigint(11) NOT NULL default '0',
  `trash_date` varchar(14) default NULL,
  `description` text,
  `ipaddress` varchar(128) NOT NULL,
  `user_id` varchar(80) default NULL,
  `user_name` varchar(80) NOT NULL,
  `nick_name` varchar(80) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  PRIMARY KEY  (`trash_srl`),
  KEY `idx_document_srl` (`document_srl`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_trash_date` (`trash_date`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_member_srl` (`member_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_document_voted_log` (
  `document_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `ipaddress` varchar(128) NOT NULL,
  `regdate` varchar(14) default NULL,
  `point` bigint(11) NOT NULL,
  KEY `idx_document_srl` (`document_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_editor_autosave` (
  `member_srl` bigint(11) default '0',
  `ipaddress` varchar(128) default NULL,
  `module_srl` bigint(11) default NULL,
  `document_srl` bigint(11) NOT NULL default '0',
  `title` varchar(250) default NULL,
  `content` longtext NOT NULL,
  `regdate` varchar(14) default NULL,
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_editor_components` (
  `component_name` varchar(250) NOT NULL,
  `enabled` char(1) NOT NULL default 'N',
  `extra_vars` text,
  `list_order` bigint(11) NOT NULL,
  PRIMARY KEY  (`component_name`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_editor_components_site` (
  `site_srl` bigint(11) NOT NULL default '0',
  `component_name` varchar(250) NOT NULL,
  `enabled` char(1) NOT NULL default 'N',
  `extra_vars` text,
  `list_order` bigint(11) NOT NULL,
  UNIQUE KEY `unique_component_site` (`site_srl`,`component_name`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_files` (
  `file_srl` bigint(11) NOT NULL,
  `upload_target_srl` bigint(11) NOT NULL default '0',
  `upload_target_type` char(3) default NULL,
  `sid` varchar(60) default NULL,
  `module_srl` bigint(11) NOT NULL default '0',
  `member_srl` bigint(11) NOT NULL,
  `download_count` bigint(11) NOT NULL default '0',
  `direct_download` char(1) NOT NULL default 'N',
  `source_filename` varchar(250) default NULL,
  `uploaded_filename` varchar(250) default NULL,
  `file_size` bigint(11) NOT NULL default '0',
  `comment` varchar(250) default NULL,
  `isvalid` char(1) default 'N',
  `regdate` varchar(14) default NULL,
  `ipaddress` varchar(128) NOT NULL,
  PRIMARY KEY  (`file_srl`),
  KEY `idx_upload_target_srl` (`upload_target_srl`),
  KEY `idx_upload_target_type` (`upload_target_type`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_download_count` (`download_count`),
  KEY `idx_file_size` (`file_size`),
  KEY `idx_is_valid` (`isvalid`),
  KEY `idx_regdate` (`regdate`),
  KEY `idx_ipaddress` (`ipaddress`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_join_extend` (
  `member_srl` bigint(11) NOT NULL,
  `jumin` varchar(32) default NULL,
  `recoid_member_srl` bigint(11) default NULL,
  `rocoid_point` bigint(11) default NULL,
  PRIMARY KEY  (`member_srl`),
  KEY `idx_jumin` (`jumin`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_join_extend_coupon` (
  `coupon_srl` bigint(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `point` varchar(10) default NULL,
  `own_member_srl` bigint(11) default NULL,
  `member_srl` bigint(11) default NULL,
  `regdate` varchar(14) default NULL,
  `joindate` varchar(14) default NULL,
  `validdate` varchar(14) default NULL,
  PRIMARY KEY  (`coupon_srl`),
  UNIQUE KEY `unique_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_join_extend_invitation` (
  `invitation_srl` bigint(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `own_member_srl` bigint(11) default NULL,
  `member_srl` bigint(11) default NULL,
  `regdate` varchar(14) default NULL,
  `joindate` varchar(14) default NULL,
  `validdate` varchar(14) default NULL,
  PRIMARY KEY  (`invitation_srl`),
  UNIQUE KEY `unique_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_join_extend_notify` (
  `mode` varchar(10) NOT NULL,
  `member_info` text,
  `regdate` varchar(14) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_lang` (
  `site_srl` bigint(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lang_code` varchar(10) NOT NULL,
  `value` text,
  KEY `idx_lang` (`site_srl`,`name`,`lang_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_layouts` (
  `layout_srl` bigint(12) NOT NULL,
  `site_srl` bigint(11) NOT NULL default '0',
  `layout` varchar(250) default NULL,
  `title` varchar(250) default NULL,
  `extra_vars` text,
  `layout_path` varchar(250) default NULL,
  `module_srl` bigint(12) default '0',
  `regdate` varchar(14) default NULL,
  `layout_type` char(1) default 'P',
  PRIMARY KEY  (`layout_srl`),
  KEY `menu_site_srl` (`site_srl`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_layouts` VALUES(70, 0, 'yamnyam_layout', 'yamNyam layout', 'O:8:"stdClass":5:{s:10:"banner_url";s:54:"http://skku.yamnyam.com/?mid=notice&document_srl=11562";s:8:"logo_url";s:1:".";s:10:"logo_image";s:33:"./files/attach/images/70/logo.png";s:12:"banner_image";s:41:"./files/attach/images/70/event_banner.gif";s:14:"menu_name_list";N;}', '', 0, '20110202032830', 'P');
INSERT INTO `yman_layouts` VALUES(1828, 0, 'yamnyam_shop_layout', 'yamNyam Shop layout', 'O:8:"stdClass":3:{s:9:"main_menu";s:1:"0";s:11:"mypage_menu";s:1:"0";s:14:"menu_name_list";N;}', '', 0, '20110309071659', 'P');
INSERT INTO `yman_layouts` VALUES(3008, 0, 'xe_official', 'welcome_layout', 'O:8:"stdClass":4:{s:8:"colorset";s:7:"default";s:9:"main_menu";i:3005;s:11:"bottom_menu";i:3005;s:14:"menu_name_list";a:1:{i:3005;s:12:"welcome_menu";}}', '', 0, '20110403225158', 'P');
INSERT INTO `yman_layouts` VALUES(8429, 0, 'yamnyam_mobile', 'yamnyam_mobile', 'O:8:"stdClass":3:{s:9:"main_menu";s:1:"0";s:10:"logo_image";N;s:14:"menu_name_list";N;}', '', 0, '20110416011203', 'M');

CREATE TABLE IF NOT EXISTS `yman_member` (
  `member_srl` bigint(11) NOT NULL,
  `user_id` varchar(80) NOT NULL,
  `email_address` varchar(250) NOT NULL,
  `password` varchar(60) NOT NULL,
  `email_id` varchar(80) NOT NULL,
  `email_host` varchar(160) default NULL,
  `user_name` varchar(40) NOT NULL,
  `nick_name` varchar(40) NOT NULL,
  `find_account_question` bigint(11) default NULL,
  `find_account_answer` varchar(250) default NULL,
  `homepage` varchar(250) default NULL,
  `blog` varchar(250) default NULL,
  `birthday` char(8) default NULL,
  `allow_mailing` char(1) NOT NULL default 'Y',
  `allow_message` char(1) NOT NULL default 'Y',
  `denied` char(1) default 'N',
  `limit_date` varchar(14) default NULL,
  `regdate` varchar(14) default NULL,
  `last_login` varchar(14) default NULL,
  `change_password_date` varchar(14) default NULL,
  `is_admin` char(1) default 'N',
  `description` text,
  `extra_vars` text,
  `list_order` bigint(11) NOT NULL,
  PRIMARY KEY  (`member_srl`),
  UNIQUE KEY `unique_user_id` (`user_id`),
  UNIQUE KEY `unique_email_address` (`email_address`),
  UNIQUE KEY `unique_nick_name` (`nick_name`),
  KEY `idx_email_host` (`email_host`),
  KEY `idx_allow_mailing` (`allow_mailing`),
  KEY `idx_is_denied` (`denied`),
  KEY `idx_regdate` (`regdate`),
  KEY `idx_last_login` (`last_login`),
  KEY `idx_is_admin` (`is_admin`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_member_auth_mail` (
  `auth_key` varchar(60) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `user_id` varchar(80) NOT NULL,
  `new_password` varchar(80) NOT NULL,
  `is_register` char(1) default 'N',
  `regdate` varchar(14) default NULL,
  UNIQUE KEY `unique_key` (`auth_key`,`member_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_member_autologin` (
  `autologin_key` varchar(80) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  UNIQUE KEY `unique_key` (`autologin_key`,`member_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_member_denied_user_id` (
  `user_id` varchar(80) NOT NULL,
  `regdate` varchar(14) default NULL,
  `description` text,
  `list_order` bigint(11) NOT NULL,
  PRIMARY KEY  (`user_id`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_member_denied_user_id` VALUES('yamnyam', '20110413162704', '', -7625);
INSERT INTO `yman_member_denied_user_id` VALUES('yamnyamadmin', '20110413162712', '', -7626);
INSERT INTO `yman_member_denied_user_id` VALUES('webadmin', '20110413162722', '', -7627);
INSERT INTO `yman_member_denied_user_id` VALUES('amiks', '20110413162740', '', -7628);

CREATE TABLE IF NOT EXISTS `yman_member_friend` (
  `friend_srl` bigint(11) NOT NULL,
  `friend_group_srl` bigint(11) NOT NULL default '0',
  `member_srl` bigint(11) NOT NULL,
  `target_srl` bigint(11) NOT NULL,
  `list_order` bigint(11) NOT NULL,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`friend_srl`),
  KEY `idx_friend_group_srl` (`friend_group_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_target_srl` (`target_srl`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_member_friend_group` (
  `friend_group_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`friend_group_srl`),
  KEY `index_owner_member_srl` (`member_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_member_group` (
  `site_srl` bigint(11) NOT NULL default '0',
  `group_srl` bigint(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  `regdate` varchar(14) default NULL,
  `is_default` char(1) default 'N',
  `is_admin` char(1) default 'N',
  `image_mark` text,
  `description` text,
  PRIMARY KEY  (`group_srl`),
  UNIQUE KEY `idx_site_title` (`site_srl`,`title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE `yman_member_group`;

INSERT INTO `yman_member_group` VALUES(0, 1, '관리그룹', '20110202031519', 'N', 'Y', '', '');
INSERT INTO `yman_member_group` VALUES(0, 1338, '교직원', '20110302142731', 'N', 'N', '', '');
INSERT INTO `yman_member_group` VALUES(0, 237, '성균관대', '20110202075038', 'N', 'N', '', '');
INSERT INTO `yman_member_group` VALUES(0, 238, '일반회원', '20110202075045', 'Y', 'N', '', '');
INSERT INTO `yman_member_group` VALUES(0, 239, '상점회원', '20110202075056', 'N', 'N', '', '');

CREATE TABLE IF NOT EXISTS `yman_member_group_member` (
  `site_srl` bigint(11) NOT NULL default '0',
  `group_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `regdate` varchar(14) default NULL,
  KEY `idx_site_srl` (`site_srl`),
  KEY `idx_group_member` (`group_srl`,`member_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_member_join_form` (
  `member_join_form_srl` bigint(11) NOT NULL,
  `column_type` varchar(60) NOT NULL,
  `column_name` varchar(60) NOT NULL,
  `column_title` varchar(60) NOT NULL,
  `required` char(1) NOT NULL default 'N',
  `default_value` text,
  `is_active` char(1) default 'Y',
  `description` text,
  `list_order` bigint(11) NOT NULL default '1',
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`member_join_form_srl`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_member_join_form` VALUES(73, 'tel', 'cellphone', '핸드폰 번호', 'Y', '', 'Y', '', 72, '20110202033422');
INSERT INTO `yman_member_join_form` VALUES(75, 'text', 'validationcode', '인증번호', 'Y', '', 'Y', '', 74, '20110202033444');
INSERT INTO `yman_member_join_form` VALUES(244, 'kr_zip', 'address', '주소', 'Y', '', 'Y', '', 243, '20110202080309');
INSERT INTO `yman_member_join_form` VALUES(302, 'checkbox', 'notification', '알림매체', 'N', 'a:3:{i:0;s:3:"SMS";i:1;s:3:"MMS";i:2;s:6:"E-MAIL";}', 'Y', '', 301, '20110204004841');
INSERT INTO `yman_member_join_form` VALUES(12328, 'text', 'mypeople', '마이피플 개인 key', 'N', '', 'N', '', 12327, '20110918020635');
INSERT INTO `yman_member_join_form` VALUES(2787, 'text', 'recentaddress', '최근배송지', 'N', '', 'N', '', 2786, '20110330220050');
INSERT INTO `yman_member_join_form` VALUES(3865, 'checkbox', 'allowsms', '문자 수신 허용', 'N', 'a:2:{i:0;s:3:"예";i:1;s:9:"아니오";}', 'Y', '', 3864, '20110409025922');

CREATE TABLE IF NOT EXISTS `yman_member_message` (
  `message_srl` bigint(11) NOT NULL,
  `related_srl` bigint(11) NOT NULL,
  `sender_srl` bigint(11) NOT NULL,
  `receiver_srl` bigint(11) NOT NULL,
  `message_type` char(1) NOT NULL default 'S',
  `title` varchar(250) NOT NULL,
  `content` text NOT NULL,
  `readed` char(1) NOT NULL default 'N',
  `list_order` bigint(11) NOT NULL,
  `regdate` varchar(14) default NULL,
  `readed_date` varchar(14) default NULL,
  PRIMARY KEY  (`message_srl`),
  KEY `idx_related_srl` (`related_srl`),
  KEY `idx_sender_srl` (`sender_srl`),
  KEY `idx_receiver_srl` (`receiver_srl`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_member_message` VALUES(1772, 1771, 269, 4, 'S', 'test', '<p>test</p>', 'Y', -1773, '20110308210307', '20110308210335');
INSERT INTO `yman_member_message` VALUES(1775, 1774, 269, 4, 'S', 'vxcv', '<p>xdv</p>', 'Y', -1776, '20110308210718', '20110308210725');

CREATE TABLE IF NOT EXISTS `yman_member_openid` (
  `member_srl` bigint(11) NOT NULL,
  `openid` varchar(80) NOT NULL,
  `regdate` varchar(14) default NULL,
  UNIQUE KEY `unique_openid` (`openid`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_member_openid_association` (
  `server_url` text NOT NULL,
  `handle` varchar(255) NOT NULL,
  `secret` text NOT NULL,
  `issued` bigint(11) default NULL,
  `lifetime` bigint(11) default NULL,
  `assoc_type` varchar(64) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_member_openid_nonce` (
  `nonce` char(8) NOT NULL,
  `expires` bigint(11) default NULL,
  PRIMARY KEY  (`nonce`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_member_scrap` (
  `member_srl` bigint(11) NOT NULL,
  `document_srl` bigint(11) NOT NULL,
  `title` varchar(250) default NULL,
  `user_id` varchar(80) default NULL,
  `user_name` varchar(80) NOT NULL,
  `nick_name` varchar(80) NOT NULL,
  `target_member_srl` bigint(11) NOT NULL,
  `regdate` varchar(14) default NULL,
  `list_order` bigint(11) NOT NULL,
  UNIQUE KEY `unique_scrap` (`member_srl`,`document_srl`),
  KEY `idx_regdate` (`regdate`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_menu` (
  `menu_srl` bigint(12) NOT NULL,
  `site_srl` bigint(11) NOT NULL default '0',
  `title` varchar(250) default NULL,
  `listorder` bigint(11) default '0',
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`menu_srl`),
  KEY `menu_site_srl` (`site_srl`),
  KEY `idx_listorder` (`listorder`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_menu` VALUES(50, 0, 'test', -50, '20110202031541');
INSERT INTO `yman_menu` VALUES(3005, 0, 'welcome_menu', -3005, '20110403225158');

CREATE TABLE IF NOT EXISTS `yman_menu_item` (
  `menu_item_srl` bigint(12) NOT NULL,
  `parent_srl` bigint(12) NOT NULL default '0',
  `menu_srl` bigint(12) NOT NULL,
  `name` text,
  `url` varchar(250) default NULL,
  `open_window` char(1) default 'N',
  `expand` char(1) default 'N',
  `normal_btn` varchar(255) default NULL,
  `hover_btn` varchar(255) default NULL,
  `active_btn` varchar(255) default NULL,
  `group_srls` text,
  `listorder` bigint(11) default '0',
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`menu_item_srl`),
  KEY `idx_menu_srl` (`menu_srl`),
  KEY `idx_listorder` (`listorder`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_menu_item` VALUES(3006, 0, 3005, 'menu1', '', '', '', '', '', '', '', -3006, '20110403225158');
INSERT INTO `yman_menu_item` VALUES(3007, 3006, 3005, 'menu1-1', 'welcome_page', '', '', '', '', '', '', -3007, '20110403225158');

CREATE TABLE IF NOT EXISTS `yman_menu_layout` (
  `menu_srl` bigint(12) NOT NULL,
  `layout_srl` bigint(12) NOT NULL,
  PRIMARY KEY  (`menu_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_mobilemessage` (
  `mobilemessage_srl` bigint(11) NOT NULL,
  `gid` varchar(30) NOT NULL,
  `mid` varchar(30) NOT NULL,
  `mtype` varchar(3) NOT NULL default 'SMS',
  `userid` varchar(80) NOT NULL,
  `country` varchar(10) NOT NULL default '82',
  `callno` varchar(20) NOT NULL,
  `callback` varchar(20) NOT NULL,
  `subject` varchar(40) NOT NULL,
  `content` varchar(4000) NOT NULL,
  `reservflag` char(1) NOT NULL default 'N',
  `reservdate` varchar(14) NOT NULL,
  `ref_userid` varchar(80) default NULL,
  `ref_username` varchar(40) default NULL,
  `ref_nickname` varchar(40) default NULL,
  `mstat` char(1) NOT NULL default '0',
  `rcode` varchar(2) NOT NULL default '99',
  `senddate` varchar(14) default NULL,
  `carrier` varchar(3) default NULL,
  `regdate` varchar(14) NOT NULL,
  PRIMARY KEY  (`mobilemessage_srl`),
  KEY `idx_gid` (`gid`),
  KEY `idx_mid` (`mid`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_mobilemessage_files` (
  `mobilemessage_file_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `filename` varchar(250) NOT NULL,
  `fileextension` varchar(4) NOT NULL,
  `filesize` bigint(11) NOT NULL,
  `comment` varchar(250) default NULL,
  `regdate` varchar(14) NOT NULL,
  PRIMARY KEY  (`mobilemessage_file_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_mobilemessage_keeping` (
  `keeping_srl` bigint(11) NOT NULL,
  `user_id` varchar(80) NOT NULL,
  `content` varchar(4000) NOT NULL,
  `regdate` varchar(14) NOT NULL,
  PRIMARY KEY  (`keeping_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_mobilemessage_mapping` (
  `user_id` varchar(80) NOT NULL,
  `phone_num` varchar(20) NOT NULL,
  `country` varchar(10) NOT NULL,
  `regdate` varchar(14) NOT NULL,
  KEY `idx_user_id` (`user_id`),
  KEY `idx_phone_num` (`phone_num`),
  KEY `idx_country` (`country`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_mobilemessage_noticom` (
  `notification_srl` bigint(11) NOT NULL,
  `content` varchar(250) NOT NULL,
  `msgtype` varchar(5) NOT NULL default 'SMS',
  `registrant` char(1) NOT NULL default 'N',
  `replier` char(1) NOT NULL default 'N',
  `nonmember_index` bigint(11) NOT NULL default '0',
  `id_list` varchar(250) NOT NULL default 'N',
  `except_id_list` varchar(250) NOT NULL default 'N',
  `group_srl_list` varchar(250) NOT NULL default 'N',
  `manager` char(1) NOT NULL default 'N',
  `direct_numbers` varchar(250) NOT NULL default '',
  `callback_number_type` varchar(10) NOT NULL default 'self',
  `callback_number_direct` varchar(50) NOT NULL default '',
  `message_link` char(1) NOT NULL default 'N',
  `reverse_notify` char(1) NOT NULL default 'N',
  `extra_vars` text,
  `regdate` varchar(14) NOT NULL,
  PRIMARY KEY  (`notification_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_mobilemessage_notidoc` (
  `notification_srl` bigint(11) NOT NULL,
  `content` varchar(250) NOT NULL,
  `msgtype` varchar(5) NOT NULL default 'SMS',
  `id_list` varchar(250) NOT NULL default 'N',
  `except_id_list` varchar(250) NOT NULL default 'N',
  `group_srl_list` varchar(250) NOT NULL default 'N',
  `manager` char(1) NOT NULL default 'N',
  `direct_numbers` varchar(250) NOT NULL default '',
  `callback_number_type` varchar(10) NOT NULL default 'self',
  `callback_number_direct` varchar(50) NOT NULL default '',
  `nonmember_index` bigint(11) NOT NULL default '0',
  `extra_vars` text,
  `regdate` varchar(14) NOT NULL,
  PRIMARY KEY  (`notification_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_mobilemessage_notification_modules` (
  `notification_srl` bigint(11) NOT NULL,
  `module_srl` bigint(11) NOT NULL,
  `regdate` varchar(14) NOT NULL,
  KEY `idx_notification_srl` (`notification_srl`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_mobilemessage_prohibit` (
  `phone_num` varchar(20) NOT NULL,
  `country` varchar(10) NOT NULL default '82',
  `limit_date` varchar(14) default NULL,
  `memo` varchar(250) default NULL,
  `regdate` varchar(14) NOT NULL,
  PRIMARY KEY  (`phone_num`),
  KEY `idx_limit_date` (`limit_date`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_mobilemessage_recent_receiver` (
  `receiver_srl` bigint(11) NOT NULL,
  `user_id` varchar(80) NOT NULL,
  `phone_num` varchar(20) NOT NULL,
  `ref_name` varchar(40) NOT NULL,
  `regdate` varchar(14) NOT NULL,
  PRIMARY KEY  (`receiver_srl`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_phone_num` (`phone_num`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_mobilemessage_validation` (
  `callno` varchar(20) NOT NULL,
  `country` varchar(10) NOT NULL default '82',
  `valcode` varchar(20) NOT NULL,
  `regdate` varchar(14) NOT NULL,
  KEY `idx_callno` (`callno`),
  KEY `idx_country` (`country`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_modules` (
  `module_srl` bigint(11) NOT NULL,
  `module` varchar(80) NOT NULL,
  `module_category_srl` bigint(11) default '0',
  `layout_srl` bigint(11) default '0',
  `use_mobile` char(1) default 'N',
  `mlayout_srl` bigint(11) default '0',
  `menu_srl` bigint(11) default '0',
  `site_srl` bigint(11) NOT NULL default '0',
  `mid` varchar(40) NOT NULL,
  `skin` varchar(250) default NULL,
  `mskin` varchar(250) default NULL,
  `browser_title` varchar(250) NOT NULL,
  `description` text,
  `is_default` char(1) NOT NULL default 'N',
  `content` longtext,
  `mcontent` longtext,
  `open_rss` char(1) NOT NULL default 'Y',
  `header_text` text,
  `footer_text` text,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`module_srl`),
  UNIQUE KEY `idx_site_mid` (`site_srl`,`mid`),
  KEY `idx_module` (`module`),
  KEY `idx_module_category` (`module_category_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_modules` VALUES(55, 'board', 0, 70, 'Y', 8429, 0, 0, 'food_list', 'yamnyam_foodlist', 'yamnyam_mobile_foodlist', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 음식 리스트', '', 'N', '', '', 'Y', '', '', '20110202032254');
INSERT INTO `yman_modules` VALUES(71, 'page', 0, 70, 'N', 0, 0, 0, 'main', '', '', 'yamNyam', '', 'N', '', '', 'Y', '', '', '20110202032855');
INSERT INTO `yman_modules` VALUES(76, 'board', 0, 70, 'Y', 8429, 0, 0, 'order_list', 'yamnyam_orderlist', 'yamnyam_mobile_orderlist', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 주문 리스트', '', 'N', '', '', 'Y', '', '', '20110202041111');
INSERT INTO `yman_modules` VALUES(141, 'board', 0, 70, 'Y', 8429, 0, 0, 'restaurant_list', 'yamnyam_restraunt', 'yamnyam_mobile_restaurantlist', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 상점 리스트', '', 'N', '', '', 'Y', '', '', '20110202055850');
INSERT INTO `yman_modules` VALUES(234, 'board', 0, 70, 'N', 0, 0, 0, 'notice', 'yamnyam_board', 'default', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 공지사항', '', 'N', '', '', 'Y', '', '', '20110202073818');
INSERT INTO `yman_modules` VALUES(11627, 'opage', 0, 70, 'N', 0, 0, 0, 'welcome', '', '', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 환영', '', 'N', '', '', 'Y', '', '', '20110610212226');
INSERT INTO `yman_modules` VALUES(12268, 'opage', 0, 1828, 'N', 0, 0, 0, 'shop_main', '', '', 'Admin', '', 'N', '', '', 'Y', '', '', '20110917013539');
INSERT INTO `yman_modules` VALUES(12262, 'opage', 0, 70, 'N', 0, 0, 0, 'mobile_se', '', '', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 주문내역', '', 'N', '', '', 'Y', '', '', '20110916062337');
INSERT INTO `yman_modules` VALUES(236, 'page', 0, 70, 'N', 0, 0, 0, 'cooperation', '', '', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 제휴안내', '', 'N', '<img src="./common/tpl/images/widget_bg.jpg" class="zbxe_widget_output" widget="widgetContent" style="float: left; width: 100%;" body="" document_srl="1803" widget_padding_left="0" widget_padding_right="0" widget_padding_top="0" widget_padding_bottom="0"  />', '', 'Y', '', '', '20110202074348');
INSERT INTO `yman_modules` VALUES(2523, 'board', 0, 70, 'Y', 8429, 0, 0, 'mypage', 'yamnyam_mypage', 'yamnyam_mobile_mypage', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 마이페이지', '', 'N', '', '', 'Y', '', '', '20110329111819');
INSERT INTO `yman_modules` VALUES(2632, 'board', 0, 70, 'N', 0, 0, 0, 'qna_mail', 'yamnyam_qnamail', 'default', 'qna_mail', '', 'N', '', '', 'Y', '', '', '20110330155155');
INSERT INTO `yman_modules` VALUES(2025, 'board', 0, 70, 'Y', 8429, 0, 0, 'today_menu_list', 'yamnyam_todaylist', 'yamnyam_mobile_todaylist', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 오늘의 식단', '', 'N', '', '', 'Y', '', '', '20110315204658');
INSERT INTO `yman_modules` VALUES(12309, 'opage', 0, 1828, 'N', 0, 0, 0, 'shop', '', '', 'Shop Admin', '', 'N', '', '', 'Y', '', '', '20110917173837');
INSERT INTO `yman_modules` VALUES(2245, 'board', 0, 0, 'N', 0, 0, 0, 'testtest', 'xe_board', 'default', 'skima.skku.edu/~testestest', '', 'N', '', '', 'Y', '', '', '20110317223307');
INSERT INTO `yman_modules` VALUES(300, 'board', 0, 0, 'N', 0, 0, 0, 'event_list', 'xe_board', 'default', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 이벤트 목록', '', 'N', '', '', 'Y', '', '', '20110204004150');
INSERT INTO `yman_modules` VALUES(713, 'board', 0, 70, 'N', 0, 0, 0, 'statistical_list', 'xe_board', 'default', 'statistical_list', '', 'N', '', '', 'Y', '', '', '20110205013802');
INSERT INTO `yman_modules` VALUES(1078, 'board', 0, 0, 'N', 0, 0, 0, 'test', 'xe_board', 'simpleGray', 'test', '', 'N', '', '', 'Y', '', '', '20110211234558');
INSERT INTO `yman_modules` VALUES(2253, 'board', 0, 1828, 'N', 0, 0, 0, 'shop_notice', 'yamnyam_shopnotice', 'default', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 상점회원 공지사항', '', 'N', '', '', 'Y', '', '', '20110318220444');
INSERT INTO `yman_modules` VALUES(8430, 'board', 0, 70, 'Y', 8429, 0, 0, 'dummy_food_list', 'yamnyam_foodlist', 'yamnyam_mobile_foodlist', '모바일 태스트용', '', 'N', '', '', 'Y', '', '', '20110416011327');
INSERT INTO `yman_modules` VALUES(11561, 'opage', 0, 70, 'N', 0, 0, 0, 'wizard_list', '', '', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 주문마법사', '', 'N', '', '', 'Y', '', '', '20110610150255');
INSERT INTO `yman_modules` VALUES(3009, 'page', 0, 3008, 'N', 0, 0, 0, 'welcome_page', '', '', '', '', 'N', '<img src="./common/tpl/images/widget_bg.jpg" class="zbxe_widget_output" widget="widgetContent" style="WIDTH: 100%; FLOAT: left" body="" document_srl="3010" widget_padding_left="0" widget_padding_right="0" widget_padding_top="0" widget_padding_bottom="0"  />', '', 'Y', '', '', '20110403225158');
INSERT INTO `yman_modules` VALUES(3204, 'opage', 0, 70, 'N', 0, 0, 0, 'clause', '', '', '이용약관', '', 'N', '', '', 'Y', '', '', '20110405135406');
INSERT INTO `yman_modules` VALUES(3235, 'opage', 0, 70, 'N', 0, 0, 0, 'privacy', '', '', '개인정보취급방침', '', 'N', '', '', 'Y', '', '', '20110405152801');
INSERT INTO `yman_modules` VALUES(3261, 'board', 0, 70, 'N', 0, 0, 0, 'faq', 'yamnyam_board', 'default', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: FAQ', '', 'N', '', '', 'Y', '', '', '20110405221458');
INSERT INTO `yman_modules` VALUES(3264, 'board', 0, 70, 'N', 0, 0, 0, 'request', 'yamnyam_board', 'default', '편리한 음식 주문 배달 서비스! "얌냠(yamNyam)" :: 문의하기', '', 'N', '', '', 'Y', '', '', '20110405222340');
INSERT INTO `yman_modules` VALUES(5732, 'opage', 0, 70, 'N', 0, 0, 0, 'guide', '', '', '이용안내', '', 'N', '', '', 'Y', '', '', '20110411115937');
INSERT INTO `yman_modules` VALUES(5733, 'opage', 0, 70, 'N', 0, 0, 0, 'alliance', '', '', '제휴안내', '', 'N', '', '', 'Y', '', '', '20110411124929');
INSERT INTO `yman_modules` VALUES(9727, 'opage', 0, 70, 'N', 0, 0, 0, 'guide2', '', '', '이용안내', '', 'N', '', '', 'Y', '', '', '20110502225326');
INSERT INTO `yman_modules` VALUES(9728, 'opage', 0, 70, 'N', 0, 0, 0, 'guide3', '', '', '이용안내', '', 'N', '', '', 'Y', '', '', '20110502225355');
INSERT INTO `yman_modules` VALUES(9729, 'opage', 0, 70, 'N', 0, 0, 0, 'guide4', '', '', '이용안내', '', 'N', '', '', 'Y', '', '', '20110502225424');

CREATE TABLE IF NOT EXISTS `yman_module_admins` (
  `module_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `regdate` varchar(14) default NULL,
  UNIQUE KEY `unique_module_admin` (`module_srl`,`member_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_module_categories` (
  `module_category_srl` bigint(11) NOT NULL default '0',
  `title` varchar(250) default NULL,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`module_category_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_module_categories` VALUES(12256, 'yamnyam', '20110914012518');

CREATE TABLE IF NOT EXISTS `yman_module_config` (
  `module` varchar(250) NOT NULL,
  `config` text,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE `yman_module_config`;

INSERT INTO `yman_module_config` VALUES('comment', 'b:0;', '20110202031516');
INSERT INTO `yman_module_config` VALUES('editor', 'b:0;', '20110202031516');
INSERT INTO `yman_module_config` VALUES('file', 'O:8:"stdClass":3:{s:16:"allowed_filesize";s:1:"2";s:19:"allowed_attach_size";s:1:"2";s:17:"allowed_filetypes";s:3:"*.*";}', '20110403230910');
INSERT INTO `yman_module_config` VALUES('layout', 'N;', '20110202031516');
INSERT INTO `yman_module_config` VALUES('rss', 'b:0;', '20110202031516');
INSERT INTO `yman_module_config` VALUES('trackback', 'b:0;', '20110202031516');
INSERT INTO `yman_module_config` VALUES('poll', 'O:8:"stdClass":2:{s:4:"skin";s:7:"default";s:8:"colorset";s:6:"normal";}', '20110403230910');
INSERT INTO `yman_module_config` VALUES('mobilemessage', 'O:8:"stdClass":30:{s:9:"cs_userid";s:7:"";s:9:"cs_passwd";s:7:"";s:19:"cellphone_fieldname";s:9:"cellphone";s:24:"validationcode_fieldname";s:14:"validationcode";s:21:"countrycode_fieldname";N;s:8:"callback";N;s:12:"admin_phones";N;s:19:"flag_welcome_member";N;s:18:"flag_welcome_admin";N;s:16:"allow_lms_member";N;s:15:"allow_lms_admin";N;s:14:"welcome_member";s:76:"[회원가입완료]\n%user_name%(%user_id%)님 가입을 축하드립니다.";s:13:"welcome_admin";s:69:"[회원가입알림]\n%user_name%(%user_id%)님이 가입했습니다.";s:13:"point_for_sms";N;s:13:"point_for_lms";N;s:12:"callback_url";s:24:"";s:12:"keep_mapping";s:1:"N";s:17:"keep_mapping_days";N;s:7:"id_list";N;s:14:"group_srl_list";N;s:20:"callback_number_type";s:4:"self";s:22:"callback_number_direct";N;s:21:"change_group_srl_list";N;s:19:"inform_group_change";N;s:22:"allow_lms_group_change";N;s:20:"group_change_message";s:88:"[그룹변경알림]\n%user_name%(%user_id%)님 %groups% 그룹에 추가되었습니다.";s:11:"force_strip";N;s:15:"default_country";s:2:"82";s:15:"display_country";N;s:12:"encode_utf16";N;}', '20110515004741');
INSERT INTO `yman_module_config` VALUES('point', 'O:8:"stdClass":24:{s:9:"max_level";s:2:"30";s:12:"signup_point";i:0;s:11:"login_point";i:0;s:10:"point_name";s:5:"point";s:10:"level_icon";s:7:"default";s:16:"disable_download";s:1:"N";s:15:"insert_document";i:0;s:19:"insert_document_act";s:23:"procBoardInsertDocument";s:19:"delete_document_act";s:23:"procBoardDeleteDocument";s:14:"insert_comment";i:0;s:18:"insert_comment_act";s:44:"procBoardInsertComment,procBlogInsertComment";s:18:"delete_comment_act";s:44:"procBoardDeleteComment,procBlogDeleteComment";s:11:"upload_file";i:0;s:15:"upload_file_act";s:14:"procFileUpload";s:15:"delete_file_act";s:14:"procFileDelete";s:13:"download_file";i:0;s:17:"download_file_act";s:16:"procFileDownload";s:13:"read_document";i:0;s:5:"voted";i:0;s:6:"blamed";i:0;s:21:"disable_read_document";s:1:"N";s:11:"group_reset";s:1:"Y";s:10:"expression";N;s:10:"level_step";a:30:{i:1;i:90;i:2;i:360;i:3;i:810;i:4;i:1440;i:5;i:2250;i:6;i:3240;i:7;i:4410;i:8;i:5760;i:9;i:7290;i:10;i:9000;i:11;i:10890;i:12;i:12960;i:13;i:15210;i:14;i:17640;i:15;i:20250;i:16;i:23040;i:17;i:26010;i:18;i:29160;i:19;i:32490;i:20;i:36000;i:21;i:39690;i:22;i:43560;i:23;i:47610;i:24;i:51840;i:25;i:56250;i:26;i:60840;i:27;i:65610;i:28;i:70560;i:29;i:75690;i:30;i:81000;}}', '20110917211822');
INSERT INTO `yman_module_config` VALUES('communication', 'O:8:"stdClass":4:{s:4:"skin";s:7:"default";s:8:"colorset";s:5:"white";s:11:"editor_skin";s:12:"xpresseditor";s:15:"editor_colorset";N;}', '20110205000718');
INSERT INTO `yman_module_config` VALUES('syndication', 'O:8:"stdClass":3:{s:15:"target_services";a:1:{i:0;s:0:"";}s:8:"site_url";s:23:"skima.skku.edu/~yamnyam";s:4:"year";s:4:"2011";}', '20110310222225');
INSERT INTO `yman_module_config` VALUES('member', 'O:8:"stdClass":28:{s:14:"webmaster_name";s:9:"webmaster";s:15:"webmaster_email";s:21:"webmaster@yamnyam.com";s:4:"skin";s:14:"yamNyam_member";s:8:"colorset";s:5:"white";s:11:"editor_skin";s:12:"xpresseditor";s:15:"editor_colorset";s:5:"white";s:13:"enable_openid";s:1:"N";s:11:"enable_join";s:1:"Y";s:14:"enable_confirm";N;s:9:"limit_day";i:0;s:15:"after_login_url";N;s:16:"after_logout_url";s:2:"./";s:12:"redirect_url";s:9:"./welcome";s:13:"profile_image";s:1:"Y";s:23:"profile_image_max_width";s:2:"80";s:24:"profile_image_max_height";s:2:"80";s:10:"image_name";s:1:"Y";s:20:"image_name_max_width";s:2:"90";s:21:"image_name_max_height";s:2:"20";s:10:"image_mark";s:1:"Y";s:20:"image_mark_max_width";s:2:"20";s:21:"image_mark_max_height";s:2:"20";s:16:"group_image_mark";s:1:"N";s:26:"group_image_mark_max_width";N;s:27:"group_image_mark_max_height";N;s:9:"signature";s:1:"N";s:20:"signature_max_height";N;s:20:"change_password_date";i:0;}', '20110610212800');

CREATE TABLE IF NOT EXISTS `yman_module_extend` (
  `parent_module` varchar(80) NOT NULL,
  `extend_module` varchar(80) NOT NULL,
  `type` varchar(15) NOT NULL,
  `kind` varchar(5) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_module_extra_vars` (
  `module_srl` bigint(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `value` text,
  UNIQUE KEY `unique_module_vars` (`module_srl`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_module_extra_vars` VALUES(55, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(55, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(55, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(55, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(71, '_filter', 'insert_page');
INSERT INTO `yman_module_extra_vars` VALUES(300, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(55, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(55, 'use_category', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(713, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(713, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(76, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(76, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(76, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(76, 'consultation', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(76, 'sms_send', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(76, 'use_category', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(76, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(141, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(141, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(141, 'list_count', '100');
INSERT INTO `yman_module_extra_vars` VALUES(141, 'search_list_count', '100');
INSERT INTO `yman_module_extra_vars` VALUES(2025, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(141, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(141, 'use_category', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(300, 'use_category', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(234, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(234, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(234, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(234, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(234, 'use_category', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(234, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(55, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(236, 'regdate', '20110202074348');
INSERT INTO `yman_module_extra_vars` VALUES(141, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(300, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(300, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(300, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(300, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(300, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(300, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(713, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(713, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(713, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(713, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(713, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(713, 'use_category', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(713, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(713, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(1078, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(1078, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(1078, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(1078, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(1078, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(1078, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(1078, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(1078, 'use_category', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(1078, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(1078, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2253, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(2253, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(3204, 'path', './etc_page/policy.html');
INSERT INTO `yman_module_extra_vars` VALUES(2523, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(2253, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(2253, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(2253, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(2025, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2025, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(2025, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(2025, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2025, 'use_category', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(2025, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(12309, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(2245, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(2245, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(2245, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(2245, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(2245, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(2245, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(2245, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(2245, 'use_category', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2245, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2245, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2253, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(2523, 'use_category', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2523, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2523, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(2523, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(2523, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(2523, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(2632, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(2632, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(2632, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(2632, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(2632, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(2632, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(2632, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(2632, 'consultation', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(2632, 'admin_mail', 'minhoz@skima.co.kr');
INSERT INTO `yman_module_extra_vars` VALUES(2632, 'use_category', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2632, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(3009, 'regdate', '20110403225158');
INSERT INTO `yman_module_extra_vars` VALUES(3204, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(3235, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(3235, 'path', './etc_page/privacy.html');
INSERT INTO `yman_module_extra_vars` VALUES(234, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(234, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(234, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(234, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(3261, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(3261, 'use_category', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(3261, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(3261, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(3261, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(3261, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(3261, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(3264, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(3264, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(3264, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(3264, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(3264, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(3264, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(3264, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(76, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(76, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(76, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(5732, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(5732, 'path', './etc_page/use.html');
INSERT INTO `yman_module_extra_vars` VALUES(5733, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(5733, 'path', './etc_page/alliance.html');
INSERT INTO `yman_module_extra_vars` VALUES(3264, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(3264, 'consultation', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(3264, 'admin_mail', 'webmaster@yamnyam.com');
INSERT INTO `yman_module_extra_vars` VALUES(55, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(55, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(76, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(141, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(141, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(300, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(300, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2025, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(2025, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(2025, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(2253, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(2253, 'use_category', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2253, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2253, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2523, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(2523, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(2523, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(3261, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(3261, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(3261, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(3264, 'use_category', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(236, '_filter', 'insert_page');
INSERT INTO `yman_module_extra_vars` VALUES(141, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(55, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(8430, 'order_type', 'asc');
INSERT INTO `yman_module_extra_vars` VALUES(8430, 'list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(8430, 'search_list_count', '20');
INSERT INTO `yman_module_extra_vars` VALUES(8430, 'page_count', '10');
INSERT INTO `yman_module_extra_vars` VALUES(8430, 'except_notice', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(8430, 'use_anonymous', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(8430, 'consultation', 'N');
INSERT INTO `yman_module_extra_vars` VALUES(8430, '_filter', 'insert_board');
INSERT INTO `yman_module_extra_vars` VALUES(8430, 'use_category', 'Y');
INSERT INTO `yman_module_extra_vars` VALUES(8430, 'order_target', 'list_order');
INSERT INTO `yman_module_extra_vars` VALUES(9727, 'path', './etc_page/use2.html');
INSERT INTO `yman_module_extra_vars` VALUES(9727, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(9728, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(9729, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(9729, 'path', './etc_page/use4.html');
INSERT INTO `yman_module_extra_vars` VALUES(9728, 'path', './etc_page/use3.html');
INSERT INTO `yman_module_extra_vars` VALUES(11561, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(11561, 'path', '/Users/yamnyam/Sites/wizard/wizard_main.html');
INSERT INTO `yman_module_extra_vars` VALUES(11627, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(11627, 'path', '/Users/yamnyam/Sites/etc_page/welcome.html');
INSERT INTO `yman_module_extra_vars` VALUES(12268, 'path', './modules/member/tpl/shop_main.html');
INSERT INTO `yman_module_extra_vars` VALUES(12268, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(12262, '_filter', 'insert_opage');
INSERT INTO `yman_module_extra_vars` VALUES(12262, 'path', '/Users/yamnyam/Sites/etc_pages/mobile_setting.html');
INSERT INTO `yman_module_extra_vars` VALUES(12262, 'mpath', '/Users/yamnyam/Sites/etc_pages/mobile_setting.html');
INSERT INTO `yman_module_extra_vars` VALUES(12309, 'path', './modules/member/tpl/shop_main.html');

CREATE TABLE IF NOT EXISTS `yman_module_filebox` (
  `module_filebox_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `filename` varchar(250) NOT NULL,
  `fileextension` varchar(4) NOT NULL,
  `filesize` bigint(11) NOT NULL default '0',
  `comment` varchar(250) default NULL,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`module_filebox_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_fileextension` (`fileextension`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_module_grants` (
  `module_srl` bigint(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `group_srl` bigint(11) NOT NULL,
  UNIQUE KEY `unique_module` (`module_srl`,`name`,`group_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_module_grants` VALUES(55, 'access', 0);
INSERT INTO `yman_module_grants` VALUES(55, 'list', 0);
INSERT INTO `yman_module_grants` VALUES(55, 'view', 0);
INSERT INTO `yman_module_grants` VALUES(55, 'write_comment', 237);
INSERT INTO `yman_module_grants` VALUES(55, 'write_comment', 238);
INSERT INTO `yman_module_grants` VALUES(55, 'write_document', 239);
INSERT INTO `yman_module_grants` VALUES(76, 'access', 0);
INSERT INTO `yman_module_grants` VALUES(76, 'list', 0);
INSERT INTO `yman_module_grants` VALUES(76, 'view', 0);
INSERT INTO `yman_module_grants` VALUES(76, 'write_comment', 237);
INSERT INTO `yman_module_grants` VALUES(76, 'write_comment', 238);
INSERT INTO `yman_module_grants` VALUES(76, 'write_document', 2);
INSERT INTO `yman_module_grants` VALUES(76, 'write_document', 3);
INSERT INTO `yman_module_grants` VALUES(76, 'write_document', 237);
INSERT INTO `yman_module_grants` VALUES(76, 'write_document', 238);
INSERT INTO `yman_module_grants` VALUES(76, 'write_document', 239);
INSERT INTO `yman_module_grants` VALUES(141, 'access', 0);
INSERT INTO `yman_module_grants` VALUES(141, 'list', 0);
INSERT INTO `yman_module_grants` VALUES(141, 'manager', 1);
INSERT INTO `yman_module_grants` VALUES(141, 'view', 0);
INSERT INTO `yman_module_grants` VALUES(141, 'write_comment', 1);
INSERT INTO `yman_module_grants` VALUES(141, 'write_comment', 237);
INSERT INTO `yman_module_grants` VALUES(141, 'write_comment', 238);
INSERT INTO `yman_module_grants` VALUES(141, 'write_document', 1);
INSERT INTO `yman_module_grants` VALUES(141, 'write_document', 239);
INSERT INTO `yman_module_grants` VALUES(234, 'access', 0);
INSERT INTO `yman_module_grants` VALUES(234, 'list', 0);
INSERT INTO `yman_module_grants` VALUES(234, 'view', 0);
INSERT INTO `yman_module_grants` VALUES(234, 'write_comment', 1);
INSERT INTO `yman_module_grants` VALUES(234, 'write_document', 1);
INSERT INTO `yman_module_grants` VALUES(2025, 'access', 0);
INSERT INTO `yman_module_grants` VALUES(2025, 'list', 0);
INSERT INTO `yman_module_grants` VALUES(2025, 'view', 0);
INSERT INTO `yman_module_grants` VALUES(2025, 'write_comment', 0);
INSERT INTO `yman_module_grants` VALUES(2025, 'write_document', 1);
INSERT INTO `yman_module_grants` VALUES(3261, 'access', 0);
INSERT INTO `yman_module_grants` VALUES(3261, 'list', 0);
INSERT INTO `yman_module_grants` VALUES(3261, 'view', 0);
INSERT INTO `yman_module_grants` VALUES(3261, 'write_comment', 1);
INSERT INTO `yman_module_grants` VALUES(3261, 'write_document', 1);
INSERT INTO `yman_module_grants` VALUES(3264, 'access', -1);
INSERT INTO `yman_module_grants` VALUES(3264, 'list', -1);
INSERT INTO `yman_module_grants` VALUES(3264, 'view', -1);
INSERT INTO `yman_module_grants` VALUES(3264, 'write_comment', 1);
INSERT INTO `yman_module_grants` VALUES(3264, 'write_document', -1);
INSERT INTO `yman_module_grants` VALUES(8430, 'write_comment', 237);
INSERT INTO `yman_module_grants` VALUES(8430, 'write_comment', 238);
INSERT INTO `yman_module_grants` VALUES(8430, 'write_document', 239);

CREATE TABLE IF NOT EXISTS `yman_module_locks` (
  `lock_name` varchar(40) NOT NULL,
  `deadline` varchar(14) default NULL,
  `member_srl` bigint(11) default NULL,
  UNIQUE KEY `unique_lock_name` (`lock_name`),
  KEY `idx_deadline` (`deadline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_module_part_config` (
  `module` varchar(250) NOT NULL,
  `module_srl` bigint(11) NOT NULL,
  `config` text,
  `regdate` varchar(14) default NULL,
  KEY `idx_module_part_config` (`module`,`module_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_module_part_config` VALUES('layout', 8429, 'O:8:"stdClass":1:{s:13:"header_script";N;}', '20110916211956');
INSERT INTO `yman_module_part_config` VALUES('trackback', 55, 'O:8:"stdClass":1:{s:16:"enable_trackback";s:1:"N";}', '20110202064005');
INSERT INTO `yman_module_part_config` VALUES('board', 141, 'a:7:{i:0;s:9:"thumbnail";i:1;s:5:"title";i:2;s:11:"voted_count";i:3;s:1:"1";i:4;s:1:"2";i:5;s:1:"3";i:6;s:1:"4";}', '20110202070508');
INSERT INTO `yman_module_part_config` VALUES('point', 76, 'a:1:{s:15:"insert_document";i:1;}', '20110917211902');
INSERT INTO `yman_module_part_config` VALUES('trackback', 76, 'O:8:"stdClass":1:{s:16:"enable_trackback";s:1:"N";}', '20110218151320');
INSERT INTO `yman_module_part_config` VALUES('board', 1078, 'a:6:{i:0;s:2:"no";i:1;s:5:"title";i:2;s:9:"nick_name";i:3;s:7:"regdate";i:4;s:12:"readed_count";i:5;s:11:"voted_count";}', '20110308211845');
INSERT INTO `yman_module_part_config` VALUES('layout', 1828, 'O:8:"stdClass":1:{s:13:"header_script";N;}', '20110309071705');
INSERT INTO `yman_module_part_config` VALUES('editor', 2025, 'O:8:"stdClass":19:{s:11:"editor_skin";s:12:"xpresseditor";s:19:"comment_editor_skin";s:12:"xpresseditor";s:13:"content_style";s:7:"default";s:21:"comment_content_style";s:7:"default";s:12:"content_font";N;s:17:"content_font_size";N;s:19:"sel_editor_colorset";s:16:"white_texteditor";s:27:"sel_comment_editor_colorset";s:5:"white";s:17:"enable_html_grant";a:0:{}s:25:"enable_comment_html_grant";a:0:{}s:17:"upload_file_grant";a:0:{}s:25:"comment_upload_file_grant";a:0:{}s:30:"enable_default_component_grant";a:0:{}s:38:"enable_comment_default_component_grant";a:0:{}s:22:"enable_component_grant";a:0:{}s:30:"enable_comment_component_grant";a:0:{}s:13:"editor_height";i:500;s:21:"comment_editor_height";i:120;s:15:"enable_autosave";s:1:"Y";}', '20110317214243');
INSERT INTO `yman_module_part_config` VALUES('editor', 2632, 'O:8:"stdClass":19:{s:11:"editor_skin";s:12:"xpresseditor";s:19:"comment_editor_skin";s:12:"xpresseditor";s:13:"content_style";s:7:"default";s:21:"comment_content_style";s:7:"default";s:12:"content_font";N;s:17:"content_font_size";N;s:19:"sel_editor_colorset";s:5:"white";s:27:"sel_comment_editor_colorset";s:5:"white";s:17:"enable_html_grant";a:0:{}s:25:"enable_comment_html_grant";a:0:{}s:17:"upload_file_grant";a:0:{}s:25:"comment_upload_file_grant";a:0:{}s:30:"enable_default_component_grant";a:0:{}s:38:"enable_comment_default_component_grant";a:0:{}s:22:"enable_component_grant";a:0:{}s:30:"enable_comment_component_grant";a:0:{}s:13:"editor_height";i:300;s:21:"comment_editor_height";i:120;s:15:"enable_autosave";s:1:"Y";}', '20110330160602');
INSERT INTO `yman_module_part_config` VALUES('board', 234, 'a:4:{i:0;s:2:"no";i:1;s:5:"title";i:2;s:12:"readed_count";i:3;s:7:"regdate";}', '20110405221201');
INSERT INTO `yman_module_part_config` VALUES('point', 234, 'a:7:{s:15:"insert_document";i:10;s:14:"insert_comment";i:5;s:11:"upload_file";i:5;s:13:"download_file";i:-5;s:13:"read_document";i:0;s:5:"voted";i:0;s:6:"blamed";i:0;}', '20110917211902');
INSERT INTO `yman_module_part_config` VALUES('trackback', 234, 'O:8:"stdClass":1:{s:16:"enable_trackback";s:1:"N";}', '20110405215500');
INSERT INTO `yman_module_part_config` VALUES('board', 3261, 'a:4:{i:0;s:2:"no";i:1;s:5:"title";i:2;s:7:"regdate";i:3;s:12:"readed_count";}', '20110405221522');
INSERT INTO `yman_module_part_config` VALUES('point', 3264, 'a:7:{s:15:"insert_document";i:10;s:14:"insert_comment";i:5;s:11:"upload_file";i:5;s:13:"download_file";i:-5;s:13:"read_document";i:0;s:5:"voted";i:0;s:6:"blamed";i:0;}', '20110917211902');
INSERT INTO `yman_module_part_config` VALUES('editor', 3264, 'O:8:"stdClass":19:{s:11:"editor_skin";s:12:"xpresseditor";s:19:"comment_editor_skin";s:12:"xpresseditor";s:13:"content_style";s:7:"default";s:21:"comment_content_style";s:7:"default";s:12:"content_font";N;s:17:"content_font_size";N;s:19:"sel_editor_colorset";s:17:"white_text_nohtml";s:27:"sel_comment_editor_colorset";s:5:"white";s:17:"enable_html_grant";a:0:{}s:25:"enable_comment_html_grant";a:0:{}s:17:"upload_file_grant";a:0:{}s:25:"comment_upload_file_grant";a:0:{}s:30:"enable_default_component_grant";a:0:{}s:38:"enable_comment_default_component_grant";a:0:{}s:22:"enable_component_grant";a:0:{}s:30:"enable_comment_component_grant";a:0:{}s:13:"editor_height";i:150;s:21:"comment_editor_height";i:120;s:15:"enable_autosave";s:1:"N";}', '20110405232936');
INSERT INTO `yman_module_part_config` VALUES('file', 234, 'O:8:"stdClass":7:{s:13:"allow_outlink";N;s:20:"allow_outlink_format";N;s:18:"allow_outlink_site";N;s:16:"allowed_filesize";s:1:"2";s:19:"allowed_attach_size";s:1:"2";s:17:"allowed_filetypes";s:3:"*.*";s:14:"download_grant";a:0:{}}', '20110415173852');
INSERT INTO `yman_module_part_config` VALUES('editor', 234, 'O:8:"stdClass":19:{s:11:"editor_skin";s:12:"xpresseditor";s:19:"comment_editor_skin";s:12:"xpresseditor";s:13:"content_style";s:7:"default";s:21:"comment_content_style";s:7:"default";s:12:"content_font";N;s:17:"content_font_size";N;s:19:"sel_editor_colorset";s:5:"white";s:27:"sel_comment_editor_colorset";s:17:"white_text_nohtml";s:17:"enable_html_grant";a:0:{}s:25:"enable_comment_html_grant";a:0:{}s:17:"upload_file_grant";a:0:{}s:25:"comment_upload_file_grant";a:0:{}s:30:"enable_default_component_grant";a:0:{}s:38:"enable_comment_default_component_grant";a:0:{}s:22:"enable_component_grant";a:0:{}s:30:"enable_comment_component_grant";a:0:{}s:13:"editor_height";i:500;s:21:"comment_editor_height";i:120;s:15:"enable_autosave";s:1:"Y";}', '20110415173904');
INSERT INTO `yman_module_part_config` VALUES('board', 76, 'a:4:{i:0;s:2:"no";i:1;s:5:"title";i:2;s:9:"nick_name";i:3;s:7:"regdate";}', '20110415175336');
INSERT INTO `yman_module_part_config` VALUES('layout', 8428, 'O:8:"stdClass":1:{s:13:"header_script";N;}', '20110416010603');
INSERT INTO `yman_module_part_config` VALUES('layout', 70, 'O:8:"stdClass":1:{s:13:"header_script";N;}', '20110918045453');

CREATE TABLE IF NOT EXISTS `yman_module_skins` (
  `module_srl` bigint(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `value` text,
  UNIQUE KEY `unique_module_skins` (`module_srl`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_module_trigger` (
  `trigger_name` varchar(80) NOT NULL,
  `called_position` varchar(15) NOT NULL,
  `module` varchar(80) NOT NULL,
  `type` varchar(15) NOT NULL,
  `called_method` varchar(80) NOT NULL,
  UNIQUE KEY `idx_trigger` (`trigger_name`,`called_position`,`module`,`type`,`called_method`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE `yman_module_trigger`;

INSERT INTO `yman_module_trigger` VALUES('comment.deleteComment', 'after', 'file', 'controller', 'triggerCommentDeleteAttached');
INSERT INTO `yman_module_trigger` VALUES('comment.deleteComment', 'after', 'point', 'controller', 'triggerDeleteComment');
INSERT INTO `yman_module_trigger` VALUES('comment.deleteComment', 'after', 'poll', 'controller', 'triggerDeleteCommentPoll');
INSERT INTO `yman_module_trigger` VALUES('comment.insertComment', 'after', 'file', 'controller', 'triggerCommentAttachFiles');
INSERT INTO `yman_module_trigger` VALUES('comment.insertComment', 'after', 'mobilemessage', 'controller', 'triggerInsertComment');
INSERT INTO `yman_module_trigger` VALUES('comment.insertComment', 'after', 'point', 'controller', 'triggerInsertComment');
INSERT INTO `yman_module_trigger` VALUES('comment.insertComment', 'after', 'poll', 'controller', 'triggerInsertCommentPoll');
INSERT INTO `yman_module_trigger` VALUES('comment.insertComment', 'before', 'file', 'controller', 'triggerCommentCheckAttached');
INSERT INTO `yman_module_trigger` VALUES('comment.insertComment', 'before', 'spamfilter', 'controller', 'triggerInsertComment');
INSERT INTO `yman_module_trigger` VALUES('comment.updateComment', 'after', 'file', 'controller', 'triggerCommentAttachFiles');
INSERT INTO `yman_module_trigger` VALUES('comment.updateComment', 'after', 'poll', 'controller', 'triggerUpdateCommentPoll');
INSERT INTO `yman_module_trigger` VALUES('comment.updateComment', 'before', 'file', 'controller', 'triggerCommentCheckAttached');
INSERT INTO `yman_module_trigger` VALUES('comment.updateComment', 'before', 'spamfilter', 'controller', 'triggerInsertComment');
INSERT INTO `yman_module_trigger` VALUES('display', 'before', 'editor', 'controller', 'triggerEditorComponentCompile');
INSERT INTO `yman_module_trigger` VALUES('display', 'before', 'join_extend', 'controller', 'triggerDisplay');
INSERT INTO `yman_module_trigger` VALUES('display', 'before', 'widget', 'controller', 'triggerWidgetCompile');
INSERT INTO `yman_module_trigger` VALUES('document.deleteDocument', 'after', 'comment', 'controller', 'triggerDeleteDocumentComments');
INSERT INTO `yman_module_trigger` VALUES('document.deleteDocument', 'after', 'file', 'controller', 'triggerDeleteAttached');
INSERT INTO `yman_module_trigger` VALUES('document.deleteDocument', 'after', 'point', 'controller', 'triggerDeleteDocument');
INSERT INTO `yman_module_trigger` VALUES('document.deleteDocument', 'after', 'poll', 'controller', 'triggerDeleteDocumentPoll');
INSERT INTO `yman_module_trigger` VALUES('document.deleteDocument', 'after', 'syndication', 'controller', 'triggerDeleteDocument');
INSERT INTO `yman_module_trigger` VALUES('document.deleteDocument', 'after', 'tag', 'controller', 'triggerDeleteTag');
INSERT INTO `yman_module_trigger` VALUES('document.deleteDocument', 'after', 'trackback', 'controller', 'triggerDeleteDocumentTrackbacks');
INSERT INTO `yman_module_trigger` VALUES('document.deleteDocument', 'before', 'point', 'controller', 'triggerBeforeDeleteDocument');
INSERT INTO `yman_module_trigger` VALUES('document.getDocumentMenu', 'after', 'trackback', 'controller', 'triggerSendTrackback');
INSERT INTO `yman_module_trigger` VALUES('document.insertDocument', 'after', 'editor', 'controller', 'triggerDeleteSavedDoc');
INSERT INTO `yman_module_trigger` VALUES('document.insertDocument', 'after', 'file', 'controller', 'triggerAttachFiles');
INSERT INTO `yman_module_trigger` VALUES('document.insertDocument', 'after', 'mobilemessage', 'controller', 'triggerInsertDocument');
INSERT INTO `yman_module_trigger` VALUES('document.insertDocument', 'after', 'point', 'controller', 'triggerInsertDocument');
INSERT INTO `yman_module_trigger` VALUES('document.insertDocument', 'after', 'poll', 'controller', 'triggerInsertDocumentPoll');
INSERT INTO `yman_module_trigger` VALUES('document.insertDocument', 'after', 'syndication', 'controller', 'triggerInsertDocument');
INSERT INTO `yman_module_trigger` VALUES('document.insertDocument', 'after', 'tag', 'controller', 'triggerInsertTag');
INSERT INTO `yman_module_trigger` VALUES('document.insertDocument', 'before', 'file', 'controller', 'triggerCheckAttached');
INSERT INTO `yman_module_trigger` VALUES('document.insertDocument', 'before', 'spamfilter', 'controller', 'triggerInsertDocument');
INSERT INTO `yman_module_trigger` VALUES('document.insertDocument', 'before', 'tag', 'controller', 'triggerArrangeTag');
INSERT INTO `yman_module_trigger` VALUES('document.moveDocumentToTrash', 'after', 'syndication', 'controller', 'triggerMoveDocumentToTrash');
INSERT INTO `yman_module_trigger` VALUES('document.restoreTrash', 'after', 'syndication', 'controller', 'triggerRestoreTrash');
INSERT INTO `yman_module_trigger` VALUES('document.updateDocument', 'after', 'editor', 'controller', 'triggerDeleteSavedDoc');
INSERT INTO `yman_module_trigger` VALUES('document.updateDocument', 'after', 'file', 'controller', 'triggerAttachFiles');
INSERT INTO `yman_module_trigger` VALUES('document.updateDocument', 'after', 'poll', 'controller', 'triggerUpdateDocumentPoll');
INSERT INTO `yman_module_trigger` VALUES('document.updateDocument', 'after', 'syndication', 'controller', 'triggerUpdateDocument');
INSERT INTO `yman_module_trigger` VALUES('document.updateDocument', 'after', 'tag', 'controller', 'triggerInsertTag');
INSERT INTO `yman_module_trigger` VALUES('document.updateDocument', 'before', 'file', 'controller', 'triggerCheckAttached');
INSERT INTO `yman_module_trigger` VALUES('document.updateDocument', 'before', 'point', 'controller', 'triggerUpdateDocument');
INSERT INTO `yman_module_trigger` VALUES('document.updateDocument', 'before', 'spamfilter', 'controller', 'triggerInsertDocument');
INSERT INTO `yman_module_trigger` VALUES('document.updateDocument', 'before', 'tag', 'controller', 'triggerArrangeTag');
INSERT INTO `yman_module_trigger` VALUES('document.updateReadedCount', 'after', 'point', 'controller', 'triggerUpdateReadedCount');
INSERT INTO `yman_module_trigger` VALUES('document.updateVotedCount', 'after', 'point', 'controller', 'triggerUpdateVotedCount');
INSERT INTO `yman_module_trigger` VALUES('editor.deleteSavedDoc', 'after', 'file', 'controller', 'triggerDeleteAttached');
INSERT INTO `yman_module_trigger` VALUES('file.deleteFile', 'after', 'point', 'controller', 'triggerDeleteFile');
INSERT INTO `yman_module_trigger` VALUES('file.downloadFile', 'after', 'point', 'controller', 'triggerDownloadFile');
INSERT INTO `yman_module_trigger` VALUES('file.downloadFile', 'before', 'point', 'controller', 'triggerBeforeDownloadFile');
INSERT INTO `yman_module_trigger` VALUES('file.insertFile', 'after', 'point', 'controller', 'triggerInsertFile');
INSERT INTO `yman_module_trigger` VALUES('member.deleteMember', 'before', 'join_extend', 'controller', 'triggerDeleteMember');
INSERT INTO `yman_module_trigger` VALUES('member.deleteMember', 'before', 'mobilemessage', 'controller', 'triggerMemberDelete');
INSERT INTO `yman_module_trigger` VALUES('member.doLogin', 'after', 'point', 'controller', 'triggerAfterLogin');
INSERT INTO `yman_module_trigger` VALUES('member.getMemberMenu', 'after', 'board', 'controller', 'triggerMemberMenu');
INSERT INTO `yman_module_trigger` VALUES('member.getMemberMenu', 'after', 'orderlist', 'controller', 'triggerMemberMenu');
INSERT INTO `yman_module_trigger` VALUES('member.insertMember', 'after', 'join_extend', 'controller', 'triggerInsertMember');
INSERT INTO `yman_module_trigger` VALUES('member.insertMember', 'after', 'mobilemessage', 'controller', 'triggerMemberJoin');
INSERT INTO `yman_module_trigger` VALUES('member.insertMember', 'after', 'point', 'controller', 'triggerInsertMember');
INSERT INTO `yman_module_trigger` VALUES('member.updateMember', 'after', 'mobilemessage', 'controller', 'triggerMemberUpdate');
INSERT INTO `yman_module_trigger` VALUES('module.deleteModule', 'after', 'comment', 'controller', 'triggerDeleteModuleComments');
INSERT INTO `yman_module_trigger` VALUES('module.deleteModule', 'after', 'document', 'controller', 'triggerDeleteModuleDocuments');
INSERT INTO `yman_module_trigger` VALUES('module.deleteModule', 'after', 'file', 'controller', 'triggerDeleteModuleFiles');
INSERT INTO `yman_module_trigger` VALUES('module.deleteModule', 'after', 'syndication', 'controller', 'triggerDeleteModule');
INSERT INTO `yman_module_trigger` VALUES('module.deleteModule', 'after', 'tag', 'controller', 'triggerDeleteModuleTags');
INSERT INTO `yman_module_trigger` VALUES('module.deleteModule', 'after', 'trackback', 'controller', 'triggerDeleteModuleTrackbacks');
INSERT INTO `yman_module_trigger` VALUES('module.dispAdditionSetup', 'after', 'point', 'view', 'triggerDispPointAdditionSetup');
INSERT INTO `yman_module_trigger` VALUES('module.dispAdditionSetup', 'before', 'comment', 'view', 'triggerDispCommentAdditionSetup');
INSERT INTO `yman_module_trigger` VALUES('module.dispAdditionSetup', 'before', 'document', 'view', 'triggerDispDocumentAdditionSetup');
INSERT INTO `yman_module_trigger` VALUES('module.dispAdditionSetup', 'before', 'editor', 'view', 'triggerDispEditorAdditionSetup');
INSERT INTO `yman_module_trigger` VALUES('module.dispAdditionSetup', 'before', 'file', 'view', 'triggerDispFileAdditionSetup');
INSERT INTO `yman_module_trigger` VALUES('module.dispAdditionSetup', 'before', 'rss', 'view', 'triggerDispRssAdditionSetup');
INSERT INTO `yman_module_trigger` VALUES('module.dispAdditionSetup', 'before', 'trackback', 'view', 'triggerDispTrackbackAdditionSetup');
INSERT INTO `yman_module_trigger` VALUES('moduleHandler.init', 'after', 'join_extend', 'controller', 'triggerModuleHandlerInit');
INSERT INTO `yman_module_trigger` VALUES('moduleHandler.proc', 'after', 'join_extend', 'controller', 'triggerModuleHandlerProc');
INSERT INTO `yman_module_trigger` VALUES('moduleHandler.proc', 'after', 'rss', 'controller', 'triggerRssUrlInsert');
INSERT INTO `yman_module_trigger` VALUES('trackback.insertTrackback', 'before', 'spamfilter', 'controller', 'triggerInsertTrackback');

CREATE TABLE IF NOT EXISTS `yman_point` (
  `member_srl` bigint(11) NOT NULL,
  `point` bigint(11) NOT NULL default '0',
  PRIMARY KEY  (`member_srl`),
  KEY `idx_point` (`point`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_poll` (
  `poll_srl` bigint(11) NOT NULL,
  `stop_date` varchar(14) default NULL,
  `upload_target_srl` bigint(11) NOT NULL,
  `poll_count` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `ipaddress` varchar(128) NOT NULL,
  `regdate` varchar(14) default NULL,
  `list_order` bigint(11) NOT NULL,
  PRIMARY KEY  (`poll_srl`),
  KEY `idx_upload_target_srl` (`upload_target_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_regdate` (`regdate`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_poll_item` (
  `poll_item_srl` bigint(11) NOT NULL,
  `poll_srl` bigint(11) NOT NULL,
  `poll_index_srl` bigint(11) NOT NULL,
  `upload_target_srl` bigint(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `poll_count` bigint(11) NOT NULL,
  PRIMARY KEY  (`poll_item_srl`),
  KEY `index_poll_srl` (`poll_srl`),
  KEY `idx_poll_index_srl` (`poll_index_srl`),
  KEY `idx_upload_target_srl` (`upload_target_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_poll_log` (
  `poll_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `ipaddress` varchar(128) NOT NULL,
  `regdate` varchar(14) default NULL,
  KEY `idx_poll_srl` (`poll_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_poll_title` (
  `poll_srl` bigint(11) NOT NULL,
  `poll_index_srl` bigint(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `checkcount` bigint(11) NOT NULL default '1',
  `poll_count` bigint(11) NOT NULL,
  `upload_target_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `ipaddress` varchar(128) NOT NULL,
  `regdate` varchar(14) default NULL,
  `list_order` bigint(11) NOT NULL,
  KEY `idx_poll_srl` (`poll_srl`,`poll_index_srl`),
  KEY `idx_upload_target_srl` (`upload_target_srl`),
  KEY `idx_member_srl` (`member_srl`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_regdate` (`regdate`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_purplebook` (
  `node_id` bigint(11) NOT NULL,
  `user_id` varchar(80) NOT NULL,
  `node_route` varchar(250) NOT NULL,
  `node_name` varchar(80) NOT NULL,
  `node_type` char(1) NOT NULL,
  `phone_num` varchar(40) NOT NULL,
  `regdate` varchar(14) NOT NULL,
  PRIMARY KEY  (`node_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_node_route` (`node_route`),
  KEY `idx_node_name` (`node_name`),
  KEY `idx_phone_num` (`phone_num`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_sequence` (
  `seq` bigint(64) NOT NULL auto_increment,
  PRIMARY KEY  (`seq`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12402 ;

INSERT INTO `yman_sequence` VALUES(10000);
INSERT INTO `yman_sequence` VALUES(10001);
INSERT INTO `yman_sequence` VALUES(10002);
INSERT INTO `yman_sequence` VALUES(10003);
INSERT INTO `yman_sequence` VALUES(10004);
INSERT INTO `yman_sequence` VALUES(10005);
INSERT INTO `yman_sequence` VALUES(10006);
INSERT INTO `yman_sequence` VALUES(10007);
INSERT INTO `yman_sequence` VALUES(10008);
INSERT INTO `yman_sequence` VALUES(10009);
INSERT INTO `yman_sequence` VALUES(10010);
INSERT INTO `yman_sequence` VALUES(10011);
INSERT INTO `yman_sequence` VALUES(10012);
INSERT INTO `yman_sequence` VALUES(10013);
INSERT INTO `yman_sequence` VALUES(10014);
INSERT INTO `yman_sequence` VALUES(10015);
INSERT INTO `yman_sequence` VALUES(10016);
INSERT INTO `yman_sequence` VALUES(10017);
INSERT INTO `yman_sequence` VALUES(10018);
INSERT INTO `yman_sequence` VALUES(10019);
INSERT INTO `yman_sequence` VALUES(10020);
INSERT INTO `yman_sequence` VALUES(10021);
INSERT INTO `yman_sequence` VALUES(10022);
INSERT INTO `yman_sequence` VALUES(10023);
INSERT INTO `yman_sequence` VALUES(10024);
INSERT INTO `yman_sequence` VALUES(10025);
INSERT INTO `yman_sequence` VALUES(10026);
INSERT INTO `yman_sequence` VALUES(10027);
INSERT INTO `yman_sequence` VALUES(10028);
INSERT INTO `yman_sequence` VALUES(10029);
INSERT INTO `yman_sequence` VALUES(10030);
INSERT INTO `yman_sequence` VALUES(10031);
INSERT INTO `yman_sequence` VALUES(10032);
INSERT INTO `yman_sequence` VALUES(10033);
INSERT INTO `yman_sequence` VALUES(10034);
INSERT INTO `yman_sequence` VALUES(10035);
INSERT INTO `yman_sequence` VALUES(10036);
INSERT INTO `yman_sequence` VALUES(10037);
INSERT INTO `yman_sequence` VALUES(10038);
INSERT INTO `yman_sequence` VALUES(10039);
INSERT INTO `yman_sequence` VALUES(10040);
INSERT INTO `yman_sequence` VALUES(10041);
INSERT INTO `yman_sequence` VALUES(10042);
INSERT INTO `yman_sequence` VALUES(10043);
INSERT INTO `yman_sequence` VALUES(10044);
INSERT INTO `yman_sequence` VALUES(10045);
INSERT INTO `yman_sequence` VALUES(10046);
INSERT INTO `yman_sequence` VALUES(10047);
INSERT INTO `yman_sequence` VALUES(10048);
INSERT INTO `yman_sequence` VALUES(10049);
INSERT INTO `yman_sequence` VALUES(10050);
INSERT INTO `yman_sequence` VALUES(10051);
INSERT INTO `yman_sequence` VALUES(10052);
INSERT INTO `yman_sequence` VALUES(10053);
INSERT INTO `yman_sequence` VALUES(10054);
INSERT INTO `yman_sequence` VALUES(10055);
INSERT INTO `yman_sequence` VALUES(10056);
INSERT INTO `yman_sequence` VALUES(10057);
INSERT INTO `yman_sequence` VALUES(10058);
INSERT INTO `yman_sequence` VALUES(10059);
INSERT INTO `yman_sequence` VALUES(10060);
INSERT INTO `yman_sequence` VALUES(10061);
INSERT INTO `yman_sequence` VALUES(10062);
INSERT INTO `yman_sequence` VALUES(10063);
INSERT INTO `yman_sequence` VALUES(10064);
INSERT INTO `yman_sequence` VALUES(10065);
INSERT INTO `yman_sequence` VALUES(10066);
INSERT INTO `yman_sequence` VALUES(10067);
INSERT INTO `yman_sequence` VALUES(10068);
INSERT INTO `yman_sequence` VALUES(10069);
INSERT INTO `yman_sequence` VALUES(10070);
INSERT INTO `yman_sequence` VALUES(10071);
INSERT INTO `yman_sequence` VALUES(10072);
INSERT INTO `yman_sequence` VALUES(10073);
INSERT INTO `yman_sequence` VALUES(10074);
INSERT INTO `yman_sequence` VALUES(10075);
INSERT INTO `yman_sequence` VALUES(10076);
INSERT INTO `yman_sequence` VALUES(10077);
INSERT INTO `yman_sequence` VALUES(10078);
INSERT INTO `yman_sequence` VALUES(10079);
INSERT INTO `yman_sequence` VALUES(10080);
INSERT INTO `yman_sequence` VALUES(10081);
INSERT INTO `yman_sequence` VALUES(10082);
INSERT INTO `yman_sequence` VALUES(10083);
INSERT INTO `yman_sequence` VALUES(10084);
INSERT INTO `yman_sequence` VALUES(10085);
INSERT INTO `yman_sequence` VALUES(10086);
INSERT INTO `yman_sequence` VALUES(10087);
INSERT INTO `yman_sequence` VALUES(10088);
INSERT INTO `yman_sequence` VALUES(10089);
INSERT INTO `yman_sequence` VALUES(10090);
INSERT INTO `yman_sequence` VALUES(10091);
INSERT INTO `yman_sequence` VALUES(10092);
INSERT INTO `yman_sequence` VALUES(10093);
INSERT INTO `yman_sequence` VALUES(10094);
INSERT INTO `yman_sequence` VALUES(10095);
INSERT INTO `yman_sequence` VALUES(10096);
INSERT INTO `yman_sequence` VALUES(10097);
INSERT INTO `yman_sequence` VALUES(10098);
INSERT INTO `yman_sequence` VALUES(10099);
INSERT INTO `yman_sequence` VALUES(10100);
INSERT INTO `yman_sequence` VALUES(10101);
INSERT INTO `yman_sequence` VALUES(10102);
INSERT INTO `yman_sequence` VALUES(10103);
INSERT INTO `yman_sequence` VALUES(10104);
INSERT INTO `yman_sequence` VALUES(10105);
INSERT INTO `yman_sequence` VALUES(10106);
INSERT INTO `yman_sequence` VALUES(10107);
INSERT INTO `yman_sequence` VALUES(10108);
INSERT INTO `yman_sequence` VALUES(10109);
INSERT INTO `yman_sequence` VALUES(10110);
INSERT INTO `yman_sequence` VALUES(10111);
INSERT INTO `yman_sequence` VALUES(10112);
INSERT INTO `yman_sequence` VALUES(10113);
INSERT INTO `yman_sequence` VALUES(10114);
INSERT INTO `yman_sequence` VALUES(10115);
INSERT INTO `yman_sequence` VALUES(10116);
INSERT INTO `yman_sequence` VALUES(10117);
INSERT INTO `yman_sequence` VALUES(10118);
INSERT INTO `yman_sequence` VALUES(10119);
INSERT INTO `yman_sequence` VALUES(10120);
INSERT INTO `yman_sequence` VALUES(10121);
INSERT INTO `yman_sequence` VALUES(10122);
INSERT INTO `yman_sequence` VALUES(10123);
INSERT INTO `yman_sequence` VALUES(10124);
INSERT INTO `yman_sequence` VALUES(10125);
INSERT INTO `yman_sequence` VALUES(10126);
INSERT INTO `yman_sequence` VALUES(10127);
INSERT INTO `yman_sequence` VALUES(10128);
INSERT INTO `yman_sequence` VALUES(10129);
INSERT INTO `yman_sequence` VALUES(10130);
INSERT INTO `yman_sequence` VALUES(10131);
INSERT INTO `yman_sequence` VALUES(10132);
INSERT INTO `yman_sequence` VALUES(10133);
INSERT INTO `yman_sequence` VALUES(10134);
INSERT INTO `yman_sequence` VALUES(10135);
INSERT INTO `yman_sequence` VALUES(10136);
INSERT INTO `yman_sequence` VALUES(10137);
INSERT INTO `yman_sequence` VALUES(10138);
INSERT INTO `yman_sequence` VALUES(10139);
INSERT INTO `yman_sequence` VALUES(10140);
INSERT INTO `yman_sequence` VALUES(10141);
INSERT INTO `yman_sequence` VALUES(10142);
INSERT INTO `yman_sequence` VALUES(10143);
INSERT INTO `yman_sequence` VALUES(10144);
INSERT INTO `yman_sequence` VALUES(10145);
INSERT INTO `yman_sequence` VALUES(10146);
INSERT INTO `yman_sequence` VALUES(10147);
INSERT INTO `yman_sequence` VALUES(10148);
INSERT INTO `yman_sequence` VALUES(10149);
INSERT INTO `yman_sequence` VALUES(10150);
INSERT INTO `yman_sequence` VALUES(10151);
INSERT INTO `yman_sequence` VALUES(10152);
INSERT INTO `yman_sequence` VALUES(10153);
INSERT INTO `yman_sequence` VALUES(10154);
INSERT INTO `yman_sequence` VALUES(10155);
INSERT INTO `yman_sequence` VALUES(10156);
INSERT INTO `yman_sequence` VALUES(10157);
INSERT INTO `yman_sequence` VALUES(10158);
INSERT INTO `yman_sequence` VALUES(10159);
INSERT INTO `yman_sequence` VALUES(10160);
INSERT INTO `yman_sequence` VALUES(10161);
INSERT INTO `yman_sequence` VALUES(10162);
INSERT INTO `yman_sequence` VALUES(10163);
INSERT INTO `yman_sequence` VALUES(10164);
INSERT INTO `yman_sequence` VALUES(10165);
INSERT INTO `yman_sequence` VALUES(10166);
INSERT INTO `yman_sequence` VALUES(10167);
INSERT INTO `yman_sequence` VALUES(10168);
INSERT INTO `yman_sequence` VALUES(10169);
INSERT INTO `yman_sequence` VALUES(10170);
INSERT INTO `yman_sequence` VALUES(10171);
INSERT INTO `yman_sequence` VALUES(10172);
INSERT INTO `yman_sequence` VALUES(10173);
INSERT INTO `yman_sequence` VALUES(10174);
INSERT INTO `yman_sequence` VALUES(10175);
INSERT INTO `yman_sequence` VALUES(10176);
INSERT INTO `yman_sequence` VALUES(10177);
INSERT INTO `yman_sequence` VALUES(10178);
INSERT INTO `yman_sequence` VALUES(10179);
INSERT INTO `yman_sequence` VALUES(10180);
INSERT INTO `yman_sequence` VALUES(10181);
INSERT INTO `yman_sequence` VALUES(10182);
INSERT INTO `yman_sequence` VALUES(10183);
INSERT INTO `yman_sequence` VALUES(10184);
INSERT INTO `yman_sequence` VALUES(10185);
INSERT INTO `yman_sequence` VALUES(10186);
INSERT INTO `yman_sequence` VALUES(10187);
INSERT INTO `yman_sequence` VALUES(10188);
INSERT INTO `yman_sequence` VALUES(10189);
INSERT INTO `yman_sequence` VALUES(10190);
INSERT INTO `yman_sequence` VALUES(10191);
INSERT INTO `yman_sequence` VALUES(10192);
INSERT INTO `yman_sequence` VALUES(10193);
INSERT INTO `yman_sequence` VALUES(10194);
INSERT INTO `yman_sequence` VALUES(10195);
INSERT INTO `yman_sequence` VALUES(10196);
INSERT INTO `yman_sequence` VALUES(10197);
INSERT INTO `yman_sequence` VALUES(10198);
INSERT INTO `yman_sequence` VALUES(10199);
INSERT INTO `yman_sequence` VALUES(10200);
INSERT INTO `yman_sequence` VALUES(10201);
INSERT INTO `yman_sequence` VALUES(10202);
INSERT INTO `yman_sequence` VALUES(10203);
INSERT INTO `yman_sequence` VALUES(10204);
INSERT INTO `yman_sequence` VALUES(10205);
INSERT INTO `yman_sequence` VALUES(10206);
INSERT INTO `yman_sequence` VALUES(10207);
INSERT INTO `yman_sequence` VALUES(10208);
INSERT INTO `yman_sequence` VALUES(10209);
INSERT INTO `yman_sequence` VALUES(10210);
INSERT INTO `yman_sequence` VALUES(10211);
INSERT INTO `yman_sequence` VALUES(10212);
INSERT INTO `yman_sequence` VALUES(10213);
INSERT INTO `yman_sequence` VALUES(10214);
INSERT INTO `yman_sequence` VALUES(10215);
INSERT INTO `yman_sequence` VALUES(10216);
INSERT INTO `yman_sequence` VALUES(10217);
INSERT INTO `yman_sequence` VALUES(10218);
INSERT INTO `yman_sequence` VALUES(10219);
INSERT INTO `yman_sequence` VALUES(10220);
INSERT INTO `yman_sequence` VALUES(10221);
INSERT INTO `yman_sequence` VALUES(10222);
INSERT INTO `yman_sequence` VALUES(10223);
INSERT INTO `yman_sequence` VALUES(10224);
INSERT INTO `yman_sequence` VALUES(10225);
INSERT INTO `yman_sequence` VALUES(10226);
INSERT INTO `yman_sequence` VALUES(10227);
INSERT INTO `yman_sequence` VALUES(10228);
INSERT INTO `yman_sequence` VALUES(10229);
INSERT INTO `yman_sequence` VALUES(10230);
INSERT INTO `yman_sequence` VALUES(10231);
INSERT INTO `yman_sequence` VALUES(10232);
INSERT INTO `yman_sequence` VALUES(10233);
INSERT INTO `yman_sequence` VALUES(10234);
INSERT INTO `yman_sequence` VALUES(10235);
INSERT INTO `yman_sequence` VALUES(10236);
INSERT INTO `yman_sequence` VALUES(10237);
INSERT INTO `yman_sequence` VALUES(10238);
INSERT INTO `yman_sequence` VALUES(10239);
INSERT INTO `yman_sequence` VALUES(10240);
INSERT INTO `yman_sequence` VALUES(10241);
INSERT INTO `yman_sequence` VALUES(10242);
INSERT INTO `yman_sequence` VALUES(10243);
INSERT INTO `yman_sequence` VALUES(10244);
INSERT INTO `yman_sequence` VALUES(10245);
INSERT INTO `yman_sequence` VALUES(10246);
INSERT INTO `yman_sequence` VALUES(10247);
INSERT INTO `yman_sequence` VALUES(10248);
INSERT INTO `yman_sequence` VALUES(10249);
INSERT INTO `yman_sequence` VALUES(10250);
INSERT INTO `yman_sequence` VALUES(10251);
INSERT INTO `yman_sequence` VALUES(10252);
INSERT INTO `yman_sequence` VALUES(10253);
INSERT INTO `yman_sequence` VALUES(10254);
INSERT INTO `yman_sequence` VALUES(10255);
INSERT INTO `yman_sequence` VALUES(10256);
INSERT INTO `yman_sequence` VALUES(10257);
INSERT INTO `yman_sequence` VALUES(10258);
INSERT INTO `yman_sequence` VALUES(10259);
INSERT INTO `yman_sequence` VALUES(10260);
INSERT INTO `yman_sequence` VALUES(10261);
INSERT INTO `yman_sequence` VALUES(10262);
INSERT INTO `yman_sequence` VALUES(10263);
INSERT INTO `yman_sequence` VALUES(10264);
INSERT INTO `yman_sequence` VALUES(10265);
INSERT INTO `yman_sequence` VALUES(10266);
INSERT INTO `yman_sequence` VALUES(10267);
INSERT INTO `yman_sequence` VALUES(10268);
INSERT INTO `yman_sequence` VALUES(10269);
INSERT INTO `yman_sequence` VALUES(10270);
INSERT INTO `yman_sequence` VALUES(10271);
INSERT INTO `yman_sequence` VALUES(10272);
INSERT INTO `yman_sequence` VALUES(10273);
INSERT INTO `yman_sequence` VALUES(10274);
INSERT INTO `yman_sequence` VALUES(10275);
INSERT INTO `yman_sequence` VALUES(10276);
INSERT INTO `yman_sequence` VALUES(10277);
INSERT INTO `yman_sequence` VALUES(10278);
INSERT INTO `yman_sequence` VALUES(10279);
INSERT INTO `yman_sequence` VALUES(10280);
INSERT INTO `yman_sequence` VALUES(10281);
INSERT INTO `yman_sequence` VALUES(10282);
INSERT INTO `yman_sequence` VALUES(10283);
INSERT INTO `yman_sequence` VALUES(10284);
INSERT INTO `yman_sequence` VALUES(10285);
INSERT INTO `yman_sequence` VALUES(10286);
INSERT INTO `yman_sequence` VALUES(10287);
INSERT INTO `yman_sequence` VALUES(10288);
INSERT INTO `yman_sequence` VALUES(10289);
INSERT INTO `yman_sequence` VALUES(10290);
INSERT INTO `yman_sequence` VALUES(10291);
INSERT INTO `yman_sequence` VALUES(10292);
INSERT INTO `yman_sequence` VALUES(10293);
INSERT INTO `yman_sequence` VALUES(10294);
INSERT INTO `yman_sequence` VALUES(10295);
INSERT INTO `yman_sequence` VALUES(10296);
INSERT INTO `yman_sequence` VALUES(10297);
INSERT INTO `yman_sequence` VALUES(10298);
INSERT INTO `yman_sequence` VALUES(10299);
INSERT INTO `yman_sequence` VALUES(10300);
INSERT INTO `yman_sequence` VALUES(10301);
INSERT INTO `yman_sequence` VALUES(10302);
INSERT INTO `yman_sequence` VALUES(10303);
INSERT INTO `yman_sequence` VALUES(10304);
INSERT INTO `yman_sequence` VALUES(10305);
INSERT INTO `yman_sequence` VALUES(10306);
INSERT INTO `yman_sequence` VALUES(10307);
INSERT INTO `yman_sequence` VALUES(10308);
INSERT INTO `yman_sequence` VALUES(10309);
INSERT INTO `yman_sequence` VALUES(10310);
INSERT INTO `yman_sequence` VALUES(10311);
INSERT INTO `yman_sequence` VALUES(10312);
INSERT INTO `yman_sequence` VALUES(10313);
INSERT INTO `yman_sequence` VALUES(10314);
INSERT INTO `yman_sequence` VALUES(10315);
INSERT INTO `yman_sequence` VALUES(10316);
INSERT INTO `yman_sequence` VALUES(10317);
INSERT INTO `yman_sequence` VALUES(10318);
INSERT INTO `yman_sequence` VALUES(10319);
INSERT INTO `yman_sequence` VALUES(10320);
INSERT INTO `yman_sequence` VALUES(10321);
INSERT INTO `yman_sequence` VALUES(10322);
INSERT INTO `yman_sequence` VALUES(10323);
INSERT INTO `yman_sequence` VALUES(10324);
INSERT INTO `yman_sequence` VALUES(10325);
INSERT INTO `yman_sequence` VALUES(10326);
INSERT INTO `yman_sequence` VALUES(10327);
INSERT INTO `yman_sequence` VALUES(10328);
INSERT INTO `yman_sequence` VALUES(10329);
INSERT INTO `yman_sequence` VALUES(10330);
INSERT INTO `yman_sequence` VALUES(10331);
INSERT INTO `yman_sequence` VALUES(10332);
INSERT INTO `yman_sequence` VALUES(10333);
INSERT INTO `yman_sequence` VALUES(10334);
INSERT INTO `yman_sequence` VALUES(10335);
INSERT INTO `yman_sequence` VALUES(10336);
INSERT INTO `yman_sequence` VALUES(10337);
INSERT INTO `yman_sequence` VALUES(10338);
INSERT INTO `yman_sequence` VALUES(10339);
INSERT INTO `yman_sequence` VALUES(10340);
INSERT INTO `yman_sequence` VALUES(10341);
INSERT INTO `yman_sequence` VALUES(10342);
INSERT INTO `yman_sequence` VALUES(10343);
INSERT INTO `yman_sequence` VALUES(10344);
INSERT INTO `yman_sequence` VALUES(10345);
INSERT INTO `yman_sequence` VALUES(10346);
INSERT INTO `yman_sequence` VALUES(10347);
INSERT INTO `yman_sequence` VALUES(10348);
INSERT INTO `yman_sequence` VALUES(10349);
INSERT INTO `yman_sequence` VALUES(10350);
INSERT INTO `yman_sequence` VALUES(10351);
INSERT INTO `yman_sequence` VALUES(10352);
INSERT INTO `yman_sequence` VALUES(10353);
INSERT INTO `yman_sequence` VALUES(10354);
INSERT INTO `yman_sequence` VALUES(10355);
INSERT INTO `yman_sequence` VALUES(10356);
INSERT INTO `yman_sequence` VALUES(10357);
INSERT INTO `yman_sequence` VALUES(10358);
INSERT INTO `yman_sequence` VALUES(10359);
INSERT INTO `yman_sequence` VALUES(10360);
INSERT INTO `yman_sequence` VALUES(10361);
INSERT INTO `yman_sequence` VALUES(10362);
INSERT INTO `yman_sequence` VALUES(10363);
INSERT INTO `yman_sequence` VALUES(10364);
INSERT INTO `yman_sequence` VALUES(10365);
INSERT INTO `yman_sequence` VALUES(10366);
INSERT INTO `yman_sequence` VALUES(10367);
INSERT INTO `yman_sequence` VALUES(10368);
INSERT INTO `yman_sequence` VALUES(10369);
INSERT INTO `yman_sequence` VALUES(10370);
INSERT INTO `yman_sequence` VALUES(10371);
INSERT INTO `yman_sequence` VALUES(10372);
INSERT INTO `yman_sequence` VALUES(10373);
INSERT INTO `yman_sequence` VALUES(10374);
INSERT INTO `yman_sequence` VALUES(10375);
INSERT INTO `yman_sequence` VALUES(10376);
INSERT INTO `yman_sequence` VALUES(10377);
INSERT INTO `yman_sequence` VALUES(10378);
INSERT INTO `yman_sequence` VALUES(10379);
INSERT INTO `yman_sequence` VALUES(10380);
INSERT INTO `yman_sequence` VALUES(10381);
INSERT INTO `yman_sequence` VALUES(10382);
INSERT INTO `yman_sequence` VALUES(10383);
INSERT INTO `yman_sequence` VALUES(10384);
INSERT INTO `yman_sequence` VALUES(10385);
INSERT INTO `yman_sequence` VALUES(10386);
INSERT INTO `yman_sequence` VALUES(10387);
INSERT INTO `yman_sequence` VALUES(10388);
INSERT INTO `yman_sequence` VALUES(10389);
INSERT INTO `yman_sequence` VALUES(10390);
INSERT INTO `yman_sequence` VALUES(10391);
INSERT INTO `yman_sequence` VALUES(10392);
INSERT INTO `yman_sequence` VALUES(10393);
INSERT INTO `yman_sequence` VALUES(10394);
INSERT INTO `yman_sequence` VALUES(10395);
INSERT INTO `yman_sequence` VALUES(10396);
INSERT INTO `yman_sequence` VALUES(10397);
INSERT INTO `yman_sequence` VALUES(10398);
INSERT INTO `yman_sequence` VALUES(10399);
INSERT INTO `yman_sequence` VALUES(10400);
INSERT INTO `yman_sequence` VALUES(10401);
INSERT INTO `yman_sequence` VALUES(10402);
INSERT INTO `yman_sequence` VALUES(10403);
INSERT INTO `yman_sequence` VALUES(10404);
INSERT INTO `yman_sequence` VALUES(10405);
INSERT INTO `yman_sequence` VALUES(10406);
INSERT INTO `yman_sequence` VALUES(10407);
INSERT INTO `yman_sequence` VALUES(10408);
INSERT INTO `yman_sequence` VALUES(10409);
INSERT INTO `yman_sequence` VALUES(10410);
INSERT INTO `yman_sequence` VALUES(10411);
INSERT INTO `yman_sequence` VALUES(10412);
INSERT INTO `yman_sequence` VALUES(10413);
INSERT INTO `yman_sequence` VALUES(10414);
INSERT INTO `yman_sequence` VALUES(10415);
INSERT INTO `yman_sequence` VALUES(10416);
INSERT INTO `yman_sequence` VALUES(10417);
INSERT INTO `yman_sequence` VALUES(10418);
INSERT INTO `yman_sequence` VALUES(10419);
INSERT INTO `yman_sequence` VALUES(10420);
INSERT INTO `yman_sequence` VALUES(10421);
INSERT INTO `yman_sequence` VALUES(10422);
INSERT INTO `yman_sequence` VALUES(10423);
INSERT INTO `yman_sequence` VALUES(10424);
INSERT INTO `yman_sequence` VALUES(10425);
INSERT INTO `yman_sequence` VALUES(10426);
INSERT INTO `yman_sequence` VALUES(10427);
INSERT INTO `yman_sequence` VALUES(10428);
INSERT INTO `yman_sequence` VALUES(10429);
INSERT INTO `yman_sequence` VALUES(10430);
INSERT INTO `yman_sequence` VALUES(10431);
INSERT INTO `yman_sequence` VALUES(10432);
INSERT INTO `yman_sequence` VALUES(10433);
INSERT INTO `yman_sequence` VALUES(10434);
INSERT INTO `yman_sequence` VALUES(10435);
INSERT INTO `yman_sequence` VALUES(10436);
INSERT INTO `yman_sequence` VALUES(10437);
INSERT INTO `yman_sequence` VALUES(10438);
INSERT INTO `yman_sequence` VALUES(10439);
INSERT INTO `yman_sequence` VALUES(10440);
INSERT INTO `yman_sequence` VALUES(10441);
INSERT INTO `yman_sequence` VALUES(10442);
INSERT INTO `yman_sequence` VALUES(10443);
INSERT INTO `yman_sequence` VALUES(10444);
INSERT INTO `yman_sequence` VALUES(10445);
INSERT INTO `yman_sequence` VALUES(10446);
INSERT INTO `yman_sequence` VALUES(10447);
INSERT INTO `yman_sequence` VALUES(10448);
INSERT INTO `yman_sequence` VALUES(10449);
INSERT INTO `yman_sequence` VALUES(10450);
INSERT INTO `yman_sequence` VALUES(10451);
INSERT INTO `yman_sequence` VALUES(10452);
INSERT INTO `yman_sequence` VALUES(10453);
INSERT INTO `yman_sequence` VALUES(10454);
INSERT INTO `yman_sequence` VALUES(10455);
INSERT INTO `yman_sequence` VALUES(10456);
INSERT INTO `yman_sequence` VALUES(10457);
INSERT INTO `yman_sequence` VALUES(10458);
INSERT INTO `yman_sequence` VALUES(10459);
INSERT INTO `yman_sequence` VALUES(10460);
INSERT INTO `yman_sequence` VALUES(10461);
INSERT INTO `yman_sequence` VALUES(10462);
INSERT INTO `yman_sequence` VALUES(10463);
INSERT INTO `yman_sequence` VALUES(10464);
INSERT INTO `yman_sequence` VALUES(10465);
INSERT INTO `yman_sequence` VALUES(10466);
INSERT INTO `yman_sequence` VALUES(10467);
INSERT INTO `yman_sequence` VALUES(10468);
INSERT INTO `yman_sequence` VALUES(10469);
INSERT INTO `yman_sequence` VALUES(10470);
INSERT INTO `yman_sequence` VALUES(10471);
INSERT INTO `yman_sequence` VALUES(10472);
INSERT INTO `yman_sequence` VALUES(10473);
INSERT INTO `yman_sequence` VALUES(10474);
INSERT INTO `yman_sequence` VALUES(10475);
INSERT INTO `yman_sequence` VALUES(10476);
INSERT INTO `yman_sequence` VALUES(10477);
INSERT INTO `yman_sequence` VALUES(10478);
INSERT INTO `yman_sequence` VALUES(10479);
INSERT INTO `yman_sequence` VALUES(10480);
INSERT INTO `yman_sequence` VALUES(10481);
INSERT INTO `yman_sequence` VALUES(10482);
INSERT INTO `yman_sequence` VALUES(10483);
INSERT INTO `yman_sequence` VALUES(10484);
INSERT INTO `yman_sequence` VALUES(10485);
INSERT INTO `yman_sequence` VALUES(10486);
INSERT INTO `yman_sequence` VALUES(10487);
INSERT INTO `yman_sequence` VALUES(10488);
INSERT INTO `yman_sequence` VALUES(10489);
INSERT INTO `yman_sequence` VALUES(10490);
INSERT INTO `yman_sequence` VALUES(10491);
INSERT INTO `yman_sequence` VALUES(10492);
INSERT INTO `yman_sequence` VALUES(10493);
INSERT INTO `yman_sequence` VALUES(10494);
INSERT INTO `yman_sequence` VALUES(10495);
INSERT INTO `yman_sequence` VALUES(10496);
INSERT INTO `yman_sequence` VALUES(10497);
INSERT INTO `yman_sequence` VALUES(10498);
INSERT INTO `yman_sequence` VALUES(10499);
INSERT INTO `yman_sequence` VALUES(10500);
INSERT INTO `yman_sequence` VALUES(10501);
INSERT INTO `yman_sequence` VALUES(10502);
INSERT INTO `yman_sequence` VALUES(10503);
INSERT INTO `yman_sequence` VALUES(10504);
INSERT INTO `yman_sequence` VALUES(10505);
INSERT INTO `yman_sequence` VALUES(10506);
INSERT INTO `yman_sequence` VALUES(10507);
INSERT INTO `yman_sequence` VALUES(10508);
INSERT INTO `yman_sequence` VALUES(10509);
INSERT INTO `yman_sequence` VALUES(10510);
INSERT INTO `yman_sequence` VALUES(10511);
INSERT INTO `yman_sequence` VALUES(10512);
INSERT INTO `yman_sequence` VALUES(10513);
INSERT INTO `yman_sequence` VALUES(10514);
INSERT INTO `yman_sequence` VALUES(10515);
INSERT INTO `yman_sequence` VALUES(10516);
INSERT INTO `yman_sequence` VALUES(10517);
INSERT INTO `yman_sequence` VALUES(10518);
INSERT INTO `yman_sequence` VALUES(10519);
INSERT INTO `yman_sequence` VALUES(10520);
INSERT INTO `yman_sequence` VALUES(10521);
INSERT INTO `yman_sequence` VALUES(10522);
INSERT INTO `yman_sequence` VALUES(10523);
INSERT INTO `yman_sequence` VALUES(10524);
INSERT INTO `yman_sequence` VALUES(10525);
INSERT INTO `yman_sequence` VALUES(10526);
INSERT INTO `yman_sequence` VALUES(10527);
INSERT INTO `yman_sequence` VALUES(10528);
INSERT INTO `yman_sequence` VALUES(10529);
INSERT INTO `yman_sequence` VALUES(10530);
INSERT INTO `yman_sequence` VALUES(10531);
INSERT INTO `yman_sequence` VALUES(10532);
INSERT INTO `yman_sequence` VALUES(10533);
INSERT INTO `yman_sequence` VALUES(10534);
INSERT INTO `yman_sequence` VALUES(10535);
INSERT INTO `yman_sequence` VALUES(10536);
INSERT INTO `yman_sequence` VALUES(10537);
INSERT INTO `yman_sequence` VALUES(10538);
INSERT INTO `yman_sequence` VALUES(10539);
INSERT INTO `yman_sequence` VALUES(10540);
INSERT INTO `yman_sequence` VALUES(10541);
INSERT INTO `yman_sequence` VALUES(10542);
INSERT INTO `yman_sequence` VALUES(10543);
INSERT INTO `yman_sequence` VALUES(10544);
INSERT INTO `yman_sequence` VALUES(10545);
INSERT INTO `yman_sequence` VALUES(10546);
INSERT INTO `yman_sequence` VALUES(10547);
INSERT INTO `yman_sequence` VALUES(10548);
INSERT INTO `yman_sequence` VALUES(10549);
INSERT INTO `yman_sequence` VALUES(10550);
INSERT INTO `yman_sequence` VALUES(10551);
INSERT INTO `yman_sequence` VALUES(10552);
INSERT INTO `yman_sequence` VALUES(10553);
INSERT INTO `yman_sequence` VALUES(10554);
INSERT INTO `yman_sequence` VALUES(10555);
INSERT INTO `yman_sequence` VALUES(10556);
INSERT INTO `yman_sequence` VALUES(10557);
INSERT INTO `yman_sequence` VALUES(10558);
INSERT INTO `yman_sequence` VALUES(10559);
INSERT INTO `yman_sequence` VALUES(10560);
INSERT INTO `yman_sequence` VALUES(10561);
INSERT INTO `yman_sequence` VALUES(10562);
INSERT INTO `yman_sequence` VALUES(10563);
INSERT INTO `yman_sequence` VALUES(10564);
INSERT INTO `yman_sequence` VALUES(10565);
INSERT INTO `yman_sequence` VALUES(10566);
INSERT INTO `yman_sequence` VALUES(10567);
INSERT INTO `yman_sequence` VALUES(10568);
INSERT INTO `yman_sequence` VALUES(10569);
INSERT INTO `yman_sequence` VALUES(10570);
INSERT INTO `yman_sequence` VALUES(10571);
INSERT INTO `yman_sequence` VALUES(10572);
INSERT INTO `yman_sequence` VALUES(10573);
INSERT INTO `yman_sequence` VALUES(10574);
INSERT INTO `yman_sequence` VALUES(10575);
INSERT INTO `yman_sequence` VALUES(10576);
INSERT INTO `yman_sequence` VALUES(10577);
INSERT INTO `yman_sequence` VALUES(10578);
INSERT INTO `yman_sequence` VALUES(10579);
INSERT INTO `yman_sequence` VALUES(10580);
INSERT INTO `yman_sequence` VALUES(10581);
INSERT INTO `yman_sequence` VALUES(10582);
INSERT INTO `yman_sequence` VALUES(10583);
INSERT INTO `yman_sequence` VALUES(10584);
INSERT INTO `yman_sequence` VALUES(10585);
INSERT INTO `yman_sequence` VALUES(10586);
INSERT INTO `yman_sequence` VALUES(10587);
INSERT INTO `yman_sequence` VALUES(10588);
INSERT INTO `yman_sequence` VALUES(10589);
INSERT INTO `yman_sequence` VALUES(10590);
INSERT INTO `yman_sequence` VALUES(10591);
INSERT INTO `yman_sequence` VALUES(10592);
INSERT INTO `yman_sequence` VALUES(10593);
INSERT INTO `yman_sequence` VALUES(10594);
INSERT INTO `yman_sequence` VALUES(10595);
INSERT INTO `yman_sequence` VALUES(10596);
INSERT INTO `yman_sequence` VALUES(10597);
INSERT INTO `yman_sequence` VALUES(10598);
INSERT INTO `yman_sequence` VALUES(10599);
INSERT INTO `yman_sequence` VALUES(10600);
INSERT INTO `yman_sequence` VALUES(10601);
INSERT INTO `yman_sequence` VALUES(10602);
INSERT INTO `yman_sequence` VALUES(10603);
INSERT INTO `yman_sequence` VALUES(10604);
INSERT INTO `yman_sequence` VALUES(10605);
INSERT INTO `yman_sequence` VALUES(10606);
INSERT INTO `yman_sequence` VALUES(10607);
INSERT INTO `yman_sequence` VALUES(10608);
INSERT INTO `yman_sequence` VALUES(10609);
INSERT INTO `yman_sequence` VALUES(10610);
INSERT INTO `yman_sequence` VALUES(10611);
INSERT INTO `yman_sequence` VALUES(10612);
INSERT INTO `yman_sequence` VALUES(10613);
INSERT INTO `yman_sequence` VALUES(10614);
INSERT INTO `yman_sequence` VALUES(10615);
INSERT INTO `yman_sequence` VALUES(10616);
INSERT INTO `yman_sequence` VALUES(10617);
INSERT INTO `yman_sequence` VALUES(10618);
INSERT INTO `yman_sequence` VALUES(10619);
INSERT INTO `yman_sequence` VALUES(10620);
INSERT INTO `yman_sequence` VALUES(10621);
INSERT INTO `yman_sequence` VALUES(10622);
INSERT INTO `yman_sequence` VALUES(10623);
INSERT INTO `yman_sequence` VALUES(10624);
INSERT INTO `yman_sequence` VALUES(10625);
INSERT INTO `yman_sequence` VALUES(10626);
INSERT INTO `yman_sequence` VALUES(10627);
INSERT INTO `yman_sequence` VALUES(10628);
INSERT INTO `yman_sequence` VALUES(10629);
INSERT INTO `yman_sequence` VALUES(10630);
INSERT INTO `yman_sequence` VALUES(10631);
INSERT INTO `yman_sequence` VALUES(10632);
INSERT INTO `yman_sequence` VALUES(10633);
INSERT INTO `yman_sequence` VALUES(10634);
INSERT INTO `yman_sequence` VALUES(10635);
INSERT INTO `yman_sequence` VALUES(10636);
INSERT INTO `yman_sequence` VALUES(10637);
INSERT INTO `yman_sequence` VALUES(10638);
INSERT INTO `yman_sequence` VALUES(10639);
INSERT INTO `yman_sequence` VALUES(10640);
INSERT INTO `yman_sequence` VALUES(10641);
INSERT INTO `yman_sequence` VALUES(10642);
INSERT INTO `yman_sequence` VALUES(10643);
INSERT INTO `yman_sequence` VALUES(10644);
INSERT INTO `yman_sequence` VALUES(10645);
INSERT INTO `yman_sequence` VALUES(10646);
INSERT INTO `yman_sequence` VALUES(10647);
INSERT INTO `yman_sequence` VALUES(10648);
INSERT INTO `yman_sequence` VALUES(10649);
INSERT INTO `yman_sequence` VALUES(10650);
INSERT INTO `yman_sequence` VALUES(10651);
INSERT INTO `yman_sequence` VALUES(10652);
INSERT INTO `yman_sequence` VALUES(10653);
INSERT INTO `yman_sequence` VALUES(10654);
INSERT INTO `yman_sequence` VALUES(10655);
INSERT INTO `yman_sequence` VALUES(10656);
INSERT INTO `yman_sequence` VALUES(10657);
INSERT INTO `yman_sequence` VALUES(10658);
INSERT INTO `yman_sequence` VALUES(10659);
INSERT INTO `yman_sequence` VALUES(10660);
INSERT INTO `yman_sequence` VALUES(10661);
INSERT INTO `yman_sequence` VALUES(10662);
INSERT INTO `yman_sequence` VALUES(10663);
INSERT INTO `yman_sequence` VALUES(10664);
INSERT INTO `yman_sequence` VALUES(10665);
INSERT INTO `yman_sequence` VALUES(10666);
INSERT INTO `yman_sequence` VALUES(10667);
INSERT INTO `yman_sequence` VALUES(10668);
INSERT INTO `yman_sequence` VALUES(10669);
INSERT INTO `yman_sequence` VALUES(10670);
INSERT INTO `yman_sequence` VALUES(10671);
INSERT INTO `yman_sequence` VALUES(10672);
INSERT INTO `yman_sequence` VALUES(10673);
INSERT INTO `yman_sequence` VALUES(10674);
INSERT INTO `yman_sequence` VALUES(10675);
INSERT INTO `yman_sequence` VALUES(10676);
INSERT INTO `yman_sequence` VALUES(10677);
INSERT INTO `yman_sequence` VALUES(10678);
INSERT INTO `yman_sequence` VALUES(10679);
INSERT INTO `yman_sequence` VALUES(10680);
INSERT INTO `yman_sequence` VALUES(10681);
INSERT INTO `yman_sequence` VALUES(10682);
INSERT INTO `yman_sequence` VALUES(10683);
INSERT INTO `yman_sequence` VALUES(10684);
INSERT INTO `yman_sequence` VALUES(10685);
INSERT INTO `yman_sequence` VALUES(10686);
INSERT INTO `yman_sequence` VALUES(10687);
INSERT INTO `yman_sequence` VALUES(10688);
INSERT INTO `yman_sequence` VALUES(10689);
INSERT INTO `yman_sequence` VALUES(10690);
INSERT INTO `yman_sequence` VALUES(10691);
INSERT INTO `yman_sequence` VALUES(10692);
INSERT INTO `yman_sequence` VALUES(10693);
INSERT INTO `yman_sequence` VALUES(10694);
INSERT INTO `yman_sequence` VALUES(10695);
INSERT INTO `yman_sequence` VALUES(10696);
INSERT INTO `yman_sequence` VALUES(10697);
INSERT INTO `yman_sequence` VALUES(10698);
INSERT INTO `yman_sequence` VALUES(10699);
INSERT INTO `yman_sequence` VALUES(10700);
INSERT INTO `yman_sequence` VALUES(10701);
INSERT INTO `yman_sequence` VALUES(10702);
INSERT INTO `yman_sequence` VALUES(10703);
INSERT INTO `yman_sequence` VALUES(10704);
INSERT INTO `yman_sequence` VALUES(10705);
INSERT INTO `yman_sequence` VALUES(10706);
INSERT INTO `yman_sequence` VALUES(10707);
INSERT INTO `yman_sequence` VALUES(10708);
INSERT INTO `yman_sequence` VALUES(10709);
INSERT INTO `yman_sequence` VALUES(10710);
INSERT INTO `yman_sequence` VALUES(10711);
INSERT INTO `yman_sequence` VALUES(10712);
INSERT INTO `yman_sequence` VALUES(10713);
INSERT INTO `yman_sequence` VALUES(10714);
INSERT INTO `yman_sequence` VALUES(10715);
INSERT INTO `yman_sequence` VALUES(10716);
INSERT INTO `yman_sequence` VALUES(10717);
INSERT INTO `yman_sequence` VALUES(10718);
INSERT INTO `yman_sequence` VALUES(10719);
INSERT INTO `yman_sequence` VALUES(10720);
INSERT INTO `yman_sequence` VALUES(10721);
INSERT INTO `yman_sequence` VALUES(10722);
INSERT INTO `yman_sequence` VALUES(10723);
INSERT INTO `yman_sequence` VALUES(10724);
INSERT INTO `yman_sequence` VALUES(10725);
INSERT INTO `yman_sequence` VALUES(10726);
INSERT INTO `yman_sequence` VALUES(10727);
INSERT INTO `yman_sequence` VALUES(10728);
INSERT INTO `yman_sequence` VALUES(10729);
INSERT INTO `yman_sequence` VALUES(10730);
INSERT INTO `yman_sequence` VALUES(10731);
INSERT INTO `yman_sequence` VALUES(10732);
INSERT INTO `yman_sequence` VALUES(10733);
INSERT INTO `yman_sequence` VALUES(10734);
INSERT INTO `yman_sequence` VALUES(10735);
INSERT INTO `yman_sequence` VALUES(10736);
INSERT INTO `yman_sequence` VALUES(10737);
INSERT INTO `yman_sequence` VALUES(10738);
INSERT INTO `yman_sequence` VALUES(10739);
INSERT INTO `yman_sequence` VALUES(10740);
INSERT INTO `yman_sequence` VALUES(10741);
INSERT INTO `yman_sequence` VALUES(10742);
INSERT INTO `yman_sequence` VALUES(10743);
INSERT INTO `yman_sequence` VALUES(10744);
INSERT INTO `yman_sequence` VALUES(10745);
INSERT INTO `yman_sequence` VALUES(10746);
INSERT INTO `yman_sequence` VALUES(10747);
INSERT INTO `yman_sequence` VALUES(10748);
INSERT INTO `yman_sequence` VALUES(10749);
INSERT INTO `yman_sequence` VALUES(10750);
INSERT INTO `yman_sequence` VALUES(10751);
INSERT INTO `yman_sequence` VALUES(10752);
INSERT INTO `yman_sequence` VALUES(10753);
INSERT INTO `yman_sequence` VALUES(10754);
INSERT INTO `yman_sequence` VALUES(10755);
INSERT INTO `yman_sequence` VALUES(10756);
INSERT INTO `yman_sequence` VALUES(10757);
INSERT INTO `yman_sequence` VALUES(10758);
INSERT INTO `yman_sequence` VALUES(10759);
INSERT INTO `yman_sequence` VALUES(10760);
INSERT INTO `yman_sequence` VALUES(10761);
INSERT INTO `yman_sequence` VALUES(10762);
INSERT INTO `yman_sequence` VALUES(10763);
INSERT INTO `yman_sequence` VALUES(10764);
INSERT INTO `yman_sequence` VALUES(10765);
INSERT INTO `yman_sequence` VALUES(10766);
INSERT INTO `yman_sequence` VALUES(10767);
INSERT INTO `yman_sequence` VALUES(10768);
INSERT INTO `yman_sequence` VALUES(10769);
INSERT INTO `yman_sequence` VALUES(10770);
INSERT INTO `yman_sequence` VALUES(10771);
INSERT INTO `yman_sequence` VALUES(10772);
INSERT INTO `yman_sequence` VALUES(10773);
INSERT INTO `yman_sequence` VALUES(10774);
INSERT INTO `yman_sequence` VALUES(10775);
INSERT INTO `yman_sequence` VALUES(10776);
INSERT INTO `yman_sequence` VALUES(10777);
INSERT INTO `yman_sequence` VALUES(10778);
INSERT INTO `yman_sequence` VALUES(10779);
INSERT INTO `yman_sequence` VALUES(10780);
INSERT INTO `yman_sequence` VALUES(10781);
INSERT INTO `yman_sequence` VALUES(10782);
INSERT INTO `yman_sequence` VALUES(10783);
INSERT INTO `yman_sequence` VALUES(10784);
INSERT INTO `yman_sequence` VALUES(10785);
INSERT INTO `yman_sequence` VALUES(10786);
INSERT INTO `yman_sequence` VALUES(10787);
INSERT INTO `yman_sequence` VALUES(10788);
INSERT INTO `yman_sequence` VALUES(10789);
INSERT INTO `yman_sequence` VALUES(10790);
INSERT INTO `yman_sequence` VALUES(10791);
INSERT INTO `yman_sequence` VALUES(10792);
INSERT INTO `yman_sequence` VALUES(10793);
INSERT INTO `yman_sequence` VALUES(10794);
INSERT INTO `yman_sequence` VALUES(10795);
INSERT INTO `yman_sequence` VALUES(10796);
INSERT INTO `yman_sequence` VALUES(10797);
INSERT INTO `yman_sequence` VALUES(10798);
INSERT INTO `yman_sequence` VALUES(10799);
INSERT INTO `yman_sequence` VALUES(10800);
INSERT INTO `yman_sequence` VALUES(10801);
INSERT INTO `yman_sequence` VALUES(10802);
INSERT INTO `yman_sequence` VALUES(10803);
INSERT INTO `yman_sequence` VALUES(10804);
INSERT INTO `yman_sequence` VALUES(10805);
INSERT INTO `yman_sequence` VALUES(10806);
INSERT INTO `yman_sequence` VALUES(10807);
INSERT INTO `yman_sequence` VALUES(10808);
INSERT INTO `yman_sequence` VALUES(10809);
INSERT INTO `yman_sequence` VALUES(10810);
INSERT INTO `yman_sequence` VALUES(10811);
INSERT INTO `yman_sequence` VALUES(10812);
INSERT INTO `yman_sequence` VALUES(10813);
INSERT INTO `yman_sequence` VALUES(10814);
INSERT INTO `yman_sequence` VALUES(10815);
INSERT INTO `yman_sequence` VALUES(10816);
INSERT INTO `yman_sequence` VALUES(10817);
INSERT INTO `yman_sequence` VALUES(10818);
INSERT INTO `yman_sequence` VALUES(10819);
INSERT INTO `yman_sequence` VALUES(10820);
INSERT INTO `yman_sequence` VALUES(10821);
INSERT INTO `yman_sequence` VALUES(10822);
INSERT INTO `yman_sequence` VALUES(10823);
INSERT INTO `yman_sequence` VALUES(10824);
INSERT INTO `yman_sequence` VALUES(10825);
INSERT INTO `yman_sequence` VALUES(10826);
INSERT INTO `yman_sequence` VALUES(10827);
INSERT INTO `yman_sequence` VALUES(10828);
INSERT INTO `yman_sequence` VALUES(10829);
INSERT INTO `yman_sequence` VALUES(10830);
INSERT INTO `yman_sequence` VALUES(10831);
INSERT INTO `yman_sequence` VALUES(10832);
INSERT INTO `yman_sequence` VALUES(10833);
INSERT INTO `yman_sequence` VALUES(10834);
INSERT INTO `yman_sequence` VALUES(10835);
INSERT INTO `yman_sequence` VALUES(10836);
INSERT INTO `yman_sequence` VALUES(10837);
INSERT INTO `yman_sequence` VALUES(10838);
INSERT INTO `yman_sequence` VALUES(10839);
INSERT INTO `yman_sequence` VALUES(10840);
INSERT INTO `yman_sequence` VALUES(10841);
INSERT INTO `yman_sequence` VALUES(10842);
INSERT INTO `yman_sequence` VALUES(10843);
INSERT INTO `yman_sequence` VALUES(10844);
INSERT INTO `yman_sequence` VALUES(10845);
INSERT INTO `yman_sequence` VALUES(10846);
INSERT INTO `yman_sequence` VALUES(10847);
INSERT INTO `yman_sequence` VALUES(10848);
INSERT INTO `yman_sequence` VALUES(10849);
INSERT INTO `yman_sequence` VALUES(10850);
INSERT INTO `yman_sequence` VALUES(10851);
INSERT INTO `yman_sequence` VALUES(10852);
INSERT INTO `yman_sequence` VALUES(10853);
INSERT INTO `yman_sequence` VALUES(10854);
INSERT INTO `yman_sequence` VALUES(10855);
INSERT INTO `yman_sequence` VALUES(10856);
INSERT INTO `yman_sequence` VALUES(10857);
INSERT INTO `yman_sequence` VALUES(10858);
INSERT INTO `yman_sequence` VALUES(10859);
INSERT INTO `yman_sequence` VALUES(10860);
INSERT INTO `yman_sequence` VALUES(10861);
INSERT INTO `yman_sequence` VALUES(10862);
INSERT INTO `yman_sequence` VALUES(10863);
INSERT INTO `yman_sequence` VALUES(10864);
INSERT INTO `yman_sequence` VALUES(10865);
INSERT INTO `yman_sequence` VALUES(10866);
INSERT INTO `yman_sequence` VALUES(10867);
INSERT INTO `yman_sequence` VALUES(10868);
INSERT INTO `yman_sequence` VALUES(10869);
INSERT INTO `yman_sequence` VALUES(10870);
INSERT INTO `yman_sequence` VALUES(10871);
INSERT INTO `yman_sequence` VALUES(10872);
INSERT INTO `yman_sequence` VALUES(10873);
INSERT INTO `yman_sequence` VALUES(10874);
INSERT INTO `yman_sequence` VALUES(10875);
INSERT INTO `yman_sequence` VALUES(10876);
INSERT INTO `yman_sequence` VALUES(10877);
INSERT INTO `yman_sequence` VALUES(10878);
INSERT INTO `yman_sequence` VALUES(10879);
INSERT INTO `yman_sequence` VALUES(10880);
INSERT INTO `yman_sequence` VALUES(10881);
INSERT INTO `yman_sequence` VALUES(10882);
INSERT INTO `yman_sequence` VALUES(10883);
INSERT INTO `yman_sequence` VALUES(10884);
INSERT INTO `yman_sequence` VALUES(10885);
INSERT INTO `yman_sequence` VALUES(10886);
INSERT INTO `yman_sequence` VALUES(10887);
INSERT INTO `yman_sequence` VALUES(10888);
INSERT INTO `yman_sequence` VALUES(10889);
INSERT INTO `yman_sequence` VALUES(10890);
INSERT INTO `yman_sequence` VALUES(10891);
INSERT INTO `yman_sequence` VALUES(10892);
INSERT INTO `yman_sequence` VALUES(10893);
INSERT INTO `yman_sequence` VALUES(10894);
INSERT INTO `yman_sequence` VALUES(10895);
INSERT INTO `yman_sequence` VALUES(10896);
INSERT INTO `yman_sequence` VALUES(10897);
INSERT INTO `yman_sequence` VALUES(10898);
INSERT INTO `yman_sequence` VALUES(10899);
INSERT INTO `yman_sequence` VALUES(10900);
INSERT INTO `yman_sequence` VALUES(10901);
INSERT INTO `yman_sequence` VALUES(10902);
INSERT INTO `yman_sequence` VALUES(10903);
INSERT INTO `yman_sequence` VALUES(10904);
INSERT INTO `yman_sequence` VALUES(10905);
INSERT INTO `yman_sequence` VALUES(10906);
INSERT INTO `yman_sequence` VALUES(10907);
INSERT INTO `yman_sequence` VALUES(10908);
INSERT INTO `yman_sequence` VALUES(10909);
INSERT INTO `yman_sequence` VALUES(10910);
INSERT INTO `yman_sequence` VALUES(10911);
INSERT INTO `yman_sequence` VALUES(10912);
INSERT INTO `yman_sequence` VALUES(10913);
INSERT INTO `yman_sequence` VALUES(10914);
INSERT INTO `yman_sequence` VALUES(10915);
INSERT INTO `yman_sequence` VALUES(10916);
INSERT INTO `yman_sequence` VALUES(10917);
INSERT INTO `yman_sequence` VALUES(10918);
INSERT INTO `yman_sequence` VALUES(10919);
INSERT INTO `yman_sequence` VALUES(10920);
INSERT INTO `yman_sequence` VALUES(10921);
INSERT INTO `yman_sequence` VALUES(10922);
INSERT INTO `yman_sequence` VALUES(10923);
INSERT INTO `yman_sequence` VALUES(10924);
INSERT INTO `yman_sequence` VALUES(10925);
INSERT INTO `yman_sequence` VALUES(10926);
INSERT INTO `yman_sequence` VALUES(10927);
INSERT INTO `yman_sequence` VALUES(10928);
INSERT INTO `yman_sequence` VALUES(10929);
INSERT INTO `yman_sequence` VALUES(10930);
INSERT INTO `yman_sequence` VALUES(10931);
INSERT INTO `yman_sequence` VALUES(10932);
INSERT INTO `yman_sequence` VALUES(10933);
INSERT INTO `yman_sequence` VALUES(10934);
INSERT INTO `yman_sequence` VALUES(10935);
INSERT INTO `yman_sequence` VALUES(10936);
INSERT INTO `yman_sequence` VALUES(10937);
INSERT INTO `yman_sequence` VALUES(10938);
INSERT INTO `yman_sequence` VALUES(10939);
INSERT INTO `yman_sequence` VALUES(10940);
INSERT INTO `yman_sequence` VALUES(10941);
INSERT INTO `yman_sequence` VALUES(10942);
INSERT INTO `yman_sequence` VALUES(10943);
INSERT INTO `yman_sequence` VALUES(10944);
INSERT INTO `yman_sequence` VALUES(10945);
INSERT INTO `yman_sequence` VALUES(10946);
INSERT INTO `yman_sequence` VALUES(10947);
INSERT INTO `yman_sequence` VALUES(10948);
INSERT INTO `yman_sequence` VALUES(10949);
INSERT INTO `yman_sequence` VALUES(10950);
INSERT INTO `yman_sequence` VALUES(10951);
INSERT INTO `yman_sequence` VALUES(10952);
INSERT INTO `yman_sequence` VALUES(10953);
INSERT INTO `yman_sequence` VALUES(10954);
INSERT INTO `yman_sequence` VALUES(10955);
INSERT INTO `yman_sequence` VALUES(10956);
INSERT INTO `yman_sequence` VALUES(10957);
INSERT INTO `yman_sequence` VALUES(10958);
INSERT INTO `yman_sequence` VALUES(10959);
INSERT INTO `yman_sequence` VALUES(10960);
INSERT INTO `yman_sequence` VALUES(10961);
INSERT INTO `yman_sequence` VALUES(10962);
INSERT INTO `yman_sequence` VALUES(10963);
INSERT INTO `yman_sequence` VALUES(10964);
INSERT INTO `yman_sequence` VALUES(10965);
INSERT INTO `yman_sequence` VALUES(10966);
INSERT INTO `yman_sequence` VALUES(10967);
INSERT INTO `yman_sequence` VALUES(10968);
INSERT INTO `yman_sequence` VALUES(10969);
INSERT INTO `yman_sequence` VALUES(10970);
INSERT INTO `yman_sequence` VALUES(10971);
INSERT INTO `yman_sequence` VALUES(10972);
INSERT INTO `yman_sequence` VALUES(10973);
INSERT INTO `yman_sequence` VALUES(10974);
INSERT INTO `yman_sequence` VALUES(10975);
INSERT INTO `yman_sequence` VALUES(10976);
INSERT INTO `yman_sequence` VALUES(10977);
INSERT INTO `yman_sequence` VALUES(10978);
INSERT INTO `yman_sequence` VALUES(10979);
INSERT INTO `yman_sequence` VALUES(10980);
INSERT INTO `yman_sequence` VALUES(10981);
INSERT INTO `yman_sequence` VALUES(10982);
INSERT INTO `yman_sequence` VALUES(10983);
INSERT INTO `yman_sequence` VALUES(10984);
INSERT INTO `yman_sequence` VALUES(10985);
INSERT INTO `yman_sequence` VALUES(10986);
INSERT INTO `yman_sequence` VALUES(10987);
INSERT INTO `yman_sequence` VALUES(10988);
INSERT INTO `yman_sequence` VALUES(10989);
INSERT INTO `yman_sequence` VALUES(10990);
INSERT INTO `yman_sequence` VALUES(10991);
INSERT INTO `yman_sequence` VALUES(10992);
INSERT INTO `yman_sequence` VALUES(10993);
INSERT INTO `yman_sequence` VALUES(10994);
INSERT INTO `yman_sequence` VALUES(10995);
INSERT INTO `yman_sequence` VALUES(10996);
INSERT INTO `yman_sequence` VALUES(10997);
INSERT INTO `yman_sequence` VALUES(10998);
INSERT INTO `yman_sequence` VALUES(10999);
INSERT INTO `yman_sequence` VALUES(11000);
INSERT INTO `yman_sequence` VALUES(11001);
INSERT INTO `yman_sequence` VALUES(11002);
INSERT INTO `yman_sequence` VALUES(11003);
INSERT INTO `yman_sequence` VALUES(11004);
INSERT INTO `yman_sequence` VALUES(11005);
INSERT INTO `yman_sequence` VALUES(11006);
INSERT INTO `yman_sequence` VALUES(11007);
INSERT INTO `yman_sequence` VALUES(11008);
INSERT INTO `yman_sequence` VALUES(11009);
INSERT INTO `yman_sequence` VALUES(11010);
INSERT INTO `yman_sequence` VALUES(11011);
INSERT INTO `yman_sequence` VALUES(11012);
INSERT INTO `yman_sequence` VALUES(11013);
INSERT INTO `yman_sequence` VALUES(11014);
INSERT INTO `yman_sequence` VALUES(11015);
INSERT INTO `yman_sequence` VALUES(11016);
INSERT INTO `yman_sequence` VALUES(11017);
INSERT INTO `yman_sequence` VALUES(11018);
INSERT INTO `yman_sequence` VALUES(11019);
INSERT INTO `yman_sequence` VALUES(11020);
INSERT INTO `yman_sequence` VALUES(11021);
INSERT INTO `yman_sequence` VALUES(11022);
INSERT INTO `yman_sequence` VALUES(11023);
INSERT INTO `yman_sequence` VALUES(11024);
INSERT INTO `yman_sequence` VALUES(11025);
INSERT INTO `yman_sequence` VALUES(11026);
INSERT INTO `yman_sequence` VALUES(11027);
INSERT INTO `yman_sequence` VALUES(11028);
INSERT INTO `yman_sequence` VALUES(11029);
INSERT INTO `yman_sequence` VALUES(11030);
INSERT INTO `yman_sequence` VALUES(11031);
INSERT INTO `yman_sequence` VALUES(11032);
INSERT INTO `yman_sequence` VALUES(11033);
INSERT INTO `yman_sequence` VALUES(11034);
INSERT INTO `yman_sequence` VALUES(11035);
INSERT INTO `yman_sequence` VALUES(11036);
INSERT INTO `yman_sequence` VALUES(11037);
INSERT INTO `yman_sequence` VALUES(11038);
INSERT INTO `yman_sequence` VALUES(11039);
INSERT INTO `yman_sequence` VALUES(11040);
INSERT INTO `yman_sequence` VALUES(11041);
INSERT INTO `yman_sequence` VALUES(11042);
INSERT INTO `yman_sequence` VALUES(11043);
INSERT INTO `yman_sequence` VALUES(11044);
INSERT INTO `yman_sequence` VALUES(11045);
INSERT INTO `yman_sequence` VALUES(11046);
INSERT INTO `yman_sequence` VALUES(11047);
INSERT INTO `yman_sequence` VALUES(11048);
INSERT INTO `yman_sequence` VALUES(11049);
INSERT INTO `yman_sequence` VALUES(11050);
INSERT INTO `yman_sequence` VALUES(11051);
INSERT INTO `yman_sequence` VALUES(11052);
INSERT INTO `yman_sequence` VALUES(11053);
INSERT INTO `yman_sequence` VALUES(11054);
INSERT INTO `yman_sequence` VALUES(11055);
INSERT INTO `yman_sequence` VALUES(11056);
INSERT INTO `yman_sequence` VALUES(11057);
INSERT INTO `yman_sequence` VALUES(11058);
INSERT INTO `yman_sequence` VALUES(11059);
INSERT INTO `yman_sequence` VALUES(11060);
INSERT INTO `yman_sequence` VALUES(11061);
INSERT INTO `yman_sequence` VALUES(11062);
INSERT INTO `yman_sequence` VALUES(11063);
INSERT INTO `yman_sequence` VALUES(11064);
INSERT INTO `yman_sequence` VALUES(11065);
INSERT INTO `yman_sequence` VALUES(11066);
INSERT INTO `yman_sequence` VALUES(11067);
INSERT INTO `yman_sequence` VALUES(11068);
INSERT INTO `yman_sequence` VALUES(11069);
INSERT INTO `yman_sequence` VALUES(11070);
INSERT INTO `yman_sequence` VALUES(11071);
INSERT INTO `yman_sequence` VALUES(11072);
INSERT INTO `yman_sequence` VALUES(11073);
INSERT INTO `yman_sequence` VALUES(11074);
INSERT INTO `yman_sequence` VALUES(11075);
INSERT INTO `yman_sequence` VALUES(11076);
INSERT INTO `yman_sequence` VALUES(11077);
INSERT INTO `yman_sequence` VALUES(11078);
INSERT INTO `yman_sequence` VALUES(11079);
INSERT INTO `yman_sequence` VALUES(11080);
INSERT INTO `yman_sequence` VALUES(11081);
INSERT INTO `yman_sequence` VALUES(11082);
INSERT INTO `yman_sequence` VALUES(11083);
INSERT INTO `yman_sequence` VALUES(11084);
INSERT INTO `yman_sequence` VALUES(11085);
INSERT INTO `yman_sequence` VALUES(11086);
INSERT INTO `yman_sequence` VALUES(11087);
INSERT INTO `yman_sequence` VALUES(11088);
INSERT INTO `yman_sequence` VALUES(11089);
INSERT INTO `yman_sequence` VALUES(11090);
INSERT INTO `yman_sequence` VALUES(11091);
INSERT INTO `yman_sequence` VALUES(11092);
INSERT INTO `yman_sequence` VALUES(11093);
INSERT INTO `yman_sequence` VALUES(11094);
INSERT INTO `yman_sequence` VALUES(11095);
INSERT INTO `yman_sequence` VALUES(11096);
INSERT INTO `yman_sequence` VALUES(11097);
INSERT INTO `yman_sequence` VALUES(11098);
INSERT INTO `yman_sequence` VALUES(11099);
INSERT INTO `yman_sequence` VALUES(11100);
INSERT INTO `yman_sequence` VALUES(11101);
INSERT INTO `yman_sequence` VALUES(11102);
INSERT INTO `yman_sequence` VALUES(11103);
INSERT INTO `yman_sequence` VALUES(11104);
INSERT INTO `yman_sequence` VALUES(11105);
INSERT INTO `yman_sequence` VALUES(11106);
INSERT INTO `yman_sequence` VALUES(11107);
INSERT INTO `yman_sequence` VALUES(11108);
INSERT INTO `yman_sequence` VALUES(11109);
INSERT INTO `yman_sequence` VALUES(11110);
INSERT INTO `yman_sequence` VALUES(11111);
INSERT INTO `yman_sequence` VALUES(11112);
INSERT INTO `yman_sequence` VALUES(11113);
INSERT INTO `yman_sequence` VALUES(11114);
INSERT INTO `yman_sequence` VALUES(11115);
INSERT INTO `yman_sequence` VALUES(11116);
INSERT INTO `yman_sequence` VALUES(11117);
INSERT INTO `yman_sequence` VALUES(11118);
INSERT INTO `yman_sequence` VALUES(11119);
INSERT INTO `yman_sequence` VALUES(11120);
INSERT INTO `yman_sequence` VALUES(11121);
INSERT INTO `yman_sequence` VALUES(11122);
INSERT INTO `yman_sequence` VALUES(11123);
INSERT INTO `yman_sequence` VALUES(11124);
INSERT INTO `yman_sequence` VALUES(11125);
INSERT INTO `yman_sequence` VALUES(11126);
INSERT INTO `yman_sequence` VALUES(11127);
INSERT INTO `yman_sequence` VALUES(11128);
INSERT INTO `yman_sequence` VALUES(11129);
INSERT INTO `yman_sequence` VALUES(11130);
INSERT INTO `yman_sequence` VALUES(11131);
INSERT INTO `yman_sequence` VALUES(11132);
INSERT INTO `yman_sequence` VALUES(11133);
INSERT INTO `yman_sequence` VALUES(11134);
INSERT INTO `yman_sequence` VALUES(11135);
INSERT INTO `yman_sequence` VALUES(11136);
INSERT INTO `yman_sequence` VALUES(11137);
INSERT INTO `yman_sequence` VALUES(11138);
INSERT INTO `yman_sequence` VALUES(11139);
INSERT INTO `yman_sequence` VALUES(11140);
INSERT INTO `yman_sequence` VALUES(11141);
INSERT INTO `yman_sequence` VALUES(11142);
INSERT INTO `yman_sequence` VALUES(11143);
INSERT INTO `yman_sequence` VALUES(11144);
INSERT INTO `yman_sequence` VALUES(11145);
INSERT INTO `yman_sequence` VALUES(11146);
INSERT INTO `yman_sequence` VALUES(11147);
INSERT INTO `yman_sequence` VALUES(11148);
INSERT INTO `yman_sequence` VALUES(11149);
INSERT INTO `yman_sequence` VALUES(11150);
INSERT INTO `yman_sequence` VALUES(11151);
INSERT INTO `yman_sequence` VALUES(11152);
INSERT INTO `yman_sequence` VALUES(11153);
INSERT INTO `yman_sequence` VALUES(11154);
INSERT INTO `yman_sequence` VALUES(11155);
INSERT INTO `yman_sequence` VALUES(11156);
INSERT INTO `yman_sequence` VALUES(11157);
INSERT INTO `yman_sequence` VALUES(11158);
INSERT INTO `yman_sequence` VALUES(11159);
INSERT INTO `yman_sequence` VALUES(11160);
INSERT INTO `yman_sequence` VALUES(11161);
INSERT INTO `yman_sequence` VALUES(11162);
INSERT INTO `yman_sequence` VALUES(11163);
INSERT INTO `yman_sequence` VALUES(11164);
INSERT INTO `yman_sequence` VALUES(11165);
INSERT INTO `yman_sequence` VALUES(11166);
INSERT INTO `yman_sequence` VALUES(11167);
INSERT INTO `yman_sequence` VALUES(11168);
INSERT INTO `yman_sequence` VALUES(11169);
INSERT INTO `yman_sequence` VALUES(11170);
INSERT INTO `yman_sequence` VALUES(11171);
INSERT INTO `yman_sequence` VALUES(11172);
INSERT INTO `yman_sequence` VALUES(11173);
INSERT INTO `yman_sequence` VALUES(11174);
INSERT INTO `yman_sequence` VALUES(11175);
INSERT INTO `yman_sequence` VALUES(11176);
INSERT INTO `yman_sequence` VALUES(11177);
INSERT INTO `yman_sequence` VALUES(11178);
INSERT INTO `yman_sequence` VALUES(11179);
INSERT INTO `yman_sequence` VALUES(11180);
INSERT INTO `yman_sequence` VALUES(11181);
INSERT INTO `yman_sequence` VALUES(11182);
INSERT INTO `yman_sequence` VALUES(11183);
INSERT INTO `yman_sequence` VALUES(11184);
INSERT INTO `yman_sequence` VALUES(11185);
INSERT INTO `yman_sequence` VALUES(11186);
INSERT INTO `yman_sequence` VALUES(11187);
INSERT INTO `yman_sequence` VALUES(11188);
INSERT INTO `yman_sequence` VALUES(11189);
INSERT INTO `yman_sequence` VALUES(11190);
INSERT INTO `yman_sequence` VALUES(11191);
INSERT INTO `yman_sequence` VALUES(11192);
INSERT INTO `yman_sequence` VALUES(11193);
INSERT INTO `yman_sequence` VALUES(11194);
INSERT INTO `yman_sequence` VALUES(11195);
INSERT INTO `yman_sequence` VALUES(11196);
INSERT INTO `yman_sequence` VALUES(11197);
INSERT INTO `yman_sequence` VALUES(11198);
INSERT INTO `yman_sequence` VALUES(11199);
INSERT INTO `yman_sequence` VALUES(11200);
INSERT INTO `yman_sequence` VALUES(11201);
INSERT INTO `yman_sequence` VALUES(11202);
INSERT INTO `yman_sequence` VALUES(11203);
INSERT INTO `yman_sequence` VALUES(11204);
INSERT INTO `yman_sequence` VALUES(11205);
INSERT INTO `yman_sequence` VALUES(11206);
INSERT INTO `yman_sequence` VALUES(11207);
INSERT INTO `yman_sequence` VALUES(11208);
INSERT INTO `yman_sequence` VALUES(11209);
INSERT INTO `yman_sequence` VALUES(11210);
INSERT INTO `yman_sequence` VALUES(11211);
INSERT INTO `yman_sequence` VALUES(11212);
INSERT INTO `yman_sequence` VALUES(11213);
INSERT INTO `yman_sequence` VALUES(11214);
INSERT INTO `yman_sequence` VALUES(11215);
INSERT INTO `yman_sequence` VALUES(11216);
INSERT INTO `yman_sequence` VALUES(11217);
INSERT INTO `yman_sequence` VALUES(11218);
INSERT INTO `yman_sequence` VALUES(11219);
INSERT INTO `yman_sequence` VALUES(11220);
INSERT INTO `yman_sequence` VALUES(11221);
INSERT INTO `yman_sequence` VALUES(11222);
INSERT INTO `yman_sequence` VALUES(11223);
INSERT INTO `yman_sequence` VALUES(11224);
INSERT INTO `yman_sequence` VALUES(11225);
INSERT INTO `yman_sequence` VALUES(11226);
INSERT INTO `yman_sequence` VALUES(11227);
INSERT INTO `yman_sequence` VALUES(11228);
INSERT INTO `yman_sequence` VALUES(11229);
INSERT INTO `yman_sequence` VALUES(11230);
INSERT INTO `yman_sequence` VALUES(11231);
INSERT INTO `yman_sequence` VALUES(11232);
INSERT INTO `yman_sequence` VALUES(11233);
INSERT INTO `yman_sequence` VALUES(11234);
INSERT INTO `yman_sequence` VALUES(11235);
INSERT INTO `yman_sequence` VALUES(11236);
INSERT INTO `yman_sequence` VALUES(11237);
INSERT INTO `yman_sequence` VALUES(11238);
INSERT INTO `yman_sequence` VALUES(11239);
INSERT INTO `yman_sequence` VALUES(11240);
INSERT INTO `yman_sequence` VALUES(11241);
INSERT INTO `yman_sequence` VALUES(11242);
INSERT INTO `yman_sequence` VALUES(11243);
INSERT INTO `yman_sequence` VALUES(11244);
INSERT INTO `yman_sequence` VALUES(11245);
INSERT INTO `yman_sequence` VALUES(11246);
INSERT INTO `yman_sequence` VALUES(11247);
INSERT INTO `yman_sequence` VALUES(11248);
INSERT INTO `yman_sequence` VALUES(11249);
INSERT INTO `yman_sequence` VALUES(11250);
INSERT INTO `yman_sequence` VALUES(11251);
INSERT INTO `yman_sequence` VALUES(11252);
INSERT INTO `yman_sequence` VALUES(11253);
INSERT INTO `yman_sequence` VALUES(11254);
INSERT INTO `yman_sequence` VALUES(11255);
INSERT INTO `yman_sequence` VALUES(11256);
INSERT INTO `yman_sequence` VALUES(11257);
INSERT INTO `yman_sequence` VALUES(11258);
INSERT INTO `yman_sequence` VALUES(11259);
INSERT INTO `yman_sequence` VALUES(11260);
INSERT INTO `yman_sequence` VALUES(11261);
INSERT INTO `yman_sequence` VALUES(11262);
INSERT INTO `yman_sequence` VALUES(11263);
INSERT INTO `yman_sequence` VALUES(11264);
INSERT INTO `yman_sequence` VALUES(11265);
INSERT INTO `yman_sequence` VALUES(11266);
INSERT INTO `yman_sequence` VALUES(11267);
INSERT INTO `yman_sequence` VALUES(11268);
INSERT INTO `yman_sequence` VALUES(11269);
INSERT INTO `yman_sequence` VALUES(11270);
INSERT INTO `yman_sequence` VALUES(11271);
INSERT INTO `yman_sequence` VALUES(11272);
INSERT INTO `yman_sequence` VALUES(11273);
INSERT INTO `yman_sequence` VALUES(11274);
INSERT INTO `yman_sequence` VALUES(11275);
INSERT INTO `yman_sequence` VALUES(11276);
INSERT INTO `yman_sequence` VALUES(11277);
INSERT INTO `yman_sequence` VALUES(11278);
INSERT INTO `yman_sequence` VALUES(11279);
INSERT INTO `yman_sequence` VALUES(11280);
INSERT INTO `yman_sequence` VALUES(11281);
INSERT INTO `yman_sequence` VALUES(11282);
INSERT INTO `yman_sequence` VALUES(11283);
INSERT INTO `yman_sequence` VALUES(11284);
INSERT INTO `yman_sequence` VALUES(11285);
INSERT INTO `yman_sequence` VALUES(11286);
INSERT INTO `yman_sequence` VALUES(11287);
INSERT INTO `yman_sequence` VALUES(11288);
INSERT INTO `yman_sequence` VALUES(11289);
INSERT INTO `yman_sequence` VALUES(11290);
INSERT INTO `yman_sequence` VALUES(11291);
INSERT INTO `yman_sequence` VALUES(11292);
INSERT INTO `yman_sequence` VALUES(11293);
INSERT INTO `yman_sequence` VALUES(11294);
INSERT INTO `yman_sequence` VALUES(11295);
INSERT INTO `yman_sequence` VALUES(11296);
INSERT INTO `yman_sequence` VALUES(11297);
INSERT INTO `yman_sequence` VALUES(11298);
INSERT INTO `yman_sequence` VALUES(11299);
INSERT INTO `yman_sequence` VALUES(11300);
INSERT INTO `yman_sequence` VALUES(11301);
INSERT INTO `yman_sequence` VALUES(11302);
INSERT INTO `yman_sequence` VALUES(11303);
INSERT INTO `yman_sequence` VALUES(11304);
INSERT INTO `yman_sequence` VALUES(11305);
INSERT INTO `yman_sequence` VALUES(11306);
INSERT INTO `yman_sequence` VALUES(11307);
INSERT INTO `yman_sequence` VALUES(11308);
INSERT INTO `yman_sequence` VALUES(11309);
INSERT INTO `yman_sequence` VALUES(11310);
INSERT INTO `yman_sequence` VALUES(11311);
INSERT INTO `yman_sequence` VALUES(11312);
INSERT INTO `yman_sequence` VALUES(11313);
INSERT INTO `yman_sequence` VALUES(11314);
INSERT INTO `yman_sequence` VALUES(11315);
INSERT INTO `yman_sequence` VALUES(11316);
INSERT INTO `yman_sequence` VALUES(11317);
INSERT INTO `yman_sequence` VALUES(11318);
INSERT INTO `yman_sequence` VALUES(11319);
INSERT INTO `yman_sequence` VALUES(11320);
INSERT INTO `yman_sequence` VALUES(11321);
INSERT INTO `yman_sequence` VALUES(11322);
INSERT INTO `yman_sequence` VALUES(11323);
INSERT INTO `yman_sequence` VALUES(11324);
INSERT INTO `yman_sequence` VALUES(11325);
INSERT INTO `yman_sequence` VALUES(11326);
INSERT INTO `yman_sequence` VALUES(11327);
INSERT INTO `yman_sequence` VALUES(11328);
INSERT INTO `yman_sequence` VALUES(11329);
INSERT INTO `yman_sequence` VALUES(11330);
INSERT INTO `yman_sequence` VALUES(11331);
INSERT INTO `yman_sequence` VALUES(11332);
INSERT INTO `yman_sequence` VALUES(11333);
INSERT INTO `yman_sequence` VALUES(11334);
INSERT INTO `yman_sequence` VALUES(11335);
INSERT INTO `yman_sequence` VALUES(11336);
INSERT INTO `yman_sequence` VALUES(11337);
INSERT INTO `yman_sequence` VALUES(11338);
INSERT INTO `yman_sequence` VALUES(11339);
INSERT INTO `yman_sequence` VALUES(11340);
INSERT INTO `yman_sequence` VALUES(11341);
INSERT INTO `yman_sequence` VALUES(11342);
INSERT INTO `yman_sequence` VALUES(11343);
INSERT INTO `yman_sequence` VALUES(11344);
INSERT INTO `yman_sequence` VALUES(11345);
INSERT INTO `yman_sequence` VALUES(11346);
INSERT INTO `yman_sequence` VALUES(11347);
INSERT INTO `yman_sequence` VALUES(11348);
INSERT INTO `yman_sequence` VALUES(11349);
INSERT INTO `yman_sequence` VALUES(11350);
INSERT INTO `yman_sequence` VALUES(11351);
INSERT INTO `yman_sequence` VALUES(11352);
INSERT INTO `yman_sequence` VALUES(11353);
INSERT INTO `yman_sequence` VALUES(11354);
INSERT INTO `yman_sequence` VALUES(11355);
INSERT INTO `yman_sequence` VALUES(11356);
INSERT INTO `yman_sequence` VALUES(11357);
INSERT INTO `yman_sequence` VALUES(11358);
INSERT INTO `yman_sequence` VALUES(11359);
INSERT INTO `yman_sequence` VALUES(11360);
INSERT INTO `yman_sequence` VALUES(11361);
INSERT INTO `yman_sequence` VALUES(11362);
INSERT INTO `yman_sequence` VALUES(11363);
INSERT INTO `yman_sequence` VALUES(11364);
INSERT INTO `yman_sequence` VALUES(11365);
INSERT INTO `yman_sequence` VALUES(11366);
INSERT INTO `yman_sequence` VALUES(11367);
INSERT INTO `yman_sequence` VALUES(11368);
INSERT INTO `yman_sequence` VALUES(11369);
INSERT INTO `yman_sequence` VALUES(11370);
INSERT INTO `yman_sequence` VALUES(11371);
INSERT INTO `yman_sequence` VALUES(11372);
INSERT INTO `yman_sequence` VALUES(11373);
INSERT INTO `yman_sequence` VALUES(11374);
INSERT INTO `yman_sequence` VALUES(11375);
INSERT INTO `yman_sequence` VALUES(11376);
INSERT INTO `yman_sequence` VALUES(11377);
INSERT INTO `yman_sequence` VALUES(11378);
INSERT INTO `yman_sequence` VALUES(11379);
INSERT INTO `yman_sequence` VALUES(11380);
INSERT INTO `yman_sequence` VALUES(11381);
INSERT INTO `yman_sequence` VALUES(11382);
INSERT INTO `yman_sequence` VALUES(11383);
INSERT INTO `yman_sequence` VALUES(11384);
INSERT INTO `yman_sequence` VALUES(11385);
INSERT INTO `yman_sequence` VALUES(11386);
INSERT INTO `yman_sequence` VALUES(11387);
INSERT INTO `yman_sequence` VALUES(11388);
INSERT INTO `yman_sequence` VALUES(11389);
INSERT INTO `yman_sequence` VALUES(11390);
INSERT INTO `yman_sequence` VALUES(11391);
INSERT INTO `yman_sequence` VALUES(11392);
INSERT INTO `yman_sequence` VALUES(11393);
INSERT INTO `yman_sequence` VALUES(11394);
INSERT INTO `yman_sequence` VALUES(11395);
INSERT INTO `yman_sequence` VALUES(11396);
INSERT INTO `yman_sequence` VALUES(11397);
INSERT INTO `yman_sequence` VALUES(11398);
INSERT INTO `yman_sequence` VALUES(11399);
INSERT INTO `yman_sequence` VALUES(11400);
INSERT INTO `yman_sequence` VALUES(11401);
INSERT INTO `yman_sequence` VALUES(11402);
INSERT INTO `yman_sequence` VALUES(11403);
INSERT INTO `yman_sequence` VALUES(11404);
INSERT INTO `yman_sequence` VALUES(11405);
INSERT INTO `yman_sequence` VALUES(11406);
INSERT INTO `yman_sequence` VALUES(11407);
INSERT INTO `yman_sequence` VALUES(11408);
INSERT INTO `yman_sequence` VALUES(11409);
INSERT INTO `yman_sequence` VALUES(11410);
INSERT INTO `yman_sequence` VALUES(11411);
INSERT INTO `yman_sequence` VALUES(11412);
INSERT INTO `yman_sequence` VALUES(11413);
INSERT INTO `yman_sequence` VALUES(11414);
INSERT INTO `yman_sequence` VALUES(11415);
INSERT INTO `yman_sequence` VALUES(11416);
INSERT INTO `yman_sequence` VALUES(11417);
INSERT INTO `yman_sequence` VALUES(11418);
INSERT INTO `yman_sequence` VALUES(11419);
INSERT INTO `yman_sequence` VALUES(11420);
INSERT INTO `yman_sequence` VALUES(11421);
INSERT INTO `yman_sequence` VALUES(11422);
INSERT INTO `yman_sequence` VALUES(11423);
INSERT INTO `yman_sequence` VALUES(11424);
INSERT INTO `yman_sequence` VALUES(11425);
INSERT INTO `yman_sequence` VALUES(11426);
INSERT INTO `yman_sequence` VALUES(11427);
INSERT INTO `yman_sequence` VALUES(11428);
INSERT INTO `yman_sequence` VALUES(11429);
INSERT INTO `yman_sequence` VALUES(11430);
INSERT INTO `yman_sequence` VALUES(11431);
INSERT INTO `yman_sequence` VALUES(11432);
INSERT INTO `yman_sequence` VALUES(11433);
INSERT INTO `yman_sequence` VALUES(11434);
INSERT INTO `yman_sequence` VALUES(11435);
INSERT INTO `yman_sequence` VALUES(11436);
INSERT INTO `yman_sequence` VALUES(11437);
INSERT INTO `yman_sequence` VALUES(11438);
INSERT INTO `yman_sequence` VALUES(11439);
INSERT INTO `yman_sequence` VALUES(11440);
INSERT INTO `yman_sequence` VALUES(11441);
INSERT INTO `yman_sequence` VALUES(11442);
INSERT INTO `yman_sequence` VALUES(11443);
INSERT INTO `yman_sequence` VALUES(11444);
INSERT INTO `yman_sequence` VALUES(11445);
INSERT INTO `yman_sequence` VALUES(11446);
INSERT INTO `yman_sequence` VALUES(11447);
INSERT INTO `yman_sequence` VALUES(11448);
INSERT INTO `yman_sequence` VALUES(11449);
INSERT INTO `yman_sequence` VALUES(11450);
INSERT INTO `yman_sequence` VALUES(11451);
INSERT INTO `yman_sequence` VALUES(11452);
INSERT INTO `yman_sequence` VALUES(11453);
INSERT INTO `yman_sequence` VALUES(11454);
INSERT INTO `yman_sequence` VALUES(11455);
INSERT INTO `yman_sequence` VALUES(11456);
INSERT INTO `yman_sequence` VALUES(11457);
INSERT INTO `yman_sequence` VALUES(11458);
INSERT INTO `yman_sequence` VALUES(11459);
INSERT INTO `yman_sequence` VALUES(11460);
INSERT INTO `yman_sequence` VALUES(11461);
INSERT INTO `yman_sequence` VALUES(11462);
INSERT INTO `yman_sequence` VALUES(11463);
INSERT INTO `yman_sequence` VALUES(11464);
INSERT INTO `yman_sequence` VALUES(11465);
INSERT INTO `yman_sequence` VALUES(11466);
INSERT INTO `yman_sequence` VALUES(11467);
INSERT INTO `yman_sequence` VALUES(11468);
INSERT INTO `yman_sequence` VALUES(11469);
INSERT INTO `yman_sequence` VALUES(11470);
INSERT INTO `yman_sequence` VALUES(11471);
INSERT INTO `yman_sequence` VALUES(11472);
INSERT INTO `yman_sequence` VALUES(11473);
INSERT INTO `yman_sequence` VALUES(11474);
INSERT INTO `yman_sequence` VALUES(11475);
INSERT INTO `yman_sequence` VALUES(11476);
INSERT INTO `yman_sequence` VALUES(11477);
INSERT INTO `yman_sequence` VALUES(11478);
INSERT INTO `yman_sequence` VALUES(11479);
INSERT INTO `yman_sequence` VALUES(11480);
INSERT INTO `yman_sequence` VALUES(11481);
INSERT INTO `yman_sequence` VALUES(11482);
INSERT INTO `yman_sequence` VALUES(11483);
INSERT INTO `yman_sequence` VALUES(11484);
INSERT INTO `yman_sequence` VALUES(11485);
INSERT INTO `yman_sequence` VALUES(11486);
INSERT INTO `yman_sequence` VALUES(11487);
INSERT INTO `yman_sequence` VALUES(11488);
INSERT INTO `yman_sequence` VALUES(11489);
INSERT INTO `yman_sequence` VALUES(11490);
INSERT INTO `yman_sequence` VALUES(11491);
INSERT INTO `yman_sequence` VALUES(11492);
INSERT INTO `yman_sequence` VALUES(11493);
INSERT INTO `yman_sequence` VALUES(11494);
INSERT INTO `yman_sequence` VALUES(11495);
INSERT INTO `yman_sequence` VALUES(11496);
INSERT INTO `yman_sequence` VALUES(11497);
INSERT INTO `yman_sequence` VALUES(11498);
INSERT INTO `yman_sequence` VALUES(11499);
INSERT INTO `yman_sequence` VALUES(11500);
INSERT INTO `yman_sequence` VALUES(11501);
INSERT INTO `yman_sequence` VALUES(11502);
INSERT INTO `yman_sequence` VALUES(11503);
INSERT INTO `yman_sequence` VALUES(11504);
INSERT INTO `yman_sequence` VALUES(11505);
INSERT INTO `yman_sequence` VALUES(11506);
INSERT INTO `yman_sequence` VALUES(11507);
INSERT INTO `yman_sequence` VALUES(11508);
INSERT INTO `yman_sequence` VALUES(11509);
INSERT INTO `yman_sequence` VALUES(11510);
INSERT INTO `yman_sequence` VALUES(11511);
INSERT INTO `yman_sequence` VALUES(11512);
INSERT INTO `yman_sequence` VALUES(11513);
INSERT INTO `yman_sequence` VALUES(11514);
INSERT INTO `yman_sequence` VALUES(11515);
INSERT INTO `yman_sequence` VALUES(11516);
INSERT INTO `yman_sequence` VALUES(11517);
INSERT INTO `yman_sequence` VALUES(11518);
INSERT INTO `yman_sequence` VALUES(11519);
INSERT INTO `yman_sequence` VALUES(11520);
INSERT INTO `yman_sequence` VALUES(11521);
INSERT INTO `yman_sequence` VALUES(11522);
INSERT INTO `yman_sequence` VALUES(11523);
INSERT INTO `yman_sequence` VALUES(11524);
INSERT INTO `yman_sequence` VALUES(11525);
INSERT INTO `yman_sequence` VALUES(11526);
INSERT INTO `yman_sequence` VALUES(11527);
INSERT INTO `yman_sequence` VALUES(11528);
INSERT INTO `yman_sequence` VALUES(11529);
INSERT INTO `yman_sequence` VALUES(11530);
INSERT INTO `yman_sequence` VALUES(11531);
INSERT INTO `yman_sequence` VALUES(11532);
INSERT INTO `yman_sequence` VALUES(11533);
INSERT INTO `yman_sequence` VALUES(11534);
INSERT INTO `yman_sequence` VALUES(11535);
INSERT INTO `yman_sequence` VALUES(11536);
INSERT INTO `yman_sequence` VALUES(11537);
INSERT INTO `yman_sequence` VALUES(11538);
INSERT INTO `yman_sequence` VALUES(11539);
INSERT INTO `yman_sequence` VALUES(11540);
INSERT INTO `yman_sequence` VALUES(11541);
INSERT INTO `yman_sequence` VALUES(11542);
INSERT INTO `yman_sequence` VALUES(11543);
INSERT INTO `yman_sequence` VALUES(11544);
INSERT INTO `yman_sequence` VALUES(11545);
INSERT INTO `yman_sequence` VALUES(11546);
INSERT INTO `yman_sequence` VALUES(11547);
INSERT INTO `yman_sequence` VALUES(11548);
INSERT INTO `yman_sequence` VALUES(11549);
INSERT INTO `yman_sequence` VALUES(11550);
INSERT INTO `yman_sequence` VALUES(11551);
INSERT INTO `yman_sequence` VALUES(11552);
INSERT INTO `yman_sequence` VALUES(11553);
INSERT INTO `yman_sequence` VALUES(11554);
INSERT INTO `yman_sequence` VALUES(11555);
INSERT INTO `yman_sequence` VALUES(11556);
INSERT INTO `yman_sequence` VALUES(11557);
INSERT INTO `yman_sequence` VALUES(11558);
INSERT INTO `yman_sequence` VALUES(11559);
INSERT INTO `yman_sequence` VALUES(11560);
INSERT INTO `yman_sequence` VALUES(11561);
INSERT INTO `yman_sequence` VALUES(11562);
INSERT INTO `yman_sequence` VALUES(11563);
INSERT INTO `yman_sequence` VALUES(11564);
INSERT INTO `yman_sequence` VALUES(11565);
INSERT INTO `yman_sequence` VALUES(11566);
INSERT INTO `yman_sequence` VALUES(11567);
INSERT INTO `yman_sequence` VALUES(11568);
INSERT INTO `yman_sequence` VALUES(11569);
INSERT INTO `yman_sequence` VALUES(11570);
INSERT INTO `yman_sequence` VALUES(11571);
INSERT INTO `yman_sequence` VALUES(11572);
INSERT INTO `yman_sequence` VALUES(11573);
INSERT INTO `yman_sequence` VALUES(11574);
INSERT INTO `yman_sequence` VALUES(11575);
INSERT INTO `yman_sequence` VALUES(11576);
INSERT INTO `yman_sequence` VALUES(11577);
INSERT INTO `yman_sequence` VALUES(11578);
INSERT INTO `yman_sequence` VALUES(11579);
INSERT INTO `yman_sequence` VALUES(11580);
INSERT INTO `yman_sequence` VALUES(11581);
INSERT INTO `yman_sequence` VALUES(11582);
INSERT INTO `yman_sequence` VALUES(11583);
INSERT INTO `yman_sequence` VALUES(11584);
INSERT INTO `yman_sequence` VALUES(11585);
INSERT INTO `yman_sequence` VALUES(11586);
INSERT INTO `yman_sequence` VALUES(11587);
INSERT INTO `yman_sequence` VALUES(11588);
INSERT INTO `yman_sequence` VALUES(11589);
INSERT INTO `yman_sequence` VALUES(11590);
INSERT INTO `yman_sequence` VALUES(11591);
INSERT INTO `yman_sequence` VALUES(11592);
INSERT INTO `yman_sequence` VALUES(11593);
INSERT INTO `yman_sequence` VALUES(11594);
INSERT INTO `yman_sequence` VALUES(11595);
INSERT INTO `yman_sequence` VALUES(11596);
INSERT INTO `yman_sequence` VALUES(11597);
INSERT INTO `yman_sequence` VALUES(11598);
INSERT INTO `yman_sequence` VALUES(11599);
INSERT INTO `yman_sequence` VALUES(11600);
INSERT INTO `yman_sequence` VALUES(11601);
INSERT INTO `yman_sequence` VALUES(11602);
INSERT INTO `yman_sequence` VALUES(11603);
INSERT INTO `yman_sequence` VALUES(11604);
INSERT INTO `yman_sequence` VALUES(11605);
INSERT INTO `yman_sequence` VALUES(11606);
INSERT INTO `yman_sequence` VALUES(11607);
INSERT INTO `yman_sequence` VALUES(11608);
INSERT INTO `yman_sequence` VALUES(11609);
INSERT INTO `yman_sequence` VALUES(11610);
INSERT INTO `yman_sequence` VALUES(11611);
INSERT INTO `yman_sequence` VALUES(11612);
INSERT INTO `yman_sequence` VALUES(11613);
INSERT INTO `yman_sequence` VALUES(11614);
INSERT INTO `yman_sequence` VALUES(11615);
INSERT INTO `yman_sequence` VALUES(11616);
INSERT INTO `yman_sequence` VALUES(11617);
INSERT INTO `yman_sequence` VALUES(11618);
INSERT INTO `yman_sequence` VALUES(11619);
INSERT INTO `yman_sequence` VALUES(11620);
INSERT INTO `yman_sequence` VALUES(11621);
INSERT INTO `yman_sequence` VALUES(11622);
INSERT INTO `yman_sequence` VALUES(11623);
INSERT INTO `yman_sequence` VALUES(11624);
INSERT INTO `yman_sequence` VALUES(11625);
INSERT INTO `yman_sequence` VALUES(11626);
INSERT INTO `yman_sequence` VALUES(11627);
INSERT INTO `yman_sequence` VALUES(11628);
INSERT INTO `yman_sequence` VALUES(11629);
INSERT INTO `yman_sequence` VALUES(11630);
INSERT INTO `yman_sequence` VALUES(11631);
INSERT INTO `yman_sequence` VALUES(11632);
INSERT INTO `yman_sequence` VALUES(11633);
INSERT INTO `yman_sequence` VALUES(11634);
INSERT INTO `yman_sequence` VALUES(11635);
INSERT INTO `yman_sequence` VALUES(11636);
INSERT INTO `yman_sequence` VALUES(11637);
INSERT INTO `yman_sequence` VALUES(11638);
INSERT INTO `yman_sequence` VALUES(11639);
INSERT INTO `yman_sequence` VALUES(11640);
INSERT INTO `yman_sequence` VALUES(11641);
INSERT INTO `yman_sequence` VALUES(11642);
INSERT INTO `yman_sequence` VALUES(11643);
INSERT INTO `yman_sequence` VALUES(11644);
INSERT INTO `yman_sequence` VALUES(11645);
INSERT INTO `yman_sequence` VALUES(11646);
INSERT INTO `yman_sequence` VALUES(11647);
INSERT INTO `yman_sequence` VALUES(11648);
INSERT INTO `yman_sequence` VALUES(11649);
INSERT INTO `yman_sequence` VALUES(11650);
INSERT INTO `yman_sequence` VALUES(11651);
INSERT INTO `yman_sequence` VALUES(11652);
INSERT INTO `yman_sequence` VALUES(11653);
INSERT INTO `yman_sequence` VALUES(11654);
INSERT INTO `yman_sequence` VALUES(11655);
INSERT INTO `yman_sequence` VALUES(11656);
INSERT INTO `yman_sequence` VALUES(11657);
INSERT INTO `yman_sequence` VALUES(11658);
INSERT INTO `yman_sequence` VALUES(11659);
INSERT INTO `yman_sequence` VALUES(11660);
INSERT INTO `yman_sequence` VALUES(11661);
INSERT INTO `yman_sequence` VALUES(11662);
INSERT INTO `yman_sequence` VALUES(11663);
INSERT INTO `yman_sequence` VALUES(11664);
INSERT INTO `yman_sequence` VALUES(11665);
INSERT INTO `yman_sequence` VALUES(11666);
INSERT INTO `yman_sequence` VALUES(11667);
INSERT INTO `yman_sequence` VALUES(11668);
INSERT INTO `yman_sequence` VALUES(11669);
INSERT INTO `yman_sequence` VALUES(11670);
INSERT INTO `yman_sequence` VALUES(11671);
INSERT INTO `yman_sequence` VALUES(11672);
INSERT INTO `yman_sequence` VALUES(11673);
INSERT INTO `yman_sequence` VALUES(11674);
INSERT INTO `yman_sequence` VALUES(11675);
INSERT INTO `yman_sequence` VALUES(11676);
INSERT INTO `yman_sequence` VALUES(11677);
INSERT INTO `yman_sequence` VALUES(11678);
INSERT INTO `yman_sequence` VALUES(11679);
INSERT INTO `yman_sequence` VALUES(11680);
INSERT INTO `yman_sequence` VALUES(11681);
INSERT INTO `yman_sequence` VALUES(11682);
INSERT INTO `yman_sequence` VALUES(11683);
INSERT INTO `yman_sequence` VALUES(11684);
INSERT INTO `yman_sequence` VALUES(11685);
INSERT INTO `yman_sequence` VALUES(11686);
INSERT INTO `yman_sequence` VALUES(11687);
INSERT INTO `yman_sequence` VALUES(11688);
INSERT INTO `yman_sequence` VALUES(11689);
INSERT INTO `yman_sequence` VALUES(11690);
INSERT INTO `yman_sequence` VALUES(11691);
INSERT INTO `yman_sequence` VALUES(11692);
INSERT INTO `yman_sequence` VALUES(11693);
INSERT INTO `yman_sequence` VALUES(11694);
INSERT INTO `yman_sequence` VALUES(11695);
INSERT INTO `yman_sequence` VALUES(11696);
INSERT INTO `yman_sequence` VALUES(11697);
INSERT INTO `yman_sequence` VALUES(11698);
INSERT INTO `yman_sequence` VALUES(11699);
INSERT INTO `yman_sequence` VALUES(11700);
INSERT INTO `yman_sequence` VALUES(11701);
INSERT INTO `yman_sequence` VALUES(11702);
INSERT INTO `yman_sequence` VALUES(11703);
INSERT INTO `yman_sequence` VALUES(11704);
INSERT INTO `yman_sequence` VALUES(11705);
INSERT INTO `yman_sequence` VALUES(11706);
INSERT INTO `yman_sequence` VALUES(11707);
INSERT INTO `yman_sequence` VALUES(11708);
INSERT INTO `yman_sequence` VALUES(11709);
INSERT INTO `yman_sequence` VALUES(11710);
INSERT INTO `yman_sequence` VALUES(11711);
INSERT INTO `yman_sequence` VALUES(11712);
INSERT INTO `yman_sequence` VALUES(11713);
INSERT INTO `yman_sequence` VALUES(11714);
INSERT INTO `yman_sequence` VALUES(11715);
INSERT INTO `yman_sequence` VALUES(11716);
INSERT INTO `yman_sequence` VALUES(11717);
INSERT INTO `yman_sequence` VALUES(11718);
INSERT INTO `yman_sequence` VALUES(11719);
INSERT INTO `yman_sequence` VALUES(11720);
INSERT INTO `yman_sequence` VALUES(11721);
INSERT INTO `yman_sequence` VALUES(11722);
INSERT INTO `yman_sequence` VALUES(11723);
INSERT INTO `yman_sequence` VALUES(11724);
INSERT INTO `yman_sequence` VALUES(11725);
INSERT INTO `yman_sequence` VALUES(11726);
INSERT INTO `yman_sequence` VALUES(11727);
INSERT INTO `yman_sequence` VALUES(11728);
INSERT INTO `yman_sequence` VALUES(11729);
INSERT INTO `yman_sequence` VALUES(11730);
INSERT INTO `yman_sequence` VALUES(11731);
INSERT INTO `yman_sequence` VALUES(11732);
INSERT INTO `yman_sequence` VALUES(11733);
INSERT INTO `yman_sequence` VALUES(11734);
INSERT INTO `yman_sequence` VALUES(11735);
INSERT INTO `yman_sequence` VALUES(11736);
INSERT INTO `yman_sequence` VALUES(11737);
INSERT INTO `yman_sequence` VALUES(11738);
INSERT INTO `yman_sequence` VALUES(11739);
INSERT INTO `yman_sequence` VALUES(11740);
INSERT INTO `yman_sequence` VALUES(11741);
INSERT INTO `yman_sequence` VALUES(11742);
INSERT INTO `yman_sequence` VALUES(11743);
INSERT INTO `yman_sequence` VALUES(11744);
INSERT INTO `yman_sequence` VALUES(11745);
INSERT INTO `yman_sequence` VALUES(11746);
INSERT INTO `yman_sequence` VALUES(11747);
INSERT INTO `yman_sequence` VALUES(11748);
INSERT INTO `yman_sequence` VALUES(11749);
INSERT INTO `yman_sequence` VALUES(11750);
INSERT INTO `yman_sequence` VALUES(11751);
INSERT INTO `yman_sequence` VALUES(11752);
INSERT INTO `yman_sequence` VALUES(11753);
INSERT INTO `yman_sequence` VALUES(11754);
INSERT INTO `yman_sequence` VALUES(11755);
INSERT INTO `yman_sequence` VALUES(11756);
INSERT INTO `yman_sequence` VALUES(11757);
INSERT INTO `yman_sequence` VALUES(11758);
INSERT INTO `yman_sequence` VALUES(11759);
INSERT INTO `yman_sequence` VALUES(11760);
INSERT INTO `yman_sequence` VALUES(11761);
INSERT INTO `yman_sequence` VALUES(11762);
INSERT INTO `yman_sequence` VALUES(11763);
INSERT INTO `yman_sequence` VALUES(11764);
INSERT INTO `yman_sequence` VALUES(11765);
INSERT INTO `yman_sequence` VALUES(11766);
INSERT INTO `yman_sequence` VALUES(11767);
INSERT INTO `yman_sequence` VALUES(11768);
INSERT INTO `yman_sequence` VALUES(11769);
INSERT INTO `yman_sequence` VALUES(11770);
INSERT INTO `yman_sequence` VALUES(11771);
INSERT INTO `yman_sequence` VALUES(11772);
INSERT INTO `yman_sequence` VALUES(11773);
INSERT INTO `yman_sequence` VALUES(11774);
INSERT INTO `yman_sequence` VALUES(11775);
INSERT INTO `yman_sequence` VALUES(11776);
INSERT INTO `yman_sequence` VALUES(11777);
INSERT INTO `yman_sequence` VALUES(11778);
INSERT INTO `yman_sequence` VALUES(11779);
INSERT INTO `yman_sequence` VALUES(11780);
INSERT INTO `yman_sequence` VALUES(11781);
INSERT INTO `yman_sequence` VALUES(11782);
INSERT INTO `yman_sequence` VALUES(11783);
INSERT INTO `yman_sequence` VALUES(11784);
INSERT INTO `yman_sequence` VALUES(11785);
INSERT INTO `yman_sequence` VALUES(11786);
INSERT INTO `yman_sequence` VALUES(11787);
INSERT INTO `yman_sequence` VALUES(11788);
INSERT INTO `yman_sequence` VALUES(11789);
INSERT INTO `yman_sequence` VALUES(11790);
INSERT INTO `yman_sequence` VALUES(11791);
INSERT INTO `yman_sequence` VALUES(11792);
INSERT INTO `yman_sequence` VALUES(11793);
INSERT INTO `yman_sequence` VALUES(11794);
INSERT INTO `yman_sequence` VALUES(11795);
INSERT INTO `yman_sequence` VALUES(11796);
INSERT INTO `yman_sequence` VALUES(11797);
INSERT INTO `yman_sequence` VALUES(11798);
INSERT INTO `yman_sequence` VALUES(11799);
INSERT INTO `yman_sequence` VALUES(11800);
INSERT INTO `yman_sequence` VALUES(11801);
INSERT INTO `yman_sequence` VALUES(11802);
INSERT INTO `yman_sequence` VALUES(11803);
INSERT INTO `yman_sequence` VALUES(11804);
INSERT INTO `yman_sequence` VALUES(11805);
INSERT INTO `yman_sequence` VALUES(11806);
INSERT INTO `yman_sequence` VALUES(11807);
INSERT INTO `yman_sequence` VALUES(11808);
INSERT INTO `yman_sequence` VALUES(11809);
INSERT INTO `yman_sequence` VALUES(11810);
INSERT INTO `yman_sequence` VALUES(11811);
INSERT INTO `yman_sequence` VALUES(11812);
INSERT INTO `yman_sequence` VALUES(11813);
INSERT INTO `yman_sequence` VALUES(11814);
INSERT INTO `yman_sequence` VALUES(11815);
INSERT INTO `yman_sequence` VALUES(11816);
INSERT INTO `yman_sequence` VALUES(11817);
INSERT INTO `yman_sequence` VALUES(11818);
INSERT INTO `yman_sequence` VALUES(11819);
INSERT INTO `yman_sequence` VALUES(11820);
INSERT INTO `yman_sequence` VALUES(11821);
INSERT INTO `yman_sequence` VALUES(11822);
INSERT INTO `yman_sequence` VALUES(11823);
INSERT INTO `yman_sequence` VALUES(11824);
INSERT INTO `yman_sequence` VALUES(11825);
INSERT INTO `yman_sequence` VALUES(11826);
INSERT INTO `yman_sequence` VALUES(11827);
INSERT INTO `yman_sequence` VALUES(11828);
INSERT INTO `yman_sequence` VALUES(11829);
INSERT INTO `yman_sequence` VALUES(11830);
INSERT INTO `yman_sequence` VALUES(11831);
INSERT INTO `yman_sequence` VALUES(11832);
INSERT INTO `yman_sequence` VALUES(11833);
INSERT INTO `yman_sequence` VALUES(11834);
INSERT INTO `yman_sequence` VALUES(11835);
INSERT INTO `yman_sequence` VALUES(11836);
INSERT INTO `yman_sequence` VALUES(11837);
INSERT INTO `yman_sequence` VALUES(11838);
INSERT INTO `yman_sequence` VALUES(11839);
INSERT INTO `yman_sequence` VALUES(11840);
INSERT INTO `yman_sequence` VALUES(11841);
INSERT INTO `yman_sequence` VALUES(11842);
INSERT INTO `yman_sequence` VALUES(11843);
INSERT INTO `yman_sequence` VALUES(11844);
INSERT INTO `yman_sequence` VALUES(11845);
INSERT INTO `yman_sequence` VALUES(11846);
INSERT INTO `yman_sequence` VALUES(11847);
INSERT INTO `yman_sequence` VALUES(11848);
INSERT INTO `yman_sequence` VALUES(11849);
INSERT INTO `yman_sequence` VALUES(11850);
INSERT INTO `yman_sequence` VALUES(11851);
INSERT INTO `yman_sequence` VALUES(11852);
INSERT INTO `yman_sequence` VALUES(11853);
INSERT INTO `yman_sequence` VALUES(11854);
INSERT INTO `yman_sequence` VALUES(11855);
INSERT INTO `yman_sequence` VALUES(11856);
INSERT INTO `yman_sequence` VALUES(11857);
INSERT INTO `yman_sequence` VALUES(11858);
INSERT INTO `yman_sequence` VALUES(11859);
INSERT INTO `yman_sequence` VALUES(11860);
INSERT INTO `yman_sequence` VALUES(11861);
INSERT INTO `yman_sequence` VALUES(11862);
INSERT INTO `yman_sequence` VALUES(11863);
INSERT INTO `yman_sequence` VALUES(11864);
INSERT INTO `yman_sequence` VALUES(11865);
INSERT INTO `yman_sequence` VALUES(11866);
INSERT INTO `yman_sequence` VALUES(11867);
INSERT INTO `yman_sequence` VALUES(11868);
INSERT INTO `yman_sequence` VALUES(11869);
INSERT INTO `yman_sequence` VALUES(11870);
INSERT INTO `yman_sequence` VALUES(11871);
INSERT INTO `yman_sequence` VALUES(11872);
INSERT INTO `yman_sequence` VALUES(11873);
INSERT INTO `yman_sequence` VALUES(11874);
INSERT INTO `yman_sequence` VALUES(11875);
INSERT INTO `yman_sequence` VALUES(11876);
INSERT INTO `yman_sequence` VALUES(11877);
INSERT INTO `yman_sequence` VALUES(11878);
INSERT INTO `yman_sequence` VALUES(11879);
INSERT INTO `yman_sequence` VALUES(11880);
INSERT INTO `yman_sequence` VALUES(11881);
INSERT INTO `yman_sequence` VALUES(11882);
INSERT INTO `yman_sequence` VALUES(11883);
INSERT INTO `yman_sequence` VALUES(11884);
INSERT INTO `yman_sequence` VALUES(11885);
INSERT INTO `yman_sequence` VALUES(11886);
INSERT INTO `yman_sequence` VALUES(11887);
INSERT INTO `yman_sequence` VALUES(11888);
INSERT INTO `yman_sequence` VALUES(11889);
INSERT INTO `yman_sequence` VALUES(11890);
INSERT INTO `yman_sequence` VALUES(11891);
INSERT INTO `yman_sequence` VALUES(11892);
INSERT INTO `yman_sequence` VALUES(11893);
INSERT INTO `yman_sequence` VALUES(11894);
INSERT INTO `yman_sequence` VALUES(11895);
INSERT INTO `yman_sequence` VALUES(11896);
INSERT INTO `yman_sequence` VALUES(11897);
INSERT INTO `yman_sequence` VALUES(11898);
INSERT INTO `yman_sequence` VALUES(11899);
INSERT INTO `yman_sequence` VALUES(11900);
INSERT INTO `yman_sequence` VALUES(11901);
INSERT INTO `yman_sequence` VALUES(11902);
INSERT INTO `yman_sequence` VALUES(11903);
INSERT INTO `yman_sequence` VALUES(11904);
INSERT INTO `yman_sequence` VALUES(11905);
INSERT INTO `yman_sequence` VALUES(11906);
INSERT INTO `yman_sequence` VALUES(11907);
INSERT INTO `yman_sequence` VALUES(11908);
INSERT INTO `yman_sequence` VALUES(11909);
INSERT INTO `yman_sequence` VALUES(11910);
INSERT INTO `yman_sequence` VALUES(11911);
INSERT INTO `yman_sequence` VALUES(11912);
INSERT INTO `yman_sequence` VALUES(11913);
INSERT INTO `yman_sequence` VALUES(11914);
INSERT INTO `yman_sequence` VALUES(11915);
INSERT INTO `yman_sequence` VALUES(11916);
INSERT INTO `yman_sequence` VALUES(11917);
INSERT INTO `yman_sequence` VALUES(11918);
INSERT INTO `yman_sequence` VALUES(11919);
INSERT INTO `yman_sequence` VALUES(11920);
INSERT INTO `yman_sequence` VALUES(11921);
INSERT INTO `yman_sequence` VALUES(11922);
INSERT INTO `yman_sequence` VALUES(11923);
INSERT INTO `yman_sequence` VALUES(11924);
INSERT INTO `yman_sequence` VALUES(11925);
INSERT INTO `yman_sequence` VALUES(11926);
INSERT INTO `yman_sequence` VALUES(11927);
INSERT INTO `yman_sequence` VALUES(11928);
INSERT INTO `yman_sequence` VALUES(11929);
INSERT INTO `yman_sequence` VALUES(11930);
INSERT INTO `yman_sequence` VALUES(11931);
INSERT INTO `yman_sequence` VALUES(11932);
INSERT INTO `yman_sequence` VALUES(11933);
INSERT INTO `yman_sequence` VALUES(11934);
INSERT INTO `yman_sequence` VALUES(11935);
INSERT INTO `yman_sequence` VALUES(11936);
INSERT INTO `yman_sequence` VALUES(11937);
INSERT INTO `yman_sequence` VALUES(11938);
INSERT INTO `yman_sequence` VALUES(11939);
INSERT INTO `yman_sequence` VALUES(11940);
INSERT INTO `yman_sequence` VALUES(11941);
INSERT INTO `yman_sequence` VALUES(11942);
INSERT INTO `yman_sequence` VALUES(11943);
INSERT INTO `yman_sequence` VALUES(11944);
INSERT INTO `yman_sequence` VALUES(11945);
INSERT INTO `yman_sequence` VALUES(11946);
INSERT INTO `yman_sequence` VALUES(11947);
INSERT INTO `yman_sequence` VALUES(11948);
INSERT INTO `yman_sequence` VALUES(11949);
INSERT INTO `yman_sequence` VALUES(11950);
INSERT INTO `yman_sequence` VALUES(11951);
INSERT INTO `yman_sequence` VALUES(11952);
INSERT INTO `yman_sequence` VALUES(11953);
INSERT INTO `yman_sequence` VALUES(11954);
INSERT INTO `yman_sequence` VALUES(11955);
INSERT INTO `yman_sequence` VALUES(11956);
INSERT INTO `yman_sequence` VALUES(11957);
INSERT INTO `yman_sequence` VALUES(11958);
INSERT INTO `yman_sequence` VALUES(11959);
INSERT INTO `yman_sequence` VALUES(11960);
INSERT INTO `yman_sequence` VALUES(11961);
INSERT INTO `yman_sequence` VALUES(11962);
INSERT INTO `yman_sequence` VALUES(11963);
INSERT INTO `yman_sequence` VALUES(11964);
INSERT INTO `yman_sequence` VALUES(11965);
INSERT INTO `yman_sequence` VALUES(11966);
INSERT INTO `yman_sequence` VALUES(11967);
INSERT INTO `yman_sequence` VALUES(11968);
INSERT INTO `yman_sequence` VALUES(11969);
INSERT INTO `yman_sequence` VALUES(11970);
INSERT INTO `yman_sequence` VALUES(11971);
INSERT INTO `yman_sequence` VALUES(11972);
INSERT INTO `yman_sequence` VALUES(11973);
INSERT INTO `yman_sequence` VALUES(11974);
INSERT INTO `yman_sequence` VALUES(11975);
INSERT INTO `yman_sequence` VALUES(11976);
INSERT INTO `yman_sequence` VALUES(11977);
INSERT INTO `yman_sequence` VALUES(11978);
INSERT INTO `yman_sequence` VALUES(11979);
INSERT INTO `yman_sequence` VALUES(11980);
INSERT INTO `yman_sequence` VALUES(11981);
INSERT INTO `yman_sequence` VALUES(11982);
INSERT INTO `yman_sequence` VALUES(11983);
INSERT INTO `yman_sequence` VALUES(11984);
INSERT INTO `yman_sequence` VALUES(11985);
INSERT INTO `yman_sequence` VALUES(11986);
INSERT INTO `yman_sequence` VALUES(11987);
INSERT INTO `yman_sequence` VALUES(11988);
INSERT INTO `yman_sequence` VALUES(11989);
INSERT INTO `yman_sequence` VALUES(11990);
INSERT INTO `yman_sequence` VALUES(11991);
INSERT INTO `yman_sequence` VALUES(11992);
INSERT INTO `yman_sequence` VALUES(11993);
INSERT INTO `yman_sequence` VALUES(11994);
INSERT INTO `yman_sequence` VALUES(11995);
INSERT INTO `yman_sequence` VALUES(11996);
INSERT INTO `yman_sequence` VALUES(11997);
INSERT INTO `yman_sequence` VALUES(11998);
INSERT INTO `yman_sequence` VALUES(11999);
INSERT INTO `yman_sequence` VALUES(12000);
INSERT INTO `yman_sequence` VALUES(12001);
INSERT INTO `yman_sequence` VALUES(12002);
INSERT INTO `yman_sequence` VALUES(12003);
INSERT INTO `yman_sequence` VALUES(12004);
INSERT INTO `yman_sequence` VALUES(12005);
INSERT INTO `yman_sequence` VALUES(12006);
INSERT INTO `yman_sequence` VALUES(12007);
INSERT INTO `yman_sequence` VALUES(12008);
INSERT INTO `yman_sequence` VALUES(12009);
INSERT INTO `yman_sequence` VALUES(12010);
INSERT INTO `yman_sequence` VALUES(12011);
INSERT INTO `yman_sequence` VALUES(12012);
INSERT INTO `yman_sequence` VALUES(12013);
INSERT INTO `yman_sequence` VALUES(12014);
INSERT INTO `yman_sequence` VALUES(12015);
INSERT INTO `yman_sequence` VALUES(12016);
INSERT INTO `yman_sequence` VALUES(12017);
INSERT INTO `yman_sequence` VALUES(12018);
INSERT INTO `yman_sequence` VALUES(12019);
INSERT INTO `yman_sequence` VALUES(12020);
INSERT INTO `yman_sequence` VALUES(12021);
INSERT INTO `yman_sequence` VALUES(12022);
INSERT INTO `yman_sequence` VALUES(12023);
INSERT INTO `yman_sequence` VALUES(12024);
INSERT INTO `yman_sequence` VALUES(12025);
INSERT INTO `yman_sequence` VALUES(12026);
INSERT INTO `yman_sequence` VALUES(12027);
INSERT INTO `yman_sequence` VALUES(12028);
INSERT INTO `yman_sequence` VALUES(12029);
INSERT INTO `yman_sequence` VALUES(12030);
INSERT INTO `yman_sequence` VALUES(12031);
INSERT INTO `yman_sequence` VALUES(12032);
INSERT INTO `yman_sequence` VALUES(12033);
INSERT INTO `yman_sequence` VALUES(12034);
INSERT INTO `yman_sequence` VALUES(12035);
INSERT INTO `yman_sequence` VALUES(12036);
INSERT INTO `yman_sequence` VALUES(12037);
INSERT INTO `yman_sequence` VALUES(12038);
INSERT INTO `yman_sequence` VALUES(12039);
INSERT INTO `yman_sequence` VALUES(12040);
INSERT INTO `yman_sequence` VALUES(12041);
INSERT INTO `yman_sequence` VALUES(12042);
INSERT INTO `yman_sequence` VALUES(12043);
INSERT INTO `yman_sequence` VALUES(12044);
INSERT INTO `yman_sequence` VALUES(12045);
INSERT INTO `yman_sequence` VALUES(12046);
INSERT INTO `yman_sequence` VALUES(12047);
INSERT INTO `yman_sequence` VALUES(12048);
INSERT INTO `yman_sequence` VALUES(12049);
INSERT INTO `yman_sequence` VALUES(12050);
INSERT INTO `yman_sequence` VALUES(12051);
INSERT INTO `yman_sequence` VALUES(12052);
INSERT INTO `yman_sequence` VALUES(12053);
INSERT INTO `yman_sequence` VALUES(12054);
INSERT INTO `yman_sequence` VALUES(12055);
INSERT INTO `yman_sequence` VALUES(12056);
INSERT INTO `yman_sequence` VALUES(12057);
INSERT INTO `yman_sequence` VALUES(12058);
INSERT INTO `yman_sequence` VALUES(12059);
INSERT INTO `yman_sequence` VALUES(12060);
INSERT INTO `yman_sequence` VALUES(12061);
INSERT INTO `yman_sequence` VALUES(12062);
INSERT INTO `yman_sequence` VALUES(12063);
INSERT INTO `yman_sequence` VALUES(12064);
INSERT INTO `yman_sequence` VALUES(12065);
INSERT INTO `yman_sequence` VALUES(12066);
INSERT INTO `yman_sequence` VALUES(12067);
INSERT INTO `yman_sequence` VALUES(12068);
INSERT INTO `yman_sequence` VALUES(12069);
INSERT INTO `yman_sequence` VALUES(12070);
INSERT INTO `yman_sequence` VALUES(12071);
INSERT INTO `yman_sequence` VALUES(12072);
INSERT INTO `yman_sequence` VALUES(12073);
INSERT INTO `yman_sequence` VALUES(12074);
INSERT INTO `yman_sequence` VALUES(12075);
INSERT INTO `yman_sequence` VALUES(12076);
INSERT INTO `yman_sequence` VALUES(12077);
INSERT INTO `yman_sequence` VALUES(12078);
INSERT INTO `yman_sequence` VALUES(12079);
INSERT INTO `yman_sequence` VALUES(12080);
INSERT INTO `yman_sequence` VALUES(12081);
INSERT INTO `yman_sequence` VALUES(12082);
INSERT INTO `yman_sequence` VALUES(12083);
INSERT INTO `yman_sequence` VALUES(12084);
INSERT INTO `yman_sequence` VALUES(12085);
INSERT INTO `yman_sequence` VALUES(12086);
INSERT INTO `yman_sequence` VALUES(12087);
INSERT INTO `yman_sequence` VALUES(12088);
INSERT INTO `yman_sequence` VALUES(12089);
INSERT INTO `yman_sequence` VALUES(12090);
INSERT INTO `yman_sequence` VALUES(12091);
INSERT INTO `yman_sequence` VALUES(12092);
INSERT INTO `yman_sequence` VALUES(12093);
INSERT INTO `yman_sequence` VALUES(12094);
INSERT INTO `yman_sequence` VALUES(12095);
INSERT INTO `yman_sequence` VALUES(12096);
INSERT INTO `yman_sequence` VALUES(12097);
INSERT INTO `yman_sequence` VALUES(12098);
INSERT INTO `yman_sequence` VALUES(12099);
INSERT INTO `yman_sequence` VALUES(12100);
INSERT INTO `yman_sequence` VALUES(12101);
INSERT INTO `yman_sequence` VALUES(12102);
INSERT INTO `yman_sequence` VALUES(12103);
INSERT INTO `yman_sequence` VALUES(12104);
INSERT INTO `yman_sequence` VALUES(12105);
INSERT INTO `yman_sequence` VALUES(12106);
INSERT INTO `yman_sequence` VALUES(12107);
INSERT INTO `yman_sequence` VALUES(12108);
INSERT INTO `yman_sequence` VALUES(12109);
INSERT INTO `yman_sequence` VALUES(12110);
INSERT INTO `yman_sequence` VALUES(12111);
INSERT INTO `yman_sequence` VALUES(12112);
INSERT INTO `yman_sequence` VALUES(12113);
INSERT INTO `yman_sequence` VALUES(12114);
INSERT INTO `yman_sequence` VALUES(12115);
INSERT INTO `yman_sequence` VALUES(12116);
INSERT INTO `yman_sequence` VALUES(12117);
INSERT INTO `yman_sequence` VALUES(12118);
INSERT INTO `yman_sequence` VALUES(12119);
INSERT INTO `yman_sequence` VALUES(12120);
INSERT INTO `yman_sequence` VALUES(12121);
INSERT INTO `yman_sequence` VALUES(12122);
INSERT INTO `yman_sequence` VALUES(12123);
INSERT INTO `yman_sequence` VALUES(12124);
INSERT INTO `yman_sequence` VALUES(12125);
INSERT INTO `yman_sequence` VALUES(12126);
INSERT INTO `yman_sequence` VALUES(12127);
INSERT INTO `yman_sequence` VALUES(12128);
INSERT INTO `yman_sequence` VALUES(12129);
INSERT INTO `yman_sequence` VALUES(12130);
INSERT INTO `yman_sequence` VALUES(12131);
INSERT INTO `yman_sequence` VALUES(12132);
INSERT INTO `yman_sequence` VALUES(12133);
INSERT INTO `yman_sequence` VALUES(12134);
INSERT INTO `yman_sequence` VALUES(12135);
INSERT INTO `yman_sequence` VALUES(12136);
INSERT INTO `yman_sequence` VALUES(12137);
INSERT INTO `yman_sequence` VALUES(12138);
INSERT INTO `yman_sequence` VALUES(12139);
INSERT INTO `yman_sequence` VALUES(12140);
INSERT INTO `yman_sequence` VALUES(12141);
INSERT INTO `yman_sequence` VALUES(12142);
INSERT INTO `yman_sequence` VALUES(12143);
INSERT INTO `yman_sequence` VALUES(12144);
INSERT INTO `yman_sequence` VALUES(12145);
INSERT INTO `yman_sequence` VALUES(12146);
INSERT INTO `yman_sequence` VALUES(12147);
INSERT INTO `yman_sequence` VALUES(12148);
INSERT INTO `yman_sequence` VALUES(12149);
INSERT INTO `yman_sequence` VALUES(12150);
INSERT INTO `yman_sequence` VALUES(12151);
INSERT INTO `yman_sequence` VALUES(12152);
INSERT INTO `yman_sequence` VALUES(12153);
INSERT INTO `yman_sequence` VALUES(12154);
INSERT INTO `yman_sequence` VALUES(12155);
INSERT INTO `yman_sequence` VALUES(12156);
INSERT INTO `yman_sequence` VALUES(12157);
INSERT INTO `yman_sequence` VALUES(12158);
INSERT INTO `yman_sequence` VALUES(12159);
INSERT INTO `yman_sequence` VALUES(12160);
INSERT INTO `yman_sequence` VALUES(12161);
INSERT INTO `yman_sequence` VALUES(12162);
INSERT INTO `yman_sequence` VALUES(12163);
INSERT INTO `yman_sequence` VALUES(12164);
INSERT INTO `yman_sequence` VALUES(12165);
INSERT INTO `yman_sequence` VALUES(12166);
INSERT INTO `yman_sequence` VALUES(12167);
INSERT INTO `yman_sequence` VALUES(12168);
INSERT INTO `yman_sequence` VALUES(12169);
INSERT INTO `yman_sequence` VALUES(12170);
INSERT INTO `yman_sequence` VALUES(12171);
INSERT INTO `yman_sequence` VALUES(12172);
INSERT INTO `yman_sequence` VALUES(12173);
INSERT INTO `yman_sequence` VALUES(12174);
INSERT INTO `yman_sequence` VALUES(12175);
INSERT INTO `yman_sequence` VALUES(12176);
INSERT INTO `yman_sequence` VALUES(12177);
INSERT INTO `yman_sequence` VALUES(12178);
INSERT INTO `yman_sequence` VALUES(12179);
INSERT INTO `yman_sequence` VALUES(12180);
INSERT INTO `yman_sequence` VALUES(12181);
INSERT INTO `yman_sequence` VALUES(12182);
INSERT INTO `yman_sequence` VALUES(12183);
INSERT INTO `yman_sequence` VALUES(12184);
INSERT INTO `yman_sequence` VALUES(12185);
INSERT INTO `yman_sequence` VALUES(12186);
INSERT INTO `yman_sequence` VALUES(12187);
INSERT INTO `yman_sequence` VALUES(12188);
INSERT INTO `yman_sequence` VALUES(12189);
INSERT INTO `yman_sequence` VALUES(12190);
INSERT INTO `yman_sequence` VALUES(12191);
INSERT INTO `yman_sequence` VALUES(12192);
INSERT INTO `yman_sequence` VALUES(12193);
INSERT INTO `yman_sequence` VALUES(12194);
INSERT INTO `yman_sequence` VALUES(12195);
INSERT INTO `yman_sequence` VALUES(12196);
INSERT INTO `yman_sequence` VALUES(12197);
INSERT INTO `yman_sequence` VALUES(12198);
INSERT INTO `yman_sequence` VALUES(12199);
INSERT INTO `yman_sequence` VALUES(12200);
INSERT INTO `yman_sequence` VALUES(12201);
INSERT INTO `yman_sequence` VALUES(12202);
INSERT INTO `yman_sequence` VALUES(12203);
INSERT INTO `yman_sequence` VALUES(12204);
INSERT INTO `yman_sequence` VALUES(12205);
INSERT INTO `yman_sequence` VALUES(12206);
INSERT INTO `yman_sequence` VALUES(12207);
INSERT INTO `yman_sequence` VALUES(12208);
INSERT INTO `yman_sequence` VALUES(12209);
INSERT INTO `yman_sequence` VALUES(12210);
INSERT INTO `yman_sequence` VALUES(12211);
INSERT INTO `yman_sequence` VALUES(12212);
INSERT INTO `yman_sequence` VALUES(12213);
INSERT INTO `yman_sequence` VALUES(12214);
INSERT INTO `yman_sequence` VALUES(12215);
INSERT INTO `yman_sequence` VALUES(12216);
INSERT INTO `yman_sequence` VALUES(12217);
INSERT INTO `yman_sequence` VALUES(12218);
INSERT INTO `yman_sequence` VALUES(12219);
INSERT INTO `yman_sequence` VALUES(12220);
INSERT INTO `yman_sequence` VALUES(12221);
INSERT INTO `yman_sequence` VALUES(12222);
INSERT INTO `yman_sequence` VALUES(12223);
INSERT INTO `yman_sequence` VALUES(12224);
INSERT INTO `yman_sequence` VALUES(12225);
INSERT INTO `yman_sequence` VALUES(12226);
INSERT INTO `yman_sequence` VALUES(12227);
INSERT INTO `yman_sequence` VALUES(12228);
INSERT INTO `yman_sequence` VALUES(12229);
INSERT INTO `yman_sequence` VALUES(12230);
INSERT INTO `yman_sequence` VALUES(12231);
INSERT INTO `yman_sequence` VALUES(12232);
INSERT INTO `yman_sequence` VALUES(12233);
INSERT INTO `yman_sequence` VALUES(12234);
INSERT INTO `yman_sequence` VALUES(12235);
INSERT INTO `yman_sequence` VALUES(12236);
INSERT INTO `yman_sequence` VALUES(12237);
INSERT INTO `yman_sequence` VALUES(12238);
INSERT INTO `yman_sequence` VALUES(12239);
INSERT INTO `yman_sequence` VALUES(12240);
INSERT INTO `yman_sequence` VALUES(12241);
INSERT INTO `yman_sequence` VALUES(12242);
INSERT INTO `yman_sequence` VALUES(12243);
INSERT INTO `yman_sequence` VALUES(12244);
INSERT INTO `yman_sequence` VALUES(12245);
INSERT INTO `yman_sequence` VALUES(12246);
INSERT INTO `yman_sequence` VALUES(12247);
INSERT INTO `yman_sequence` VALUES(12248);
INSERT INTO `yman_sequence` VALUES(12249);
INSERT INTO `yman_sequence` VALUES(12250);
INSERT INTO `yman_sequence` VALUES(12251);
INSERT INTO `yman_sequence` VALUES(12252);
INSERT INTO `yman_sequence` VALUES(12253);
INSERT INTO `yman_sequence` VALUES(12254);
INSERT INTO `yman_sequence` VALUES(12255);
INSERT INTO `yman_sequence` VALUES(12256);
INSERT INTO `yman_sequence` VALUES(12257);
INSERT INTO `yman_sequence` VALUES(12258);
INSERT INTO `yman_sequence` VALUES(12259);
INSERT INTO `yman_sequence` VALUES(12260);
INSERT INTO `yman_sequence` VALUES(12261);
INSERT INTO `yman_sequence` VALUES(12262);
INSERT INTO `yman_sequence` VALUES(12263);
INSERT INTO `yman_sequence` VALUES(12264);
INSERT INTO `yman_sequence` VALUES(12265);
INSERT INTO `yman_sequence` VALUES(12266);
INSERT INTO `yman_sequence` VALUES(12267);
INSERT INTO `yman_sequence` VALUES(12268);
INSERT INTO `yman_sequence` VALUES(12269);
INSERT INTO `yman_sequence` VALUES(12270);
INSERT INTO `yman_sequence` VALUES(12271);
INSERT INTO `yman_sequence` VALUES(12272);
INSERT INTO `yman_sequence` VALUES(12273);
INSERT INTO `yman_sequence` VALUES(12274);
INSERT INTO `yman_sequence` VALUES(12275);
INSERT INTO `yman_sequence` VALUES(12276);
INSERT INTO `yman_sequence` VALUES(12277);
INSERT INTO `yman_sequence` VALUES(12278);
INSERT INTO `yman_sequence` VALUES(12279);
INSERT INTO `yman_sequence` VALUES(12280);
INSERT INTO `yman_sequence` VALUES(12281);
INSERT INTO `yman_sequence` VALUES(12282);
INSERT INTO `yman_sequence` VALUES(12283);
INSERT INTO `yman_sequence` VALUES(12284);
INSERT INTO `yman_sequence` VALUES(12285);
INSERT INTO `yman_sequence` VALUES(12286);
INSERT INTO `yman_sequence` VALUES(12287);
INSERT INTO `yman_sequence` VALUES(12288);
INSERT INTO `yman_sequence` VALUES(12289);
INSERT INTO `yman_sequence` VALUES(12290);
INSERT INTO `yman_sequence` VALUES(12291);
INSERT INTO `yman_sequence` VALUES(12292);
INSERT INTO `yman_sequence` VALUES(12293);
INSERT INTO `yman_sequence` VALUES(12294);
INSERT INTO `yman_sequence` VALUES(12295);
INSERT INTO `yman_sequence` VALUES(12296);
INSERT INTO `yman_sequence` VALUES(12297);
INSERT INTO `yman_sequence` VALUES(12298);
INSERT INTO `yman_sequence` VALUES(12299);
INSERT INTO `yman_sequence` VALUES(12300);
INSERT INTO `yman_sequence` VALUES(12301);
INSERT INTO `yman_sequence` VALUES(12302);
INSERT INTO `yman_sequence` VALUES(12303);
INSERT INTO `yman_sequence` VALUES(12304);
INSERT INTO `yman_sequence` VALUES(12305);
INSERT INTO `yman_sequence` VALUES(12306);
INSERT INTO `yman_sequence` VALUES(12307);
INSERT INTO `yman_sequence` VALUES(12308);
INSERT INTO `yman_sequence` VALUES(12309);
INSERT INTO `yman_sequence` VALUES(12310);
INSERT INTO `yman_sequence` VALUES(12311);
INSERT INTO `yman_sequence` VALUES(12312);
INSERT INTO `yman_sequence` VALUES(12313);
INSERT INTO `yman_sequence` VALUES(12314);
INSERT INTO `yman_sequence` VALUES(12315);
INSERT INTO `yman_sequence` VALUES(12316);
INSERT INTO `yman_sequence` VALUES(12317);
INSERT INTO `yman_sequence` VALUES(12318);
INSERT INTO `yman_sequence` VALUES(12319);
INSERT INTO `yman_sequence` VALUES(12320);
INSERT INTO `yman_sequence` VALUES(12321);
INSERT INTO `yman_sequence` VALUES(12322);
INSERT INTO `yman_sequence` VALUES(12323);
INSERT INTO `yman_sequence` VALUES(12324);
INSERT INTO `yman_sequence` VALUES(12325);
INSERT INTO `yman_sequence` VALUES(12326);
INSERT INTO `yman_sequence` VALUES(12327);
INSERT INTO `yman_sequence` VALUES(12328);
INSERT INTO `yman_sequence` VALUES(12329);
INSERT INTO `yman_sequence` VALUES(12330);
INSERT INTO `yman_sequence` VALUES(12331);
INSERT INTO `yman_sequence` VALUES(12332);
INSERT INTO `yman_sequence` VALUES(12333);
INSERT INTO `yman_sequence` VALUES(12334);
INSERT INTO `yman_sequence` VALUES(12335);
INSERT INTO `yman_sequence` VALUES(12336);
INSERT INTO `yman_sequence` VALUES(12337);
INSERT INTO `yman_sequence` VALUES(12338);
INSERT INTO `yman_sequence` VALUES(12339);
INSERT INTO `yman_sequence` VALUES(12340);
INSERT INTO `yman_sequence` VALUES(12341);
INSERT INTO `yman_sequence` VALUES(12342);
INSERT INTO `yman_sequence` VALUES(12343);
INSERT INTO `yman_sequence` VALUES(12344);
INSERT INTO `yman_sequence` VALUES(12345);
INSERT INTO `yman_sequence` VALUES(12346);
INSERT INTO `yman_sequence` VALUES(12347);
INSERT INTO `yman_sequence` VALUES(12348);
INSERT INTO `yman_sequence` VALUES(12349);
INSERT INTO `yman_sequence` VALUES(12350);
INSERT INTO `yman_sequence` VALUES(12351);
INSERT INTO `yman_sequence` VALUES(12352);
INSERT INTO `yman_sequence` VALUES(12353);
INSERT INTO `yman_sequence` VALUES(12354);
INSERT INTO `yman_sequence` VALUES(12355);
INSERT INTO `yman_sequence` VALUES(12356);
INSERT INTO `yman_sequence` VALUES(12357);
INSERT INTO `yman_sequence` VALUES(12358);
INSERT INTO `yman_sequence` VALUES(12359);
INSERT INTO `yman_sequence` VALUES(12360);
INSERT INTO `yman_sequence` VALUES(12361);
INSERT INTO `yman_sequence` VALUES(12362);
INSERT INTO `yman_sequence` VALUES(12363);
INSERT INTO `yman_sequence` VALUES(12364);
INSERT INTO `yman_sequence` VALUES(12365);
INSERT INTO `yman_sequence` VALUES(12366);
INSERT INTO `yman_sequence` VALUES(12367);
INSERT INTO `yman_sequence` VALUES(12368);
INSERT INTO `yman_sequence` VALUES(12369);
INSERT INTO `yman_sequence` VALUES(12370);
INSERT INTO `yman_sequence` VALUES(12371);
INSERT INTO `yman_sequence` VALUES(12372);
INSERT INTO `yman_sequence` VALUES(12373);
INSERT INTO `yman_sequence` VALUES(12374);
INSERT INTO `yman_sequence` VALUES(12375);
INSERT INTO `yman_sequence` VALUES(12376);
INSERT INTO `yman_sequence` VALUES(12377);
INSERT INTO `yman_sequence` VALUES(12378);
INSERT INTO `yman_sequence` VALUES(12379);
INSERT INTO `yman_sequence` VALUES(12380);
INSERT INTO `yman_sequence` VALUES(12381);
INSERT INTO `yman_sequence` VALUES(12382);
INSERT INTO `yman_sequence` VALUES(12383);
INSERT INTO `yman_sequence` VALUES(12384);
INSERT INTO `yman_sequence` VALUES(12385);
INSERT INTO `yman_sequence` VALUES(12386);
INSERT INTO `yman_sequence` VALUES(12387);
INSERT INTO `yman_sequence` VALUES(12388);
INSERT INTO `yman_sequence` VALUES(12389);
INSERT INTO `yman_sequence` VALUES(12390);
INSERT INTO `yman_sequence` VALUES(12391);
INSERT INTO `yman_sequence` VALUES(12392);
INSERT INTO `yman_sequence` VALUES(12393);
INSERT INTO `yman_sequence` VALUES(12394);
INSERT INTO `yman_sequence` VALUES(12395);
INSERT INTO `yman_sequence` VALUES(12396);
INSERT INTO `yman_sequence` VALUES(12397);
INSERT INTO `yman_sequence` VALUES(12398);
INSERT INTO `yman_sequence` VALUES(12399);
INSERT INTO `yman_sequence` VALUES(12400);
INSERT INTO `yman_sequence` VALUES(12401);

CREATE TABLE IF NOT EXISTS `yman_session` (
  `session_key` varchar(255) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `expired` varchar(14) default NULL,
  `val` longtext,
  `ipaddress` varchar(128) NOT NULL,
  `last_update` varchar(14) default NULL,
  `cur_mid` varchar(128) default NULL,
  PRIMARY KEY  (`session_key`),
  KEY `idx_session_member_srl` (`member_srl`),
  KEY `idx_session_expired` (`expired`),
  KEY `idx_session_update` (`last_update`),
  KEY `idx_session_cur_mid` (`cur_mid`),
  KEY `idx_session_update_mid` (`member_srl`,`last_update`,`cur_mid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_sites` (
  `site_srl` bigint(11) NOT NULL,
  `index_module_srl` bigint(11) default '0',
  `domain` varchar(255) NOT NULL,
  `default_language` varchar(255) default NULL,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`site_srl`),
  UNIQUE KEY `unique_domain` (`domain`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_site_admin` (
  `site_srl` bigint(11) NOT NULL,
  `member_srl` bigint(11) NOT NULL,
  `regdate` varchar(14) default NULL,
  UNIQUE KEY `idx_site_admin` (`site_srl`,`member_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_spamfilter_denied_ip` (
  `ipaddress` varchar(250) NOT NULL,
  `description` varchar(250) default NULL,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`ipaddress`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_spamfilter_denied_word` (
  `word` varchar(250) NOT NULL,
  `hit` bigint(20) NOT NULL default '0',
  `latest_hit` varchar(14) default NULL,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`word`),
  KEY `idx_hit` (`hit`),
  KEY `idx_latest_hit` (`latest_hit`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_spamfilter_log` (
  `spamfilter_log_srl` bigint(11) NOT NULL,
  `ipaddress` varchar(250) NOT NULL,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`spamfilter_log_srl`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_syndication_except_modules` (
  `module_srl` bigint(11) NOT NULL,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`module_srl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `yman_syndication_except_modules` VALUES(0, '20110310222225');

CREATE TABLE IF NOT EXISTS `yman_syndication_logs` (
  `log_srl` bigint(11) NOT NULL,
  `module_srl` bigint(11) default '0',
  `document_srl` bigint(11) default '0',
  `title` varchar(255) default NULL,
  `summary` varchar(255) default NULL,
  `regdate` varchar(14) default NULL,
  UNIQUE KEY `primary_key` (`log_srl`),
  KEY `idx_regdate` (`regdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_tags` (
  `tag_srl` bigint(11) NOT NULL,
  `module_srl` bigint(11) NOT NULL default '0',
  `document_srl` bigint(11) NOT NULL default '0',
  `tag` varchar(240) NOT NULL,
  `regdate` varchar(14) default NULL,
  PRIMARY KEY  (`tag_srl`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_document_srl` (`document_srl`),
  KEY `idx_regdate` (`regdate`),
  KEY `idx_tag` (`document_srl`,`tag`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_trackbacks` (
  `trackback_srl` bigint(11) NOT NULL,
  `module_srl` bigint(11) NOT NULL default '0',
  `document_srl` bigint(11) NOT NULL default '0',
  `url` varchar(250) NOT NULL,
  `title` varchar(250) NOT NULL,
  `blog_name` varchar(250) NOT NULL,
  `excerpt` text NOT NULL,
  `regdate` varchar(14) default NULL,
  `ipaddress` varchar(128) NOT NULL,
  `list_order` bigint(11) NOT NULL,
  PRIMARY KEY  (`trackback_srl`),
  KEY `idx_module_srl` (`module_srl`),
  KEY `idx_document_srl` (`document_srl`),
  KEY `idx_regdate` (`regdate`),
  KEY `idx_ipaddress` (`ipaddress`),
  KEY `idx_list_order` (`list_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `yman_vote_nulla` (
  `module_srl` bigint(20) default NULL,
  `document_srl` bigint(20) default NULL,
  `sum_point` bigint(20) default NULL,
  `sum_voter` bigint(20) default NULL,
  `user_srls` longtext
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
