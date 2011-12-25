<?

class news_model extends add_model_module {

    function insert($class, $ns_treeid, $post) {
        $res = $this->db->query("START TRANSACTION;");

        $this->db->query("INSERT INTO ns_doc SET date=NOW(),father_id='" . $ns_treeid . "',show_me=1,module='" . $class . "', side_for_doc='" . $post['sidedoc'] . "';");
        $this->db->query("INSERT INTO news SET id_doc='" . mysql_insert_id() . "',date=NOW(),body=0,title=0,shortdescr=0;");
        $news_id = mysql_insert_id();

        $lastid = $this->returnLastId("+");
        foreach ($post['title'] as $key => $value) {
            $this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($value))) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
        }
        $this->db->query("UPDATE news SET title='" . $lastid . "' WHERE id='" . $news_id . "';");

        $lastid = $this->returnLastId("+");
        foreach ($post['shortdescr'] as $key => $value) {
            $this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($value))) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
        }
        $this->db->query("UPDATE news SET shortdescr='" . $lastid . "' WHERE id='" . $news_id . "';");

        $lastid = $this->returnLastId("+");
        foreach ($post['body'] as $key => $value) {
            $res2 = $this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim($value)) . "', id='" . $lastid . "' , lang='" . $key . "',date=NOW();");
        }
        $this->db->query("UPDATE news SET body='" . $lastid . "' WHERE id='" . $news_id . "';");
        $this->db->query("COMMIT;");
        return $res2;
    }

    function get_news($id, $lang, $search="") {
        if (!empty($search))
            $search = " AND id_lang_text.text LIKE '%" . $search . "%'";
        return $this->db->row_array($this->db->query("SELECT *,ns_doc.id FROM ns_doc,news,id_lang_text,modules WHERE modules.class=ns_doc.module AND news.id_doc='" . $id . "' AND ns_doc.id=news.id_doc AND news.body=id_lang_text.id AND id_lang_text.lang='" . $lang . "' " . $search . " ;"));
    }

    function get_news_all($id, $lang) {
        return $this->db->result_array($this->db->query("SELECT *,ns_doc.id,id_lang_text.id as idl FROM ns_doc,news,id_lang_text,modules WHERE modules.class=ns_doc.module AND news.id_doc='" . $this->security($id) . "' AND ns_doc.id=news.id_doc AND (news.body=id_lang_text.id OR news.title=id_lang_text.id OR news.shortdescr=id_lang_text.id)AND id_lang_text.lang='" . $lang . "' order by id_lang_text.id;"));
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

    function del($id, $lang) {
        if (!empty($lang))
            return $this->db->query("DELETE id_lang_text FROM id_lang_text,news,ns_doc WHERE (news.body=id_lang_text.id OR news.title=id_lang_text.id OR news.shortdescr=id_lang_text.id) AND ns_doc.id=" . $this->security($id) . " AND id_lang_text.lang='" . $lang . "' AND ns_doc.id=news.id_doc;");
        else
            return $this->db->query("DELETE id_lang_text,news,ns_doc FROM id_lang_text,news,ns_doc WHERE (news.body=id_lang_text.id OR news.title=id_lang_text.id OR news.shortdescr=id_lang_text.id) AND ns_doc.id=" . $id . "  AND ns_doc.id=news.id_doc;");
    }

    function get_all_news_title($ns_tree, $pag) {
        return $this->db->result_array($this->db->query("SELECT SQL_CALC_FOUND_ROWS *,id_lang_text.id as idl,news.id as idn FROM ns_doc,id_lang_text,news WHERE ns_doc.father_id='" . $this->security($ns_tree) . "' AND  ns_doc.id=news.id_doc AND id_lang_text.id=news.title  AND id_lang_text.lang='" . $GLOBALS['lang'] . "' AND ns_doc.show_me=1 ORDER BY news.id DESC LIMIT " . $this->security($pag) . ",10 ;"));
    }

    function get_all_news_shortdescr($ns_tree, $pag) {
        return $this->db->result_array($this->db->query("SELECT SQL_CALC_FOUND_ROWS *,id_lang_text.id as idl,news.id as idn FROM ns_doc,id_lang_text,news WHERE ns_doc.father_id='" . $this->security($ns_tree) . "' AND  ns_doc.id=news.id_doc AND id_lang_text.id=news.shortdescr  AND id_lang_text.lang='" . $GLOBALS['lang'] . "'  AND ns_doc.show_me=1 LIMIT " . $pag . ",10;"));
    }

    function getNewsAndNstree($id_ns_doc) {
        return $this->db->result_array($this->db->query("SELECT SQL_CALC_FOUND_ROWS *,id_lang_text.id as idl,news.id as idn,ns_tree.id as idt FROM ns_tree,ns_doc,id_lang_text,news WHERE ns_doc.id='" . $this->security($id_ns_doc) . "' AND  ns_doc.id=news.id_doc AND (id_lang_text.id=news.title OR id_lang_text.id=news.body) AND id_lang_text.lang='" . $GLOBALS['lang'] . "' AND ns_tree.id=ns_doc.father_id AND ns_doc.show_me=1 ORDER By id_lang_text.id;"));
    }

    function getPagesForNstree($nstree) {
        return $this->db->result_array($this->db->query("SELECT * FROM id_lang_text,ns_doc,news WHERE ns_doc.father_id='" . $this->security($nstree) . "' AND ns_doc.id=news.id_doc AND  news.title=id_lang_text.id AND id_lang_text.lang='" . $GLOBALS['lang'] . "';"));
    }

    function getPagesAbs($ns_doc) {
        return $this->db->result_array($this->db->query("SELECT * FROM lang LEFT JOIN id_lang_text ON id_lang_text.lang=lang.name AND id_lang_text.id=(SELECT news.title FROM news WHERE news.id_doc='" . $this->security($ns_doc) . "') WHERE id_lang_text.text is null;"));
    }

    function getIdLang($nsdoc) {
        return $this->db->row_array($this->db->query("SELECT * FROM news WHERE news.id_doc='" . $this->security($nsdoc) . "'"));
    }

}

?>