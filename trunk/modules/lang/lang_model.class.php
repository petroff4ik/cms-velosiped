<?

class lang_model extends add_model_module {

    function return_count_lang() {
        return $this->db->result_array($this->db->query("SELECT * FROM lang"));
    }

    function save_def_lang($id) {
        $this->db->query("UPDATE lang SET default_lang='' WHERE id !='$id';");
        return $this->db->query("UPDATE lang SET default_lang='true' WHERE id='$id';", true);
    }

    function save_lang_info($id, $c_id, $name, $alias) {
        $this->db->query("UPDATE lang SET id='$c_id', name='$name', alias='$alias' WHERE id='$id'");
    }

    function add_lang($name, $alias) {
        $this->db->query("INSERT INTO lang VALUES(0,'$name','$alias','');");
    }

    function del_lang($id) {
        $this->db->query("DELETE FROM lang WHERE id='$id'");
    }

    function get_message_module() {
        return $this->db->result_array($this->db->query("SELECT * from sys_info, id_lang_text WHERE sys_info.id_lang=id_lang_text.id AND id_lang_text.lang='" . $GLOBALS['lang'] . "' ;"));
    }

    function return_all_lang_array() {
        return $this->db->result_array($this->db->query("SELECT * FROM lang;"));
    }

    function return_last_Ilang() {
        return $this->db->row_array($this->db->query("SELECT * FROM id_lang_text ORDER BY id DESC LIMIT 1;"));
    }

    function get_info_lang_by_id($id) {
        return $this->db->result_array($this->db->query("SELECT * FROM lang WHERE id='" . $id . "'"));
    }

    function get_default_lang() {
        return $this->db->row_array($this->db->query("SELECT * FROM lang WHERE default_lang !='';"));
    }

}

?>