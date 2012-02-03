<?php

class tree extends add_module {

    private $class = "tree";
    private $func = "start";
    private $arr_side;

    function _return_info($id="") {
        return $this->model->get_info_ns_tree($id);
    }

    function _start_schedule($ns_tree,$shd, $url, $id_sch,$idint=0) {
        if ($ns_tree['class'] != $this->class) 
        return $this->return_menu($ns_tree['idnt'], "", $ns_tree['namet'],$idint);
    }

    function start($sys) {
        $data2['sys'] = $sys;
        $data = $this->return_menu($data2['sys']['ns_tree']['idnt'], "", $data2['sys']['ns_tree']['namet']);
        return $data + $data2;
    }

    function _create($id, $post, $oper="") {
        $this->set_message($this->model->insertDoc($id, "tree"));
        $this->relink();
    }

    function build_tree($arg="", $arg1="", $arg2="templates/admin/dir/link.tpl") {
        $tmp = $this->model->return_cat($arg, $arg1);
        $tmp = $this->build_cat($tmp, $arg2);
        return $tmp;
    }

    function build_cat($arg="", $templateslink="templates/admin/dir/link.tpl") {
        $ret = "";
        $modules = $this->model->returnAllModule();
        foreach ($arg as $key => $value) {
            if ($value['level'] != 0 && $tmp != 0) {
                if ($value['level'] > $tmp) {
                    $ret.=$this->view->view("templates/admin/dir/div_hid.tpl", $value, true);
                    $flag = false;
                } else {
                    if ($value['level'] < $tmp)
                        for ($ii = $value['level']; $ii < $tmp; $ii++) {
                            $ret.=$this->view->view("templates/admin/dir/div_end.tpl", "", true);
                        }
                }
            }
            if ($flag)
                $ret.=$this->view->view("templates/admin/dir/br.tpl", "", true);
            if ($value['show_me']) {
                $value['show_me'] = $this->view->view("templates/admin/dir/show_image_true.tpl", "", true);
            } else {
                $value['show_me'] = $this->view->view("templates/admin/dir/show_image_false.tpl", "", true);
            }
            $ret.=$this->view->view("templates/admin/dir/menu.tpl", $value, true);
            $value['space'] = str_repeat("&nbsp;", $value['level']);
            foreach ($modules as $keym => $valuem)
                $pages['pages'].=$this->_call_out_func($valuem['class'], "_returnPagesForNstree", $value['id'], $value['name'], $value['template_out']);

            $ret.=$this->view->view($templateslink, $value + $pages, true);
            unset($pages);
            $flag = true;
            $tmp = $value['level'];
        }

        for ($ii = 1; $ii < $tmp; $ii++) {
            $ret.=$this->view->view("templates/admin/dir/div_end.tpl", "", true);
        }
        return $ret;
    }

    function get_doc($id, $pag=1, $id_doc="", $path="") {
        $pag_tmp = $pag;
        $pag = ($pag * 5) - 5;
        $sm = SUM_PAGE;
        $tmp = $this->db->result_array($this->db->query("SELECT SQL_CALC_FOUND_ROWS * From ns_doc WHERE father_id='$id' and module ='$module' ORDER BY date DESC LIMIT $pag,$sm  ;"));
        $total = $this->model->get_info('', "FOUND_ROWS()", "SELECT FOUND_ROWS();", '');

        if (!count(($tmp)))
            return $this->view->view("templates/admin/table/empty_dir.tpl", "", true);
        // create dir
        foreach ($tmp as $key => $value) {
            if ($value['show_me'] == 1)
                $value['show_me'] = $this->view->view("templates/admin/table/table_red.tpl", "", true);
            else
                $value['show_me'] = $this->view->view("templates/admin/table/table_red_false.tpl", "", true);
            $value['pag'] = $pag_tmp;
            $value['cat_id'] = $id;
            $ret['dir'].=$this->view->view("templates/admin/table/table_d.tpl", $value, true);
        }
        //pagination
        $page = ceil(($total) / 5);
        for ($i = 1; $i <= $page; $i++) {
            if ($id_doc == "") {
                $data['link'] = $path . "/" . $id . "/" . $i;
            } else {
                $data['link'] = "edit_doc/" . $id_doc . "/" . $i . "/" . $id;
            };
            $data['num'] = $i;
            if ($i == $pag_tmp) {
                $ret['pagination'].=$this->view->view("templates/admin/table/pagination2.tpl", $data, true);
            } else {
                $ret['pagination'].=$this->view->view("templates/admin/table/pagination.tpl", $data, true);
            }
        }
        $ret = $this->view->view("templates/admin/table/table.tpl", $ret, true);
        return $ret;
    }

