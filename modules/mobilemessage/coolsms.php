<?php
/**
 * vi:set ts=4 sw=4 expandtab fileencoding=utf-8:
 * CoolSMS Text-Messaging Module PHP Version.
 *
 * @version v2.3.1
 * @copyright (C) 2008-2010 D&SOFT
 * @link http://open.coolsms.co.kr
 */

/**
 * constant definition
 **/
define("CSCP_VERSION_SIZE", 7);
define("CSCP_BODYLEN_SIZE", 8);
define("CSCP_VERSION", "CSCP2.0");
define("CSCPPARAM_ID_SIZE", 2);
define("CSCPPARAM_BODYLEN_SIZE", 8);
define("CSCPPARAM_ID_MESSAGE", "ME");
define("CSCPPARAM_ID_ATTACHMENT", "AT");

/**
 * @class coolsms
 * @author diver@coolsms.co.kr
 * @brief PHP texting module class
 */
class coolsms 
{
	// host address
	var $cool_gateways = array("alpha.coolsms.co.kr"=>80, "bravo.coolsms.co.kr"=>80, "delta.coolsms.co.kr"=>80);
    // reseller gateways
    var $resale_gateways = array("alpha.sendsms.kr"=>8080, "bravo.sendsms.kr"=>8080, "delta.sendsms.kr"=>8080);
    // solution registration key
    var $sln_reg_key = null; 
    var $is_resale = false;
    // character set : only support for utf8, euckr
    var $_charset = "euckr";
    // module version
    var $module_version = "php/2.3";
    // application version
    var $app_version = "";

    // retry maximum
    var $retry_max = 3;
	// define execution time limit
	var $TIME_LIMIT_SECS = 360;
    // IO timeout seconds
	var $timeout_seconds = 5;


    // TBSP version
	var $VERSION_STR = "TBSP/1.0";

	// CoolSMS user id
	var $userid;
	// CoolSMS user password
	var $passwd;

    // message queue
	var $msgl;
    // result data
	var $result;
    // error messages
	var $errmsg;
    // socket handle
	var $sockfp;

	// log file name
	var $log_file = "coolsms.log";
	var $logging_mode = false;
    // encryption type
	var $crypt = "MD5";

    var $options="";

    /**
     * @brief contructor
     **/
	function coolsms($path=false)
	{
		// set execution time limit
		set_time_limit($this->TIME_LIMIT_SECS);

        $this->msgl = array();
		$this->result = array();
		$this->errmsg = "";

		if (!$path) $path = dirname(__FILE__);
		$this->log_file = $path . "/" . $this->log_file;
	}

    function enable_resale()
    {
        $this->is_resale = true;
    }

    function set_sln_reg_key($sln_reg_key)
    {
        $this->sln_reg_key = $sln_reg_key;
        $this->enable_resale();
    }

    /**
     * @brief TBSP parser
     * @param string tbspstr text string to parse
     * @return array peroperty parsed TBSP
     */
    function tbsp_parse($tbspstr)
    {
        $tbsparr = preg_split("/\n/", $tbspstr);
        $property = array();

        foreach ($tbsparr as $line)
        {
            $element = preg_split("/:/", $line);
            if (!isset($element[1]))
                continue;
            $name = $element[0];
            $value = $element[1];

            if ($name == "MESSAGE")
            {
                if (isset($property[$name]))
                    $property[$name] .= "\n" . $value;
                else
                    $property[$name] = $value;
            } else {
                $property[$name] = $value;
            }
        }
        return $property;
    }

    /**
     * @brief TBSP builder
     * @param array tbsp Array type TBSP to make as a text string.
     * @return string tbspstr A text string.
     */
    function tbsp_build($tbsp)
    {
        $tbspstr = "";

        foreach ($tbsp as $name => $value)
        {
            if ($name == "MESSAGE")
            {
                $msgarr = preg_split("/\n/", $value);
                foreach ($msgarr as $line)
                {
                    $tbspstr .= $name . ":" . $line . "\n";
                }
            } else
                $tbspstr .= $name . ":" . $value . "\n";
        }

        return $tbspstr;
    }


