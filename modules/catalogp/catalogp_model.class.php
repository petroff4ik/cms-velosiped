<?

class catalogp_model extends add_model_module {

	function get_all_branch($lang="") {
		if ($lang)
			return $this->db->result_array($this->db->query("SELECT * FROM catalogp, id_lang_text WHERE catalogp.type='br' AND name_alias=id_lang_text.id AND  id_lang_text.lang='" . $lang . "' ORDER BY id_lang_text.text;"));
		else
			return $this->db->result_array($this->db->query("SELECT * FROM catalogp, id_lang_text WHERE catalogp.type='br' AND name_alias=id_lang_text.id AND  id_lang_text.lang='" . $GLOBALS['lang'] . "' ORDER BY id_lang_text.text"));
	}

	function insert_br($class, $ns_treeid, $post) {
		$res = $this->db->query("START TRANSACTION;");
		$this->db->query("INSERT INTO ns_doc SET date=NOW(),father_id='" . $ns_treeid . "',show_me=1,module='" . $class . "', side_for_doc='module',mod_order='cpb';");
		$ns_doc = mysql_insert_id();

		$lastid = $this->returnLastId("+");
		foreach ($post['branch_name'] as $key => $value) {
			$res = $this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim($value)) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
		}
		$lastid = $this->returnLastId();

