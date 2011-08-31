<?
class comment_model extends add_model_module {
    
    
    /**
     * @param $id_ns_tree 
     * @return true/false
     */
    function set_show_me($id_ns_tree) {
        return $this->db->query("UPDATE ns_tree SET show_me=1 WHERE id='" . $this->security($id_ns_tree, "+") . "'");
    }

    function get_all_modules() {
        return $this->db->result_array($this->db->query("SELECT * FROM modules;"));
    }

    function insert_options($post) {
        return $this->db->insert("comment_path", $post);
    }

    function update_options($idcp, $post) {
        $where = " id=" . $this->security($idcp);
        return $this->db->update("comment_path", $post, $where);
    }

    function del_path($idcp="") {
        return $this->db->query("DELETE  FROM comment_path WHERE id='" . $this->security($idcp) . "';");
    }

    function get_info_by_id($idcom) {
        return $this->db->row_array($this->db->query("SELECT comment.* FROM comment WHERE id='" . $this->security($idcom, "num") . "';"));
    }

    function get_all_cp() {
        return $this->db->result_array($this->db->query("SELECT * FROM modules,comment_path WHERE comment_path.class_id=modules.id;"));
    }

    function get_all_cp2() {
        return $this->db->result_array($this->db->query("SELECT * FROM ns_tree,id_lang_text,comment_path WHERE comment_path.tree_id=ns_tree.id AND ns_tree.alias=id_lang_text.id AND id_lang_text.lang='" . $GLOBALS['lang'] . "';"));
    }

    function get_all_message() {
        return $this->db->result_array($this->db->query("SELECT id_lang_text.*,comment.* FROM comment,id_lang_text,ns_doc WHERE id_lang_text.id=comment.email AND ns_doc.id=comment.id_doc GROUP BY comment.id;"));
    }

    function insert($class, $ns_treeid, $post) {
        $res = $this->db->query("START TRANSACTION;");
        if (empty($post['int_id']))
            $this->db->query("INSERT INTO ns_doc SET date=NOW(),father_id='" . $ns_treeid . "',show_me=1,module='" . $class . "', side_for_doc='module',mod_order='comm',mod_options='1';");
        else
            $this->db->query("INSERT INTO ns_doc SET date=NOW(),father_id='" . $ns_treeid . "',show_me=1,module='" . $class . "', side_for_doc='module',mod_order='comm',mod_options='0';");
        $ns_doc = mysql_insert_id();

        $lastid = $this->returnLastId("+");

        $res+=$this->db->query("INSERT INTO id_lang_text SET text='" . $this->security($post['email'], "+") . "',id='" . $lastid . "',lang='any';");

        $res+=$this->db->query("INSERT INTO comment SET email='" . $lastid . "',id_doc='" . $ns_doc . "',int_id='" . $post['int_id'] . "';");
        $comm = mysql_insert_id();
        $lastid++;
        $res+=$this->db->query("INSERT INTO id_lang_text SET text='" . $this->security($post['body']) . "',id='" . $lastid . "',lang='any';");
        $res+=$this->db->query("UPDATE comment SET body='" . $lastid . "' WHERE id='" . $comm . "';");
        $this->db->query("COMMIT;");
        return $res;
    }

    function get_comm($id, $lang="", $search="") {
        if (!empty($search))
            $search = " AND id_lang_text.text LIKE '%" . $search . "%'";
        return $this->db->row_array($this->db->query("SELECT comment.*,modules.*,id_lang_text.*,ns_doc.* FROM ns_doc,id_lang_text,modules,comment WHERE modules.class=ns_doc.module AND comment.id_doc='" . $id . "' AND ns_doc.id=comment.id_doc AND comment.body=id_lang_text.id AND id_lang_text.lang='" . $lang . "' " . $search . " ;"));
    }

    function get_comm_all($id, $lang) {
        return $this->db->result_array($this->db->query("SELECT comment2.text as comtex, comment2.id as comid,ns_doc.*,id_lang_text.*,comment.* FROM comment LEFT JOIN (SELECT id_lang_text.text,comment.* FROM comment,id_lang_text WHERE id_lang_text.id=comment.email ) as comment2 ON comment2.id=comment.int_id,id_lang_text,ns_doc WHERE (id_lang_text.id=comment.email OR id_lang_text.id=comment.body) AND ns_doc.id=comment.id_doc AND ns_doc.id='" . $id . "' AND id_lang_text.lang='" . $lang . "' order by id_lang_text.id;"));
    }

    function update($id, $post) {
        $res = $this->db->query("START TRANSACTION;");
        if (empty($post['int_id']))
            $res.=$this->db->query("UPDATE ns_doc SET mod_options='1' WHERE id='" . $this->security($id, "+") . "';");
        else
            $this->db->query("UPDATE ns_doc SET mod_options='0' WHERE id='" . $this->security($id, "+") . "';");
        $res.=$this->db->query("UPDATE id_lang_text SET date=NOW(),text='" . $this->security($post['email'], "+") . "' WHERE id='" . $this->security($post['email_id'], "+") . "'");
        $res.=$this->db->query("UPDATE id_lang_text SET date=NOW(),text='" . $this->security($post['body']) . "' WHERE id='" . $this->security($post['body_id'], "+") . "'");
        $res.=$this->db->query("UPDATE comment SET int_id='" . $this->security($post['int_id'], "+") . "' WHERE id='" . $this->security($post['idc'], "+") . "' ");
        $this->db->query("COMMIT;");
        return $res;
    }

