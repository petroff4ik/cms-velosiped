<?

/**
 * @author PetrOFF <andi-fm@ya.ru>
 * @version Look in the config
 * 
 * Load class,config etc
 */
error_reporting(E_ALL & ~E_NOTICE);
setlocale(LC_ALL, "UTF-8");
set_include_path(dirname(__FILE__) . '/');
ini_set("magic_quotes_runtime", 0);
require_once"config/config.php";
require_once"config/version.php";
require_once"config/route.php";
require_once"class/autoload.php";
require_once"class/error.class.php";
require_once"class/api.class.php";
require_once"modules/add_model_module.class.php";
require_once"modules/add_module.class.php";
require_once"class/model.class.php";
require_once"class/db.class.php";
require_once"class/bufer.class.php";
require_once"class/contrl_site.class.php";
require_once"class/Lite.php";

global $lang;

$db = new db(HOST, USER, PASS, NAME_BASA);

$view = new buffer($db);
$model = new model($db);
$Cache = new Cache_Lite($options);
$contrl = new contrl_site($db, $view, $model, $routes, $Cache);

$contrl->core();
?>