		$lastid_d = $this->returnLastId("+");
		foreach ($post['descr_br'] as $key => $value) {
			$res = $this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim($value)) . "', id='" . $lastid_d . "' , lang='" . $key . "',date=NOW();");
		}

		$res = $this->db->query("INSERT INTO catalogp SET type='br',name_alias='" . $lastid . "',id_doc='" . $ns_doc . "',pos='" . $post['pos'] . "', path='" . $post['path'] . "',file_name='" . $post['file_name'] . "',pid='" . $post['branch'] . "',descr_alias = '" . $lastid_d . "';");
		$res = $this->db->query("COMMIT;");
		return $res;
	}

	function insert_el($class, $ns_treeid, $post) {
		$res = $this->db->query("START TRANSACTION;");
		$this->db->query("INSERT INTO ns_doc SET date=NOW(),father_id='" . $ns_treeid . "',show_me=1,module='" . $class . "', side_for_doc='module';");
		$ns_doc = mysql_insert_id();

		$lastid = $this->returnLastId("+");
		foreach ($post['name'] as $key => $value) {
			$this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim($value)) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
		}
		$lastid = $this->returnLastId();
		$this->db->query("INSERT INTO catalogp SET name_alias='" . $lastid . "',path='" . $post['path'] . "',file_name='" . $post['file_name'] . "';");
		$id_cat = mysql_insert_id();
		$res = 0;
		$lastid++;
		foreach ($post['descr'] as $key => $value) {
			$res+=$this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim($value)) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
		}

		$this->db->query("UPDATE  catalogp SET descr_alias='" . $lastid . "' WHERE idcp='" . $id_cat . "';");

		$lastid++;
		foreach ($post['price'] as $key => $value) {
			$res+=$this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim($value)) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
		}
		$res+=$this->db->query("UPDATE  catalogp SET type='el',pid='" . $post['branch'] . "', id_doc='" . $ns_doc . "', price_alias='" . $lastid . "' WHERE idcp='" . $id_cat . "';");
                $this->db->query("UPDATE ns_doc SET mod_order = '".(int)$post['branch']."' WHERE id = ?",$ns_doc);
		$this->db->query("COMMIT;");
		return $res;
	}

	function get_cat($id, $lang, $search="", $mod_order="") {
		if (!empty($search))
			$search = " AND id_lang_text.text LIKE '%" . $search . "%'";
		if (!empty($mod_order)) {
			if (strpos($mod_order, "-cp-") === false)
				$mod_order = "";
			else
				$mod_order = " AND catalogp.pid='" . $this->security(substr($mod_order, 4)) . "'";
		}
		return $this->db->row_array($this->db->query("SELECT catalogp.*,modules.*,id_lang_text.*,ns_doc.*,catalogp2.text as brn,catalogp.type FROM ns_doc,id_lang_text,modules,catalogp LEFT JOIN (SELECT * FROM catalogp, id_lang_text WHERE catalogp.type='br' AND name_alias=id_lang_text.id AND  id_lang_text.lang='" . $lang . "' ) as catalogp2 ON catalogp.pid=catalogp2.idcp WHERE modules.class=ns_doc.module AND catalogp.id_doc='" . $id . "' AND ns_doc.id=catalogp.id_doc AND catalogp.name_alias=id_lang_text.id AND id_lang_text.lang='" . $lang . "' " . $search . " " . $mod_order . " ;"));
	}

	function del($id, $lang) {
		if (!empty($lang))
			return $this->db->query("DELETE id_lang_text FROM id_lang_text,catalogp,ns_doc WHERE (catalogp.name_alias=id_lang_text.id OR catalogp.descr_alias=id_lang_text.id OR catalogp.price_alias=id_lang_text.id) AND ns_doc.id=" . $id . " AND id_lang_text.lang='" . $lang . "' AND ns_doc.id=catalogp.id_doc;");
		else
			return $this->db->query("DELETE id_lang_text,catalogp,ns_doc FROM id_lang_text,catalogp,ns_doc WHERE (catalogp.name_alias=id_lang_text.id OR catalogp.descr_alias=id_lang_text.id OR catalogp.price_alias=id_lang_text.id) AND ns_doc.id=" . $id . "  AND ns_doc.id=catalogp.id_doc;");
	}

	function get_catalog_all($id, $lang) {
		return $this->db->result_array($this->db->query("SELECT *,ns_doc.id,id_lang_text.id as idl FROM ns_doc,catalogp,id_lang_text,modules WHERE modules.class=ns_doc.module AND catalogp.id_doc='" . $id . "' AND ns_doc.id=catalogp.id_doc AND  (catalogp.name_alias=id_lang_text.id OR catalogp.descr_alias=id_lang_text.id OR catalogp.price_alias=id_lang_text.id) AND id_lang_text.lang='" . $lang . "' order by id_lang_text.id;"));
	}

	function get_cur_branch($id_brn, $lang) {
		return $this->db->row_array($this->db->query("SELECT * FROM catalogp, id_lang_text WHERE catalogp.type='br' AND name_alias=id_lang_text.id AND  id_lang_text.lang='" . $lang . "' AND catalogp.idcp='" . $id_brn . "';"));
	}

	function update_el($id, $post) {
		$res = $this->db->query("START TRANSACTION;");
		//$this->db->query("UPDATE ns_doc SET  date= NOW() WHERE ns_doc.id='".$id."'");
		foreach ($post['arr'] as $key => $value) {
			$res+=$this->db->query("UPDATE id_lang_text SET text='" . mysql_real_escape_string(trim($value)) . "', date=NOW() WHERE id='" . $key . "' AND lang='" . $post['lang'] . "'");
		}
		$res+=$this->db->query("UPDATE catalogp SET  pid='" . $post['branch'] . "', path='" . $post['path'] . "',file_name='" . $post['file_name'] . "' WHERE catalogp.idcp='" . $post['idcp'] . "'");
                $this->db->query("UPDATE ns_doc SET mod_order = '".(int)$post['branch']."' WHERE id = ?",$id);
		$this->db->query("COMMIT;");
		return $res;
	}

	function update_br($id, $post) {
		$res = $this->db->query("START TRANSACTION;");
		//$this->db->query("UPDATE ns_doc SET  date= NOW() WHERE ns_doc.id='".$id."'");
		$res+=$this->db->query("UPDATE id_lang_text SET text='" . mysql_real_escape_string(trim($post['name_alias'])) . "', date=NOW() WHERE id='" . $post['idl'] . "' AND lang='" . $post['lang'] . "'");
		$res+=$this->db->query("UPDATE id_lang_text SET text='" . mysql_real_escape_string(trim($post['descr_br'])) . "', date=NOW() WHERE id='" . $post['idl_descr'] . "' AND lang='" . $post['lang'] . "'");
		$res+=$this->db->query("UPDATE catalogp SET pos='" . $post['pos'] . "', path='" . $post['path'] . "',file_name='" . $post['file_name'] . "',pid='" . $post['branch'] . "' WHERE catalogp.idcp='" . $post['idcp'] . "'");
		$this->db->query("COMMIT;");
		return $res;
	}

	function get_all_branch_site($id_nstree,$parent_id = 0) {
		return $this->db->result_array($this->db->query("SELECT catalogp.*,id_lang_text.*,descr.text as descr, ns_doc.*,ns_doc.id as id_doc,addi.text as addi FROM  id_lang_text,ns_doc,id_lang_text as descr,catalogp left join id_lang_text as addi ON addi.id = catalogp.price_alias AND addi.lang = '" . $GLOBALS['lang'] . "' WHERE catalogp.type='br' AND name_alias=id_lang_text.id AND id_lang_text.lang='" . $GLOBALS['lang'] . "' AND ns_doc.show_me=1 AND ns_doc.father_id='" . $id_nstree . "' AND ns_doc.id=catalogp.id_doc AND descr.id = catalogp.descr_alias AND descr.lang = id_lang_text.lang AND catalogp.pid = ? ORDER BY pos ;",array($parent_id)));
	}

	function get_all_element_site($id_nstree,$parent_id = 0) {
		return $this->db->result_array($this->db->query("SELECT *,name_t.text as name,descr_t.text as descr,add_t.text as addi FROM catalogp, id_lang_text as name_t,id_lang_text as descr_t,id_lang_text as add_t,ns_doc WHERE catalogp.type='el' AND catalogp.name_alias=name_t.id AND catalogp.descr_alias=descr_t.id AND catalogp.price_alias=add_t.id AND name_t.lang='".$GLOBALS['lang']."' AND ns_doc.show_me=1 AND ns_doc.father_id='".(int)$id_nstree."' AND ns_doc.id=catalogp.id_doc AND name_t.lang = descr_t.lang AND add_t.lang = name_t.lang AND catalogp.pid IN(SELECT idcp FROM catalogp WHERE pid = ?) ORDER BY name_t.id;",array($parent_id)));
	}

	function getPagesAbs($ns_doc) {
		return $this->db->result_array($this->db->query("SELECT * FROM lang LEFT JOIN id_lang_text ON id_lang_text.lang=lang.name AND id_lang_text.id=(SELECT catalogp.name_alias FROM catalogp WHERE catalogp.id_doc='" . $this->security($ns_doc) . "') WHERE id_lang_text.text is null;"));
	}

	function getIdLang($nsdoc) {
		return $this->db->row_array($this->db->query("SELECT * FROM catalogp WHERE catalogp.id_doc='" . $this->security($nsdoc) . "'"));
	}

	function getBranchAndEl($ns_doc) {
		return $this->db->row_array($this->db->query("SELECT catalogp.*,id_lang_text.*,descr.text as descr, ns_doc.*,ns_doc.id as id_doc FROM catalogp, id_lang_text,ns_doc,id_lang_text as descr WHERE catalogp.type='br' AND name_alias=id_lang_text.id AND  id_lang_text.lang='" . $GLOBALS['lang'] . "' AND ns_doc.show_me=1 AND ns_doc.id='" . $ns_doc . "' AND ns_doc.id=catalogp.id_doc AND descr.id = catalogp.descr_alias AND descr.lang = '" . $GLOBALS['lang'] . "' ORDER BY pos;"));
	}

	function getSideModule() {
		return $this->db->row_array($this->db->query("SELECT * FROM side_module,modules,templates WHERE modules.class = 'catalogp' AND modules.scheduleSide = side_module.id AND templates.id =  side_module.id_template;"));
	}

	function getElementsForBranch($ns_doc) {
		return $this->db->result_array($this->db->query("SELECT * FROM catalogp as br,catalogp as el,ns_doc,id_lang_text WHERE br.idcp = el.pid AND br.id_doc = ns_doc.id AND ns_doc.show_me = 1 AND ns_doc.id = '" . $ns_doc . "' AND id_lang_text.id = el.name_alias AND id_lang_text.lang = '" . $GLOBALS['lang'] . "';"));
	}

	function getElement($id_doc) {
		return $this->db->row_array($this->db->query("SELECT catalogp.*,name.text as name,descr.text as descr FROM catalogp, ns_doc,id_lang_text as name, id_lang_text as descr WHERE ns_doc.show_me = 1 AND ns_doc.id = catalogp.id_doc AND name.id = catalogp.name_alias AND name.lang= '" . $GLOBALS['lang'] . "' AND catalogp.descr_alias = descr.id AND descr.lang = '" . $GLOBALS['lang'] . "'  AND ns_doc.id = '" . $id_doc . "';"));
	}

	function insert_spec($type, $name, $descr, $lang, $pid, $pos, $add) {
		if ($type == "name serves") {
			$type = "e";
			$type2 = "el";
			$pid = $pid;
		} else {
			$type = "b";
			$type2 = "br";
			$pid = 0;
			$pos++;
		}
		$sql = "INSERT INTO ns_doc ( date, father_id, show_me, module, side_for_doc, children_id, mod_order, mod_group, mod_options, sch, types, sch_n, prew_id) VALUES
( NOW(), 3, 1, 'catalogp', 'module', 0, 'cp{$type}', 0, 0, 0,'' , 0, 0);";
		$this->db->query($sql);
		$ns_doc = mysql_insert_id();
		$arr['lang_id_name'] = $this->returnLastId("+");
		$sql = "INSERT INTO `id_lang_text` (`id`, `text`, `lang`, `date`) VALUES (" . $arr['lang_id_name'] . ", '" . mysql_real_escape_string(trim($name)) . "', '" . $lang . "', NOW());";
		$this->db->query($sql);
		$arr['lang_id_descr'] = $this->returnLastId("+");
		$sql = "INSERT INTO `id_lang_text` (`id`, `text`, `lang`, `date`) VALUES (" . $arr['lang_id_descr'] . ", '" . mysql_real_escape_string(trim($descr)) . "', '" . $lang . "', NOW());";
		$this->db->query($sql);
		$arr['lang_id_add'] = $this->returnLastId("+");
		$sql = "INSERT INTO `id_lang_text` (`id`, `text`, `lang`, `date`) VALUES (" . $arr['lang_id_add'] . ", '" . mysql_real_escape_string(trim($add)) . "', '" . $lang . "', NOW());";
		$this->db->query($sql);
		$sql = "INSERT INTO catalogp ( type, name_alias, descr_alias, price_alias, pid, id_doc, pos, file_name, path) VALUES
( '{$type2}', {$arr['lang_id_name']}, {$arr['lang_id_descr']}, {$arr['lang_id_add']}, '{$pid}', {$ns_doc}, $pos,'' ,'' );";
		$this->db->query($sql);
		if($type == "b"){
		$arr['parent_id'] = mysql_insert_id();
                }else {
		$arr['parent_id'] = $pid;
                $this->db->query("UPDATE ns_doc SET mod_order = '".(int)$pid."' WHERE id = ?",$ns_doc);
                }
		$arr['pos'] = $pos;
		return $arr;
	}

	function insert_spec2($name, $descr, $add, $lang, $arr) {
		$sql = "INSERT INTO `id_lang_text` (`id`, `text`, `lang`, `date`) VALUES (" . $arr['lang_id_name'] . ", '" . mysql_real_escape_string(trim($name)) . "', '" . $lang . "', NOW());";
		$this->db->query($sql);
		$sql = "INSERT INTO `id_lang_text` (`id`, `text`, `lang`, `date`) VALUES (" . $arr['lang_id_descr'] . ", '" . mysql_real_escape_string(trim($descr)) . "', '" . $lang . "', NOW());";
		$this->db->query($sql);
		$sql = "INSERT INTO `id_lang_text` (`id`, `text`, `lang`, `date`) VALUES (" . $arr['lang_id_add'] . ", '" . mysql_real_escape_string(trim($add)) . "', '" . $lang . "', NOW());";
		$this->db->query($sql);
	}
        
        function get_xls(){
            return $this->db->result_array($this->db->query("SELECT catalogp.idcp,name.text as name,descr.text as descr,price.text as price,name.lang 
FROM ns_doc,catalogp,id_lang_text as name, id_lang_text as descr, id_lang_text as price where ns_doc.id = catalogp.id_doc and ns_doc.father_id = 3 and name.id =catalogp.name_alias and descr.id = catalogp.descr_alias and price.id = catalogp.price_alias and price.lang = name.lang and name.lang=descr.lang"));
        }
        
        function updateSpec($cpid, $name, $descr, $price, $lang){
            $catalogp = $this->db->row_array($this->db->query("SELECT * FROM catalogp WHERE idcp =?",array($cpid)));
            $this->db->query("UPDATE id_lang_text SET text = ? WHERE id = ? AND lang = ?;",array($name,$catalogp['name_alias'],$lang));
            $this->db->query("UPDATE id_lang_text SET text = ? WHERE id = ? AND lang = ?;",array($descr,$catalogp['descr_alias'],$lang));
            return $this->db->query("UPDATE id_lang_text SET text = ? WHERE id = ? AND lang = ?;",array($price,$catalogp['price_alias'],$lang));
        }
        
        function delSpec($cpid, $name, $descr, $price, $lang){
            return $this->db->query("DELETE ns_doc,catalogp,id_lang_text FROM ns_doc,catalogp,id_lang_text WHERE catalogp.idcp = ? AND ns_doc.id = catalogp.id_doc AND (catalogp.name_alias = id_lang_text.id OR catalogp.descr_alias = id_lang_text.id OR catalogp.price_alias = id_lang_text.id)",array($cpid));
        }
        

}?>
