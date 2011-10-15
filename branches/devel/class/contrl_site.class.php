<?php

/**
 * @author PetrOFF <andi-fm@ya.ru>
 * @version Look in the config
 * 
 * @package Contrl_site
 * @category Core
 * Core
 */
class contrl_site extends api {

    /**
     *
     * @param object $db class for work database
     * @param object $view class to create visual content
     * @param object $model model of database queries
     * @param object $routes routing url
     * @param object $cache cache class
     */
    function __construct($db, $view, $model, $routes, $cache) {
        $this->view = $view;
        $this->model = $model;
        $this->db = $db;
        $this->url = array();
        $this->routes = $routes;
        $this->cache = $cache;
    }

    /**
     * Starts the secondary units, caches them
     * @param array $url url
     * @param array $sys these branches,schedule
     * @return array content ['side']=>content
     */
    function schedule($url, $sys) {
        if (empty($sys['schedule']))
            return false;
        $data = array();
        foreach ($sys['schedule'] as $key => $value) {
            if (($value['cache'] || $value['free_cache'] == "_" . $value['name'] . "_schedule") && $ret = $this->cache->get($this->cache_path, "(" . $value['class'] . ")" . "(" . $GLOBALS['lang'] . ")" . "(sh)" ."(".$value['id'].")". "(" . $_SESSION['user']['level'] . ")")) {
                $data = array_merge($data, $ret);
                $data['cache_sh'].="Schedule: " . $value['class'] . ":" . $value['name'] . "<br />";
            } else {

                // $sys,$shd,$url,$id_sch,$id_int
                $ret = call_user_func(array($this->_load_module($value['class']), "_" . $value['name'] . "_schedule"), $sys['ns_tree'], $value, $url, $value['id'], @$sys['idint']);
                if (is_array($ret)) {
                    $data = array_merge($data, $ret);
                    if ($value['cache'] || $value['free_cache'] == "_" . $value['name'] . "_schedule") {
                        $this->cache->save($ret);
                        $data['cache_sh'] = false;
                    }
                }
            } //end cache
        } //end foreach
        return $data;
    }

    /**
     * Appoints the language choose the primary information about the node, selects the main module for this thread, does caching this module, selects the secondary units (Scheduled)
     * @param array $url url [0]=>class [1]=>func [2]=>param [3]..[4]...[][]
     * @return array content ['side']=>content  ['schedule']=> [0]=>secondary module1 [1]=>secondary module2 .....
     */
    function events($url) {

        $this->view->set_lang($this->lang);
        if (empty($url[0]) || count($url) == 1)
            $url[0] = 1;
        else
            array_shift($url);

        if (is_numeric($url[0]))
            $ns_tree = $this->model->GetInfoForLinkTreeById($url[0]);
        else
            $ns_tree=$this->model->GetInfoForLinkTreeByName($url[0]);

        if ($ns_tree) {
            if (isset($url[1])) {
                $url[0] = $ns_tree['module'];
            } else {
                $url[0] = $ns_tree['module'];
                $url[1] = $ns_tree['func_name'];
            }
            $cache = $ns_tree['cache'];
            $free_cache = $ns_tree['free_cache'];
            $this->cache_path = implode("/", $url) . "/" . $ns_tree['name'];
            $info['ns_tree'] = $ns_tree;
        } else {
            $all_module = $this->model->return_task($_SESSION['user']['level']);
            foreach ($all_module as $key => $value) {
                if ($value['class'] == $url[0] && $value['events']) {
                    $cache = $value['cache'];
                    $free_cache = $value['free_cache'];
                    $this->cache_path = implode("/", $url);
                    if (!isset($url[1]))
                        $url[1] = $value['name'];
                    $info['modules'] = $value;
                    break;
                }
            }
        }

        if (empty($info['ns_tree']) && empty($info['modules']))
            $this->show_404();
        $class = $this->_load_module($url[0]);
        if (isset($class)) {
            if (($cache || $free_cache == $url[1]) && $data = $this->cache->get($this->cache_path, "(" . $url[0] . ")" . "(" . $GLOBALS['lang'] . ")" . "(ev)" . "(" . $_SESSION['user']['level'] . ")")) {
                $data['cache'] = "Event: " . $url[0] . ":" . $url[1] . "<br />";
                return $data;
            } else {
                $arg = array_slice($url, 2);
                array_unshift($arg, $info);
                $data = call_user_func_array(array($class, $url[1]), $arg);
                $data['sys']['schedule'] = $this->model->getShedule($data['sys']['ns_tree']['id'], $data['sys']['idint']);
                if ($cache || $free_cache == $url[1]) {
                    $this->cache->save($data);
                    $data['cache'] = false;
                }
                return $data;
            }
        };
        $this->show_404();
    }

    /**
     * Parse the URL, it assigns the value of the array, check for a specified length and not safe characters,made route
     * @return array url [0]=>lang [1]=>class [2]=>method [3][4]... =>param 
     */
    function parse_uri() {
        $url = $this->analysis_url(SITE_URL, $_SERVER['REDIRECT_URL']);
        if (empty($url)) {
            $url[0] = "";
        } else {
            if ($url[0] == '/')
                $url = substr($url, 1);
            $url = $this->route($url);
            if ($url[strlen($url) - 1] == '/')
                $url = substr($url, 0, -1);
            $url = explode('/', $url);
            $count = count($url);
        }
        if ($url[0] != ADMIN_DIR) {
            $this->_call_out_func("lang", "set_lang", @$url[0]);
            $this->lang = $this->_call_out_func("lang", "get_message_module");
        }
        for ($i = 0; $i < $count; $i++) {
            $url[$i] = $this->security($url[$i], 6, 20);
            if ($url[$i] === false && $url[$i] !== "0")
                $this->show_404("Core", "events", "Bad symvol in URL");
        }
        $this->url = $url;
        return $url;
    }

    /**
     * Starting method analyzes the URL, calls the module for a given URL, launch the secondary units (according to schedule)
     * @return string final content
     */
    function core() {
        $this->start_time();
        $url = $this->parse_uri();
        if ($url[0] == ADMIN_DIR) {//backend start
            require_once"class/add.contrl.class.php";
            require_once"class/contrl_admin.class.php";
            new contrl_admin($this->db, $this->view, $this->model, $this->routes, $this->cache, $url);
        } else {
            $data = $this->events($url);
            $data_schedule = $this->schedule($url, $data['sys']);
            if (is_array($data_schedule))
                $data = array_merge($data_schedule, $data);
            $this->view->view($data['sys']['ns_tree']['path_file'], $data);
        }
        if (DEBUG_INFO) {
            if ($data['cache'] || $data['cache_sh'])
                $cache = $data['cache'] . " " . $data['cache_sh'];
            $debug['time'] = $this->end_time();
            $debug['cache'] = $cache;
            $this->view->view("templates/admin/info/debug.tpl", $debug);
        }
    }

}

?>