<?

class gallery_model extends add_model_module {

	/**
	 * @param $id_ns_tree 
	 * @return true/false
	 */
	function insert($class, $ns_treeid, $post) {
		$res = $this->db->query("START TRANSACTION;");

		$this->db->query("INSERT INTO ns_doc SET date=NOW(),father_id='" . $ns_treeid . "',show_me=1,module='" . $class . "',types='" . @$post['types'] . "', side_for_doc='module';");
		$ns_doc = mysql_insert_id();
		$lastid = $this->returnLastId("+");
		foreach ($post['description'] as $key => $value) {
			$this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($value))) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
		}
		$res = $this->db->query("INSERT INTO gallery SET description='" . $lastid . "',path='" . $post['path'] . "',file_name='" . $post['file_name'] . "', id_doc = '" . $ns_doc . "',show_description='" . $this->security($sd, "+") . "';");
		$this->db->query("COMMIT;");
		return $res;
	}

	function get_img($id, $lang, $search = "") {
		if (!empty($search))
			$search = " AND id_lang_text.text LIKE '%" . $search . "%'";
		return $this->db->row_array($this->db->query("SELECT *,ns_doc.id FROM ns_doc,gallery,id_lang_text,modules WHERE modules.class=ns_doc.module AND gallery.id_doc='" . $id . "' AND ns_doc.id=gallery.id_doc AND gallery.description=id_lang_text.id AND id_lang_text.lang='" . $lang . "' " . $search . " ;"));
	}

	function get_img_for_ns_doc($id, $lang) {
		return $this->db->row_array($this->db->query("SELECT *,ns_doc.id,id_lang_text.id as id_lang_text FROM ns_doc,gallery,id_lang_text,modules WHERE modules.class=ns_doc.module AND gallery.id_doc='" . $this->security($id) . "' AND ns_doc.id=gallery.id_doc AND gallery.description=id_lang_text.id AND id_lang_text.lang='" . $lang . "' order by id_lang_text.id;"));
	}

	function update($id, $post) {
		$res2 = "";
		$res = $this->db->query("START TRANSACTION;");
		$res2.=$this->db->query("UPDATE ns_doc SET date=NOW() WHERE ns_doc.id='" . $id . "'");
		$res2.= $this->db->query("UPDATE id_lang_text SET text='" . mysql_real_escape_string(trim($post['description'])) . "', date=NOW() WHERE id='" . $post['id_lang_text'] . "' AND lang='" . $post['lang'] . "'");
		$sd = isset($post['show_description']) ? 1 : "";
		$res2.= $this->db->query("UPDATE gallery SET path='" . $this->security($post['path'], "+") . "',file_name='" . $this->security($post['file_name'], "+") . "',show_description='" . $this->security($sd, "+") . "'  WHERE id_doc='" . $id . "'");
		$this->db->query("COMMIT;");
		return $res2;
	}

	function del($id) {
		return $this->db->query("DELETE id_lang_text,gallery,ns_doc FROM id_lang_text,gallery,ns_doc WHERE gallery.description=id_lang_text.id  AND ns_doc.id=" . $id . "  AND ns_doc.id=gallery.id_doc;");
	}

	function get_all_for_tree($ns_tree, $pag) {
		return $this->db->result_array($this->db->query("SELECT SQL_CALC_FOUND_ROWS id_lang_text.*,ns_doc.*,gallery.* FROM ns_doc,gallery,id_lang_text WHERE ns_doc.id = gallery.id_doc AND gallery.description = id_lang_text.id AND id_lang_text.lang='" . $GLOBALS['lang'] . "' AND ns_doc.father_id = '" . $this->security($ns_tree) . "' AND ns_doc.show_me=1 LIMIT " . $this->security($pag) . ",10;"));
	}
	
	function check_gallery_all($ns_tree){
		return $this->db->row_array($this->db->query("SELECT * FROM ns_doc,gallery,id_lang_text WHERE father_id = " . $this->security($ns_tree) . " AND types = 'all' AND gallery.id_doc = ns_doc.id AND id_lang_text.id = gallery.description AND id_lang_text.lang = '".$GLOBALS['lang']."';"));
	}

}

?>