<?

/**
 * @author PetrOFF <andi-fm@ya.ru>
 * 
 * @package Api
 * @category Core
 * Options available in the kernel
 */
class add_contrl extends api {

    // system_info && uri-------------------


    function direct_link($url) {

        if (count($url) == 1) {
            if (is_numeric($url[0]))
                $result = $this->_call_out_func("tree_model", "GetInfoForLinkTreeById", $url[0]);
            else
                $result=$this->_call_out_func("tree_model", "GetInfoForLinkTreeByName", $url[0]);

            if (empty($result)) {
                return $url;
            } else {
                $this->ns_tree = $result;
                $tmp = $url[0];
                $url[0] = $result['module'];
                $url[1] = $result['func_name'];
                $url[2] = $tmp;
                return $url;
            }
        } else {
            return $url;
        }
    }

    function show_sys_info($url="") {
        $ret = "";
        if (!empty($_SESSION['message'])) {
            $data['message'] = $_SESSION['message'];
            $ret.=$this->view->view("templates/admin/sys_info/sys_info_message.tpl", $data, true);
            unset($_SESSION['message']);
        }

        if ($url == "ok")
            $ret.=$this->view->view("templates/admin/sys_info/sys_info_ok.tpl", "", true);
        else
        if ($url == "false")
            $ret.=$this->view->view("templates/admin/sys_info/sys_info_false.tpl", "", true);
        return $ret;
    }

    function return_side($tmp) {
        $ret = array();
        foreach ($tmp as $key => $value) {
            $ret[$value['side']] = $value['free'];
        }
        return $ret;
    }

    // end side control----------
    // module function----------
    function save_mod_optoins($id, $class, $name, $ins, $help, $sch, $st, $tem, $even, $nl, $la) {
        $this->model->save_mod_optoins($id, $class, $name, $ins, $help, $sch, $st, $tem, $even, $nl, $la, $_POST);
    }

    function view_modules() {
        $tmp = $this->model->load_cat_modules();
        foreach ($tmp as $key => $value) {

            if ($value['schedule'])
                $value['m_sch'] = $this->view->view("templates/admin/modules/tables/img_green.tpl", "", true);
            else
                $value['m_sch'] = $this->view->view("templates/admin/modules/tables/img_red.tpl", "", true);

            if ($value['standby'])
                $value['m_st'] = $this->view->view("templates/admin/modules/tables/img_green.tpl", "", true);
            else
                $value['m_st'] = $this->view->view("templates/admin/modules/tables/img_red.tpl", "", true);

            if ($value['events'])
                $value['events'] = $this->view->view("templates/admin/modules/tables/img_green.tpl", "", true);
            else
                $value['events'] = $this->view->view("templates/admin/modules/tables/img_red.tpl", "", true);

            $ret.=$this->view->view("templates/admin/modules/tables/table.tpl", $value, true);
        }
        return $ret;
    }

    function return_info_model($id) {
        $tmp = $this->model->return_info_model($id);
        foreach ($tmp as $key => $value) {

            if ($value['schedule'])
                $value['opt_sch'] = $this->view->view("templates/admin/modules/mod_options/mod_options_op_on.tpl", "", true);
            else
                $value['opt_sch'] = $this->view->view("templates/admin/modules/mod_options/mod_options_op_off.tpl", "", true);
            $value['side_sch'] = $this->comparison($value['class'], "sc");
            if ($value['events'])
                $value['opt_event'] = $this->view->view("templates/admin/modules/mod_options/mod_options_op_on.tpl", "", true);
            else
                $value['opt_event'] = $this->view->view("templates/admin/modules/mod_options/mod_options_op_off.tpl", "", true);
            $value['side_ev'] = $this->comparison($value['class'], "ev");
        }
        $value['all_mod'] = $this->model->load_cat_modules("number_launch");
        $value['max_level'] = $this->model->return_max_level();
        return $this->view->view("templates/admin/modules/mod_options/table_tr.tpl", $value, true);
        ;
    }