    /**
     * @brief CSCP reader
     * @param Socket pointer
     * @return CSCP content
     */
    function cscp_read($fp)
    {
        $CSCP_VERSION_SIZE = 7;
        $CSCP_BODYLEN_SIZE = 6;

        $version = fread($fp, $CSCP_VERSION_SIZE);
        $bodylen = fread($fp, $CSCP_BODYLEN_SIZE);
        $bodylen = intval($bodylen);
        $body = "";
        if ($bodylen > 0)
            $body = fread($fp, $bodylen);

        return $body;
    }

    /**
     * @brief CSCP builder
     * @param text string
     * @return capsulated text string
     */
    function cscp_build($str)
    {
        $capsule = "CSCP1.0";
        $capsule .= sprintf("%6d", strlen($str));
        $capsule .= $str;

        return $capsule;
    }

    /**
     * @brief strcut for multibytes string
     **/
    function cutout($msg, $limit) 
    {
        $msg = substr($msg, 0, $limit);

        for ($i = $limit - 1; $i > 1; $i--) 
        {	 
            if (ord(substr($msg,$i,1)) < 128) break;
        }

        $msg = substr($msg, 0, $limit - ($limit - $i + 1) % 2);

        return $msg;
    }

    /**
     * @brief strcut for utf8 string
     **/
    function strcut_utf8($str, $len, $checkmb=false, $tail='') {
        /**
         * UTF-8 Format
         * 0xxxxxxx = ASCII, 110xxxxx 10xxxxxx or 1110xxxx 10xxxxxx 10xxxxxx
         * latin, greek, cyrillic, coptic, armenian, hebrew, arab characters consist of 2bytes
         * BMP(Basic Mulitilingual Plane) including Hangul, Japanese consist of 3bytes
         **/
        preg_match_all('/[\xE0-\xFF][\x80-\xFF]{2}|./', $str, $match); // target for BMP

        $m = $match[0];
        $slen = strlen($str); // length of source string
        $tlen = strlen($tail); // length of tail string
        $mlen = count($m); // length of matched characters

        if ($slen <= $len) return $str;
        if (!$checkmb && $mlen <= $len) return $str;

        $ret = array();
        $count = 0;
        for ($i=0; $i < $len; $i++) {
            $count += ($checkmb && strlen($m[$i]) > 1)?2:1;
            if ($count + $tlen > $len) break;
            $ret[] = $m[$i];
        }

        return join('', $ret).$tail;
    }

    /**
     * @brief strlen for utf8 string
     **/
    function strlen_utf8($str, $checkmb = false) {
        preg_match_all('/[\xE0-\xFF][\x80-\xFF]{2}|./', $str, $match); // target for BMP

        $m = $match[0];
        $mlen = count($m); // length of matched characters

        if (!$checkmb) return $mlen;

        $count=0;
        for ($i=0; $i < $mlen; $i++) {
            $count += ($checkmb && strlen($m[$i]) > 1)?2:1;
        }

        return $count;
    }


    /**
     * @brief validate phone number
     * @return 0: good, 1: wrong size, 2: wrong prefix
     **/
    function check_phonenum($phonenum) {
        $phonenum = eregi_replace("[^0-9]", "", $phonenum);

        // check length
        if (strlen($phonenum) < 10 || strlen($phonenum) > 11) 
            return 1;

        // check prefix
        $prefix = substr($phonenum, 0, 3);
        if (eregi("[^0-9]", $prefix) 
            || ($prefix!='010' 
            && $prefix!='011' 
            && $prefix!='016' 
            && $prefix!='017' 
            && $prefix!='018' 
            && $prefix!='019'
            && $prefix!='070')
        ) return 2;

        return 0;
    }

    /**
     * @brief check datetime
     * @return 0: good, 1: wrong date, 2: wrong time
     **/
    function check_datetime($datetime) {
        $datetime = eregi_replace("[^0-9]", "", $datetime);
        if ($datetime) {
            // check date
            if (!checkdate(substr($datetime, 4, 2),substr($datetime, 6, 2),substr($datetime, 0, 4))) {
                trigger_error("invalid date value.", E_USER_ERROR);
                return 1;
            }
            // check time
            if (substr($datetime, 8, 2) > 23 || substr($datetime, 10, 2) > 59) {
                trigger_error("invalid time value.", E_USER_ERROR);
                return 2;
            }
        }
        return 0;
    }

