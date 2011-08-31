<?

class dv_model extends add_model_module {

    function get_doc_title($id) {
        $tmp = $this->db->row_array($this->db->query("SELECT id_lang_text.text From id_lang_text,ns_doc,doc_view WHERE ns_doc.id='$id' and ns_doc.id=doc_view.id and doc_view.show_me_title='1' and doc_view.text_title=id_lang_text.id and  id_lang_text.lang='" . $GLOBALS['lang'] . "'"));
        return $tmp;
    }

    function get_doc($id, $arg="") {

        if (empty($arg))
            $arg = "ns_doc.father_id='" . $id . "'";
        else
            $arg = " ns_doc.id='" . $id . "'";
        $tmp = $this->db->result_array($this->db->query("SELECT ns_doc.id as idg,ns_doc.side_for_doc,id_lang_text.text,title.text as title,doc_view.small_version,title.show_me_title,id_lang_text.id From id_lang_text,doc_view,ns_doc inner join (SELECT doc_view.show_me_title,id_lang_text.text,doc_view.id From id_lang_text,doc_view WHERE doc_view.text_title=id_lang_text.id AND id_lang_text.lang='" . $GLOBALS['lang'] . "') as title ON title.id=ns_doc.id  WHERE " . $arg . " and ns_doc.id=doc_view.id and doc_view.text=id_lang_text.id and ns_doc.show_me=1 and id_lang_text.lang='" . $GLOBALS['lang'] . "' ORDER BY ns_doc.date DESC;"));

        return $tmp;
    }

    function get_text($id) {
        return $this->db->row_array($this->db->query("SELECT modules.*,ns_doc.side_for_doc,id_lang_text.text,ns_doc.id,id_lang_text.lang,ns_doc.sch FROM modules,id_lang_text,doc_view,ns_doc WHERE modules.class=ns_doc.module AND ns_doc.id='" . $id . "' AND ns_doc.show_me=1 AND ns_doc.id=doc_view.id AND  doc_view.text=id_lang_text.id AND id_lang_text.lang='" . $GLOBALS['lang'] . "' ORDER BY ns_doc.date;"));
    }

    function get_text2($id, $lang, $search="") {
        if (!empty($search))
            $search = " AND id_lang_text.text LIKE '%" . $search . "%'";
        return $this->db->row_array($this->db->query("SELECT ns_doc.show_me,modules.*,ns_doc.side_for_doc,id_lang_text.text,ns_doc.id,id_lang_text.lang,ns_doc.sch FROM modules,id_lang_text,doc_view,ns_doc WHERE modules.class=ns_doc.module AND ns_doc.id='" . $id . "'  AND ns_doc.id=doc_view.id AND  doc_view.text=id_lang_text.id AND id_lang_text.lang='" . $lang . "' " . $search . " ;"));
    }