    function get_dir($id) {
        $tmp = $this->db->result_array($this->db->query("SELECT name,id From ns_tree ORDER BY lft "));
        $value['name'] = $this->model->get_info($id, "name");
        $value['id'] = $id;
        $ret.=$this->view->view("templates/admin/doc/option.tpl", $value, true);
        foreach ($tmp as $key => $value) {
            $ret.=$this->view->view("templates/admin/doc/option.tpl", $value, true);
        }


        return $ret;
    }

    function return_menu($p_id, $side="", $templates="",$idint=0) {
        $ret = array();
        $tmpC = array();
        $tmp = $this->model->return_menu($p_id, $side, $GLOBALS['lang']); //only numeric
        $data['ppid'] = $p_id;
        $data['idint'] = $idint;
        foreach ($tmp as $key => $value) {
            $data['name'] = $value['text'];

            if ($value['adress']) {
                $data['operator'] = $value['adress'];
            } else {

                if (empty($value['short_a']) && empty($value['max_short_a'])) {
                    $data['operator'] = SITE_URL . $GLOBALS['lang'] . "/" . $value['module'] . "/" . $value['func_name'] . "/" . $value['name'];
                } else {
                    if (!empty($value['short_a']))
                        $data['operator'] = SITE_URL . $GLOBALS['lang'] . "/" . $value['module'] . "/" . $value['name'];
                    if (!empty($value['max_short_a']))
                        $data['operator'] = SITE_URL . $GLOBALS['lang'] . "/" . $value['name'];
                }
            }
            $data['space'] = str_repeat("&nbsp;", $value['level']);
            if ($value['templates_int'])
                $ret[$value['side']].=$this->view->view("templates/site/tpl_site/" . $templates . "/" . $value['templates_int'], $data + $value, true);
            else
                $ret[$value['side']].=$this->view->view("templates/site/tpl_site/" . $templates . "/menu.tpl", $data + $value, true);
            $tmpC[] = $data + $value;
        }
        $ret['clean_tree'] = $tmpC;
        return $ret;
    }

    function return_doc($id, $module) {
        $tmp = $this->model->return_doc($id, $module);
        foreach ($tmp as $key => $value) {
            
        }
        return $tmp;
    }

    function _add($id, $add_in, $show, $adress, $side, $post) {
        if (isset($post['autos'])) {
            if (isset($post['lang']['en'])) {
                $add_in = $this->url_title($post['lang']['en'], "", true);
            } else {
                $lang = $this->_call_out_func("lang_model", "get_default_lang");
                $str = $this->translate($post['lang'][$lang['name']]);
                $add_in = $this->url_title($str);
            }
        }

        return $this->model->add_in($id, $add_in, $show, $adress, $side, $post);
    }

    function save_ns_tree($id, $idAlias, $postArray) {
        if (isset($postArray['autos'])) {
            if (isset($postArray['en'])) {
                $postArray['add_in'] = $this->url_title($postArray['en'], "", true);
            } else {
                $lang = $this->_call_out_func("lang_model", "get_default_lang");
                $str = $this->translate($postArray[$lang['name']]);
                $postArray['add_in'] = $this->url_title($str);
            }
        }
        $ress = 0;
        if ($_POST['move'] && $_POST['idt'])
            $ress = $this->model->moveNstree($id, $_POST['idt'], $_POST['move']);
        $ress.=$this->model->save_ns_tree($id, $idAlias, $postArray);
        return $ress;
    }