    /**
     * @brief generate a key string.
     * @return key string
     **/
    function keygen()
    {
        $randval = rand(100000, 999999);
        $usec = explode(" ", microtime());
        $str_usec = str_replace(".", "", strval($usec[0]));
        $str_usec = substr($str_usec, 0, 6);
        return date("YmdHis") . $str_usec . $randval;
    }

    function __write_log__($log)
    {
        if ($this->logging_mode)
        {
            $fp = fopen($this->log_file, "a");
            fwrite($fp, $log);
            fclose($fp);
        }
    }

    function __connect__($host, $port) {
        $connected = false;
        $errno=0;
        $errstr="";

        $this->sockfp = @fsockopen($host, $port, $errno, $errstr, $this->timeout_seconds);
        $this->__write_log__("connect to: {$host}:{$port}\n");
        if ($this->sockfp)
        {
            $connected = true;
            stream_set_timeout($this->sockfp, $this->timeout_seconds);
            $this->__write_log__("Connected to: {$host}:{$port}\n");
        } else {
            $this->__write_log__("couldn't connect to: {$host}:{$port}\n");
        }

        return $connected;
    }

    function connect() {
        $connected = false;

        if ($this->is_resale)
            $gateways = $this->resale_gateways;
        else
            $gateways = $this->cool_gateways;

        foreach ($gateways as $host => $port) {
            $connected = $this->__connect__($host, $port);
            if ($connected) break;
        }
        return $connected;
    }

    function disconnect() {
        if ($this->sockfp) fclose($this->sockfp);
    }

    /**
     * @brief setting user id and password.
     **/
    function setuser($userid, $passwd, $crypt="MD5") 
    {
        $this->userid = $userid;
        if ($crypt == "MD5")
            $this->passwd = md5($passwd);
        else
            $this->passwd = $passwd;
    }

    function setcrypt($crypt="MD5")
    {
        $this->crypt = $crypt;
    }

    /**
     * @brief setting charset
     * @param charset, default: euckr
     * @return success: true , fail: false
     **/
    function charset($_charset="euckr") {
        if (!in_array($_charset, array("utf8", "euckr"))) {
            trigger_error("unknown charset.", E_USER_ERROR);
            return false;
        }
        $this->_charset = $_charset;
        return true;
    }

    /**
     * @brief setting application's name & version
     * @param version string APPNAME/VERSION
     **/
    function appversion($version) {
        $this->app_version = $version;
    }

    /**
     * @brief empty all of message list
     **/
    function emptyall() 
    {
        $this->msgl = array();
        $this->result = array();
    }

    /**
     * @brief reutrn result array for transmission.
     **/
    function getr() 
    {
        return $this->result;
    }

    function printr()
    {
        foreach($this->result as $rs)
        {
            foreach ($rs as $key => $val) {
                echo "{$key} : {$val}<br />";
            }
        }
    }

    /**
     * @brief return error boolean.
     * @return if successful return true, otherwise false
     **/
    function errordetected()
    {
        if ($this->errmsg != "")
            return true;
        return false;
    }

    function lasterror()
    {
        $errmsg = $this->errmsg;
        $this->errmsg = "";
        return $errmsg;
    }

