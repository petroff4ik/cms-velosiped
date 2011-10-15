<?

/**
 * @author PetrOFF <andi-fm@ya.ru>
 * 
 * @package Error
 * @category Core
 * Function for work error, logging
 */
class error {

    protected function show_error() {
        $tmp = func_get_args();
        $err = "in the module <strong>" . $tmp[0] . "</strong> -> ";
        switch ($tmp[0]) {

            case "db": {
                    if (empty($tmp[3]))
                        $tmp[3] = $tmp[1];
                    $this->print_error(@$tmp[3], $tmp[1]);
                }break;

            case "buffer": {
                    $err.="path file wrong " . $tmp[1];
                    $this->print_error($err, "Templates error!");
                }break;

            default: {
                    $err = "not undestand type error</br><hr/>";
                    foreach ($tmp as $key => $value) {
                        $err.="<br>" . $value . "<br>";
                    }
                    $err.="<hr><br/>";
                    $this->print_error($err, "Unidentified error!");
                };
                break;
        }
    }

    protected function print_error($add="", $privateR="Error") {
        if (TOLOG) {
            $this->write_log("<b>" . date("Y-m-d h:m") . "</b> -> " . $_SERVER['REMOTE_ADDR'] . " " . @$_SESSION['type'] . " " . @$_SESSION['user']['adress'] . " " . SITE_URL . $_SERVER['REQUEST_URI'] . " <b>Add:</b>" . $add . "  (print_error)<br />");
            echo"<div style='clear: both;'><div style='border:1px solid;padding:10px;position:relative;top:10px;float:left ;margin:10px;'><font color='red'>$privateR</font></div><br/></div>";
            return;
        }
        echo"<div style='clear: both;'><div style='border:1px solid;padding:10px;position:relative;top:10px;float:left ;margin:10px;'><font color='red'>$add</font></div><br/></div>";
    }

    protected function error($add="Error! (empty arg.)") {
        if (TOLOG) {
            $this->write_log("<b>" . date("Y-m-d h:m") . "</b> -> " . $_SERVER['REMOTE_ADDR'] . " " . @$_SESSION['type'] . " " . @$_SESSION['user']['adress'] . " " . SITE_URL . $_SERVER['REQUEST_URI'] . " <b>Add:</b>" . $add . "  (error)<br />");
            exit();
        } else {
            echo"<div style='clear: both;'><div style='border:1px solid;padding:10px;position:relative;top:10px;float:left ;margin:10px;'><font color='red'>" . $add . "</font></div><br/></div>";
            exit();
        }
    }

    protected function wrapper_error($add="Error default") {
        if (TOLOG) {
            $this->write_log("<b>" . date("Y-m-d h:m") . "</b> -> " . $_SERVER['REMOTE_ADDR'] . " " . @$_SESSION['type'] . " " . @$_SESSION['user']['adress'] . " " . SITE_URL . $_SERVER['REQUEST_URI'] . " <b>Add:</b>" . $add . "  (error)<br />");
            return;
        } else {
            return "<div style='clear: both;'><div style='border:1px solid;padding:10px;position:relative;top:10px;float:left ;margin:10px;'><font color='red'>" . $add . "</font></div><br/></div>";
        }
    }

    protected function show_404($method="", $params="", $add="") {
        if (TOLOG)
            $this->write_log("<b>" . date("Y-m-d h:m") . "</b> -> " . $_SERVER['REMOTE_ADDR'] . " " . @$_SESSION['type'] . " " . @$_SESSION['user']['adress'] . " " . SITE_URL . $_SERVER['REQUEST_URI'] . "  <b>Method:</b>" . $method . "  <b>Param:</b>" . print_r($param) . " <b>Add:</b>" . $add . "  (show_404)<br />");
        include_once(SITE_DIR . "templates/errors/404.tpl");
        exit();
    }

    function __call($method, $params) {
        if (TOLOG) {
            $this->write_log("<b>" . date("Y-m-d h:m") . "</b> -> " . $_SERVER['REMOTE_ADDR'] . " " . @$_SESSION['type'] . " " . @$_SESSION['user']['adress'] . " " . SITE_URL . $_SERVER['REQUEST_URI'] . "  <b>Method:</b>" . $method . "  <b>Param:</b>" . print_r($param) . " <b>Add:</b>" . $add . " (__call)<br />");
            return;
        } else {
            echo "Output in module error::Call nothing $method ->" . print_r($params);
        }
    }

    protected function write_log($text, $file="error.log") {
        if (!file_exists(LOG_DIR . $file)) {
            echo $this->lang['l_notfoundlog'];
            return;
        }
        $fp = fopen(LOG_DIR . $file, 'a');
        flock($fp, LOCK_EX); // ������������ ����� ��� ������
        fwrite($fp, $text);
        flock($fp, LOCK_UN); // ������ ����������
        fclose($fp);
    }

}

?>