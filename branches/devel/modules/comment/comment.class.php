<?

class comment extends add_module {

	protected $class = "comment";
	protected $func = "comm";

	function _create_ini($id, $post) {
		$this->set_message("true");
		$this->relink(ADMIN_DIR_FULL);
	}

	protected function _options($id_module, $idcp="", $oper="") {

		$ret['view'] = $this->lang['l_mod_options_empty'];
		return $ret;
	}


	function _returnPath($module, $func, $link) {
		return $link;
	}

	function _retModOptions($nsdoc) {
		return '<a href="' . ADMIN_DIR_FULL . 'safe_launch/comment/create_to/' . $nsdoc . '">' . $this->lang['l_answertff'] . '</a>';
	}

	function _returnNLink($id, $lang) {
		$data = $this->model->get_comm($id, "any");
		if ($data['int_id'])
			$data['text'] = "(" . $this->lang['l_ans'] . ") " . $data['text'];
		return $data;
	}

	function _returnLink($id, $lang, $search="", $mod_order="") {
		$data = $this->model->getInfoDocMod($id);
		if (($data['types'] == 'form' || $data['types'] == 'view') && empty($search)) {

			$data['lang'] = "any";
			$data['sch_menu'] = true;
			if ($data['types'] == "form") {
				$data['sch_add_menu'] = '<a href="' . ADMIN_DIR_FULL . 'safe_launch/comment/editform/' . $data['father_id'] . '/' . $data['id'] . '">' . $this->lang['l_editform'] . '</a><br/>';
				$data['text'] = $this->lang['lang_m_descr_comm_lang'];
			} else {
				$data['text'] = $this->lang['lang_m_descr_comm_lang_view'];
				$data['sch_add_menu'] = '<a href="' . ADMIN_DIR_FULL . 'safe_launch/comment/editform/' . $data['father_id'] . '/' . $data['id'] . '">' . $this->lang['l_editform'] . '</a><br/>';
			}
			if ($data['sch'])
				$data['text_ext'] = '<img align="left" style="margin-right:5px;" alt="' . $this->lang['lang_childrenn'] . '" src="/templates/images/link.png"  />';
		} else {
			$data = $this->model->get_comm($id, "any", $search);
			if ($data['int_id']) {
				$tmp = $this->model->get_info_by_id($data['int_id']);
				$data['text_ext'] = "(<a href='" . ADMIN_DIR_FULL . "safe_launch/comment/edit/" . $tmp['id_doc'] . "/any'>" . $this->lang['l_ans'] . "</a>) ";
			}
		}
		return $data;
	}

	function _retModOrder() {
		$data['-doc-comm'] = $this->lang['l_comm'];
		return $data;
	}

	function _create($id, $post, $oper="") {
		$data['init'] = $oper;

		$data['all_email'] = $this->model->get_all_message();
		$data['id'] = $id;
		return $this->view->view("templates/admin_modules/comment/create.tpl", $data + $this->lang + $post, true);
	}

	function _create_to($nsdoc) {
		$ns_tree = $this->model->get_tree($nsdoc);
		return $this->_create($ns_tree['id'], $ns_tree);
	}

	function _insert($ns_treeid) {
		$this->security("post", 200);
		$this->set_message($this->model->insert($this->class, $ns_treeid, $_POST));
		$this->relink($_POST['relink']);
	}