    function insert($func, $id, $module, $lastid) {
        $res = $this->db->query("START TRANSACTION;");
        $lastid++;
        $lastid2 = $lastid + 1;
        foreach ($_POST['title'] as $key => $value) {
            $this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim($value)) . "',id='" . $lastid . "' ,lang='" . $key . "',date=NOW();");
            //$this->db->query("UPDATE id_lang_text SET text_title='".$value."' WHERE id=".$result['texttitle']." AND lang='".$key."'");
        }
        foreach ($_POST['text'] as $key => $value) {
            $this->db->query("INSERT INTO id_lang_text SET text='" . mysql_real_escape_string(trim($value)) . "', id='" . $lastid2 . "' , lang='" . $key . "',date=NOW();");
        }
        $this->db->query("INSERT INTO ns_doc SET father_id=" . $id . ",show_me=1,side_for_doc='" . $_POST['sidedoc'] . "',module='" . $module . "',date=NOW(),sch='" . $_POST['sch'] . "';");
        $ns_docL = mysql_insert_id();
        $this->db->query("INSERT INTO doc_view SET id=" . $ns_docL . ",text_title=" . $lastid . ",text=" . $lastid2 . ",show_me_title='" . $_POST['show_me_title'] . "',small_version='" . $_POST['small_version'] . "';");
        $this->db->query("COMMIT;");
        return $ns_docL;
    }

    function returnSide() {
        return $this->db->result_array($this->db->query("SELECT * From side_site WHERE id_template=( SELECT id From templates WHERE show_me='1')"));
    }

    function returnSideForDoc($id) {
        return $this->db->result_array($this->db->query("SELECT * From side_site WHERE id_template=( SELECT template_out From ns_tree,ns_doc WHERE ns_tree.id=ns_doc.father_id AND ns_doc.id=" . $id . ")"));
    }

    function update($id) {
        $res = $this->db->query("START TRANSACTION;");
        $this->db->query("UPDATE ns_doc SET side_for_doc='" . $_POST['sidedoc'] . "',sch='" . $_POST['sch'] . "' WHERE id=" . $id . ";");
        $this->db->query("UPDATE doc_view SET small_version='" . $_POST['small_version'] . "',show_me_title='" . $_POST['show_me_title'] . "' WHERE id=" . $id . ";");
        $result = $this->db->row_array($this->db->query("SELECT * FROM doc_view WHERE id=" . $id . ";"));
        $res1 = 0;
        foreach ($_POST['title'] as $key => $value) {
            $res1+=$this->db->query("UPDATE id_lang_text SET text='" . mysql_real_escape_string(trim(strip_tags($value))) . "' ,date=NOW() WHERE id=" . $result['text_title'] . " AND lang='" . $key . "';");
            //$this->db->query("UPDATE id_lang_text SET text_title='".$value."' WHERE id=".$result['texttitle']." AND lang='".$key."'");
        }
        foreach ($_POST['text'] as $key => $value) {
            $res1+=$this->db->query("UPDATE id_lang_text SET text='" . mysql_real_escape_string(trim($value)) . "',date=NOW() WHERE id=" . $result['text'] . " AND lang='" . $key . "';");
        }
        $this->db->query("COMMIT;");
        return $res1;
    }

    function getDoc($id, $lang) {
        return $this->db->row_array($this->db->query("SELECT ns_doc.id as idg,ns_doc.side_for_doc,lang.*,id_lang_text.text,title.text as title,doc_view.small_version,title.show_me_title,id_lang_text.id,ns_doc.sch From lang,id_lang_text,doc_view,ns_doc inner join (SELECT doc_view.show_me_title,id_lang_text.text,doc_view.id From id_lang_text,doc_view WHERE doc_view.text_title=id_lang_text.id AND id_lang_text.lang='" . $lang . "') as title ON title.id=ns_doc.id  WHERE ns_doc.id='" . $id . "' and ns_doc.id=doc_view.id and doc_view.text=id_lang_text.id  and id_lang_text.lang='" . $lang . "' AND lang.name=id_lang_text.lang"));
    }

    function del($id, $lang) {
        if (!empty($lang))
            return $this->db->query("DELETE id_lang_text FROM id_lang_text,doc_view,ns_doc WHERE (doc_view.text=id_lang_text.id OR doc_view.text_title=id_lang_text.id) AND doc_view.id=" . $id . " AND id_lang_text.lang='" . $lang . "' AND ns_doc.id=doc_view.id;");
        else
            return $this->db->query("DELETE id_lang_text,doc_view,ns_doc FROM id_lang_text,doc_view,ns_doc WHERE (doc_view.text=id_lang_text.id OR doc_view.text_title=id_lang_text.id) AND doc_view.id=" . $id . "  AND ns_doc.id=doc_view.id;");
    }

    function getPagesForNstree($nstree) {
        return $this->db->result_array($this->db->query("SELECT * FROM doc_view,id_lang_text,ns_doc WHERE ns_doc.father_id='" . $nstree . "' AND ns_doc.id=doc_view.id AND doc_view.small_version=1 AND doc_view.text_title=id_lang_text.id AND id_lang_text.lang='" . $GLOBALS['lang'] . "';"));
    }

    function getPagesAbs($ns_doc) {
        return $this->db->result_array($this->db->query("SELECT * FROM lang LEFT JOIN id_lang_text ON id_lang_text.lang=lang.name AND id_lang_text.id=(SELECT doc_view.text_title FROM doc_view WHERE doc_view.id='" . $this->security($ns_doc) . "') WHERE id_lang_text.text is null;"));
    }

    function getIdLang($nsdoc) {
        return $this->db->row_array($this->db->query("SELECT * FROM doc_view WHERE doc_view.id='" . $this->security($nsdoc) . "'"));
    }

}

?>