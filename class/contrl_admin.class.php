<?php

/**
 * @author PetrOFF <andi-fm@ya.ru>
 * 
 * @package contrl_admin
 * @category Core
 */
class contrl_admin extends add_contrl {

    private $tree;
    protected $actionlog;

    /**
     * Great for a "large switch" :( , the selection function in this design
     * @param array $url url[]=>param
     * @return string content ['body']=>content 
     */
    protected function edit($url) {
        $datas = $this->model->GetInfoForLinkTree($url[1]);
        $datas['aliaslink'] = $this->model->GetAllAliasForLink($url[1]);
        $datas['showside'] = $this->model->return_side($datas['template_out']);
        $datas['allModules'] = $this->model->return_config_mod_by_events();
        $datas['alltemplates'] = $this->model->return_all_templates();
        $datas['tree'] = $this->_call_out_func("tree_model", "return_cat", "cat!", $url[1]);
        $data['body'] = $this->view->view("templates/admin/edit.tpl", $datas, true);
        return $data;
    }

    protected function create($url) {
        $data['cat'] = $this->model->get_info($url[1], "name");
        $data['id'] = $this->model->get_info($url[1], "id");
        if (!isset($url[2]))
            $url[2] = 1;
        $data['dir'] = $this->_call_out_func("tree", "get_doc", $data['id'], $url[2], "", "create");
        $data['body'] = $this->view->view("templates/admin/create.tpl", $data, true);
        return $data;
    }

    protected function edit_doc($url) {
        $data['id'] = $url[1];
        $data['lang'] = $url[2];
        $data['url_quit'] = $url[3];
        $data['url_arg'] = $url[4];
        $data['relink'] = $_SERVER['HTTP_REFERER'];
        $data['editor'] = $this->model->get_doc($url[1], $url[2]);
        $data['body'] = $this->view->view("templates/admin/doc/edit_doc.tpl", $data, true);
        return $data;
    }

