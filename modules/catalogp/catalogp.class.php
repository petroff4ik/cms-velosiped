<?php

class catalogp extends add_module {

	protected $class = "catalogp";
	protected $func = "show";

	function branch($sys, $ns_tree, $id_doc) {
		$data['sys']['ns_tree'] = $this->get_ns_tree($ns_tree);
		$data['sys']['idint'] = (int) $id_doc;
		$page['br'] = $this->model->getBranchAndEl($id_doc);
		$page['el'] = $this->model->getElementsForBranch($id_doc);
		$side = $this->model->getSideModule();
		if (empty($page['br']))
			$this->show_404();
		$data[$side['side']] = $this->view->view("templates/site/tpl_module/catalogp/catalogp_branch.tpl", $page, true);
		$tags = $this->_call_out_func("tags_model", "getAllSideTagsG", $side['id_template']);
		foreach ($tags as $key => $value) {
			$data[$value['side']] = strip_tags($page['br']['text']);
		}
		return $data;
	}

	function element($sys, $ns_tree, $id_doc) {
		$data['sys']['ns_tree'] = $this->get_ns_tree($ns_tree);
		$data['sys']['idint'] = (int) $id_doc;
		$page['el'] = $this->model->getElement($id_doc);
		$side = $this->model->getSideModule();
		if (empty($page['el']))
			$this->show_404();
		$data[$side['side']] = $this->view->view("templates/site/tpl_module/catalogp/catalogp_element.tpl", $page, true);
		$tags = $this->_call_out_func("tags_model", "getAllSideTagsG", $side['id_template']);
		foreach ($tags as $key => $value) {
			$data[$value['side']] = strip_tags($page['el']['text']);
		}
		return $data;
	}

	function show($sys) {
		//$date['template']['path_file']="modules/news/template/news.tpl";
		$data['sys'] = $sys;
		$pages = $sys['ns_tree'];
		//menu end
		$side = $this->_call_out_func("tree_model", "returnSideForEvent", $this->class, $pages['template_out']);
		$data['branch'] = $this->model->get_all_branch_site($pages['id']);
		$data['element'] = $this->model->get_all_element_site($pages['id']);
		if (empty($data['branch']) && empty($data['element']))
			$this->show_404();
		foreach ($side as $key => $value) {
			$data[$value['side']] = $this->view->view("templates/site/tpl_module/catalogp/catalogp.tpl", $data, true);
		}
		return $data;
	}

	protected function _edit($id, $lang) {
		$data['doc'] = $this->model->get_catalog_all($id, $lang);
		$data['id'] = $data['doc'][0]['father_id'];
		if ($data['doc'][0]['type'] == "el") {
			$data['branch'] = $this->model->get_all_branch($lang);
			$data['cur_branch'] = $this->model->get_cur_branch($data['doc'][0]['pid'], $lang);
			return $this->view->view("templates/admin_modules/catalogp/edit_el.tpl", $data + $this->lang, true);
		} else {
			$data['branch'] = $this->model->get_all_branch($lang);
			return $this->view->view("templates/admin_modules/catalogp/edit_br.tpl", $data + $this->lang, true);
		}
	}

	function _create($id, $post, $oper="") {
		$data['init'] = $oper;
		if (empty($post['lang_cur'])) {
			$data['lang_arr'] = $this->_call_out_func("lang", "return_all_lang_array", array());
		} else {
			$data['lang_arr'] = $this->_call_out_func("lang_model", "get_info_lang_by_id", $post['lang_cur']);
		}
		$data['branch'] = $this->model->get_all_branch();
		$data['id'] = $id;
		return $this->view->view("templates/admin_modules/catalogp/create.tpl", $data + $this->lang, true);
	}

	function _insert_br($ns_treeid) {
		$this->set_message($this->model->insert_br($this->class, $ns_treeid, $_POST) . $mess);
		$this->relink($_POST['relink']);
	}