    function comparison($class, $arg) {


        $tmp_t = $this->model->return_all_templates();


        foreach ($tmp_t as $key => $value) {
            $ret.=$this->view->view("templates/admin/modules/mod_options/mod_options_tr_separatorSide.tpl", $value, true);

            $tmp_side = $this->model->return_side($value['id']);
            $tmp_sidMod = $this->model->return_side_module($class . "_" . $arg);
            foreach ($tmp_side as $key1 => $value1) {
                foreach ($tmp_sidMod as $key2 => $value2) {
                    if ($value2['side'] == $value1['side'] && $value2['id_template'] == $value['id'])
                        $value1['chechk'] = " checked ";
                }
                $value1['id'] = $value['id'];
                $value1['name'] = $arg;
                $value1['i'] = $i++;
                $ret.=$this->view->view("templates/admin/modules/mod_options/mod_options_tr_ch.tpl", $value1, true);
            }
        }

        return $ret;
    }

    function instal_module($path) {
        //exec( 'unzip -P ' . $password . ' ' . $fileZip . ' -d ' . $directory);.
        if (file_exists($path)) {
            $xml = simplexml_load_file($path);
            chdir(SITE_DIR . "modules/");
            mkdir(((string) $xml->module_info->name_class), 0777);
            foreach ($xml->module_file->folder as $m_f) {
                chdir(SITE_DIR . $m_f['path']);
                mkdir($m_f);
            }

            foreach ($xml->module_file->file as $m_f) {
                copy(SITE_DIR . "modules/upload/" . $m_f, SITE_DIR . $m_f['path'] . $m_f);
                unlink(SITE_DIR . "modules/upload/" . $m_f);
            }
            unlink(SITE_DIR . "modules/upload/instal.xml");
            $this->model->registry($xml->module_info->name_class, $xml->module_info->name_start_func, $xml->module_options->schedule, $xml->module_options->standby, $xml->module_options->side_schedule, $xml->module_options->side_standby, $xml->module_options->template_path, $xml->module_info->name_module, $xml->module_info->help->annotation);
            if ($xml->module_database->attributes() == "on")
                $this->model->create_table($xml, $xml->module_database->db_name);
        }
    }

    // end module function--------
    // template func----------------------------
    function return_info_today_tpl() {
        $data['tem'] = $this->model->return_info_template();
        $data['show'] = $this->view->view("templates/admin/modules/tables/img_green.tpl", "", true);
        $this->side = $this->return_side($this->model->return_side());
        foreach ($this->side as $key => $value) {
            $td['side'] = $key;
            $tmp.=$this->view->view("templates/admin/templates/template_info_table_td.tpl", $td, true);
        }
        $data['td'] = $tmp;
        return $this->view->view("templates/admin/templates/template_info_table.tpl", $data, true);
    }

    function return_side_contrl($id=0) {
        $temp = $this->model->return_side($id);
        foreach ($temp as $key => $value) {
            if ($value['free'])
                $value['name_file'] = "unlock.jpg";
            else
                $value['name_file'] = "lock.jpg";
            $tmp.=$this->view->view("templates/admin/templates/template_side_tr.tpl", $value, true);
        }
        $data['tr'] = $tmp;
        unset($tmp);
        $tmp = $this->model->return_all_templates();
        foreach ($tmp as $key => $value) {
            if ($value['id'] == $id)
                $ret.=$this->view->view("templates/admin/templates/template_side_tr2(2).tpl", $value, true);
            else
                $ret.=$this->view->view("templates/admin/templates/template_side_tr2.tpl", $value, true);
        }
        $data['id'] = $temp[0] ['id_template'];
        $data['tr_tem'] = $ret;
        return $this->view->view("templates/admin/templates/template_side.tpl", $data, true);
    }

    function return_templates_all() {
        $tmp = $this->model->return_all_templates();
        foreach ($tmp as $key => $value) {
            $data['id'] = $value['id'];
            $data['path_file'] = $value['path_file'];
            $data['name'] = $value['name'];
            $data['path_small_img'] = $value['path_small_img'];
            $data['show'] = $value['show_me'];
            $data['show_n'] = !$value['show_me'];
            $ret.=$this->view->view("templates/admin/templates/templates_all_tr.tpl", $data, true);
        }
        $data['tr'] = $ret;
        return $this->view->view("templates/admin/templates/templates_all.tpl", $data, true);
    }

