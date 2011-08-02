<?
/**
 * @author PetrOFF <andi-fm@ya.ru>
 * 
 * @package add_model_module
 * @category Module
 * Inherited function models to work with the database
 */
class add_model_module {

    protected $db;

    function __construct(&$db) {
        $this->db = &$db;
    }

    function get_info($return, $table, $compared_sql, $compared_request) {
        return $this->db->take_info($return, $table, $compared_sql, $compared_request);
    }

    function returnLastId($oper="=", $table="id_lang_text", $arg="id") {
        $q = $this->db->row_array($this->db->query("SELECT MAX(" . $arg . ")as lid FROM " . $table . ";"));
        if ($oper == "+") {
            $q['lid']++;
            return $q['lid'];
        } elseif ($oper == "-") {
            $q['lid']--;
            return $q['lid'];
        } elseif ($oper == "=") {
            return $q['lid'];
        }
    }

    function GetFoundRows() {
        $query = $this->db->query("SELECT FOUND_ROWS();");
        $query = $this->db->row_array($query);
        return $query['FOUND_ROWS()'];
    }

    function security($value, $arg="") {
        switch ($arg) {
            case("+"):$value = mysql_real_escape_string(trim(strip_tags($value)));
                break;
            case("num"): {
                    $value = mysql_real_escape_string(trim(strip_tags($value)));
                    if (!is_numeric($value))
                        $value = false;
                }break;
            default:$value = mysql_real_escape_string(trim($value));
                break;
        }


        return $value;
    }

    function GetInfoForLinkTreeByName($id) {
        return $this->db->row_array($this->db->query("SELECT templates.name as namet,templates.*,ns_tree.* FROM ns_tree,templates WHERE templates.id=ns_tree.template_out AND  ns_tree.name='" . $id . "' AND ns_tree.show_me=1;"));
    }

    function GetInfoForLinkTreeById($id) {
        return $this->db->row_array($this->db->query("SELECT ns_tree.id as idnt,templates.name as namet,templates.*,ns_tree.* FROM ns_tree,templates WHERE templates.id=ns_tree.template_out AND  ns_tree.id='" . (int) $id . "' AND ns_tree.show_me=1;"));
    }

    function insertPages($nsdoc, $post) {
        foreach ($post['fields'] as $key => $value)
            $res = $this->db->query("INSERT INTO id_lang_text SET id='" . (int) $key . "',text='" . $value . "', lang='" . $post['lang'] . "'");
        return $res;
    }

    function getInfoDocMod($ns_doc) {
        return $this->db->row_array($this->db->query("SELECT modules.*,ns_doc.* FROM ns_doc,modules WHERE ns_doc.module=modules.class AND ns_doc.id='" . (int) $ns_doc . "'"));
    }

    function getSideMod($ns_doc, $mod, $arg="sc") {
        return $this->db->result_array($this->db->query("SELECT side_module.* FROM side_module,ns_doc,ns_tree WHERE ns_doc.id='" . $ns_doc . "' AND ns_tree.id=ns_doc.father_id AND ns_tree.template_out=side_module.id_template AND side_module.id='" . (string) $mod . "_" . (string) $arg . "';"));
    }

    function insertDoc($id, $mod, $side="module") {
        return $this->db->query("INSERT INTO ns_doc SET date=NOW(), father_id='" . (int) $this->security($id) . "',show_me=1,sch=1,module='" . $this->security($mod) . "',side_for_doc='" . $this->security($side) . "';");
    }

    function getShedule($ns_tree, $intid="", $arg="") {
        if ($intid)
            $arg2 = "OR invert_sc.idint = '" . (int) $intid . "'";
        else
            $arg2 = "OR invert_sc.ns_tree='" . (int) $ns_tree . "'";
        if (!empty($arg))
            $arg1 = " AND ns_doc.module = '" . mysql_real_escape_string(trim($arg)) . "'";

        return $this->db->result_array($this->db->query("SELECT parent.*,modules.*,parent.name as namet,ns_doc.* FROM ns_tree as node,ns_tree as parent,modules,ns_doc WHERE node.id='" . $ns_tree . "' AND parent.rgt >= node.rgt AND parent.lft <= node.lft " . $arg1 . " AND modules.class=ns_doc.module AND modules.schedule=1 AND modules.level_access <= '" . $_SESSION['user']['level_access'] . "' AND parent.id=ns_doc.father_id AND ns_doc.sch=1 AND ns_doc.show_me=1  AND   ns_doc.id NOT IN(SELECT invert_sc.iddoc FROM invert_sc WHERE invert_sc.iddoc=ns_doc.id AND( node.lft  BETWEEN invert_sc.lft AND invert_sc.rgt  " . $arg2 . " ))  ;"));
    }
	
	function deleteNsdoc($ns_doc){
		return $this->db->query("DELETE FROM ns_doc WHERE ns_doc.id=".$ns_doc.";");
	}

}

?>