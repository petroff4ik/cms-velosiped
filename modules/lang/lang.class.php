<?

class lang extends add_module {

	private $class = "lang";
	private $func = "choose";
	private $all_lang;

	function get_message_module() {
		$lang_m = array();
		$lang = $this->model->get_message_module();

		foreach ($lang as $key => $value) {
			$lang_m['langs'][$value['module']][$value['name_message']] = $value['text'];
		}
		return $lang_m;
	}

	function _choose_schedule($sys, $shd, $url, $id_sch) {
		$data = array();
		$side = $this->_call_out_func("tree_model", "returnSideForModules", $this->class, "_sc", $sys['template_out']);
		foreach ($side as $key => $value) {
			$data[$value['side']] = $this->show_table_lang($sys['namet']);
		}
		return $data;
	}

	function show_table_lang($template="") {
		if (!empty($this->all_lang['lang']) && count($this->all_lang['lang']) >= 2) {
			if (empty($template))
				$path = "/tpl_module/lang/";
			else
				$path = "/tpl_site/" . $template . "/";
			$data = $this->view->view("templates/site" . $path . "lang_form.tpl", $this->all_lang, true);
			return $data;
		}else {
			return $data = "";
		}
	}

	function choose($sys="", $lang="") {
		$lang = $this->security($lang, 2, 2);
		if (empty($lang)) {
			$this->default_lang();
		} else {
			if ($this->check_lang($lang)) {
				$old_lang = $GLOBALS['lang'];
				$tmp = parse_url($_SERVER['HTTP_REFERER']);
				if ($tmp['path'] == "/")
					header("location:" . $_SERVER['HTTP_REFERER'] . $lang . "/");
				else
					header("location:" . str_replace("/" . $old_lang . "/", "/" . $lang . "/", $_SERVER['HTTP_REFERER']));
			} else {
				header("location:" . SITE_URL);
			}
			die();
		}
	}

	protected function default_lang() {
		if (empty($GLOBALS['lang'])) {

			$lang = $this->model->get_info("name", "lang", "default_lang", "true");
			$GLOBALS['lang'] = $lang;
		}
	}

	protected function default_lang_direct() {

		$lang = $this->model->get_info("name", "lang", "default_lang", "true");
		$GLOBALS['lang'] = $lang;
	}

	protected function set_lang($lang="") {
		$this->all_lang['lang'] = $this->model->return_count_lang();
		if ($lang) {
			if ($lang = $this->security($lang, 2, 2)) {
				if ($this->check_lang($lang))
					$GLOBALS['lang'] = $lang;
				return;
			}
			$this->show_404();
		}else {
			$this->default_lang();
		}
	}

	protected function check_lang($lang) {
		foreach ($this->all_lang['lang'] as $key => $value)
			if ($value['name'] == $lang)
				return true;
		return false;
	}

	protected function show_all_lang() {
		$lang = $this->model->get_info("name", "lang", "default_lang", "true");
		$tmp = $this->model->return_count_lang();
		if (!empty($tmp)) {
			foreach ($tmp as $key => $value) {
				$value['l_ch_def_td'] = "&bull;";
				if ($lang != $value['name'])
					$value['l_ch_def_td'] = $this->view->view("templates/admin/lang/lang_body_tr_def.tpl", $value, true);
				$ret.=$this->view->view("templates/admin/lang/lang_body_tr.tpl", $value, true);
			}
			return $ret;
		}else {
			return false;
		}
	}

	protected function get_lang() {
		return $this->model->return_count_lang();
	}

	protected function chose_def($id) {
		$this->model->save_def_lang($id);
	}

	protected function save_lang_info($id) {
		$this->security("POST");
		$this->model->save_lang_info($id, $_POST['id'], $_POST['name'], $_POST['alias']);
	}

	protected function add_lang() {
		$this->security("POST");
		$this->model->add_lang($_POST['name'], $_POST['alias']);
	}

	protected function del_lang($id) {
		$this->model->del_lang($id);
	}