    /**
     * @brief add message as object
     * @param $args->rcvnum
     * @param $args->callback
     * @param $args->msg
     * @param $args->callname
     * @param $args->reservdate
     * @param $args->msgid
     * @param $args->type
     * @param $args->subject
     * @param $args->groupid
     * @param $args->country
     * @param $args->delay_count
     **/
    function addobj($args)
    {

        if ($args->reservdate && $this->check_datetime($args->reservdate) > 0) {
            $this->errmsg = "wrong reservation datetime : " . $args->reservdate;
            return false;
        }

        $tbsp = array();

        if ($this->sln_reg_key) $tbsp["SLN-REG-KEY"] = $this->sln_reg_key;
        $tbsp["VERSION"] = $this->VERSION_STR;
        $tbsp["MODULE-VERSION"] = $this->module_version;
        if ($this->app_version)
            $tbsp["APP-VERSION"] = $this->app_version;
        $tbsp["COMMAND"] = "SEND";
        if ($this->_charset) 
            $tbsp["CHARSET"] = $this->_charset;
        $tbsp["MESSAGE"] = $args->msg;
        if ($args->msgid)
            $tbsp["MESSAGE-ID"] = $args->msgid;
        if ($args->groupid)
            $tbsp["GROUP-ID"] = $args->groupid;
        $tbsp["CALLED-NUMBER"] = $args->rcvnum;
        $tbsp["CALLING-NUMBER"] = $args->callback;
        if ($args->callname)
            $tbsp["CALLED-NAME"] = $args->callname;
        if ($args->reservdate)
            $tbsp["RESERVE-DATE"] = $args->reservdate;
        if ($this->crypt == "MD5")
            $tbsp["CRYPT-METHOD"] = "MD5";
        $tbsp["AUTH-ID"] = $this->userid;
        $tbsp["AUTH-PASS"] = $this->passwd;
        $version = "Unknown";
        if (function_exists("phpversion"))
            $version = phpversion();
        $language = "PHP-" . $version;
        $tbsp["LANGUAGE"] = $language;
        $tbsp["TYPE"] = $args->type;
        if ($args->subject)
            $tbsp["SUBJECT"] = $args->subject;
        if ($args->country)
            $tbsp["COUNTRY-CODE"] = $args->country;
        if ($args->attachment)
            $tbsp["ATTACHMENT"] = $args->attachment;
        if ($this->options)
			$tbsp["OPTIONS"] = $this->options;
        if ($args->delay_count)
			$tbsp["DELAY-COUNT"] = $args->delay_count;

        $this->msgl[] = $tbsp;

        return true;
    }

    /**
     * @brief add sms as object
     **/
    function addsmsobj($args)
    {
        $args->type = 'SMS';
        return $this->addobj($args);
    }

    /**
     * @brief add lms as object
     **/
    function addlmsobj($args)
    {
        $args->type = 'LMS';
        return $this->addobj($args);
    }

    /**
     * @brief add mms as object
     **/
    function addmmsobj($args) {
        $args->type = 'MMS';
        return $this->addobj($args);
    }

    /**
     * @brief add
     **/
    function add($rcvnum, $callback, $msg, $callname="", $reservdate="", $msgid="", $type="SMS", $subject="", $groupid="", $delay_count=0) 
    {
        $args = new StdClass();
        $args->rcvnum = $rcvnum;
        $args->callback = $callback;
        $args->msg = $msg;
        $args->callname = $callname;
        $args->reservdate = $reservdate;
        $args->msgid = $msgid;
        $args->type = $type;
        $args->subject = $subject;
        $args->groupid = $groupid;
        $args->delay_count = $delay_count;

        return $this->addobj($args);
    }

    /**
     * @brief addsms
     **/
    function addsms($rcvnum, $callback, $msg, $callname="", $reservdate="", $msgid="", $groupid="", $delay_count=0)
    {
        return $this->add($rcvnum, $callback, $msg, $callname, $reservdate, $msgid, "SMS", "", $groupid, $delay_count);
    }

    /**
     * @brief addlms
     **/
    function addlms($rcvnum, $callback, $subject, $msg, $callname="", $reservdate="", $msgid="", $groupid="")
    {
        return $this->add($rcvnum, $callback, $msg, $callname, $reservdate, $msgid, "LMS", $subject, $groupid);
    }