    protected function save_edit($url) {
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $url[1]));
        $this->cache->clean("tree,sh", "callback_killByGroup");
        $this->set_message($this->_call_out_func("tree", "save_ns_tree", $url[1], $url[2], $_POST));
        $this->relink(ADMIN_DIR_FULL);
        return $data;
    }

    protected function save_edit_d($url) {
        $this->set_message($this->model->save_d($url[1], $url[2], $_POST['edit']));
        $this->cache->clean($url[2], "callback_killByGroup");
        $this->relink($_POST['relink']);
        return $data;
    }

    protected function save_doc($url) {
        $this->model->save_doc($url[1], $_POST['edit'], $_POST['name'], $_POST['show_me']);
        header("location: /" . ADMIN_DIR);
        return $data;
    }

    protected function delnsdoc($url) {
        $this->set_message($this->model->delnsdoc($url[1]));
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $this->_call_out_func("tree_model", "get_info", "father_id", "ns_doc", "id", $url[1])));
        $this->relink($_POST['relink']);
        return $data;
    }

    protected function add($url) {
        $data['showside'] = $this->model->return_side();
        $data['allModules'] = $this->model->return_config_mod_by_events();
        $data['lang'] = $this->_call_out_func("lang", "return_all_lang_array");
        $data['alltemplates'] = $this->model->return_all_templates();
        $data['cat'] = $this->model->get_info($url[1], "name");
        $data['id'] = $this->model->get_info($url[1], "id");
        $data['body'] = $this->view->view("templates/admin/add_del.tpl", $data, true);
        return $data;
    }

    protected function add_in($url) {
        $this->security("POST", "", 200);
        $module = $this->_call_out_func("tree", "_add", $url[1], $_POST['add_in'], $_POST['show'], $_POST['adress'], $_POST['side'], $_POST);
        $this->cache->clean("tree", "callback_killByGroup");
        if ($_POST['mod'] != "undefined") {
            $this->set_message("ok");
            header("location: /" . ADMIN_DIR . "/id/" . $module['lastid']);
        } else {
            header("location: /" . ADMIN_DIR . "/message/ok");
        }
        return $data;
    }

    protected function add_r($url) {
        $this->model->add_r($url[1], $_POST['add_r'], $_POST['show'], $_POST['adress'], $_POST['side']);
        header("location: /" . ADMIN_DIR);
        return $data;
    }

    protected function del($url) {
        $this->model->del_cat($url[1]);
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $url[1]));
        $this->cache->clean("tree", "callback_killByGroup");
        header("location: /" . ADMIN_DIR . "/message/ok");
        return $data;
    }

    protected function info($url) {
        $tmp['end_time'] = $this->end_time();
        $tmp['cache'] = CACHE;
        $tmp['cache_size'] = $this->dir_size(CACHE_DIR);
        $data['body'] = $this->view->view("templates/admin/info/info.tpl", $tmp, true);
        return $data;
    }

    protected function modules($url) {
        $data['modules'] = $this->view_modules();
        $data['body'] = $this->view->view("templates/admin/modules/modules.tpl", $data, true);
        return $data;
    }

    protected function load_files($url) {
        $uploadfile = SITE_DIR . $url[1] . "/upload/" . basename($_FILES['userfile']['name']);
        if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)) {
            if ($url[1] == "modules") {
                $this->instal_module($uploadfile);
                header("location:/" . ADMIN_DIR . "/modules/ok");
            } else {
                $this->instal_template($uploadfile);
                header("location:/" . ADMIN_DIR . "/temp_ld/ok");
            }
        } else {
            header("location:/" . ADMIN_DIR . "/" . $url[1] . "/false");
        }
        return $data;
    }

    protected function mod_options($url) {
        $data['tr'] = $this->return_info_model($url[1]);
        $info = $this->model->return_info_model($url[1]);
        $mod = $this->_call_out_func_arr($info[0]['class'], "_options", $url, 1);
        $data['mod_option'] = $mod['view'];
        if (isset($mod['sys']['clean_cache']) && $mod['sys']['clean_cache'])
            $this->cache->clean($info[0]['class'], "callback_killByGroup");
        $data['body'] = @$this->view->view("templates/admin/modules/mod_options/mod_options.tpl", $data + $mod, true);
        return $data;
    }

    protected function templates($url) {
        $data['templates_body'] = $this->return_info_today_tpl();
        $data['body'] = $this->view->view("templates/admin/templates/templates.tpl", $data, true);
        return $data;
    }

    protected function side($url) {
        $data['templates_body'] = $this->return_side_contrl($url[1]);
        $data['body'] = $this->view->view("templates/admin/templates/templates.tpl", $data, true);
        return $data;
    }

    protected function temp_all($url) {
        $data['templates_body'] = $this->return_templates_all();
        $data['body'] = $this->view->view("templates/admin/templates/templates.tpl", $data, true);
        return $data;
    }

    protected function temp_ld($url) {
        $data['templates_body'] = $this->template_load_del();
        $data['body'] = $this->view->view("templates/admin/templates/templates.tpl", $data, true);
        return $data;
    }

    protected function securitys($url) {
        $data['security_body'] = $this->return_user_security($url[1]);
        $data['body'] = $this->view->view("templates/admin/security/security.tpl", $data, true);
        return $data;
    }

    protected function element($url) {
        $data['security_body'] = $this->return_element($url[1]);
        $data['body'] = $this->view->view("templates/admin/security/security.tpl", $data, true);
        return $data;
    }

    protected function save_element($url) {
        $this->security("POST", "", 200);
        $this->model->save_element($_POST['url'], $_POST['level'], $_POST['name'], $_POST['id_level']);
        header("location: /" . ADMIN_DIR . "/element/ok");
        return $data;
    }

    protected function save_l($url) {
        if ($_POST['level'] >= 1) {
            $this->model->save_level($this->security($_POST['level'], 3), $url[1]);
            header("location: /" . ADMIN_DIR . "/element/ok");
        } else {
            header("location: /" . ADMIN_DIR . "/element/false");
        }
        return $data;
    }

    protected function quit_adm($url) {
        session_unset();
        session_destroy();
        header("location: /" . ADMIN_DIR);
        return $data;
    }

    protected function quit($url) {
        header("location: /" . ADMIN_DIR . "/" . $url[1]);
    }

