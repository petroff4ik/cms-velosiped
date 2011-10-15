<?php

/**
 * @author PetrOFF <andi-fm@ya.ru>
 * 
 * @package Buffer
 * @category Core
 * Map of content
 */
class buffer extends api {

    protected $lang = array();
    protected $db;

    function __construct($db, $filename="") {
        $this->db = $db;
        $this->path['path'] = SITE_URL;
        $this->path['admin_dir_full'] = ADMIN_DIR_FULL;
        if (file_exists($filename)) {
            $this->buffer.=join(" ", file(SITE_DIR . $filename));
        }
    }

    function view($filename, $arr="", $arg=false) {
        if (file_exists($filename)) {
            if (empty($arr))
                $arr = array();
            extract($arr + $this->path + $this->lang);
            if ($arg != 1) {
                include (SITE_DIR . $filename);
                return;
            } else {
                ob_start();                    // Start output buffering
                include(SITE_DIR . $filename);                // Include the file
                $contents = ob_get_contents(); // Get the contents of the buffer
                ob_end_clean();                // End buffering and discard
                return $contents;
            }
        } else {
            $this->show_error("buffer", $filename);
        }
    }

    function set_lang($lang) {
        $this->lang = $lang;
        $this->path['site_url'] = SITE_URL . $GLOBALS['lang'] . "/";
    }

}

?>