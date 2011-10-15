<?php

class map extends add_module {

	protected $class = "map";
	protected $func = "show";

	function show($sys, $pag=1) {
		$data['sys'] = $sys;
		$side = $this->model->getSideNsdoc($sys['ns_tree']['id']);
		$data[$side['side_for_doc']] = $this->_creat_site_map();
		return $data;
	}
	

	function _create($id, $post, $oper="") {
		$this->set_message($this->model->insert($this->class, $id, $post));
		$this->relink();
	}

	function _create_ini($id, $post) {
		$this->set_message($this->model->insert($this->class, $id, $post));
		$this->relink(ADMIN_DIR_FULL);
	}

	function _insert($ns_treeid) {
		$this->security("post", 200);
		$this->set_message($this->model->insert($this->class, $ns_treeid, $_POST));
		$this->relink($_POST['relink']);
	}

	function _del($id, $lang="") {
		$this->set_message($this->model->deleteNsdoc($id));
		$this->relink(@$_SERVER['HTTP_REFERER']);
	}

	function __call($method, $params) {
		return $this->show_404($method, $params);
	}

	function _returnPath($module, $func, $link) {
		return $link;
	}

	function _returnLink($id, $lang, $search="", $mod_order="") {
		if (empty($mod_order) || $mod_order == "none" && empty($search)) {
			$data = $this->model->getInfoDocMod($id);
			$data['text'] = $this->lang['lang_m_descr_menu'];
			$data['side_only_read'] = false;
			$data['lang'] = "any";
			$data['sch_menu'] = true;
			return $data;
		}
	}
	
	function _creat_site_map(){
		$data['cat'] = $this->_call_out_func("tree_model", "return_cat","all");
		return $this->view->view("templates/site/tpl_module/map/show.tpl",$data,true);
	}

}

?>