    function del($id, $lang) {
        if (!empty($lang))
            return $this->db->query("DELETE id_lang_text FROM id_lang_text,comment,ns_doc WHERE (comment.body=id_lang_text.id OR comment.email=id_lang_text.id ) AND ns_doc.id=" . $id . " AND id_lang_text.lang='" . $lang . "' AND ns_doc.id=comment.id_doc;");
        else
            return $this->db->query("DELETE id_lang_text,comment,ns_doc FROM id_lang_text,comment,ns_doc WHERE (comment.body=id_lang_text.id OR comment.email=id_lang_text.id) AND ns_doc.id=" . $id . "  AND ns_doc.id=comment.id_doc;");
    }

    function get_path_form($idt) {
        return $this->db->row_array($this->db->query("SELECT * FROM ns_doc WHERE father_id='" . $this->security((int)$idt, "+") . "' AND types='form';"));
    }
    
     function get_path_view($idt) {
        return $this->db->row_array($this->db->query("SELECT * FROM ns_doc WHERE father_id='" . $this->security((int)$idt, "+") . "' AND types='view';"));
    }

    function insert_front($post, $id_nstree,$ext_id) {
        $res = $this->db->query("START TRANSACTION;");
        if (empty($post['int_id']))
            $this->db->query("INSERT INTO ns_doc SET date=NOW(),father_id='" . $id_nstree . "',show_me=1,module='comment', side_for_doc='module',mod_order='comm',mod_options='1'");
        else
            $this->db->query("INSERT INTO ns_doc SET date=NOW(),father_id='" . $id_nstree . "',show_me=1,module='comment', side_for_doc='module',mod_order='comm',mod_options='0';");
        $ns_doc = mysql_insert_id();

        $lastid = $this->returnLastId("+");

        $res = $this->db->query("INSERT INTO id_lang_text SET text='" . $this->security($post['email'], "+") . "',id='" . $lastid . "',lang='any';");
        $res = $this->db->query("INSERT INTO comment SET email='" . $lastid . "',id_doc='" . $ns_doc . "',int_id='" . $post['int_id'] . "',ext_id='".$ext_id."';");

        $comm = mysql_insert_id();
        $lastid++;
        $this->db->query("INSERT INTO id_lang_text SET text='" . $this->security($post['body'], "+") . "',id='" . $lastid . "',lang='any';");
        $res.=$this->db->query("UPDATE comment SET body='" . $lastid . "' WHERE id='" . $comm . "';");
        $this->db->query("COMMIT;");
        return $res;
    }

    function get_commen_path_tree($ns_tree) {
        return $this->db->row_array($this->db->query("SELECT * FROM ns_tree, ns_doc WHERE ns_tree.id='" . $this->security($ns_tree, "+") . "' AND ns_tree.show_me=1 AND ns_doc.father_id=ns_tree.id AND ns_doc.show_me=1 AND ns_doc.types='form';"));
    }

    function get_comment_for($nstree,$ext_id) {
        return $this->db->result_array($this->db->query("SELECT comment.id as idcomm, comment.*,id_lang_text.*,ns_doc.*,combody.text as body FROM id_lang_text,ns_doc,comment INNER JOIN (SELECT id_lang_text.text,comment.id FROM comment,id_lang_text WHERE comment.body=id_lang_text.id) as combody ON combody.id=comment.id WHERE comment.email=id_lang_text.id AND comment.id_doc=ns_doc.id AND ns_doc.father_id='" . $this->security($nstree) . "' AND ns_doc.show_me=1  AND (comment.int_id=0 OR comment.int_id='') AND ext_id = '".$this->security($ext_id,"+")."' ORDER BY ns_doc.date DESC;"));
    }

    function get_comment_for_n($nstree,$ext_id) {
        return $this->db->result_array($this->db->query("SELECT comment.id as idcomm, comment.*,id_lang_text.*,ns_doc.*,combody.text as body FROM id_lang_text,ns_doc,comment INNER JOIN (SELECT id_lang_text.text,comment.id FROM comment,id_lang_text WHERE comment.body=id_lang_text.id) as combody ON combody.id=comment.id WHERE comment.email=id_lang_text.id AND comment.id_doc=ns_doc.id AND ns_doc.father_id='" . $this->security($nstree) . "' AND ns_doc.show_me=1  AND (comment.int_id!=0 OR comment.int_id!='') AND ext_id = '".$this->security($ext_id,"+")."' ORDER BY ns_doc.date DESC;"));
    }

    function get_tree($ns_doc) {
        return $this->db->row_array($this->db->query("SELECT id_lang_text.*,comment.*,ns_tree.*,comment.id as comid FROM ns_doc,ns_tree,comment,id_lang_text WHERE ns_doc.father_id=ns_tree.id AND ns_doc.id='" . $this->security($ns_doc) . "' AND ns_doc.id=comment.id_doc AND comment.email=id_lang_text.id;"));
    }

    function inserteditfor($post) {
        
        return $this->db->insert("ns_doc",$_POST);
    }
    
    function updateeditfor($post){
        return $this->db->update("ns_doc",$post," id = ".$post['id']);
    }
    
    function insertView($data){
        return $this->db->insert("ns_doc",$data);
    }
	


}

?>