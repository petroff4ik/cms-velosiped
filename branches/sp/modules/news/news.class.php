<?php

class news extends add_module {

    protected $class = "news";
    protected $func = "show";

    function id($sys, $id_doc="") {
        $data['sys'] = $sys;
        $data['sys']['idint'] = (int) $id_doc;
        $page['news'] = $this->model->getNewsAndNstree($id_doc);
        $data[$page['news'][0]['side_for_doc']] = $this->view->view("templates/site/tpl_module/news/onenews.tpl", $page, true);
        if (empty($page['news']))
            $this->show_404();
        $tags = $this->_call_out_func("tags_model", "getAllSideTagsG", $page['news'][0]['template_out']);
        foreach ($tags as $key => $value) {
            $data[$value['side']] = strip_tags($page['news'][0]['text']);
        }
        return $data;
    }

    function show($sys, $pag=1) {
        //$date['template']['path_file']="modules/news/template/news.tpl";
        $data['sys'] = $sys;
        $pages = $sys['ns_tree'];

        //menu end

        $act['pag'] = $pag;
        $pag_tmp = $pag;
        $pag = ($pag * 10) - 10;
        $news['title'] = $this->model->get_all_news_title($pages['id'], $pag);
        $total = $this->model->GetFoundRows();
        $news['shortdescr'] = $this->model->get_all_news_shortdescr($pages['id'], $pag);
        if (empty($news['title']) && empty($news['shortdescr']))
            $this->show_404();
        $page = ceil(($total) / 10);
        $act['link'] = "";
        for ($i = 1; $i <= $page; $i++) {
            if (is_int($i / 30))
                $act['link'].="<br />";
            if ($i == $pag_tmp) {
                $act['link'].=$i . "&nbsp;|&nbsp;";
            } else {
                $act['link'].="<a href='" . SITE_URL . $GLOBALS['lang'] . "/" . $this->ns_tree['name'] . "/" . $this->func . "/" . $i . "'>" . $i . "</a>&nbsp;|&nbsp;";
            }
        }
        $act['id_template'] = $pages['template_out'];
        $news_temp = $this->view->view("templates/site/tpl_module/news/news.tpl", $act + $news + $data, true);
        $side = $this->_call_out_func("tree_model", "returnSideForEvent", $this->class, $pages['template_out']);
        foreach ($side as $key => $value) {
            $data[$value['side']] = $news_temp;
        }
        return $data;
    }

    protected function _edit($id, $lang) {
        //$data['side']=$this->model->returnSideForDoc($id);
        $data['side'] = $this->_call_out_func("tree_model", "returnSideForDoc", $id);
        $data['doc'] = $this->model->get_news_all($id, $lang);
        return $this->view->view("templates/admin_modules/news/edit.tpl", $data + $this->lang, true);
    }

    function _create($id, $post, $oper="") {
        $data['init'] = $oper;
        if (empty($post['lang_cur'])) {
            $data['lang_arr'] = $this->_call_out_func("lang", "return_all_lang_array", array());
        } else {
            $data['lang_arr'] = $this->_call_out_func("lang_model", "get_info_lang_by_id", $post['lang_cur']);
        }
        $data['side'] = $this->_call_out_func("tree_model", "returnSideForFatherId", $id);
        $data['id'] = $id;
        return $this->view->view("templates/admin_modules/news/create.tpl", $data + $this->lang, true);
    }

    function _insert($ns_treeid) {
        $this->security("post", 200);
        $this->set_message($this->model->insert($this->class, $ns_treeid, $_POST));
        $this->relink($_POST['relink']);
    }

    function _update($id) {
        $this->security("post", "", 200);
        $this->set_message($this->model->update($id, $_POST));
        $this->relink(@$_POST['relink']);
    }

    function _del($id, $lang="") {
        $this->set_message($this->model->del($id, $lang));
        $this->relink(@$_SERVER['HTTP_REFERER']);
    }

    function __call($method, $params) {
        return $this->show_404($method, $params);
    }

    function _returnPath($module, $func, $link) {
        return $link;
    }

    function _returnNLink($id, $lang) {
        return $this->model->get_news($id, $lang);
    }

    function _returnLink($id, $lang, $search="", $mod_order="") {
        if (empty($mod_order) || $mod_order == "none") {
            return $this->model->get_news($id, $lang, $search);
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
        return array('nsdoc' => $ns_doc, 'class' => $class, 'title' => $this->lang['l_add_pages'], 'descr' => array(0 => array('title' => $this->lang['c_gtitle'], 'col' => 20, 'editor' => false, 'name' => 'title', 'idlang' => $il['title']), 1 => array('title' => $this->lang['c_shortdescr'], 'col' => 40, 'editor' => false, 'name' => 'shortdescr', 'idlang' => $il['shortdescr']), 2 => array('title' => $this->lang['c_body'], 'col' => 80, 'editor' => true, 'name' => 'body', 'idlang' => $il['body'])));
    }

}

?>