    /**
     * @brief sending all of list.
     **/
    function send() 
    {
        $count = 0;
        $tbspstr = "";
        foreach($this->msgl as $tbsp) {
            $cscp = new CSCP($this->sockfp);
            if (array_key_exists("ATTACHMENT", $tbsp)) {
                if (!is_array($tbsp["ATTACHMENT"])) $image_list = array($tbsp["ATTACHMENT"]);
                else $image_list = $tbsp["ATTACHMENT"];

                $filename = array();
                foreach ($image_list as $image) {
                    $image_content = file_get_contents($image);
                    $image = basename($image);
                    $filename[] = $image;
                    $cscp->addparam(constant("CSCPPARAM_ID_ATTACHMENT"), sprintf("%03u", strlen($image)) . $image . $image_content);
                }
                $tbsp["ATTACHMENT"] = implode(",", $filename);
            }
            $cscp->addparam(constant("CSCPPARAM_ID_MESSAGE"), coolsms::tbsp_build($tbsp));

            $cscp->build();
            if (!$cscp->send()) {
                $this->errmsg = "cscp send error";
                continue;
                // error
            }
            // fputs($this->sockfp, $req);

            $ack = new CSCP($this->sockfp);
            if (!$ack->read()) {
                $this->errmsg = "cscp ack read error";
                $this->__write_log__("cscp ack read error");
                continue;
                // error
            }
            $param = $ack->getparam(constant("CSCPPARAM_ID_MESSAGE"));
            $tbspstr = $param->getbody();

            /*
            $tbspstr = coolsms::cscp_read($this->sockfp);
             */
            if (!$tbspstr)
            {
                $this->errmsg = "cscp_read error";
                $this->__write_log__("cscp_read error");
                continue;
            }
            $tbsp = coolsms::tbsp_parse($tbspstr);
            if (!$tbsp)
            {
                $this->errmsg = "tbsp_parse error";
                $this->__write_log__("tbsp_parse error");
                continue;
            }

            $this->result[] = $tbsp;
            $count++;
        }
        return $count;
    }

    function credits()
    {
        return $this->remain();
    }

    function remain()
    {
        $tbsp = array();
        $tbsp["VERSION"] = $this->VERSION_STR;
        $tbsp["MODULE-VERSION"] = $this->module_version;
        if ($this->app_version)
            $tbsp["APP-VERSION"] = $this->app_version;
        $tbsp["COMMAND"] = "CHECK-CREDITS";
        if ($this->crypt == "MD5")
            $tbsp["CRYPT-METHOD"] = "MD5";
        $tbsp["AUTH-ID"] = $this->userid;
        $tbsp["AUTH-PASS"] = $this->passwd;
        if ($this->options)
			$tbsp["OPTIONS"] = $this->options;

        $cscp = new CSCP($this->sockfp);
        $cscp->addparam(constant("CSCPPARAM_ID_MESSAGE"), coolsms::tbsp_build($tbsp));
        $cscp->build();
        if (!$cscp->send()) {
            $this->errmsg = "cscp send error";
            return false;
        }

        /*
        $cscp_str = coolsms::cscp_build(coolsms::tbsp_build($tbsp));
        fputs($this->sockfp, $cscp_str);
         */

        $ack = new CSCP($this->sockfp);
        if (!$ack->read()) {
            $this->errmsg = "cscp ack read error";
            $this->__write_log__("cscp ack read error");
            return false;
        }

        $param = $ack->getparam(constant("CSCPPARAM_ID_MESSAGE"));
        $tbspstr = $param->getbody();
        /*
        $tbspstr = coolsms::cscp_read($this->sockfp);
         */
        if (!$tbspstr)
        {
            $this->errmsg = "cscp_read error";
            $this->__write_log__("cscp_read error");
        }
        $ack = coolsms::tbsp_parse($tbspstr);
        if (!$ack)
        {
            $this->errmsg = "tbsp_parse error";
            $this->__write_log__("tbsp_parse error");
        }

        return $ack;
    }

    /**
     * STATUS
     * RESULT-CODE 
     * RESULT-MESSAGE
     */
    function rcheck($msgid)
    {
        $tbsp = array();
        $tbsp["VERSION"] = $this->VERSION_STR;
        $tbsp["MODULE-VERSION"] = $this->module_version;
        if ($this->app_version)
            $tbsp["APP-VERSION"] = $this->app_version;
        $tbsp["COMMAND"] = "CHECK-RESULT";
        if ($this->crypt == "MD5")
            $tbsp["CRYPT-METHOD"] = "MD5";
        $tbsp["AUTH-ID"] = $this->userid;
        $tbsp["AUTH-PASS"] = $this->passwd;
        $tbsp["MESSAGE-ID"] = $msgid;
        if ($this->options)
			$tbsp["OPTIONS"] = $this->options;
        $cscp_str = coolsms::cscp_build(coolsms::tbsp_build($tbsp));


        fputs($this->sockfp, $cscp_str);

        $tbspstr = coolsms::cscp_read($this->sockfp);

        if (!$tbspstr)
        {
            $this->errmsg = "cscp_read error";
            $this->__write_log__("cscp_read error");
        }
        $tbsp = coolsms::tbsp_parse($tbspstr);
        if (!$tbsp)
        {
            $this->errmsg = "tbsp_parse error";
            $this->__write_log__("tbsp_parse error");
        }

        return $tbsp;

    }

