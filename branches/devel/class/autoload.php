<?

/**
 * @author PetrOFF <andi-fm@ya.ru>
 * 
 * @category Core
 */
function __autoload($class) {

    if (!class_exists($class))
        if (file_exists(LIBRARY_PATH . $class . "/" . $class . ".php")) {
            require_once LIBRARY_PATH . $class . "/" . $class . ".php";
        } else {
            echo"error load class!";
        }
}

?>