    function template_load_del() {
        $tmp = $this->model->return_all_templates();
        foreach ($tmp as $key => $value) {
            $data['name'] = $value['name'];
            $data['name_cat'] = $value['name_project'];
            $ret.=$this->view->view("templates/admin/templates/templates_l_d_tr.tpl", $data, true);
        }
        $data['tr'] = $ret;

        return $this->view->view("templates/admin/templates/templates_l_d.tpl", $data, true);
    }

    function instal_template($path) {
        //exec( 'unzip -P ' . $password . ' ' . $fileZip . ' -d ' . $directory);.
        if (file_exists($path)) {
            $xml = simplexml_load_file($path);
            chdir(SITE_DIR . "templates/site/tpl_site/");
            mkdir(((string) $xml->template_info->name_project), 0777);
        }

        foreach ($xml->template_file->folder as $t_f) {
            chdir(SITE_DIR . $t_f['path']);
            mkdir($t_f);
        }

        foreach ($xml->template_file->file as $t_f) {
            copy(SITE_DIR . "templates/upload/" . $t_f, SITE_DIR . $t_f['path'] . $t_f);
            unlink(SITE_DIR . "templates/upload/" . $t_f);
        }
        unlink(SITE_DIR . "templates/upload/" . $xml->template_info->instal_file_name);
        $this->model->registry_template($xml->template_info->name_template, $xml->template_info->name_project, $xml->template_info->path_file, $xml->template_info->path_small_img, $xml->template_options->show_me);
        $id = $this->model->get_info($xml->template_info->name_project, "id", "", "templates", "name_project");
        foreach ($xml->template_options->side as $t_s) {
            $this->model->save_side($t_s, $id);
        }
    }

    // end template-----------------------------
    // security---------------------------------
    function return_user_security($pag="1", $search="empty") {
        if (empty($pag))
            $pag = 1;
        $pag_tmp = $pag;
        $pag = ($pag * LIMIT_DB) - LIMIT_DB;
        $data['user'] = $this->model->return_user2($pag);
        $total = $this->model->GetFoundRows();
        $page = ceil(($total) / LIMIT_DB);
        $data['link'] = "";
        for ($i = 1; $i <= $page; $i++) {
            if (is_int($i / 30))
                $data['link'].="<br />";
            if ($i == $pag_tmp) {
                $data['link'].=$i . "&nbsp;|&nbsp;";
            } else {
                $data['link'].="<a href='" . ADMIN_DIR_FULL . "security/" . $i . "/" . $search . "'>" . $i . "</a>&nbsp;|&nbsp;";
            }
        }

        return $this->view->view("templates/admin/security/security_user.tpl", $data, true);
    }

    function return_element($oper) {
        if (isset($oper)) {
            $tmp = $this->model->return_element(1);
            foreach ($tmp as $key => $value) {
                if ($value['id'] == $oper)
                    $ret.=$this->view->view("templates/admin/security/security_element_tr_2+.tpl", $value, true);
                else
                    $ret.=$this->view->view("templates/admin/security/security_element_tr_2.tpl", $value, true);
            }
            if ($oper) {
                $tmp = $this->model->return_element($oper);
                foreach ($tmp as $key => $value) {
                    $ret2.=$this->view->view("templates/admin/security/security_element_tr.tpl", $value, true);
                }
                $ret_temp['tr2'] = $ret2;
                $ret2 = $this->view->view("templates/admin/security/security_element_table_cat.tpl", $ret_temp, true);
                $ret = str_replace("{tr2}", $ret2, $ret);
            }
            $data['id'] = $oper;
            $data['tr'] = $ret;
            return $this->view->view("templates/admin/security/security_element_2.tpl", $data, true);
        } else {
            $tmp = $this->model->return_element(0);
            foreach ($tmp as $key => $value) {
                $ret.=$this->view->view("templates/admin/security/security_element_tr.tpl", $value, true);
            }
            $data['tr'] = $ret;
            return $this->view->view("templates/admin/security/security_element.tpl", $data, true);
        }
    }