    /**
     * @brief cancel
     **/
	function cancel($msgid) 
	{
		$tbsp = array();

		$tbsp["VERSION"] = $this->VERSION_STR;
        $tbsp["MODULE-VERSION"] = $this->module_version;
        if ($this->app_version)
            $tbsp["APP-VERSION"] = $this->app_version;
		$tbsp["COMMAND"] = "CANCEL";
	    $tbsp["MESSAGE-ID"] = $msgid;
		if ($this->crypt == "MD5")
			$tbsp["CRYPT-METHOD"] = "MD5";
		$tbsp["AUTH-ID"] = $this->userid;
		$tbsp["AUTH-PASS"] = $this->passwd;
		$version = "Unknown";
		if (function_exists("phpversion"))
			$version = phpversion();
		$language = "PHP-" . $version;
		$tbsp["LANGUAGE"] = $language;
        if ($this->options)
			$tbsp["OPTIONS"] = $this->options;

		$cscp_str = coolsms::cscp_build(coolsms::tbsp_build($tbsp));

        fputs($this->sockfp, $cscp_str);

        $tbspstr = coolsms::cscp_read($this->sockfp);
        if (!$tbspstr)
        {
            $this->errmsg = "cscp_read error";
            $this->__write_log__("cscp_read error");
            return $tbsp;
        }
        $tbsp = coolsms::tbsp_parse($tbspstr);
        if (!$tbsp)
        {
            $this->errmsg = "tbsp_parse error";
            $this->__write_log__("tbsp_parse error");
            return $tbsp;
        }

		return $tbsp;
	}

    /**
     * @brief groupcancel
     **/
	function groupcancel($gid) 
	{
		$tbsp = array();

		$tbsp["VERSION"] = $this->VERSION_STR;
        $tbsp["MODULE-VERSION"] = $this->module_version;
        if ($this->app_version)
            $tbsp["APP-VERSION"] = $this->app_version;
		$tbsp["COMMAND"] = "GROUP-CANCEL";
	    $tbsp["GROUP-ID"] = $gid;
		if ($this->crypt == "MD5")
			$tbsp["CRYPT-METHOD"] = "MD5";
		$tbsp["AUTH-ID"] = $this->userid;
		$tbsp["AUTH-PASS"] = $this->passwd;
		$version = "Unknown";
		if (function_exists("phpversion"))
			$version = phpversion();
		$language = "PHP-" . $version;
		$tbsp["LANGUAGE"] = $language;
        if ($this->options)
			$tbsp["OPTIONS"] = $this->options;

		$cscp_str = coolsms::cscp_build(coolsms::tbsp_build($tbsp));

        fputs($this->sockfp, $cscp_str);

        $tbspstr = coolsms::cscp_read($this->sockfp);
        if (!$tbspstr)
        {
            $this->errmsg = "cscp_read error";
            $this->__write_log__("cscp_read error");
            return $tbsp;
        }
        $tbsp = coolsms::tbsp_parse($tbspstr);
        if (!$tbsp)
        {
            $this->errmsg = "tbsp_parse error";
            $this->__write_log__("tbsp_parse error");
            return $tbsp;
        }

		return $tbsp;
	}

