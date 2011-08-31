<?

class gallery extends add_module {

	/**
	 * @author PetrOFF <andi-fm@ya.ru>
	 * 
	 * @package Api
	 * @category module
	 * 
	 * _returnLink Внешняя функция возврашаюшая связаные документы модуля {
	 * $text_ext дополнительный текст описания
	 * $side_only_read блокирует для редактирования стороны модуля
	 * $sch_menu  если true  возврашает меню в $sch_menu_ и дополнительно в $sch_add_menu
	 * $s_edit при услови true открывает ссылку на редактирование странички
	 * $s_del при услови true открывает ссылку на удаление странички
	 * $s_create при услови true вызывает аналогичную функцию на страничке создания ветки
	 * $s_events при услови true показывае модули которые подерживают вызов по событию на страничке создания ветки
	 * $s_add при услови true открывает ссылку на добавление странички
	 * }
	 * _returnNLink Внешняя функция возврашаюшая не связанные документы модуля
	 * _retModOrder Сортировка внешняя, создаваемая в модуле фщрмат ключ=значение
	 * _getPagesAbs если нет страницы а запись в документе есть возврашает меню  с пунктами вставки страницыб сама функция возврашает (ns_doc->mod_table->id_lang_text where text is null)
	 * _retModOptions возврашает меню модюля при условии mod_options true
	 * _creatorMenu возврашает лист в подвале для создании ссылки на функцию создания страничк, например кодга в для одного модуля есть несколько функций creator 
	 * _getPrototypePages возврашает прототип страницы при условии возврата true _getPagesAbs (отсутсвие страницы но есть сам документ)(формат ишем в модулях)
	 * _insertPages поумолчанию всавляет в id_lang_text запись (страничку в документ)
	 * _create_ini при создании страницы вызывается, функция оберткоа для функции _creator
	 * _options в меню модули возврашает меню для модуля
	 * _noLevel по умолчанию отображается когда не хватает полномочий пользователя
	 * _returnPagesForNstree возврашает странички например при создании ссылок в редакторе на страничку в документы. Пример новости, документ один, страничек много
	 * _returnPath возврашает путь к модулю, например в редакторе при построение ссылки
	 * get_ns_tree устаревшая функция оставленая для совместимости
	 * __call поумолчанию возврашает ошибку при отсутсвии метода в модули
	 * _create возврашает страничку с созданием странички модуля
	 * _edit возврашае страничку для редактирования
	 * _insert соотвествено вставляет страничку в документ
	 * _update соотвествено обновляет страничку в документе
	 */
	protected $class = "gallery";
	protected $func = "img";

	function _create_ini($id, $post) {
		$this->set_message("true");
		$this->relink(ADMIN_DIR_FULL);
	}

	function _retModOrder() {
		return false;
	}

	function _retModOptions() {
		return false;
	}

	function _returnPath($module, $func, $link) {
		return $link;
	}

	protected function _options($id_module=0, $id_templates=0) {
		$ret['sys']['clean_cache'] = false;
		$ret['view'] = $this->lang['l_mod_options_empty'];
		return $ret;
	}

	function _returnLink($id, $lang, $search="", $mod_order="") {
		if (empty($mod_order) || $mod_order == "none") {
			$ret = $this->model->get_img($id, $lang, $search);
		}
		if ($ret['types']) {
			$ret['s_edit'] = false;
			$ret['mod_options'] = '<a href="' . ADMIN_DIR_FULL . 'safe_launch/gallery/editall/' . $id . '/' . $lang . '">' . $this->lang['l_editall'] . '</a><br/>';
			$ret['text_ext'] = '<img style="padding:10px;width:100px;height:100px;" align="center" src="/templates/images/blank_all.jpg"/>';
			return $ret;
		}
		if (!empty($ret['path']) && !empty($ret['file_name']))
			$ret['text_ext'] = '<img style="padding:10px;width:100px;height:100px;" align="center" src="' . ADMIN_DIR_FULL . "unsafe_launch/gallery/open?path=thumb&cat=" . $ret['father_id'] . "&file_name=" . $ret['file_name'] . '"/>';
		else
			$ret['text_ext'] = '<img style="padding:10px;width:100px;height:100px;" align="center" src="/templates/images/blank.jpg"/>';
		return $ret;
	}

	function _returnNLink($id, $lang) {
		return $this->model->get_img($id, $lang);
	}

	function _del($id="", $lang="") {
		$img = $this->model->get_img_for_ns_doc($id, $GLOBALS['lang']);
		$res = $this->model->del($id, $lang);
		@unlink(SITE_DIR . $img['path'] . $img['file_name']);
		@unlink(SITE_DIR . $img['path'] . "thumb/" . $img['file_name']);
		@unlink(SITE_DIR . $img['path'] . "thumb/large_" . $img['file_name']);
		$this->set_message($res);
		$this->relink(@$_SERVER['HTTP_REFERER']);
	}

	function _create($id="", $post="", $oper="") {
		$data['init'] = $oper;
		if (empty($post['lang_cur'])) {
			$data['lang_arr'] = $this->_call_out_func("lang", "return_all_lang_array", array());
		} else {
			$data['lang_arr'] = $this->_call_out_func("lang_model", "get_info_lang_by_id", $post['lang_cur']);
		}
		$data['id'] = $id;
		$data['warning'] = $this->model->check_gallery_all($id);
		return $this->view->view("templates/admin_modules/gallery/create.tpl", $data + $this->lang, true);
	}