    function level_access($url) {
        $t_level = $_SESSION['user']['level'];
        $f_level = $this->model->return_level_form($url);
        if ($t_level >= $f_level[0] ['level'] && isset($f_level [0] ['level']))
            return true;
        else
            return false;
    }

    function edit_profile($id="") {
        if ($id == "") {
            $tmp = $this->model->return_user_type();
            foreach ($tmp as $key => $value) {
                $ret_s.=$this->view->view("templates/admin/security/security_edit_user_select.tpl", $value, true);
                $ret_l.=$this->view->view("templates/admin/security/security_edit_user_tr_l.tpl", $value, true);
            }
            $data['select_op'] = $ret_s;
            $data['tr_u'] = $ret;
            $data['tr_l'] = $ret_l;
            return $this->view->view("templates/admin/security/security_edit_user.tpl", $data, true);
        } else {
            $datas = $this->model->return_user($id);
            $ret_s.=$this->view->view("templates/admin/security/security_edit_user_select.tpl", $datas, true);
            $tmp = $this->model->return_user_type();
            foreach ($tmp as $key => $value) {
                if ($value['type'] != $datas['type'])
                    $ret_s.=$this->view->view("templates/admin/security/security_edit_user_select.tpl", $value, true);
            }
            $data['select_op'] = $ret_s;
            return $this->view->view("templates/admin/security/security_edit_user_one.tpl", $data + $datas, true);
        }
    }

    function edit_login($id) {
        $tmp = $this->model->return_user_type($id);
        foreach ($tmp as $key => $value) {
            
        }
        return $this->view->view("templates/admin/security/security_edit_login.tpl", $value, true);
    }

    // end security-----------------------------
    //document---------------------------------------
    function document_pagination($pag, $link, $oper, $arg, $lang, $search) {
        if (isset($_POST['search']))
            $pag = 1;
        $pag_tmp = $pag;
        $pag = ($pag * 10) - 10;
        $sm = 10;
        $tmp = $this->model->query_pagination($pag, $sm, $oper, $arg, $lang, $search);
        $total = $this->model->get_info('', "FOUND_ROWS()", "SELECT FOUND_ROWS();");
        if (!empty($tmp)) {
            foreach ($tmp as $key => $value) {
                $value['pag'] = $pag_tmp;
                if ($this->model->getLangPages($value['id']))
                    $value['p'] = true;
                else
                    $value['p'] = false;
                $ret.=$this->view->view("templates/admin/document/document_tr.tpl", $value, true);
            }

            $page = ceil(($total) / 10);

            for ($i = 1; $i <= $page; $i++) {
                $data['link'] = $link . $i . "/" . $oper . "/" . $arg . "/" . $lang . "/" . $search;
                $data['num'] = $i;
                if ($i == $pag_tmp) {
                    $ret_t['pagination'].=$this->view->view("templates/admin/table/pagination2.tpl", $data, true);
                } else {
                    $ret_t['pagination'].=$this->view->view("templates/admin/table/pagination.tpl", $data, true);
                }
            }
            $ret.=$this->view->view("templates/admin/table/pagination_construct.tpl", $ret_t, true);
            return $ret;
        } else {
            $ret_t['pagination'] = $this->lang['d_not_find'];
            return $this->view->view("templates/admin/table/pagination_construct.tpl", $ret_t, true);
        }
    }

    function document_all($pag, $link, $oper, $arg, $lang, $search) {
        if (isset($_POST['ch_lang']))
            $this->relink(ADMIN_DIR_FULL . "document/" . $pag . "/" . $oper . "/" . $arg . "/" . $_POST['ch_lang'] . "/");
        $data['search'] = $search;
        $data['doc_img_id'] = "";
        $data['doc_img_dt'] = "";
        $data['oper'] = $oper;
        $data['vector2'] = $arg;

        switch ($arg) {

            case("up"): {
                    $data[$oper] = $this->view->view("templates/admin/document/document_img_up.tpl", "", true);
                    $data['vector'] = "down";
                }break;

            case("down"): {
                    $data[$oper] = $this->view->view("templates/admin/document/document_img_down.tpl", "", true);
                    $data['vector'] = "up";
                }break;

            default: {
                    $data['doc_img_id'] = "";
                    $data['doc_img_dt'] = "";
                    $data['vector'] = "up";
                }break;
        }
        //if(empty($lang))$lang=ADMIN_LANG;
        $tmp = $this->_call_out_func("lang", "get_lang");
        $val['name'] = $lang;
        $data['option'] = $this->view->view("templates/admin/document/document_option.tpl", $val, true);
        ;
        foreach ($tmp as $key => $value) {
            if ($lang != $value['name'])
                $data['option'].=$this->view->view("templates/admin/document/document_option.tpl", $value, true);
        };
        $data['lang'] = $lang;
        $data['pag'] = $pag;
        $data['tr'] = $this->document_pagination($pag, $link, $oper, $arg, $lang, $search);
        return $this->view->view("templates/admin/document/document_table.tpl", $data, true);
    }