    /**
     * @brief set callback url
     **/
	function setcallbackurl($callback_url) 
	{
		$tbsp = array();

		$tbsp["VERSION"] = $this->VERSION_STR;
        $tbsp["MODULE-VERSION"] = $this->module_version;
        if ($this->app_version)
            $tbsp["APP-VERSION"] = $this->app_version;
		$tbsp["COMMAND"] = "CALLBACK-URL";
	    $tbsp["URL"] = $callback_url;
		if ($this->crypt == "MD5")
			$tbsp["CRYPT-METHOD"] = "MD5";
		$tbsp["AUTH-ID"] = $this->userid;
		$tbsp["AUTH-PASS"] = $this->passwd;
		$version = "Unknown";
		if (function_exists("phpversion"))
			$version = phpversion();
		$language = "PHP-" . $version;
		$tbsp["LANGUAGE"] = $language;
        if ($this->options)
			$tbsp["OPTIONS"] = $this->options;

		$cscp_str = coolsms::cscp_build(coolsms::tbsp_build($tbsp));

        fputs($this->sockfp, $cscp_str);

        $tbspstr = coolsms::cscp_read($this->sockfp);
        if (!$tbspstr)
        {
            $this->errmsg = "cscp_read error";
            $this->__write_log__("cscp_read error");
            return $tbsp;
        }
        $tbsp = coolsms::tbsp_parse($tbspstr);
        if (!$tbsp)
        {
            $this->errmsg = "tbsp_parse error";
            $this->__write_log__("tbsp_parse error");
            return $tbsp;
        }

		return $tbsp;
	}

    function encode_utf16()
    {
        if ($this->options) $this->options .= ";";
        $this->options .= "ENCODE-UTF16=1";
    }
}

/**
 * @brief CSCP v2
 **/
class CSCP {
    var $sockfp;
    var $params;
    var $bodylen;
    var $buf;

    var $debug = false;

    /**
     * @brief contructor
     **/
    function CSCP($fp) {
        $this->sockfp = $fp;
        $this->params = array();
        $this->bodylen = 0;
        $this->buf = null;
    }

    function send() {
        if ($this->buf) fwrite($this->sockfp, $this->buf);
        return true;
    }

    function read() {
        $version = fread($this->sockfp, constant("CSCP_VERSION_SIZE"));
        $bodylen = fread($this->sockfp, constant("CSCP_BODYLEN_SIZE"));

        $bodylen = intval($bodylen);

        $body = false;

        //if ($bodylen > 0) $body = fread($this->sockfp, $bodylen);
        if ($bodylen > 0) {
            $restlen = bodylen;
            do {
                $param = new CSCPPARAM($this->sockfp);
                $param->debug = $this->debug;
                if (!$param->read()) {
                    // error
                    return false;
                }
                $restlen -= $param->size();
                $this->add($param);
            } while($restlen > 0);
        }

        return true;
    }

    function getparam($id) {
        foreach ($this->params as $param) {
            if ($param->getid() == $id) return $param;
        }
    }

    function add($param) {
        $this->params[] = $param;
        $this->bodylen += $param->size();
    }

    function addparam($id, $body) {
        $param = new CSCPPARAM();
        $param->setid($id);
        $param->setbody($body);
        $param->build();
        $this->add($param);
    }

    function build() {
        $this->buf = constant("CSCP_VERSION");
        $this->buf .= sprintf("%08u", $this->bodylen);
        foreach ($this->params as $param) {
            $this->buf .= $param->getbin();
        }
    }
}

class CSCPPARAM {

    var $sockfp;
    var $id;
    var $body;
    var $bodylen;
    var $buf;

    var $debug = false;

    function CSCPPARAM($fp=null) { $this->sockfp = $fp; }
    function setid($id) { $this->id = $id; }
    function setbody($body) { $this->body = $body; $this->bodylen = strlen($body); }
    function size() { return constant("CSCPPARAM_ID_SIZE") + constant("CSCPPARAM_BODYLEN_SIZE") + $this->bodylen; }
    function bodysize() { return $this->bodylen; }
    function getid() { return $this->id; }
    function getbody() { return $this->body; }
    function getbin() { return $this->buf; }

    function build() {
        $this->buf = $this->id;
        $this->buf .= sprintf("%08u", $this->bodylen);
        $this->buf .= $this->body;
    }

    function read() {
        // id
        $this->id = fread($this->sockfp, constant("CSCPPARAM_ID_SIZE"));
        // bodylen
        $this->bodylen = intval(fread($this->sockfp, constant("CSCPPARAM_BODYLEN_SIZE")));
        if ($this->debug) echo "BODYLEN:" . $this->bodylen;
        // body
        $this->body = fread($this->sockfp, $this->bodylen);
        if ($this->debug) echo "BODY:" . $this->body;

        return true;
    }
}
?>