	protected function _edit($ns_doc="", $lang="") {
		$data['img'] = $this->model->get_img_for_ns_doc($ns_doc, $lang);
		$data['id'] = $data['img']['father_id'];
		$data['warning'] = $this->model->check_gallery_all($data['img']['father_id']);
		return $this->view->view("templates/admin_modules/gallery/edit.tpl", $data + $this->lang, true);
	}

	function _insert($ns_treeid) {
		$this->security("post", 200);
		$this->set_message($this->model->insert($this->class, $ns_treeid, $_POST));
		$this->relink($_POST['relink']);
	}

	function _update($id="") {
		$this->security("post", "", 200);
		$this->set_message($this->model->update($id, $_POST));
		$this->relink(@$_POST['relink']);
	}

	function _upload() {
		$path = SITE_DIR . "templates/admin_modules/gallery/upload/";
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
				$path_tofile = "templates/admin_modules/gallery/upload/" . $_POST['id'] . "/";
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


	function img($sys, $pag=1) {
		$data['sys'] = $sys;

		$act['pag'] = $pag;
		$pag_tmp = $pag;
		$pag = ($pag * 10) - 10;
		$all = $this->model->check_gallery_all($sys['ns_tree']['id']);
		if (empty($all)) {
			$img['img']['img'] = $this->model->get_all_for_tree($sys['ns_tree']['id'], $pag);
			$total = $this->model->GetFoundRows();
		} else {
			$path = "templates/admin_modules/gallery/upload/" . $sys['ns_tree']['id'] . "/";
			if (is_dir(SITE_DIR . $path)) {
				$tmp = array();
				$dh = opendir(SITE_DIR . $path);
				$img['img']['img'] = array();
				while ($file = readdir($dh)) :
					if (is_file(SITE_DIR.$path . $file) )
						$tmp[] = array("path"=>$path,"file_name"=>$file,"father_id"=>$sys['ns_tree']['id'],"show_description"=>$all['show_description'],"description"=>$all['description'],"types"=>"all","text"=>$all['text']);
				endwhile;
				closedir($dh);	
				$img['img']['img'] = array_slice($tmp, $pag,10);
				$total = count($tmp);
			}
		}
		$page = ceil(($total) / 10);
		$act['link']['link'] = "";
		for ($i = 1; $i <= $page; $i++) {
			if (is_int($i / 30))
				$act['link']['link'].="<br />";
			if ($i == $pag_tmp) {
				$act['link']['link'].=$i . "&nbsp;|&nbsp;";
			} else {
				$act['link']['link'].="<span class='pag_link' style='cursor:pointer;' link='" . SITE_URL . $GLOBALS['lang'] . "/" . $sys['ns_tree']['name'] . "/" . $this->func . "/" . $i . "'>" . $i . "</span>&nbsp;|&nbsp;";
			}
		}
		if ($this->isAjax()) {
			$json = $this->view->view("templates/site/tpl_module/gallery/list.tpl", $img['img'] + $act['link'], true);
			die(json_encode(array("body" => $json)));
		} else {
			$side = $this->_call_out_func("tree_model", "returnSideForEvent", $this->class, $sys['ns_tree']['template_out']);
			foreach ($side as $key => $value) {
				$data[$value['side']] = $this->view->view("templates/site/tpl_module/gallery/gallery.tpl", $img + $act + $data, true);
			}
			return $data;
		}
	}

	function open() {
		$path = "templates/admin_modules/gallery/upload/";
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

	function _creatorMenu($arr) {
		return array(0 => array("class" => $arr['class'] . "|" . "_createAll", "name_module" => $arr['name_module'] . $this->lang['lang_gallery_all']));
	}

	function _createAll($id="", $post="", $oper="") {
		$data['init'] = $oper;
		$data['id'] = $id;
		$data['imgs'] = $this->_prev($id);
		if (empty($post['lang_cur'])) {
			$data['lang_arr'] = $this->_call_out_func("lang", "return_all_lang_array", array());
		} else {
			$data['lang_arr'] = $this->_call_out_func("lang_model", "get_info_lang_by_id", $post['lang_cur']);
		}
		return $this->view->view("templates/admin_modules/gallery/gallery.tpl", $data + $this->lang, true);
	}

	protected function _editall($ns_doc, $lang="") {
		$data['img'] = $this->model->get_img_for_ns_doc($ns_doc, $lang);
		$data['init'] = $oper;
		$data['id'] = $data['img']['father_id'];
		$data['imgs'] = $this->_prev($data['img']['father_id']);
		return $this->view->view("templates/admin_modules/gallery/galleryedit.tpl", $data + $this->lang, true);
	}

	function _prev($id="") {
		if (!empty($id))
			$data['id'] = $id;
		if (isset($_POST['id']))
			$data['id'] = $_POST['id'];
		$path = SITE_DIR . "templates/admin_modules/gallery/upload/" . $data['id'] . "/thumb/";
		if (is_dir($path)) {
			$dh = opendir($path);
			$data['arrfile'] = array();
			while ($file = readdir($dh)) :
				if (is_file($path . $file) && strpos($file, "large_") === false)
					$data['arrfile'][] = $file;
			endwhile;
			closedir($dh);

			if ($this->isAjax())
				die(json_encode(array("msg" => $this->view->view("templates/admin_modules/gallery/list.tpl", $data, true))));
			else
				return $this->view->view("templates/admin_modules/gallery/list.tpl", $data, true);
		}
	}

}

?>