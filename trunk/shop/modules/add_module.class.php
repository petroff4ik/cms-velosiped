<?

/**
 * @author PetrOFF <andi-fm@ya.ru>
 * 
 * @package Api
 * @category Core
 * Inherited the basic functions and additional modules
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
 * _add создает страничку для добавление странички в документ
 */
class add_module extends api {

	protected $view;
	protected $model;
	protected $db;
	protected $lang;

	function __construct($db, $view, $name, $lang_m) {
		require_once SITE_DIR . "modules/" . $name . "/" . $name . "_model" . ".class.php";

		if (file_exists(SITE_DIR . "lang/admin/modules/" . $name . "/ru.ini") && $lang_m['admin_true']) {
			$lang = parse_ini_file(SITE_DIR . "lang/admin/modules/" . $name . "/ru.ini", false) + parse_ini_file(SITE_DIR . "/lang/admin/ru_all.ini", false);
			$this->lang = $lang;
		} else {
			$this->lang = $lang_m;
		}
		$this->view = $view;
		$name = $name . "_model";
		$this->model = new $name($db);
		$this->db = $db;
		$this->_noLevel();
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

	protected function _create_ini($id, $post) {
		return $this->_create($id, $post, "init");
	}

	protected function get_ns_tree($ns_tree) {
		$data = array();
		if (is_numeric($ns_tree))
			$data = $this->model->GetInfoForLinkTreeById($ns_tree);
		else
			$data=$this->model->GetInfoForLinkTreeByName($ns_tree);

		return $data;
	}

	function _returnPagesForNstree($nstree) {
		return false;
	}

	function _getPagesAbs($ns_doc) {
		return false;
	}

	function _getPrototypePages($ns_doc) {
		return false;
	}

	function _insertPages($ns_doc) {
		$this->set_message($this->model->insertPages($ns_doc, $this->security("POST")));
		$this->relink(@$_POST['relink']);
	}

	function _noLevel() {
		if ($_SESSION['user']['level'] < $this->ns_tree['level_access'] || $_SESSION['user']['level'] < $this->moduleCurent['level_access']) {
			$this->view->view("templates/site/tpl_module/user_auth/nolevel.tpl", $this->lang);
			exit();
		}
	}

	function _returnLink() {
		return false;
	}

	function _returnNLink($id, $lang) {
		return false;
	}

	function _creatorMenu() {
		return false;
	}

	function __call($method, $params) {
		return $this->show_404($method, $params);
	}

	function _del($id="", $lang="") {
		return false;
	}
	
	function _create($id="", $post="", $oper="") {
		return false;
	}
	
	protected function _edit($id="", $lang="") {
		return false;
	}
	
	function _insert($lastid="") {
		return false;
	}
	
	function _update($id="") {
		return false;
	}
	
	function _add($ns_doc="") {
		return false;
	}
	
	protected function isAjax() {
		return (isset($_SERVER['HTTP_X_REQUESTED_WITH']) &&
		($_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest'));
	}

}

?>