    function url_title($str, $separator = 'dash', $lowercase = FALSE) {
        if ($separator == 'dash') {
            $search = '_';
            $replace = '-';
        } else {
            $search = '-';
            $replace = '_';
        }

        $trans = array(
            '&\#\d+?;' => '',
            '&\S+?;' => '',
            '\s+' => $replace,
            '[^a-z0-9\-\._]' => '',
            $replace . '+' => $replace,
            $replace . '$' => $replace,
            '^' . $replace => $replace,
            '\.+$' => ''
        );

        $str = strip_tags($str);

        foreach ($trans as $key => $val) {
            $str = preg_replace("#" . $key . "#i", $val, $str);
        }

        if ($lowercase === TRUE) {
            $str = strtolower($str);
        }

        return mb_substr(trim(stripslashes($str)), 0, 20, 'UTF-8');
    }

    function translate($str) {

        $arr = array(
            'Р°' => 'a',
            'Р±' => 'b',
            'РІ' => 'v',
            'Рі' => 'g',
            'Рґ' => 'd',
            'Рµ' => 'e',
            'С‘' => 'jo',
            'Р¶' => 'zh',
            'Р·' => 'z',
            'Рё' => 'i',
            'Р№' => 'jj',
            'Рє' => 'k',
            'Р»' => 'l',
            'Рј' => 'm',
            'РЅ' => 'n',
            'Рѕ' => 'o',
            'Рї' => 'p',
            'СЂ' => 'r',
            'СЃ' => 's',
            'С‚' => 't',
            'Сѓ' => 'u',
            'С„' => 'f',
            'С…' => 'kh',
            'С†' => 'c',
            'С‡' => 'ch',
            'С€' => 'sh',
            'С‰' => 'shh',
            'СЉ' => '"',
            'С‹' => 'y',
            'СЊ' => "'",
            'СЌ' => 'eh',
            'СЋ' => 'ju',
            'СЏ' => 'ja'
        );

        return str_replace(array_keys($arr), array_values($arr), mb_strtolower($str, "utf-8"));
    }

    function current_address($id_nstree) {  //sys
        $nstree = $this->model->GetInfoForLinkTreeById($id_nstree);
        if ($nstree['max_short_a']) {
            return "/" . $nstree['name'];
        } elseif ($nstree['short_a']) {
            return "/" . $nstree['module'] . "/" . $nstree['name'];
        } else {
            return "/" . $nstree['module'] . "/" . $nstree['func_name'] . "/" . $nstree['name'];
        }

        return false;
    }
    

    function current_address2($id_nstree) {  //sys
        $nstree = $this->model->GetInfoForLinkTreeById($id_nstree);
        if ($nstree['max_short_a']) {
            return $nstree['module'] . "/" . $nstree['func_name'] . "/" . $nstree['name'];
        } elseif ($nstree['short_a']) {
            return $nstree['module'] . "/" . $nstree['name'];
        } else {
            return $nstree['module'] . "/" . $nstree['func_name'] . "/" . $nstree['name'];
        }

        return false;
    }
    
    function _returnLink($id, $lang, $search="", $mod_order=""){
       if (empty($mod_order) || $mod_order == "none" && empty($search)) {
           $data=$this->model->getInfoDocMod($id);
           $data['text']=$this->lang['lang_m_descr_tree_lang'];
           $data['side_for_doc']=$this->lang['lang_m_descr_tree_lang2'];
           $data['side_only_read']=true;
           $data['lang']="any";
           $data['sch_menu'] = true;
           $data['text_ext']='<img align="left" style="margin-right:5px;" alt="'.$this->lang['lang_childrenn'].'" src="/templates/images/link.png"  />';
            return $data;
        }  
    }

}

?>