    //end document----------------------------------
    //launch id--------------------------------------
    function startLaunch($id, $lang, $order="", $vector="", $pag="", $search="", $mod_order="") {
        if (empty($mod_order)) {
            $mod_order = "none";
            $data['mod_order'] = $mod_order;
        } else {
            $data['mod_order'] = $mod_order;
        }

        if (empty($order)) {
            $order = "date";
            $data['order'] = $order;
        } else {
            $data['order'] = $order;
        }

        if (empty($vector)) {
            $vector = "ASC";
            $data['vector'] = $vector;
        } else {
            $data['vector'] = $vector;
        }

        if (empty($pag)) {
            $pag = "1";
            $data['pag'] = $pag;
        } else {
            $data['pag'] = $pag;
        }

        if (isset($_POST['search'])) {
            $search = $_POST['search'];
        }

        if (empty($search) || $search == "none") {
            $search = "";
            $data['search'] = "none";
        } else {
            $data['search'] = $search;
        }
        $data['lang'] = $this->_call_out_func("lang", "get_lang");
        if (empty($lang))
            $lang = $GLOBALS['lang'];
        $datas['freeLink'] = $this->model->returnFreeLink();
        foreach ($datas['freeLink'] as $key => $value) {
            $tmp = $this->_call_out_func($value['module'], "_returnNLink", $value['id'], $lang);
            if (!empty($tmp))
                $data['freeLink'][] = $tmp;
        }

        $pag_tmp = $pag;
        $pag = ($pag * LIMIT_DB) - LIMIT_DB;
        $sch = $this->model->getShedule2($id);
        $data['sch2'] = $this->model->getShedule3($id); //all inventor
        $data['sch3'] = $this->model->getSheduleAll($id);
		foreach($data['sch2'] as $key2=>$value2)$data['sch2'][$key2]['private_info'] = $this->_call_out_func($value2['module'], "_returnLink", $value2['id'], $lang);
		foreach($data['sch3'] as $key3=>$value3)$data['sch3'][$key3]['private_info'] = $this->_call_out_func($value3['module'], "_returnLink", $value3['id'], $lang);
        $data['sch'] = array();
        if (!empty($sch))
            foreach ($sch as $key => $value) {
                $rl = $this->_call_out_func($value['module'], "_returnLink", $value['id'], $lang, mysql_real_escape_string(urldecode($search)), $mod_order);
                if (is_array($rl))
                    $data['sch'][] = array_merge($rl, array('namet' => $value['text'],'father_id_res'=>($value['father_id'])?$value['father_id']:NULL));
            }
        $data['inv'] = $this->model->getInvertor($id);
        $datas['all_doc'] = $this->model->returnLink($id, $order, $vector, $pag, mysql_real_escape_string(urldecode($search)), $mod_order);
        $total = $this->model->GetFoundRows();
        $page = ceil(($total) / LIMIT_DB);
        $data['link'] = "";
        for ($i = 1; $i <= $page; $i++) {
            if (is_int($i / 30))
                $data['link'].="<br />";
            if (empty($search))
                if ($i == $pag_tmp) {
                    $data['link'].=$i . "&nbsp;|&nbsp;";
                } else {
                    $data['link'].="<a href='" . ADMIN_DIR_FULL . "id/" . $id . "/" . $lang . "/" . $order . "/" . $vector . "/" . $i . "/" . $data['search'] . "/" . $data['mod_order'] . "'>" . $i . "</a>&nbsp;|&nbsp;";
                }
        }
        $data['mod_orders'] = array();
        $data['mod_options'] = array();
		
		//create mod sort
		$mod = $this->model->getModForNsDoc($id);
		foreach($mod as $keyM=>$valueM){
		$mod_orders = $this->_call_out_func($valueM['module'], "_retModOrder", $id, $lang, mysql_real_escape_string(urldecode($search)));
		if (!empty($mod_orders))
                $data['mod_orders'] = $mod_orders + $data['mod_orders'];
		}
		
		//cretate body
        foreach ($datas['all_doc'] as $key => $value) {
            $tmp = $this->_call_out_func($value['module'], "_returnLink", $value['id'], $lang, mysql_real_escape_string(urldecode($search)), $mod_order);
            $cur_inv['inv'] = $this->model->getCurentInventor($value['id']);
            if (!empty($tmp)) {
                if ($value['mod_options'])
                    $tmp['mod_options'] = $this->_call_out_func($value['module'], "_retModOptions", $value['id'], $lang, urldecode($search));
                $date['ns_doc_date'] = $value['date'];
                $pages['pages'] = $this->_call_out_func($value['module'], "_getPagesAbs", $value['id']);
                $data['all_doc'][] = ($tmp + $date + $pages + $cur_inv);
            }elseif (empty($tmp) && empty($search) && $mod_order == "none") {
                $pages['pages'] = $this->_call_out_func($value['module'], "_getPagesAbs", $value['id']);
                $value['erlink'] = true;
                $data['all_doc'][] = $value + $pages + $cur_inv;
            }
        }

        //$data['all_doc']=$this->model->GetALLModulesForPage($id);

        $data['cur_lang'] = $lang;
        $data['idc'] = $id;
        $tree = $this->model->GetInfoForLinkTree($id);
        $data['alias'] = $tree['text'];
        $data['side_doc'] = $this->model->return_side($tree['template_out']);
		$data['all_side'] = $this->model->returnAllSide();
        $data['create_module'] = $this->model->GetModelFroCreate();
        foreach ($data['create_module'] as $key => $value) {
            $tmpM = $this->_call_out_func($value['class'], "_creatorMenu", $value);
            if ($tmpM)
                $data['create_module'] = array_merge($data['create_module'], $tmpM);
        }
        return $this->view->view("templates/admin/id/id.tpl", $data, true);
    }

