<?

class user_auth extends add_module {

	private $class = "user_auth";
	private $func = "login";

	// securitu and session func----------------- devel version2
	protected function _use_session($arg="", $arr="") {
		$this->sessionStart();
		switch ($arg) {
			case("start"): {
					if (empty($_SESSION['type'])) {
						$_SESSION['count'] = 0;
						$_SESSION['type'] = "unknown";
					} else {
						if ($_SESSION['type'] == "unknown")
							$_SESSION['count']++;
					}
				}break;

			case("admin_mode"): {
					$tmp = $this->model->return_info_user($arr['type']);
					$_SESSION['user'] = $tmp[0];
					$_SESSION['count'] = 0;
					$_SESSION['type'] = "member";
				}break;

			case("access"): {

					if ($_SESSION['type'] == "member" && $_SESSION['user']['level'] >= LEVEL_ACCESS_ADMINPANEL) {
						return true;
					} else {
						return false;
					}
				}break;

			case("user_mode"): {
					$tmp = $this->model->return_info_user($arr['type']);
					$_SESSION['user'] = $tmp[0];
					$_SESSION['count'] = 0;
					$_SESSION['type'] = "user";
				}break;

			case("access_user"): {
					if ($_SESSION['type'] == "user") {
						return true;
					} else {
						return false;
					}
				}break;

			default: {
					$_SESSION['user'] = "";
					$_SESSION['user']['level'] = 0;
					return false;
				}break;
		}
	}

	protected function _login() {
		if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST['pass']) && !empty($_POST['login'])) {
			if ($_SESSION['count'] >= COUNT_ERR_LOGIN) {
				return (isset($this->lang['langs']['user_auth']["count_error"])) ? $this->lang['langs']['user_auth']["count_error"] : $this->lang["count_error"];
			} else {
				$login = $this->security($_POST['login']);
				$pass = $this->security($_POST['pass']);
				$tmp = $this->model->return_login_users();
				foreach ($tmp as $key => $value) {
					if ($value['name'] == $login) {
						if (md5($pass) == $this->model->return_pass($value['type'])) {
							if ($value['level'] > LEVEL_ACCESS_ADMINPANEL) {
								$this->_use_session("admin_mode", $value);
								$this->relink();
								exit();
							} else {
								$this->_use_session("user_mode", $value);
								$this->relinkF();
								exit();
							}
						} else {
							return (isset($this->lang['langs']['user_auth']["password_error"])) ? $this->lang['langs']['user_auth']["password_error"] : $this->lang["password_error"];
						}
					}
				}
				return (isset($this->lang['langs']['user_auth']["login_error"])) ? $this->lang['langs']['user_auth']["login_error"] : $this->lang["login_error"];
			};
		} else {
			if ($_SERVER["REQUEST_METHOD"] == "POST")
				return (isset($this->lang['langs']['user_auth']["lempty_fields"])) ? $this->lang['langs']['user_auth']["lempty_fields"] : $this->lang["lempty_fields"];
		};
	}

	// end securitu and session-----------------




	function _login_schedule($sys) {
		$side = $this->_call_out_func("tree_model", "returnSideForModules", $this->class, "_sc", $sys['template_out']);

		if ($this->_use_session("access_user")) {
			foreach ($side as $key => $value) {
				$data[$value['side']] = $this->_show_hello();
			}
			return $data;
		} else {
			foreach ($side as $key => $value) {
				$data[$value['side']] = $this->_show_form();
			}
			return $data;
		}
	}

	function logined() {
		$this->_use_session("start");
		$this->set_messageF(array($this->class => $this->_login()), "arr");
		$this->relinkF();
	}

	protected function _show_form() {
		$data['error'] = "";
		$data = $this->view->view("templates/site/tpl_module/user_auth/login_form.tpl", $data, true);
		return $data;
	}

	protected function _show_hello() {
		$data['level_access_l'] = $_SESSION['user']['level'];
		$data['login_type'] = $_SESSION['user']['type'];
		$data['login_name'] = $_SESSION['user']['name'];
		$data = $this->view->view("templates/site/tpl_module/user_auth/login_panel.tpl", $data, true);
		return $data;
	}

	protected function _show_hello_admin() {

		$data['level_access_l'] = $_SESSION['user']['level'];
		$data['login_type'] = $_SESSION['user']['type'];
		$data['login_name'] = $_SESSION['user']['name'];
		$data = $this->view->view("templates/admin/login/login_panel.tpl", $data, true);
		return $data;
	}

	function logout() {
		$this->sessionStart();
		unset($_SESSION['type']);
		unset($_SESSION['user']);
		setcookie(session_name(), "");
		header("location: /");
	}

	protected function default_user() {
		if (empty($_SESSION['user']['level']))
			$this->_use_session("default");
	}

	function _returnLink($id, $lang, $search="", $mod_order="") {
		if (empty($mod_order) || $mod_order == "none" && empty($search)) {
			$data = $this->model->getInfoDocMod($id);
			$data['text'] = $this->lang['lang_m_descr_menu_ua'];
			//$side=$this->model->getSideMod($id,"user_auth");
			$data['lang'] = "any";
			$data['sch_menu'] = true;
			$data['text_ext'] = '<img align="left" style="margin-right:5px;"  vspace="10" alt="' . $this->lang['lang_childrenn'] . '" src="/templates/images/link.png"  />';
			return $data;
		}
	}

	function _create($id, $post, $oper="") {
		$this->set_message($this->model->insertDoc($id, "user_auth"));
		$this->relink();
	}

	protected function _check_SID() {
		if (isset($_POST["PHPSESSID"])) {
			session_id($_POST["PHPSESSID"]);
		}
		
	}

}

?>