	protected function _options() {
		$data['body_lang'] = $this->show_all_lang();
		if (empty($data['body_lang']))
			$data['lang_all'] = "Empty lang";
		$ret['view'] = $this->view->view("templates/admin/lang/lang.tpl", $data, true) . "<br/><a href='" . ADMIN_DIR_FULL . "safe_launch/lang/translate/'>" . $this->lang['l_translate_base_add'] . "</a>";
		return $ret;
	}

	protected function return_all_lang_array() {
		return $this->model->return_all_lang_array();
	}

	protected function return_last_Ilang() {
		return $this->model->return_last_Ilang();
	}

	function _returnLink($id, $lang, $search="", $mod_order="") {
		if (empty($mod_order) || $mod_order == "none" && empty($search)) {
			$data = $this->model->getInfoDocMod($id);
			$data['text'] = $this->lang['lang_m_descr_menu_lang'];
			$side = $this->model->getSideMod($id, "lang");
			$data['side_for_doc'] = "";
			foreach ($side as $key => $value) {
				$data['side_for_doc'].=$value['side'];
			}
			$data['side_only_read'] = true;
			$data['lang'] = "any";
			$data['sch_menu'] = true;
			$data['text_ext'] = '<img align="left" style="margin-right:5px;"  vspace="10" alt="' . $this->lang['lang_childrenn'] . '" src="/templates/images/link.png"  />';
			return $data;
		}
	}

	function _create($id, $post, $oper="") {
		$this->set_message($this->model->insertDoc($id, "lang"));
		$this->relink();
	}

	function _curlToGoogle($data, $fromLanguage, $toLanguage) {
		try {
			$curl = curl_init();
			if (!$curl)
				throw new Exception($this->lang['l_error_curl_initialise']);
			curl_setopt($curl, CURLOPT_URL, "http://translate.google.com/translate_a/t?client=te&text=" . urlencode($data) . "&hl=ru&sl={$fromLanguage}&tl={$toLanguage}&multires=1&otf=1&ssel=0&tsel=0&&sc=1");
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
			if (isset($_SERVER['HTTP_REFERER'])) {
				curl_setopt($curl, CURLOPT_REFERER, $_SERVER['HTTP_REFERER']);
			}
			curl_setopt($curl, CURLOPT_USERAGENT, "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.71 Safari/534.24");
			$response = curl_exec($curl);
			// Check if any error occured
			if (curl_errno($curl)) {
				$this->_errors .= "Curl Error: " . curl_error($curl);
				return false;
			}
			curl_close($curl);
			return $response;
		} catch (Exception $e) {
			$this->error($e);
		}
	}

	function _translate($langV="") {

		set_time_limit(380);
		$lang = $this->model->return_all_lang_array();
		$all_field = $this->model->get_all_field();
		$prev = 1;
		$lang_t = $lang;
		foreach ($all_field as $keyF => $valueF) {

			if ($prev != $valueF['id']) {//new field
				//check lang
				if (count($lang_t) > 0) {
					if (empty($history))
						$history = $back;
					foreach ($lang_t as $keyT => $valueT) {
						$trans = "";
						if (!empty($history['text'])) {
							$trans1 = json_decode($this->_curlToGoogle($history['text'], $history['lang'], $valueT['name']), true);
							foreach ($trans1['sentences'] as $keyG => $valueG)
								$trans.= $valueG['trans'];
						}
						$this->model->insert_spec($trans, $valueT['name'], $history['id']);
					}
				}
				$lang_t = $lang;
				$history = "";
			}

			foreach ($lang_t as $keyL => $valueL) {
				if ($valueL['name'] == $valueF['lang'])
					unset($lang_t[$keyL]);
			}

			$prev = $valueF['id'];
			$back = $valueF;
			if (empty($langV))
				$history = $valueF;
			elseif ($langV == $valueF['lang'])
				$history = $valueF;
		}
		
		$this->set_message("true");
		$this->relink();
	}

}

?>