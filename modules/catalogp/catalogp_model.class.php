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
            $res = $this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($value))) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
        }
        $lastid = $this->returnLastId();

        $lastid_d = $this->returnLastId("+");
        foreach ($post['descr_br'] as $key => $value) {
            $res = $this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($value))) . "', id='" . $lastid_d . "' , lang='" . $key . "',date=NOW();");
        }

        $res = $this->db->query("INSERT INTO catalogp SET type='br',name_alias='" . $lastid . "',id_doc='" . $ns_doc . "',pos='" . $post['pos'] . "', path='" . $post['path'] . "',file_name='" . $post['file_name'] . "',pid='" . $post['branch'] . "',descr_alias = '" . $lastid_d . "';");
        $res = $this->db->query("COMMIT;");
        return $res;
    }

    function insert_el($class, $ns_treeid, $post) {
        $res = $this->db->query("START TRANSACTION;");
        $this->db->query("INSERT INTO ns_doc SET date=NOW(),father_id='" . $ns_treeid . "',show_me=1,module='" . $class . "', side_for_doc='module',mod_order='cpe';");
        $ns_doc = mysql_insert_id();

        $lastid = $this->returnLastId("+");
        foreach ($post['name'] as $key => $value) {
            $this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($value))) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
        }
        $lastid = $this->returnLastId();
        $this->db->query("INSERT INTO catalogp SET name_alias='" . $lastid . "',path='" . $post['path'] . "',file_name='" . $post['file_name'] . "';");
        $id_cat = mysql_insert_id();
        $res = 0;
        $lastid++;
        foreach ($post['descr'] as $key => $value) {
            $res+=$this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($value))) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
        }

        $this->db->query("UPDATE  catalogp SET descr_alias='" . $lastid . "' WHERE idcp='" . $id_cat . "';");

        $lastid++;
        foreach ($post['price'] as $key => $value) {
            $res+=$this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($value))) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
        }
        $res+=$this->db->query("UPDATE  catalogp SET type='el',pid='" . $post['branch'] . "', id_doc='" . $ns_doc . "', price_alias='" . $lastid . "' WHERE idcp='" . $id_cat . "';");
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
                $mod_order=" AND catalogp.pid='" . $this->security(substr($mod_order, 4)) . "'";
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
            $res+=$this->db->query("UPDATE id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($value))) . "', date=NOW() WHERE id='" . $key . "' AND lang='" . $post['lang'] . "'");
        }
        $res+=$this->db->query("UPDATE catalogp SET  pid='" . $post['branch'] . "', path='" . $post['path'] . "',file_name='" . $post['file_name'] . "' WHERE catalogp.idcp='" . $post['idcp'] . "'");
        $this->db->query("COMMIT;");
        return $res;
    }

    function update_br($id, $post) {
        $res = $this->db->query("START TRANSACTION;");
        //$this->db->query("UPDATE ns_doc SET  date= NOW() WHERE ns_doc.id='".$id."'");
        $res+=$this->db->query("UPDATE id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($post['name_alias']))) . "', date=NOW() WHERE id='" . $post['idl'] . "' AND lang='" . $post['lang'] . "'");
        $res+=$this->db->query("UPDATE id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($post['descr_br']))) . "', date=NOW() WHERE id='" . $post['idl_descr'] . "' AND lang='" . $post['lang'] . "'");
        $res+=$this->db->query("UPDATE catalogp SET pos='" . $post['pos'] . "', path='" . $post['path'] . "',file_name='" . $post['file_name'] . "',pid='" . $post['branch'] . "' WHERE catalogp.idcp='" . $post['idcp'] . "'");
        $this->db->query("COMMIT;");
        return $res;
    }

    function get_all_branch_site($id_nstree) {
        return $this->db->result_array($this->db->query("SELECT catalogp.*,id_lang_text.*,descr.text as descr, ns_doc.*,ns_doc.id as id_doc FROM catalogp, id_lang_text,ns_doc,id_lang_text as descr WHERE catalogp.type='br' AND name_alias=id_lang_text.id AND  id_lang_text.lang='" . $GLOBALS['lang'] . "' AND ns_doc.show_me=1 AND ns_doc.father_id='" . $id_nstree . "' AND ns_doc.id=catalogp.id_doc AND descr.id = catalogp.descr_alias AND descr.lang = '" . $GLOBALS['lang'] . "' ORDER BY pos;"));
    }

    function get_all_element_site($id_nstree) {
        return $this->db->result_array($this->db->query("SELECT * FROM catalogp, id_lang_text,ns_doc WHERE catalogp.type='el' AND (catalogp.name_alias=id_lang_text.id OR catalogp.descr_alias=id_lang_text.id OR catalogp.price_alias=id_lang_text.id) AND  id_lang_text.lang='" . $GLOBALS['lang'] . "' AND ns_doc.show_me=1 AND ns_doc.father_id='" . $id_nstree . "' AND ns_doc.id=catalogp.id_doc ORDER BY id_lang_text.id;"));
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
        return $this->db->row_array($this->db->query("SELECT catalogp.*,name.text as name,descr.text as descr FROM catalogp, ns_doc,id_lang_text as name, id_lang_text as descr WHERE ns_doc.show_me = 1 AND ns_doc.id = catalogp.id_doc AND name.id = catalogp.name_alias AND name.lang= '" . $GLOBALS['lang'] . "' AND catalogp.descr_alias = descr.id AND descr.lang = '" . $GLOBALS['lang'] . "'  AND ns_doc.id = '".$id_doc."';"));
    }

}

?>
