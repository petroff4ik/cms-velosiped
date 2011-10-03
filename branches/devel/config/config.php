<?php

/**
 * @author PetrOFF <andi-fm@ya.ru>
 * 
 * @package Config
 * @category Config
 * config:
 * 
 */
define('SITE_URL', 'http://db/');
define('SITE_DIR', '/home/db/www/');
define('ADMIN_DIR', 'admin');
define('ADMIN_DIR_FULL', SITE_URL . ADMIN_DIR . "/");
define('LIBRARY_PATH', SITE_DIR . "library/");
define('SUM_PAGE', '5');
define('SECURITY_LEN_STRING', '20000');
define('COUNT_ERR_LOGIN', '5');
define('LEVEL_ACCESS_ADMINPANEL', '2');
define('ADMIN_THRESHOLD', '5');
define('ADMIN_LANG', 'ru');
define('ADMIN_ARR_LANGS', 'ru');
define('CHARSET', 'utf8');
define('DELEMITER_SYMVOL', 200);
define('TOLOG', true);
define('ACTIONLOG', true);
define('LOG_DIR', SITE_DIR . "log/");
define('DEBUG_INFO', true);
define('UPDATE', true);
define('LIMIT_DB', 10);
define('HOST', 'localhost');
define('PASS', '');
define('NAME_BASA', 'test');
define('USER', 'root');
define('ROOT_TREE_TITLE_SHOW',false);
//cache
$options = array(
    'caching' => false,
    'cacheDir' => SITE_DIR . 'tmp/',
    'lifeTime' => 3600,
    'automaticSerialization' => true
);

define('CACHE', $options['caching']);
define('CACHE_DIR', $options['cacheDir']);
?>