//insert=-=-=-=-=-=-=-=-=-=-=-

    protected function edit_user($url) {
        if (isset($url[1]) && $url[1] != "ok" & $url[1] != "false") {
            $data['security_body'] = $this->edit_profile($url[1]);
        } else {
            $data['security_body'] = $this->edit_profile();
        }
        $data['body'] = $this->view->view("templates/admin/security/security.tpl", $data, true);
        return $data;
    }

    protected function s_add_login($url) {
        $this->security("POST");
        if ($this->security($_POST['level'], 3)) {
            if (isset($url[1])) {
                $this->model->save_login($_POST['type'], $_POST['level'], $url[1]);
            } else {
                $this->model->save_login($_POST['login'], $_POST['level']);
            }
            header("location: /" . ADMIN_DIR . "/edit_user/ok");
        } else {
            header("location: /" . ADMIN_DIR . "/edit_user/false");
        };
        return $data;
    }

    protected function s_add_user($url) {
        $this->security("POST", "", 200);
        $this->set_message($this->model->save_user($_POST['name'], $_POST['adress'], $_POST['pass'], $_POST['type'], $url[2], $url[1]));
        $this->relink();
        return $data;
    }

    protected function s_del_user($url) {
        $this->model->del_user($url[1]);
        header("location: /" . ADMIN_DIR . "/edit_user/ok");
    }

    protected function s_del_login($url) {
        $this->model->del_login($url[1]);
        header("location: /" . ADMIN_DIR . "/edit_user/ok");
    }

    protected function s_edit_login($url) {
        $data['security_body'] = $this->edit_login($url[1]);
        $data['body'] = $this->view->view("templates/admin/security/security.tpl", $data, true);
        return $data;
    }

    protected function tem_side_l($url) {
        $this->model->save_side_l_un($url[1], $url[2], $url[3]);
        header("location: /" . ADMIN_DIR . "/side/ok");
        return $data;
    }

    protected function tem_side_d($url) {
        $this->model->tem_del_side($url[1], $url[2]);
        $this->cache->clean();
        header("location: /" . ADMIN_DIR . "/side/ok");
        return $data;
    }

    protected function tem_add_s($url) {
        $this->model->save_side($this->security($_POST['name']), $url[1]);
        $this->cache->clean();
        header("location: /" . ADMIN_DIR . "/side/ok");
        return $data;
    }

    protected function save_tmp_inf($url) {
        $this->security("POST", "", 200);
        $this->cache->clean();
        $this->model->save_tmp_inf($url[1], $_POST['id'], $_POST['path_file'], $_POST['name'], $_POST['show_me']);
        header("location: /" . ADMIN_DIR . "/temp_all/ok");
        return $data;
    }

    protected function tem_del_tem($url) {
        $this->model->del_templates($url[1]);
        $this->cache->clean();
        unlink(SITE_DIR . "templates/site/tpl_site/" . $url[1]);
        header("location: /" . ADMIN_DIR . "/temp_ld/ok");
        return $data;
    }

    protected function lang($url) {
        $data['body_lang'] = $this->_call_out_func("lang", "show_all_lang");
        if (empty($data['body_lang']))
            $data['lang_all'] = $this->lang['l_not_lang'];
        $data['body'] = $this->view->view("templates/admin/lang/lang.tpl", $data, true);
        return $data;
    }

    protected function l_ch_def($url) {
        $this->_call_out_func("lang", "chose_def", $url[1]);
        unset($GLOBALS['lang']);
        $this->_call_out_func("lang", "default_lang");
        $this->set_message(true);
        $this->relink();
        return $data;
    }

    protected function l_save_info($url) {
        $this->_call_out_func("lang", "save_lang_info", $url[1]);
        $this->set_message(true);
        $this->relink();
        return $data;
    }

    protected function l_add($url) {
        $this->_call_out_func("lang", "add_lang");
        $this->set_message(true);
        $this->relink();
        return $data;
    }

    protected function l_del($url) {
        $this->cache->clean($this->_call_out_func("lang_model", "get_info", "name", "lang", "id", $url[1]), "callback_killByGroup");
        $this->_call_out_func("lang", "del_lang", $url[1]);
        $this->set_message(true);
        $this->relink();
        return $data;
    }

    protected function document($url) {
        $this->security("POST");
        if (empty($url[1]))
            $url[1] = 1;
        if (empty($url[2]))
            $url[2] = "doc_img_id";
        if (empty($url[3]))
            $url[3] = "up";
        if (empty($url[4]))
            $url[4] = ADMIN_LANG;
        if (isset($_POST['search']))
            $url[5] = $_POST['search'];
        $data['table'] = $this->document_all($url[1], "document/", $url[2], $url[3], $url[4], $url[5]);
        $data['body'] = $this->view->view("templates/admin/document/document.tpl", $data, true);
        return $data;
    }

    protected function m_save_mod($url) {
//$this->security("POST","",100);
        $this->save_mod_optoins($_POST['id'], $_POST['class'], $_POST['name'], $_POST['ins'], $_POST['help'], $_POST['sch'], $_POST['stn'], $_POST['tem'], $_POST['event'], $_POST['nl'], $_POST['la']);
        $this->cache->clean($_POST['class'], "callback_killByGroup");
        header("location: /" . ADMIN_DIR . "/modules/ok");
        return $data;
    }

    protected function save_nl($url) {
        $this->model->module_nl($url[2], $url[1]);
        header("location: /" . ADMIN_DIR . "/modules/ok");
        return $data;
    }

    protected function id($url) {
        $data['body'] = $this->startLaunch($url[1], $url[2], $url[3], $url[4], $url[5], $url[6], $url[7]);
        return $data;
    }

    protected function changevector($url) {
        if ($url[4] == "ASC")
            $url[4] = "DESC";
        else
            $url[4] = "ASC";
        $this->relink(ADMIN_DIR_FULL . "id/" . $url[1] . "/" . $url[2] . "/" . $url[3] . "/" . $url[4] . "/" . $url[5] . "/" . $url[6] . "/" . $url[7]);
        return $data;
    }

    protected function launch($url) {
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $url[2]));
        $tmpA = explode("|", $_POST['mod']);
        if (count($tmpA) <= 1)
            $data['body'] = $this->_call_out_func($_POST['mod'], "_create", $url[2], $_POST);
        else
            $data['body'] = $this->_call_out_func($tmpA[0], $tmpA[1], $url[2], $_POST);
        return $data;
    }

    protected function hidedoc($url) {
        $data['sys_info'] = $this->show_sys_info("ok");
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $url[2]));
        $this->set_message($this->model->showHideDoc($url[1], $url[3]));
        $this->relink(@$_SERVER['HTTP_REFERER']);
        return $data;
    }

    protected function showdoc($url) {
        $data['sys_info'] = $this->show_sys_info("ok");
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $url[2]));
        $this->set_message($this->model->showHideDoc($url[1], $url[3]));
        $this->relink(@$_SERVER['HTTP_REFERER']);
        return $data;
    }

    protected function saveSideDoc($url) {
        $data['sys_info'] = $this->show_sys_info("ok");
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $url[2]));
        $this->set_message($this->model->saveSideDoc($url[1], $_POST['sidedoc']));
        $this->relink(@$_SERVER['HTTP_REFERER']);
        return $data;
    }

    protected function safe_launch($url) {
        $url[2] = "_" . $url[2];
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $this->_call_out_func("tree_model", "get_info", "father_id", "ns_doc", "id", $url[3])));
        $data['body'] = $this->_call_out_func_arr($url[1], $url[2], $url, 3);
        return $data;
    }

    protected function unsafe_launch($url) {
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $this->_call_out_func("tree_model", "get_info", "father_id", "ns_doc", "id", $url[3])));
        $data['body'] = $this->_call_out_func_arr($url[1], $url[2], $url, 3);
        return $data;
    }

    protected function branch($url) {
        $this->view->view("templates/admin/branch/index.tpl", "");
        echo $this->_call_out_func_arr("tree", "build_tree", array("arg" => "all", "arg1" => "", "arg3" => "templates/admin/dir/linkeditor.tpl"));
        $data['lang'] = $this->_call_out_func("lang_model", "return_count_lang");
        $this->view->view("templates/admin/branch/endindex.tpl", $data);
        exit;
    }

    protected function returnpath($url) {
        $tmp = $this->model->GetInfoForLinkTreeAndModule($_POST['q']);
        $res = $this->_call_out_func($tmp['module'], "_returnPath", $tmp['module'], $tmp['func_name'], $_POST['q']);
        if (empty($res))
            echo"error";
        else
            echo $res;
        exit;
    }

    protected function galery($url) {
        require_once(SITE_DIR . "editor/tiny_mce/plugins/advimage/galery.php");
        exit;
    }

    protected function add_doc($url) {
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $url[1]));
        $this->set_message($this->model->add_doc($url[1], $_POST['add_doc']));
        $this->relink($_SERVER['HTTP_REFERER']);
        return $data;
    }

    protected function returnside($url) {
        $this->security("POST");
        $res = $this->model->return_side($_POST['q']);
        if (empty($res)) {
            echo "error";
        } else {
            foreach ($res as $key => $value)
                echo $value['side'] . "\n";
        }
        exit;
    }

    protected function uncoupling($url) {
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $this->_call_out_func("tree_model", "get_info", "father_id", "ns_doc", "id", $url[1])));
        $this->set_message($this->model->uncouplingDoc($url[1]));
        $this->relink(@$_SERVER['HTTP_REFERER']);
        return $data;
    }

    protected function savedate($url) {
        $this->security("POST");
        $this->set_message($this->model->saveDateNsdoc($url[1], $_POST));
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $this->_call_out_func("tree_model", "get_info", "father_id", "ns_doc", "id", $url[1])));
        $this->relink(@$_SERVER['HTTP_REFERER']);
        return $data;
    }

    protected function ajaxloadside($url) {
        if (empty($_POST['add_in'])) {
            $lang = $this->_call_out_func("lang_model", "get_default_lang");
            if (empty($_POST['lang'][$lang['name']])) {
                echo $this->lang['lang_empty_add_in'] . $lang['name'];
            } else {
                echo"empty";
            }
        }
        exit();
    }

    protected function options($url) {
        $data['body'] = $this->view->view("templates/admin/options/options.tpl", "", true);
        return $data;
    }

    protected function cache($url) {

        $data['body'] = $this->view->view("templates/admin/options/cache.tpl", $tmp, true);
        return $data;
    }

    protected function config($url) {
        $tmp['file'] = file_get_contents(SITE_DIR . "/config/config.php");
        $data['body'] = $this->view->view("templates/admin/options/config.tpl", $tmp, true);
        return $data;
    }

    protected function log($url) {
        if (empty($_POST['log']))
            $tmp['ch'] = "error.log";
        else
            $tmp['ch'] = $_POST['log'];
        if (isset($_POST['clean'])) {
            $fp = fopen(LOG_DIR . $tmp['ch'], 'a');
            $this->set_message(ftruncate($fp, 0));
            $this->relink();
        }

        $tmp['file'] = $this->read_log($tmp['ch']);
        $data['body'] = $this->view->view("templates/admin/options/log.tpl", $tmp, true);
        return $data;
    }

    protected function clean_log($url) {
        $fp = fopen(LOG_DIR . $_POST['log'], 'a'); //Открываем файл в режиме записи
        $this->set_message(ftruncate($fp, 0));
        $this->relink();
        return $data;
    }

    protected function config_save($url) {
        $this->set_message(file_put_contents(SITE_DIR . "/config/config.php", $_POST['config']));
        $this->cache->clean();
        $this->relink();
        return $data;
    }

    protected function cache_clean($url) {
        $this->set_message($this->cache->clean());
        $this->relink();
        return $data;
    }

    protected function cache_clean_old($url) {
        $this->set_message($this->cache->clean("old"));
        $this->relink();
        return $data;
    }

    protected function cache_clean_hand($url) {
        $this->set_message($this->cache->clean($_POST['hand'], "callback_killByGroup"));
        $this->relink();
        return $data;
    }

    protected function add_page($url) {
        $lang['lang'] = $this->model->getLangPages($url[1]);
        $lang['id_lang_text'] = $url[1];

        $data['body'] = $this->view->view("templates/admin/document/add_page.tpl", $lang, true);
        return $data;
    }

    protected function add_edit_d($url) {
        $this->set_message($this->model->insertPages($_POST));
        $this->relink($_POST['relink']);
        return $data;
    }

    protected function insertpagesindoc($url) {
        $data['pt'] = $this->_call_out_func($url[1], "_getPrototypePages", $url[2], $url[1]);
        if (empty($data['pt']['descr'][0]['idlang'])) {
            $this->set_message($this->lang['l_bad_doc'], "add");
            $this->relink();
        }
        $data['lang'] = $this->_call_out_func($url[1], "_getPagesAbs", $url[2]);
        $this->cache->removeP($this->_call_out_func("tree", "current_address2", $this->_call_out_func("tree_model", "get_info", "father_id", "ns_doc", "id", $url[2])));
        $data['body'] = $this->view->view("templates/admin/id/insert_page.tpl", $data, true);
        return $data;
    }

    public function proxy($url="") {
        $this->proxyInt();
        exit();
    }

    protected function invert($url) {
        $data['inv2'] = $this->model->getInvertAll();
        foreach ($data['inv2'] as $key => $value) {
            $tmp = $value;
            if ($value['rgt'] && $value['lft'])
                $tmp['area'] = $this->model->getArea($value['rgt'], $value['lft']);
			$tmp['private_info'] = $this->_call_out_func($value['module'], "_returnLink", $value['iddoc'], $GLOBALS['lang']);

            if ($value['ns_tree'])
                $tmp['tree'] = $this->model->GetInfoForLinkTree($value['ns_tree']);
            if ($value['idint']) {
                $doc = $this->model->getNs_doc($value['idint']);
                $tmp['idint'] = $this->_call_out_func($doc['module'], "_returnLink", $value['idint'], $GLOBALS['lang']);
            }
            $data['inv'][] = $tmp;
        }
        $data['body'] = $this->view->view("templates/admin/id/invert.tpl", $data, true);
        return $data;
    }

    protected function invcreate($url) {
        $data['inv'] = $this->model->returnScModAll();
		foreach($data['inv'] as $key=>$value){
		$data['inv'][$key]['private_info'] = $this->_call_out_func($value['module'], "_returnLink", $value['id'], $GLOBALS['lang']);
		
		}
        $data['ns_tree'] = $this->_call_out_func("tree_model", "return_cat", "cat!", $this->model->get_info(1, "name"));
        $data['mod'] = $this->model->return_config_mod();
        $data['body'] = $this->view->view("templates/admin/id/invertcre.tpl", $data, true);
        return $data;
    }

    protected function invcreatedb($url) {
        $this->security("post");
        $this->set_message($this->model->insertInv($_POST));
        $this->cache->clean();
        $this->relink($_POST['relink']);
        return $data;
    }

    protected function delinv($url) {
        $this->set_message($this->model->delInv($url[1]));
        $this->cache->clean();
        $this->relink();
        return $data;
    }

    protected function editinv($url) {
        $data['curent'] = $this->model->getInvertor2($url[1]);
        $data['inv'] = $this->model->returnScModAll();
		foreach($data['inv'] as $key=>$value){
		$data['inv'][$key]['private_info'] = $this->_call_out_func($value['module'], "_returnLink", $value['id'], $GLOBALS['lang']);
		
		}
        $data['ns_tree'] = $this->_call_out_func("tree_model", "return_cat", "cat!", $this->model->get_info(1, "name"));
        $data['mod'] = $this->model->return_config_mod();
        $data['body'] = $this->view->view("templates/admin/id/editinv.tpl", $data, true);
        return $data;
    }

    protected function updateinv($url) {
        $this->security("post");
        $this->set_message($this->model->updateInv($url[1], $_POST));
        $this->cache->clean();
        $this->relink($_POST['relink']);
        return $data;
    }

    protected function createinvfordoc($url) {
        $this->security("post");
        $this->set_message($this->model->createinvfordoc($url[1], $_POST));
        $this->cache->clean();
        $this->relink();
        return $data;
    }

    protected function createinvfortree($url) {
        $this->security("post");
        $_POST['ns_tree'] = $url['1'];
        $this->set_message($this->model->insertInv($_POST));
        $this->cache->clean();
        $this->relink();
        return $data;
    }

    protected function edittemplate($url) {

        ob_start();
        $filesd = new file_browser(SITE_DIR . "library/file_browser/interface", "elementary", SITE_DIR . "/templates");
        $contents = ob_get_contents(); // Get the contents of the buffer
        ob_end_clean();                // End buffering and discard
        $data['body'] = $contents;
        return $data;
    }

    protected function readtemplate($url) {
        if (!file_exists($_GET['filename'])) {
            $data['body'] = $this->lang['l_notfoundfile'];
            break;
        }
        $data['content'] = htmlspecialchars(file_get_contents($_GET['filename']));
        $data['filenames'] = $_GET['filename'];
        $data['body'] = $this->view->view("templates/admin/templates/readtemplate.tpl", $data, true);
        return $data;
    }

    protected function saveftemplate($url) {
        $this->security("post");
        if (!file_exists($_POST['filenames'])) {
            $data['body'] = $this->lang['l_notfoundfile'];
            break;
        }
        $content = $_POST['content'];
        $content = htmlspecialchars_decode($content);
        $content = stripcslashes($content);
        $content = stripslashes($content);
        $fp = fopen($_POST['filenames'], 'w');
        flock($fp, LOCK_EX); // ������������ ����� ��� ������
        fwrite($fp, $content);
        flock($fp, LOCK_UN); // ������ ����������
        fclose($fp);
        $this->set_message($fp);
        $this->cache->clean();
        $this->relink($_POST['relink']);
        return $data;
    }

    protected function deflt($url) {
        $data['body'] = $this->_call_out_func("tree", "build_tree", "all");
        if (empty($data['body']))
            $data['body'] = $this->view->view("templates/admin/catalog/catalogempty.tpl", $data, true);
        $data['body'] = $this->view->view("templates/admin/catalog/catalog.tpl", $data, true);
        return $data;
    }

    /**
     * Start function, authorization, logging, select the language packs, updater
     * @return content
     */
    function __construct($db, $view, $model, $routes, $cache, $url) {
        $this->view = $view;
        $this->model = $model;
        $this->db = $db;
        $this->url = $url;
        $this->routes = $routes;
        $this->cache = $cache;
        if (isset($_POST["PHPSESSID"]))session_id($_POST["PHPSESSID"]);	
        $this->sessionStart();
        $this->actionlog = "<b>" . date("Y-m-d h:m") . "</b> -> " . $this->getIP() . " " . @$_SESSION['type'] . " " . @$_SESSION['user']['adress'] . " " . SITE_URL . $_SERVER['REQUEST_URI'];
        if (ACTIONLOG)
            $this->write_log($this->actionlog . "<br />", "action.log");
        if (empty($_SESSION['admin_lang'])) {
            if (isset($_POST['lang'])) {
                $GLOBALS['lang'] = $this->security($_POST['lang'], 2, 2);
            } else {
                $GLOBALS['lang'] = ADMIN_LANG;
            }
            $_SESSION['admin_lang'] = $GLOBALS['lang'];
        } else {
            $GLOBALS['lang'] = $_SESSION['admin_lang'];
        }
        $this->lang = parse_ini_file(SITE_DIR . "/lang/admin/controler/" . $GLOBALS['lang'] . ".ini", false) + parse_ini_file(SITE_DIR . "/lang/admin/" . $GLOBALS['lang'] . "_all.ini", false);
        $this->view->set_lang($this->lang);
        if ($this->_call_out_func("user_auth", "_use_session", "access")) {
            if (!isset($_SESSION['update']['oper']) && UPDATE) {
                if (file_exists(SITE_DIR . "modules/upload/upd.json")) {
                    $this->upd();
                } else {
                    $_SESSION['update']['oper'] = "start";
                    $this->write_log($this->actionlog . " " . $this->lang['l_start_update'] . "<br />", "action.log");
                }
            }
            $this->upd();
            array_shift($this->url);
            $data = array();
            $dataInfo['sys_info'] = $this->show_sys_info($this->url[1]);
            $dataInfo['login_info'] = $this->_call_out_func("user_auth", "_show_hello_admin");
            if ($this->level_access($this->url [0])) {
                if (empty($this->url[0]) || $this->url[0] == "message")
                    $this->url[0] = "deflt";
                $data = call_user_func(array($this, $this->url[0]), $this->url);
            } else {
                $data['body'] = $this->view->view("templates/admin/security/security_not_access.tpl", $dataInfo, true);
            }
            $this->view->view("templates/admin/index.tpl", $data + $dataInfo);
        } else {
            $this->_call_out_func("user_auth", "_use_session", "start");
            $data['error'] = $this->_call_out_func("user_auth", "_login");
            $this->view->view("templates/admin/login/view_login.tpl", $data);
        }
    }

}

?>