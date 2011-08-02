<?php

class dv extends add_module {

    protected $class = "dv";
    protected $func = "id";

    protected function _edit($id, $lang) {
        $data['side'] = $this->model->returnSideForDoc($id);
        $data['doc'] = $this->model->getDoc($id, $lang);
        return $this->view->view("templates/admin_modules/dv/edit/edit.tpl", $data + $this->lang, true);
    }
    
    function _id_schedule($sys,$shd,$url,$id_sch) {
       $data['sys']['ns_tree'] = $sys;
        $id = $data['sys']['ns_tree']['id'];
        $arg['text'] = $this->model->get_doc($id_sch,"iddoc");
        if (empty($arg['text']))
            $this->show_404();
        foreach ($arg['text'] as $key => $value) {
            $value['names'] = $name;
            $value['template_out'] = $data['sys']['ns_tree']['id'];
            $data[$value['side_for_doc']].=$this->view->view("templates/site/tpl_module/dv/dv.tpl", $value + $this->lang, true);
        }
        return $data;
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
        return $this->view->view("templates/admin_modules/dv/create/create.tpl", $data + $this->lang, true);
    }

    function _add($nsdoc_id, $lang) {
        $data['lang_arr'] = $this->_call_out_func("lang_model", "get_info_lang_by_id", $lang);
        $data['side'] = $this->_call_out_func("tree_model", "returnSideForDoc", $nsdoc_id);
        $data['nsdoc_id'] = $nsdoc_id;
        $data['lang'] = $lang;
        return $this->view->view("templates/admin_modules/dv/create/add.tpl", $data + $this->lang, true);
    }

    function _insert($lastid) {
        $data['lastInsert'] = $this->_call_out_func("lang", "return_last_Ilang", array());
        $this->set_message($this->model->insert($this->func, $lastid, $this->class, $data['lastInsert']['id']));
        $this->relink(@$_POST['relink']);
    }

    function _update($id) {
        $this->security("post", "", 200);
        $this->set_message($this->model->update($id));
        $this->relink(@$_POST['relink']);
        //header("location: /".ADMIN_DIR."/message/ok");
    }

    function _del($id, $lang="") {
        $this->set_message($this->model->del($id, $lang));
        $this->relink(@$_SERVER['HTTP_REFERER']);
    }

    function __call($method, $params) {
        return $this->show_404($method, $params);
    }

    function show($modules, $name="", $id="") {
        $data['sys']['ns_tree'] = $this->get_ns_tree($name);
        $data['sys']['idint'] = (int) $id;
        $doc['title'] = $this->model->get_doc_title($id);
        $doc['text'] = $this->model->get_text($id);
        if (empty($doc['title']) && empty($doc['text']))
            $this->show_404();
        $tags = $this->_call_out_func("tags_model", "getAllSideTagsG", $data['sys']['ns_tree']['template_out']);
        foreach ($tags as $key => $value) {
            $data[$value['side']] = strip_tags($doc['title']['text']);
        }
        $data[$doc['text']['side_for_doc']] = $this->view->view("templates/site/tpl_module/dv/show.tpl", $doc, true);
        return $data;
    }

    function id($sys) {
        $data['sys'] = $sys;
        $id = $data['sys']['ns_tree']['id'];
        $arg['text'] = $this->model->get_doc($id);
        if (empty($arg['text']))
            $this->show_404();
        foreach ($arg['text'] as $key => $value) {
            $value['names'] = $name;
            $value['template_out'] = $data['sys']['ns_tree']['id'];
            $data[$value['side_for_doc']].=$this->view->view("templates/site/tpl_module/dv/dv.tpl", $value + $this->lang, true);
        }
        return $data;
    }

    function _returnPath($module, $func, $link) {
        return $link;
    }

    function _returnNLink($id, $lang) {
        return $this->model->get_text($id, $lang);
    }

    function _returnLink($id, $lang, $search="", $mod_order="") {
        if (empty($mod_order) || $mod_order == "none") {
            $res = $this->model->get_text2($id, $lang, $search);
            if($res['sch'])$res['text_ext'] = '<img align="left" style="margin-right:5px;" alt="' . $this->lang['lang_childrenn'] . '" src="/templates/images/link.png"  />';
            return $res;
        }
    }

    function _returnPagesForNstree($nstree="", $nstreeName="", $id_template=1) {
        $ret = $this->model->getPagesForNstree($nstree);
        if (!empty($ret)) {
            $data = "";
            foreach ($ret as $key => $value)
                $data.='<a href="#" onclick="writeTo(\'' . $nstreeName . '/id/' . $value['id'] . "/" . '\');return false;">' . mb_substr(strip_tags($value['text']), 0, DELEMITER_SYMVOL - 150, "utf-8") . '...</a><br /><br />';

            return $data;
        } else {

            return false;
        }
    }

    function _getPagesAbs($ns_doc) {
        return $this->model->getPagesAbs($ns_doc);
    }

    function _getPrototypePages($ns_doc="", $class="") {
        $il = $this->model->getIdLang($ns_doc);
        return array('nsdoc' => $ns_doc, 'class' => $this->class, 'title' => $this->lang['l_add_pages'], 'descr' => array(0 => array('title' => $this->lang['c_gtitle'], 'col' => 20, 'editor' => false, 'name' => 'text_title', 'idlang' => $il['text_title']), 1 => array('title' => $this->lang['l_body_t'], 'col' => 80, 'editor' => true, 'name' => 'text', 'idlang' => $il['text'])));
    }
    
    
  

}

?>