    //end launch id----------------------------------

    function dir_size($dir) {
        $totalsize = 0;
        if ($dirstream = @opendir($dir)) {
            while (false !== ($filename = readdir($dirstream))) {
                if ($filename != "." && $filename != "..") {
                    if (is_file($dir . "/" . $filename))
                        $totalsize+=filesize($dir . "/" . $filename);

                    if (is_dir($dir . "/" . $filename))
                        $totalsize+=$this->dir_size($dir . "/" . $filename);
                }
            }
        }
        closedir($dirstream);
        return $totalsize;
    }

    function proxyInt() {
        error_reporting(0);
        if (!isset($_SERVER['HTTP_X_REQUESTED_WITH']) || $_SERVER['HTTP_X_REQUESTED_WITH'] != 'XMLHttpRequest' || !count($_GET) || !isset($_GET['json']))
            die($this->write_log($this->actionlog . " " . $this->lang['l_error_proxy'] . "<br />", "action.log"));

        $json = $_GET['json'];
        switch ($json['oper']) {

            case("wrong"): {
                    $this->write_log($this->actionlog . " " . $this->lang['l_error_proxy'] . "<br />", "action.log");
                    $_SESSION['update']['oper'] = "end";
                    return;
                }break;

            case("empty"): {
                    $this->write_log($this->actionlog . " " . $this->lang['l_empty_proxy'] . "<br />", "action.log");
                    $_SESSION['update']['oper'] = "end";
                    return;
                }break;

            case("load.cfg"): {
                    $this->write_log($this->actionlog . " " . $this->lang['l_loadcfg'] . "<br />", "action.log");
                    $_SESSION['update']['oper'] = "end";
                    $this->socet($json['serverurl'], $json['file'], VERSION, SITE_URL, SITE_DIR . "/modules/upload/", "upd.json");
                    return;
                }break;

            case("load.file"): {
                    $this->write_log($this->actionlog . " " . $this->lang['l_loadfile'] . " " . $_SESSION['update']['file'] . "<br />", "action.log");
                    $_SESSION['update']['oper'] = "end";
                    $this->socet($json['serverurl'], $json['file'], VERSION, SITE_URL, SITE_DIR . "/modules/upload/", $_SESSION['update']['file']);
                    return;
                }break;
        }//end switch
        return;
    }

