<?php

class tags extends add_module {

    private $class = "tags";
    private $func = "show";

    function _show_schedule($sys) {
        $data = $this->model->GetAllDoc($sys['template_out'], $this->class, "_sc", $sys['id']);
        if (!empty($data))
            foreach ($data as $key => $value) {
                $datas[$value['side']] = $value['text'];
            }
        return $datas;
    }

    function _insert_tags_side($post) {
        $this->model->deltags_side();
        $this->model->set_tags_side($post, $this->class);
        return true;
    }

    protected function _options($id_module, $id_templates=0) {
        if (isset($_POST['save'])) {
            $ret['sys']['result'] = $this->_insert_tags_side($_POST);
            $ret['sys']['clean_cache'] = true;
        }
        $data['id_module'] = $id_module;
        $data['templates'] = $this->_call_out_func("tree_model", "getAllTemplates");
        foreach ($data['templates'] as $key => $value) {
            $data['templates'][$key]['side'] = $this->model->getAllSideTags($value['id']);
        }

        $ret['view'] = $this->view->view("templates/admin_modules/tags/options.tpl", $data + $this->lang, true);
        return $ret;
    }

    function show($name) {
        return "not view";
    }

    protected function _edit($id, $lang) {
        $data['doc'] = $this->model->get_Doc2($id, $lang);
        $data['lang'] = $lang;
        $data['id'] = $id;
        return $this->view->view("templates/admin_modules/tags/edit.tpl", $data + $this->lang, true);
    }

    function _create($lastid, $post, $oper="") {
        $data['init'] = $oper;
        if (empty($post['lang_cur'])) {
            $data['lang_arr'] = $this->_call_out_func("lang", "return_all_lang_array", array());
        } else {
            $data['lang_arr'] = $this->_call_out_func("lang_model", "get_info_lang_by_id", $post['lang_cur']);
        }
        $data['side'] = $this->_call_out_func("tree_model", "returnSideForFatherId", $lastid);
        $data['id'] = $lastid;
        return $this->view->view("templates/admin_modules/tags/create.tpl", $data + $this->lang, true);
    }

    function _insert($ns_treeid) {
        $this->set_message($this->model->insert($this->class, $this->func, $ns_treeid, $_POST));
        $this->relink($_POST['relink']);
    }

    function _update($id) {
        $this->security("post", "", 200);
        $this->set_message($this->model->update($id, $_POST));
        $this->relink($_POST['relink']);
    }

    function __call($method, $params) {
        return $this->show_404($method, $params);
    }

    function _returnPath($module, $func, $link) {
        return $module . "/" . $link;
    }

    function _returnNLink($id, $lang) {
        $str = "";
        $arr = $this->model->get_doc($id, $lang);
        if (!empty($arr)) {
            foreach ($arr as $key => $value) {
                $str.=" " . $value['text'];
            }
            $ret = $arr[0];
            $ret['text'] = $str;
            return $ret;
        } else {
            return false;
        }
    }

    function _returnLink($id, $lang, $search="", $mod_order="") {
        if (empty($mod_order) || $mod_order == "none") {

            $str = "";
            $arr = $this->model->get_doc($id, $lang, $search);
            if (!empty($arr)) {

                foreach ($arr as $key => $value) {
                    $str.=" " . $value['text'];
                }
                $ret = $arr[0];
                $ret['text'] = $str;
                return $ret;
            } else {
                if (empty($mod_order) || $mod_order == "none" && empty($search)) {
                    $data = $this->model->getInfoDocMod($id);
					if(!$data['sch']) return false;
                    $data['text'] = $this->lang['lang_m_descr_tags_lang'];
                    $side = $this->model->getSideMod($id, "tags");
                    $data['side_for_doc'] = "";
                    foreach ($side as $key => $value) {
                        $data['side_for_doc'].="," . $value['side'];
                    }
                    $data['sch_menu'] = true;
                    $data['lang'] = "any";
                    $data['side_only_read'] = true;
                    $data['text_ext'] = '<img align="left" style="margin-right:5px;" alt="' . $this->lang['lang_childrenn'] . '" src="/templates/images/link.png"  />';
                    return $data;
                }
                return false;
            }
        }
    }

    function _del($id, $lang="") {
        $this->set_message($this->model->del($id, $lang));
        $this->relink(@$_SERVER['HTTP_REFERER']);
    }

    function _getPagesAbs($ns_doc) {
        return $this->model->getPagesAbs($ns_doc);
    }

    function _getPrototypePages($ns_doc="", $class="") {
        $il = $this->model->getIdLang($ns_doc);
        return array('nsdoc' => $ns_doc, 'class' => $class, 'title' => $this->lang['l_add_pages'], 'descr' => array(0 => array('title' => $this->lang[$il[0]['type']], 'col' => 20, 'editor' => false, 'name' => $il[0]['type'], 'idlang' => $il[0]['id_doc']), 1 => array('title' => $this->lang[$il[1]['type']], 'col' => 20, 'editor' => false, 'name' => $il[1]['type'], 'idlang' => $il[1]['id_doc']), 2 => array('title' => $this->lang[$il[2]['type']], 'col' => 20, 'editor' => false, 'name' => $il[2]['type'], 'idlang' => $il[2]['id_doc']), 3 => array('title' => $this->lang[$il[3]['type']], 'col' => 20, 'editor' => false, 'name' => $il[3]['type'], 'idlang' => $il[3]['id_doc'])));
    }

    function _creatorMenu($arr) {
        //return array(0 => array("class" => $arr['class'] . "|" . "_createSys", "name_module" => $arr['name_module'] . $this->lang['lang_tags_menuc']));
		return false;
    }

    function _createSys($ns_tree) {
        $this->set_message($this->model->insertDoc($ns_tree, "tags"));
        $this->relink();
    }

}

?>