	function _insert_el($ns_treeid) {
		$this->set_message($this->model->insert_el($this->class, $ns_treeid, $_POST));
		$this->relink($_POST['relink']);
	}

	function _update_br($id) {
		$this->set_message($this->model->update_br($id, $_POST));
		$this->relink(@$_POST['relink']);
	}

	function _update_el($id) {
		$this->set_message($this->model->update_el($id, $_POST));
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
		$data = $this->model->get_cat($id, $lang);
		if (!empty($data)) {
			if ($data['type'] == "el")
				$data['text'] = $this->lang['l_typee'] . " " . $data['text'];
			else
				$data['text'] = $this->lang['l_typeb'] . " " . $data['text'];
			return $data;
		}else {
			return false;
		}
	}

	function _returnLink($id, $lang, $search="", $mod_order="") {
		$data = $this->model->get_cat($id, $lang, $search, $mod_order);
		if (!empty($data)) {
			if ($data['type'] == "el")
				$data['text'] = " (" . $data['brn'] . ")" . $this->lang['l_typee'] . " " . $data['text'];
			else
				$data['text'] = $this->lang['l_pos'] . $data['pos'] . " " . $this->lang['l_typeb'] . " " . $data['text'];
			return $data;
		}else {
			return false;
		}
	}

	function _retModOrder($id, $lang) {
		$data['-doc-cpb'] = $this->lang['l_cpb'];
		$data['-doc-cpe'] = $this->lang['l_cpe'];
		$tmp = $this->model->get_all_branch($lang);
		foreach ($tmp as $key => $value)
			$data["-cp-" . $value['idcp']] = $value['text'];
		return $data;
	}

	function _getPagesAbs($ns_doc) {
		return $this->model->getPagesAbs($ns_doc);
	}

	function _getPrototypePages($ns_doc="", $class="") {
		$il = $this->model->getIdLang($ns_doc);
		if ($il['type'] == "el")
			return array('nsdoc' => $ns_doc, 'class' => $class, 'title' => $this->lang['l_add_pages'], 'descr' => array(0 => array('title' => $this->lang['name_el'], 'col' => 20, 'editor' => false, 'name' => 'name_alias', 'idlang' => $il['name_alias']), 1 => array('title' => $this->lang['desc_el'], 'col' => 80, 'editor' => true, 'name' => 'descr_alias', 'idlang' => $il['descr_alias']), 2 => array('title' => $this->lang['price_el'], 'col' => 5, 'editor' => false, 'name' => 'price_alias', 'idlang' => $il['price_alias'])));
		else
			return array('nsdoc' => $ns_doc, 'class' => $class, 'title' => $this->lang['l_add_pages'], 'descr' => array(0 => array('title' => $this->lang['name_el'], 'col' => 20, 'editor' => false, 'name' => 'name_alias', 'idlang' => $il['name_alias']), 1 => array('title' => $this->lang['desc_el'], 'col' => 80, 'editor' => true, 'name' => 'descr_alias', 'idlang' => $il['descr_alias'])));
	}