	protected function _edit($id, $lang) {
		$data['comm'] = $this->model->get_comm_all($id, "any");
		$data['id'] = $id;
		$data['all_email'] = $this->model->get_all_message();
		return $this->view->view("templates/admin_modules/comment/edit.tpl", $data + $this->lang, true);
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

	function comm($sys) {
		$data['sys'] = $sys;
		$datas['comment_path'] = $this->model->get_path_form($data['sys']['ns_tree']['id']);
		$datas['comment_path_v'] = $this->model->get_path_view($data['sys']['ns_tree']['id']);
		return $this->int_pross($datas, $data);
	}

	function _comm_schedule($sys, $shd, $url, $id_sch, $idint="") {

		if ($sys['class'] != $this->class) {
			$shd['father_id'] = $sys['idnt'];
			if ($shd['types'] == 'form')
				return $this->int_pross(array('comment_path' => $shd), array('sys' => array('ns_tree' => $sys, "ext_id" => $idint)));
			else
				return $this->int_pross(array('comment_path_v' => $shd), array('sys' => array('ns_tree' => $sys, "ext_id" => $idint)));
		}
	}

	private function int_pross($datas, $data) {
		$this->sessionStart();
		$this->CaptchaNumbersV2 = new CaptchaNumbersV2(4);
		$this->CaptchaNumbersV2->display();
		$_SESSION['captcha'] = $this->CaptchaNumbersV2->getString();
		if (empty($datas['comment_path']) && empty($datas['comment_path_v'])) {
			$side = $this->_call_out_func("tree_model", "returnSideForModules", $this->class, "_ev", $data['sys']['ns_tree']['template_out']);
			foreach ($side as $key => $value) {
				$data[$value['side']] = $this->wrapper_error("Error 'comment' not find sch task.");
			}
		} else {
			
			if ($datas['comment_path_v']['show_me']) {
				$datas['all_comm'] = $this->model->get_comment_for($datas['comment_path_v']['father_id'], @$data['sys']['ext_id']);
				$datas['all_commn'] = $this->model->get_comment_for_n($datas['comment_path_v']['father_id'], @$data['sys']['ext_id']);
				$view = $this->view->view("templates/site/tpl_module/comment/commview.tpl", $datas + $data, true);
			}

			if ($datas['comment_path']['show_me']) {
				$form = $this->view->view("templates/site/tpl_module/comment/comm.tpl", $data + $datas, true);
			}

			if ($datas['comment_path']['side_for_doc'] == $datas['comment_path_v']['side_for_doc'] && ($datas['comment_path']['show_me'] && $datas['comment_path_v']['show_me'])) {
				$data[$datas['comment_path']['side_for_doc']] = $form . $view;
			} else {
				if (!empty($form))
					$data[$datas['comment_path']['side_for_doc']] = $form;
				if (!empty($view))
					$data[$datas['comment_path_v']['side_for_doc']] = $view;
			}
		}
		return $data;
	}

	function insert($module, $id_nstree="", $ext_id="") {
		$this->validator = new FormValidator(false);
		$this->validator->addValidation("body", "req");
		$this->validator->addValidation("email", "email");
		$this->validator->addValidation("email", "req");
		$this->validator->addValidation("email", "maxlen=40");
		$this->validator->addValidation("body", "maxlen=2000");
		$this->validator->addValidation("body", "minlen=5");
		$formars = new MyValidator();
		$this->validator->AddCustomValidator($formars);
		if ($this->validator->ValidateForm()) {
			$this->set_messageF("<B>" . $this->lang['langs']['comment']['comm_add'] . "</B>", "add");
			$path = $this->model->get_commen_path_tree($this->security($id_nstree, 3));
			if (empty($path))
				$path = $this->model->getShedule($id_nstree, "", "comment");

			if (!empty($path)) {
				$this->model->insert_front($_POST, $id_nstree, $ext_id);
			} else {
				$this->error("comment - > internal error:wrong number tree.");
			}
		} else {
			$stre = "<B>Validation Errors:</B>";

			$error_hash = $this->validator->GetErrors();
			foreach ($error_hash as $inpname => $inp_err) {
				$stre.="<p>$inpname : $inp_err</p>\n";
			}
			$this->set_messageF($stre, "add");
		}
		$this->relinkF($_SERVER['HTTP_REFERER']);
	}

	function _creatorMenu($arr) {
		return array(0 => array("class" => $arr['class'] . "|" . "_createPoint", "name_module" => $arr['name_module'] . $this->lang['lang_com_menuc']),
			1 => array("class" => $arr['class'] . "|" . "_createView", "name_module" => $arr['name_module'] . $this->lang['lang_com_view']));
	}

	function _createPoint($lastid, $post, $oper="") {
		$data = array();
		if (empty($oper)) {
			$data['types'] = "form";
			$data['files'] = htmlspecialchars(file_get_contents(SITE_DIR . "templates/site/tpl_module/comment/comm.tpl"));
		} else {
			$data['types'] = "view";
			$data['files'] = htmlspecialchars(file_get_contents(SITE_DIR . "templates/site/tpl_module/comment/commview.tpl"));
		}

		$data['ns_tree'] = $lastid;
		$data['side'] = $this->_call_out_func("tree_model", "returnSideForFatherId", $lastid);
		$data['id'] = "";
		return $this->view->view("templates/admin_modules/comment/editform.tpl", $data + $this->lang, true);
	}

	function _inserteditform() {
		$this->security("post");
		$_POST['module'] = $this->class;
		$_POST['mod_order'] = "comm";
		$content = $_POST['edit'];

		$content = htmlspecialchars_decode($content);
		$content = stripcslashes($content);
		$content = stripslashes($content);
		if ($_POST['types'] == "form")
			$this->write_file($content, "templates/site/tpl_module/comment/comm.tpl");
		elseif ($_POST['types'] == "view")
			$this->write_file($content, "templates/site/tpl_module/comment/commview.tpl");
		if (isset($_POST['id']) && !empty($_POST['id']))
			$this->set_message($this->model->updateeditfor($_POST));
		else
			$this->set_message($this->model->inserteditfor($_POST));
		$this->relink(@$_POST['relink']);
	}

	function _editform($nstree, $iddoc) {
		$data['ns_doc'] = $this->model->getInfoDocMod($iddoc);
		if ($data['ns_doc']['types'] == 'form')
			$data['files'] = htmlspecialchars(file_get_contents(SITE_DIR . "templates/site/tpl_module/comment/comm.tpl"));
		else
			$data['files'] = htmlspecialchars(file_get_contents(SITE_DIR . "templates/site/tpl_module/comment/commview.tpl"));
		$data['types'] = $data['ns_doc']['types'];
		$data['ns_tree'] = $nstree;
		$data['id'] = $iddoc;
		$data['sch'] = $data['ns_doc']['sch'];
		$data['side'] = $this->_call_out_func("tree_model", "returnSideForFatherId", $nstree);
		return $this->view->view("templates/admin_modules/comment/editform.tpl", $data + $this->lang, true);
	}

	function _createView($nstree, $post, $oper="") {
		return $this->_createPoint($nstree, $post, "view");
	}

}

?>