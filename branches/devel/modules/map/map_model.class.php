<?

class map_model extends add_model_module {

    function insert($class, $ns_treeid, $post) {
        $res = $this->db->query("START TRANSACTION;");

        $res2 = $this->db->query("INSERT INTO ns_doc SET date=NOW(),father_id='" . $ns_treeid . "',show_me=1,module='" . $class . "', side_for_doc=(SELECT side_site.side from side_site,ns_tree WHERE ns_tree.id=" . $ns_treeid . " AND ns_tree.template_out = side_site.id_template LIMIT 1);");
        $this->db->query("COMMIT;");
        return $res2;
    }

    function update($id, $post) {
        $res2 = "";
        $res = $this->db->query("START TRANSACTION;");
        $res2.=$this->db->query("UPDATE ns_doc SET side_for_doc='" . $post['sidedoc'] . "' WHERE ns_doc.id='" . $id . "'");
        foreach ($post['arr'] as $key => $value) {
            $res2.= $this->db->query("UPDATE id_lang_text SET text='" . mysql_real_escape_string(trim($value)) . "', date=NOW() WHERE id='" . $key . "' AND lang='" . $post['lang'] . "'");
        }
        $this->db->query("COMMIT;");
        return $res2;
    }

    function getPagesAbs($ns_doc) {
        return $this->db->result_array($this->db->query("SELECT * FROM lang LEFT JOIN id_lang_text ON id_lang_text.lang=lang.name AND id_lang_text.id=(SELECT map.title FROM map WHERE map.id_doc='" . $this->security($ns_doc) . "') WHERE id_lang_text.text is null;"));
    }

    function getSideNsdoc($ns_tree) {
        return $this->db->row_array($this->db->query("SELECT ns_doc.side_for_doc FROM ns_tree,ns_doc WHERE ns_tree.id=" . $ns_tree . " AND ns_doc.father_id=ns_tree.id;"));
    }

}

?>