	function _upload() {
		$path = SITE_DIR . "templates/admin_modules/catalogp/upload/";
		$path_tofile = "";
		$error = "";
		$msg = "";
		$fileElementName = 'fileToUpload';
		$ext = @end(@explode(".", @$_FILES[$fileElementName]['name']));
		if (!empty($_FILES[$fileElementName]['error'])) {
			switch ($_FILES[$fileElementName]['error']) {

				case '1':
					$error = 'The uploaded file exceeds the upload_max_filesize directive in php.ini';
					break;
				case '2':
					$error = 'The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form';
					break;
				case '3':
					$error = 'The uploaded file was only partially uploaded';
					break;
				case '4':
					$error = 'No file was uploaded.';
					break;

				case '6':
					$error = 'Missing a temporary folder';
					break;
				case '7':
					$error = 'Failed to write file to disk';
					break;
				case '8':
					$error = 'File upload stopped by extension';
					break;
				case '999':
				default:
					$error = 'No error code avaiable';
			}
		} elseif (empty($_FILES[$fileElementName]['tmp_name']) || $_FILES[$fileElementName]['tmp_name'] == 'none') {
			$error = 'No file was uploaded..';
		} elseif (empty($ext) || ($ext != "png" && $ext != "jpg" && $ext != "gif" && $ext != "jpeg")) {
			$error = "Not image type -> " . $ext;
		} else {
			if (!is_dir($path . $_POST['id'])) {
				mkdir($path . $_POST['id']);
				mkdir($path . $_POST['id'] . "/thumb/");
			}
			$msg .= " File Name: " . $_FILES[$fileElementName]['name'] . ", ";
			$msg .= " File Size: " . @filesize($_FILES[$fileElementName]['tmp_name']);
			if (move_uploaded_file($_FILES[$fileElementName]['tmp_name'], $path . $_POST['id'] . "/" . basename($_FILES[$fileElementName]['name']))) {
				$path_tofile = "templates/admin_modules/catalogp/upload/" . $_POST['id'] . "/";
				chmod($path . $_POST['id'] . "/" . basename($_FILES[$fileElementName]['name']), 0777);
				$org = $path . $_POST['id'] . "/" . basename($_FILES[$fileElementName]['name']);
				$width = isset($_POST['width']) ? $_POST['width'] : 100;
				$height = isset($_POST['height']) ? $_POST['height'] : 100;
				$width_l = isset($_POST['width_l']) ? $_POST['width_l'] : 500;
				$height_l = isset($_POST['height_l']) ? $_POST['height_l'] : 500;
				$this->_img_resize($org, $path . $_POST['id'] . "/thumb/" . basename($_FILES[$fileElementName]['name']), $width, $height);
				$this->_img_resize($org, $path . $_POST['id'] . "/thumb/" . basename("large_" . $_FILES[$fileElementName]['name']), $width_l, $height_l);
			} else {
				$error = 'File move error';
			}
			//for security reason, we force to remove all uploaded file
			@unlink($_FILES[$fileElementName]);
		}

		echo json_encode(array("error" => $error, "name" => $_FILES[$fileElementName]['name'], "msg" => $msg, "path" => $path_tofile, "cat" => $_POST['id']));
		exit();
	}

	/*	 * *********************************************************************************
	  Функция img_resize(): генерация thumbnails
	  Параметры:
	  $src             - имя исходного файла
	  $dest            - имя генерируемого файла
	  $width, $height  - ширина и высота генерируемого изображения, в пикселях
	  Необязательные параметры:
	  $rgb             - цвет фона, по умолчанию - белый
	  $quality         - качество генерируемого JPEG, по умолчанию - максимальное (100)
	 * ********************************************************************************* */

	function _img_resize($src, $dest, $width, $height, $rgb=0xFFFFFF, $quality=100) {
		if (!file_exists($src))
			return false;

		$size = getimagesize($src);

		if ($size === false)
			return false;

		// Определяем исходный формат по MIME-информации, предоставленной
		// функцией getimagesize, и выбираем соответствующую формату
		// imagecreatefrom-функцию.
		$format = strtolower(substr($size['mime'], strpos($size['mime'], '/') + 1));
		$icfunc = "imagecreatefrom" . $format;
		if (!function_exists($icfunc))
			return false;

		$x_ratio = $width / $size[0];
		$y_ratio = $height / $size[1];

		$ratio = min($x_ratio, $y_ratio);
		$use_x_ratio = ($x_ratio == $ratio);

		$new_width = $use_x_ratio ? $width : floor($size[0] * $ratio);
		$new_height = !$use_x_ratio ? $height : floor($size[1] * $ratio);
		$new_left = $use_x_ratio ? 0 : floor(($width - $new_width) / 2);
		$new_top = !$use_x_ratio ? 0 : floor(($height - $new_height) / 2);

		$isrc = $icfunc($src);
		$idest = imagecreatetruecolor($width, $height);

		imagefill($idest, 0, 0, $rgb);
		imagecopyresampled($idest, $isrc, $new_left, $new_top, 0, 0, $new_width, $new_height, $size[0], $size[1]);

		imagejpeg($idest, $dest, $quality);

		imagedestroy($isrc);
		imagedestroy($idest);

		return true;
	}