    function socet($serverUrl, $fileServer, $version, $siteUrl, $pathSave, $fileSave) {
        $url_info = parse_url($serverUrl);

        $data = "&siteurl=" . $siteUrl . "&file=" . $fileServer . "&version=" . $version;
        $fp = @fsockopen(@$url_info['host'], 80, $errno, $errstr, 6);

        if (!$fp)
            die($this->write_log($this->actionlog . " " . $this->lang['l_connect_error'] . " " . @$url_info['host'] . "<br />", "action.log"));
        $out = "POST " . @$url_info['path'] . " HTTP/1.1\r\n";
        $out .= "Host: " . @$url_info['host'] . "\r\n";
        $out .= "Referer: /proxy.php\r\n";
        $out .= "User-Agent: Opera\r\n";
        $out .= "Content-Type: application/x-www-form-urlencoded\r\n";
        $out .= "Content-Length: " . strlen($data) . "\r\n";
        $out .= "Connection: close\r\n\r\n";
        $out .= $data;
        fputs($fp, $out);

        $in = ''; // socket_set_blocking($fp,false);
        while (!feof($fp))
            $in .= fread($fp, 1024);
        fclose($fp);
        $out = substr($in, strpos($in, "\r\n\r\n") + 4);

        file_put_contents($pathSave . $fileSave, $out) or die($this->write_log($this->actionlog . " " . $this->lang['l_connect_loadblock'] . @$url_info['host'] . "<br />", "action.log"));
        return;
    }

    function upd() {

        if (file_exists(SITE_DIR . "modules/upload/upd.json")) {
            $upd = json_decode(file_get_contents(SITE_DIR . "modules/upload/upd.json"));

            if (is_object($upd)) {

                $this->write_log($this->actionlog . " " . $this->lang['l_start_procupdate'] . "<br />", "action.log");

                foreach ($upd->file as $key => $value) {
                    if (!file_exists(SITE_DIR . "modules/upload/" . $value->name) || $value->md5 != md5_file(SITE_DIR . "modules/upload/" . $value->name)) {
                        $_SESSION['update']['oper'] = "load.file";
                        $_SESSION['update']['file'] = $value->name;
                        $_SESSION['update']['path'] = $upd->path;
                        return;
                    }
                }

                if (isset($upd->db)) {
                    $this->write_log($this->actionlog . " " . $this->lang['l_start_updatedb'] . "<br />", "action.log");
                    foreach ($upd->db as $key => $value) {
                        $this->model->updateOpDb($value);
                    }
                }

                if (isset($upd->eval)) {
                    $this->write_log($this->actionlog . " " . $this->lang['l_start_updateeval'] . "<br />", "action.log");
                    foreach ($upd->eval as $key => $value) {
                        @eval($value);
                    }
                }

                $this->write_log($this->actionlog . " " . $this->lang['l_start_updatecopy'] . "<br />", "action.log");
                foreach ($upd->file as $key => $value) {
                    copy(SITE_DIR . "modules/upload/" . $value->name, SITE_DIR . $value->path . $value->name) or die($this->write_log($this->actionlog . " " . $this->lang['l_start_blockdir'] . "<br />", "action.log"));
                    unlink(SITE_DIR . "modules/upload/" . $value->name);
                }
                $this->write_log($this->actionlog . " " . $this->lang['l_start_updateendoper'] . "<br />", "action.log");
                unlink(SITE_DIR . "modules/upload/upd.json");
            } else {

                $this->write_log($this->actionlog . " " . $this->lang['l_start_procupdatebadcfg'] . "<br />", "action.log");
                unlink(SITE_DIR . "modules/upload/upd.json");
            }
        }
    }

}

?>