	function _del_img() {
		if (empty($_POST['file_name']) || empty($_POST['path']))
			$msg = "Nothing del";
		if (is_dir(SITE_DIR . $_POST['path']) && file_exists(SITE_DIR . $_POST['path'] . $_POST['file_name'])) {
			$msg = "ok";
			unlink(SITE_DIR . $_POST['path'] . $_POST['file_name']);
			unlink(SITE_DIR . $_POST['path'] . "/thumb/" . $_POST['file_name']);
			unlink(SITE_DIR . $_POST['path'] . "/thumb/large_" . $_POST['file_name']);
		} else {
			$msg = "Bad path!";
		}
		die(json_encode(array("msg" => $msg)));
	}

	///fronend part


	function open() {
		$path = "templates/admin_modules/catalogp/upload/";
		$file_name = $_GET['file_name'];
		$cat = $_GET['cat'];
		switch ($_GET['path']) {
			case("large"): {
					$path = $path . $cat . "/thumb/large_" . $file_name;
				}break;

			case("thumb"): {
					$path = $path . $cat . "/thumb/" . $file_name;
				}break;

			case("orgin"): {
					$path = $path . $cat . "/" . $file_name;
				}break;

			default: {
					$path = "templates/images/blank.jpg";
				}break;
		}
		if (empty($file_name))
			$path = "templates/images/blank.jpg";
		header("Content-type: image/gif");
		readfile(SITE_DIR . $path);
	}

	function _prev($id="") {
		if (!empty($id))
			$data['id'] = $id;
		if (isset($_POST['id']))
			$data['id'] = $_POST['id'];
		$path = SITE_DIR . "templates/admin_modules/catalogp/upload/" . $data['id'] . "/thumb/";
		if (is_dir($path)) {
			$dh = opendir($path);
			$data['arrfile'] = array();
			while ($file = readdir($dh)) :
				if (is_file($path . $file) && strpos($file, "large_") === false)
					$data['arrfile'][] = $file;
			endwhile;
			closedir($dh);

			if ($this->isAjax())
				die(json_encode(array("msg" => $this->view->view("templates/admin_modules/catalogp/list.tpl", $data, true))));
			else
				return $this->view->view("templates/admin_modules/catalogp/list.tpl", $data, true);
		}
	}

	// private

	function _importCsv($file, $fromLanguage = "en", $toLanguage = "ru") {
		/*

		  array
		  0 => string '1' (length=1)
		  1 => string 'САЛАТИ' (length=12)
		  2 => string 'menu item' (length=9)
		  3 => string '0' (length=1)
		  4 => string 'грам/гривна' (length=21)
		  5 => string '' (length=0)
		  6 => string 'ua' (length=2)
		 */

		set_time_limit(380);
		$f = fopen(SITE_DIR . '/templates/upload/menuonly.csv', 'r');
		$data = fgetcsv($f, 1000, ',');
		$prev_id = 0;
		$menu_item = 0;
		$name_serves = 0;
		$base_id['parent_id'] = 0;
		$base_id['lang_id'] = 0;
		$base_id['pos'] = 0;
		$lang_array = $this->_call_out_func("lang", "return_all_lang_array");
		while (!feof($f)) {
			$data = fgetcsv($f, 1000, ',');
			list($curid, $name, $type, $parent_id, $add, $descr, $lang) = $data;
			if($lang == "ua") $history = $data;
			if ($curid != $prev_id) {
				$base_id = $this->model->insert_spec($type, $name, $descr, $lang, $base_id['parent_id'], $base_id['pos'], $add);
			} else {
				$this->model->insert_spec2($name, $descr,$add, $lang, $base_id);
			}
			$prev_id = $curid;
		}

		die("Finish");
	}


}

?>