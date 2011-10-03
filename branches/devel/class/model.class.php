<?php

/**
 * @author PetrOFF <andi-fm@ya.ru>
 * 
 * @package Model
 * @category Core
 * Database queries 
 */
class model {

    protected $db;

    function __construct(&$db) {
        $this->db = &$db;
    }

    function get_info($id="", $arg="", $sql="", $table="ns_tree", $arg_sql="id") {
        if ($sql != "") {
            $tmp = $this->db->result_array($this->db->query($sql));
        } else {
            $tmp = $this->db->result_array($this->db->query("SELECT $arg From $table WHERE $arg_sql='$id' LIMIT 1;"));
        };

        if ($arg != "") {
            return $tmp [0] [$arg];
        } else {

            return $tmp;
        }
    }

    function save($id, $name, $show, $postArray, $idAlias) {
        if (isset($postArray['max_short_a']))
            $postArray['max_short_a'] = 1;
        if (isset($postArray['short_a']))
            $postArray['short_a'] = 1;
        $this->db->query("START TRANSACTION;");
        $this->db->query("UPDATE ns_tree SET name='$name', show_me='$show',adress='" . $postArray['adress'] . "',side='" . $postArray['side'] . "',module='" . $postArray['module'] . "',template_out=" . $postArray['template_out'] . ",templates_int='" . $postArray['templates_int'] . "',max_short_a='" . $postArray['max_short_a'] . "',short_a='" . $postArray['short_a'] . "' WHERE id='$id'");
        foreach ($postArray as $key => $value) {
            $this->db->query("UPDATE id_lang_text SET text='" . $value . "' WHERE lang='" . $key . "' AND id='$idAlias';");
        }
        $this->db->query("COMMIT;");
    }

    function save_d($id, $lang, $edit) {
        return $this->db->query("UPDATE id_lang_text SET  text='$edit'  WHERE id='$id' AND lang='$lang'");
    }

    function save_doc($id, $edit, $name, $show) {
        return $this->db->query(" INSERT INTO ns_doc VALUES (0,'$edit',CURDATE(),'$id','$show','$name');");
    }

    function del_cat($id) {
        $this->db->query("BEGIN;");
        $this->db->query("SELECT @treeLeft := lft, @treeRight := rgt, @treeWidth := rgt - lft + 1 FROM ns_tree WHERE id = '$id';");
        $this->db->query("DELETE FROM ns_tree WHERE lft BETWEEN @treeLeft AND @treeRight;");
        $this->db->query("UPDATE ns_tree SET rgt = rgt - @treeWidth WHERE rgt > @treeRight;");
        $this->db->query("UPDATE ns_tree SET lft = lft - @treeWidth WHERE lft > @treeRight;");
        $this->db->query("COMMIT;");
    }

    function registry($class, $name, $schedule, $standby, $side_schedule, $side_standby, $templates, $name_module, $help_an) {
        $this->db->query("INSERT INTO modules VALUES(0,'$class','$name','$schedule','$standby','$side_schedule','$side_standby','$templates','$name_module','$help_an');");
    }

    function create_table($xml, $name) {
        $sql = "CREATE TABLE $name (";
        foreach ($xml->module_database->field as $f) {
            $sql_t.=$f . " " . $f['type'] . " " . $f['modifier'] . " , ";
        }
        $sql.=$sql_t . ")";
        $sql = str_replace(" , )", " )", $sql);
        $this->db->query($sql);
    }

    function return_side_module($arg) {
        return $this->db->result_array($this->db->query("SELECT * From side_module WHERE id='$arg'"));
    }

    function return_task($level=0) {
        if (empty($level))
            $level = 0;
        return $this->db->result_array($this->db->query("SELECT * From modules WHERE  level_access <= " . $level . " order by number_launch;"));
    }

    function return_side($id=0) {
        if ($id == 0) {
            $tmp = $this->db->result_array($this->db->query("SELECT * From side_site WHERE id_template=( SELECT id From templates WHERE show_me=1)"));
        } else {
            $tmp = $this->db->result_array($this->db->query("SELECT * From side_site WHERE id_template='$id'"));
        }
        return $tmp;
    }

    function return_config_mod() {
        $tmp = $this->db->result_array($this->db->query("SELECT * From modules"));
        return $tmp;
    }

    function return_config_mod_by_events() {
        $tmp = $this->db->result_array($this->db->query("SELECT * From modules WHERE s_events='1';"));
        return $tmp;
    }

    function load_cat_modules($arg="id") {
        return $this->db->result_array($this->db->query("SELECT * From modules ORDER BY $arg;"));
    }

    function return_info_model3($arg) {
        return $this->db->row_array($this->db->query("SELECT * From modules WHERE id='$arg'ORDER BY id;"));
    }

    function return_info_model($arg) {
        return $this->db->result_array($this->db->query("SELECT * From modules WHERE id='$arg'ORDER BY id;"));
    }

    function return_info_model2($arg) {
        return $this->db->query("SELECT * From modules WHERE id='$arg'ORDER BY id;");
    }

    function return_info_template() {
        return $this->db->result_array($this->db->query("SELECT * From templates  WHERE show_me=1;"));
    }

    function return_all_templates($opr="") {
        if (empty($opr))
            return $this->db->result_array($this->db->query("SELECT * From templates;"));
        else
            return $this->db->result_array($this->db->query("SELECT * From templates WHERE show_me !='1';"));
    }

    function return_user($id="") {
        if (empty($id))
            return $this->db->result_array($this->db->query("SELECT SQL_CALC_FOUND_ROWS * From users as u, type_users as ut WHERE u.id=ut.id ;"));
        else
            return $this->db->row_array($this->db->query("SELECT * From users as u, type_users as ut WHERE u.id=ut.id and u.id_user='" . $id . "';"));
    }

    function return_user2($pag) {
        return $this->db->result_array($this->db->query("SELECT SQL_CALC_FOUND_ROWS * From users as u, type_users as ut WHERE u.id=ut.id LIMIT $pag," . LIMIT_DB . ";"));
    }

    function return_element($arg) {
        if ($arg)
            return $this->db->result_array($this->db->query("SELECT * From form_level WHERE id_level='$arg'"));
        else
            return $this->db->result_array($this->db->query("SELECT * From form_level"));
    }

    function save_element($url, $level, $name, $id_level) {
        $this->db->query("INSERT INTO form_level VALUES(0,'$url','$level','$name','$id_level')");
    }

    function return_level_form($url) {
        return $this->db->result_array($this->db->query("SELECT level From form_level where url='$url'"));
    }

    function save_level($lv, $id) {
        $this->db->query("UPDATE form_level SET level='$lv' WHERE id='$id';");
    }

    function return_user_type($id="") {
        if ($id == "") {
            return $this->db->result_array($this->db->query("SELECT * From type_users ;"));
        } else {
            return $this->db->result_array($this->db->query("SELECT * From type_users WHERE id='$id';"));
        }
    }

    function save_user($name, $adress, $pass, $type, $name_p, $oper="insert") {
        if ($oper == "insert") {
            return $this->db->query("INSERT INTO users VALUES('$name','$adress','" . md5($pass) . "',(SELECT id From type_users WHERE type='$type'),0);");
        } else {
            $user = $this->db->row_array($this->db->query("SELECT * FROM users WHERE users.id_user='" . $name_p . "'"));
            if ($user['pass'] != $pass)
                return $this->db->query("UPDATE users SET name='$name', adress='$adress', pass='" . md5($pass) . "', id=(SELECT id From type_users WHERE type='$type')  WHERE id_user='" . $name_p . "'");
            else
                return $this->db->query("UPDATE users SET name='$name', adress='$adress',  id=(SELECT id From type_users WHERE type='$type')  WHERE id_user='" . $name_p . "'");
        }
    }

    function del_user($name) {
        $this->db->query("DELETE FROM users WHERE name='$name';");
    }

    function save_login($login, $level, $id="insert") {
        $res = $this->db->query("START TRANSACTION;");
        if ($id == "insert") {
            $this->db->query("INSERT INTO type_users VALUES(0,'$login','$level');");
        } else {
            $this->db->query("UPDATE type_users SET type='$login',level='$level' WHERE id='$id' ;");
        }
        return $this->db->query("COMMIT;");
    }

    function del_login($id) {
        $this->db->query("DELETE FROM type_users WHERE id='$id';");
    }

    function save_side_l_un($name, $arg, $id) {
        if ($arg)
            $arg = 0;
        else
            $arg=1;
        $this->db->query("UPDATE side_site SET free='$arg' WHERE side='$name' and id_template='$id'");
    }

    function save_side($name, $id) {
        $this->db->query("INSERT INTO side_site SET side='" . $name . "',free=1,id_template='" . $id . "';");
    }

    function save_tmp_inf($id, $id_n, $path_file, $name, $show_me) {
        $this->db->query("START TRANSACTION;");
        $this->db->query("UPDATE templates SET show_me='0';");
        $this->db->query("UPDATE templates SET id='$id_n', name='$name',path_file='$path_file', show_me='$show_me'   WHERE id='$id';", true);
        return $this->db->query("COMMIT;");
    }

    function tem_del_side($side, $id) {
        $this->db->query("DELETE FROM side_site WHERE side='$side' AND id_template='$id' ");
    }

    function registry_template($name, $name_project, $path_file, $path_small_img, $show_me) {
        $this->db->query("INSERT INTO templates VALUE(0,'$path_file','$name','$show_me','$path_small_img','$name_project')");
    }

    function del_templates($p_n) {
        $this->db->query("DELETE From templates WHERE name_project='$p_n'");
    }

    function query_pagination($pag, $sm, $oper, $arg, $lang, $search) {
        if (!empty($search))
            $sql_oper = " AND text LIKE'%" . mysql_real_escape_string($search) . "%'";
        if ($oper == "doc_img_id")
            $sql_oper.=" ORDER BY id ";
        else
            $sql_oper.=" ORDER BY date ";

        if ($arg == "up")
            $sql_oper.=" DESC  ";
        else
            $sql_oper.=" ASC ";
        return $this->db->result_array($this->db->query("SELECT SQL_CALC_FOUND_ROWS * From id_lang_text WHERE lang='$lang' " . $sql_oper . "LIMIT $pag,$sm;"));
    }

    function get_doc($id, $lang) {
        $tmp = $this->db->result_array($this->db->query("SELECT text From id_lang_text WHERE id='$id' AND lang='$lang'"));
        return $tmp [0]['text'];
    }

    function save_mod_optoins($id, $class, $name, $ins, $help, $sch, $stn, $tem, $even, $nl, $la, $arr) {
        $this->db->query("START TRANSACTION;");
        $this->db->query("UPDATE modules SET id='$id', class='$class', name='$name',help_annotation='$help', schedule='$sch',  templates='$tem', name_module='$ins', events='$even', number_launch='$nl', level_access='$la' WHERE id='$id'");
        $this->db->query("DELETE FROM side_module WHERE id='" . $class . "_" . "sc" . "' OR id='" . $class . "_" . "st" . "' OR id='" . $class . "_" . "ev" . "';");

        if (!empty($arr['sc']))
            foreach ($arr['sc'] as $keys => $values) {
                foreach ($values as $key => $value)
                    $this->db->query("INSERT INTO side_module VALUE('" . $class . "_sc" . "','" . $value . "','" . $key . "');");
            }

        if (!empty($arr['ev']))
            foreach ($arr['ev'] as $keys => $values) {
                foreach ($values as $key => $value)
                    $this->db->query("INSERT INTO side_module VALUE('" . $class . "_ev" . "','" . $value . "','" . $key . "');");
            }
        return $this->db->query("COMMIT;");
    }

    function module_nl($id, $arg) {

        if ($arg == "up")
            $arg = "+1";
        else
            $arg="-1";
        $this->db->query("BEGIN;");
        $this->db->query("SELECT @nl1 := number_launch,@nl3 := number_launch   FROM modules  WHERE id='$id';");
        $this->db->query("SELECT @nl2 := number_launch,@id2 :=id   FROM modules  WHERE number_launch=@nl1 {$arg} ;");
        $this->db->query("UPDATE modules SET number_launch=@nl2  WHERE id='$id';");
        $this->db->query("UPDATE modules SET number_launch=@nl3  WHERE id=@id2;");
        $this->db->query("COMMIT;");
    }

    function return_max_level() {
        return $this->db->result_array($this->db->query("SELECT MAX(level) AS level FROM type_users"));
    }

    function GetALLModulesForPage($id) {
        return $this->db->result_array($this->db->query("SELECT modules.*,ns_doc.*,id_lang_text.*,doc_view.id as idg FROM modules,ns_doc,ns_tree,id_lang_text,doc_view WHERE   ns_doc.father_id='$id' AND ns_doc.module=modules.class AND ns_tree.id=ns_doc.father_id AND doc_view.id=ns_doc.id AND doc_view.text=id_lang_text.id ;"));
    }

    function GetModelFroCreate() {
        return $this->db->result_array($this->db->query("SELECT * FROM modules WHERE s_create=1"));
    }

    function showHideDoc($id, $arg) {
        return $this->db->query("UPDATE ns_doc SET show_me=" . $arg . " WHERE id='$id'");
    }

    function saveSideDoc($id, $side) {
        return $this->db->query("UPDATE ns_doc SET side_for_doc='" . $side . "' WHERE id=" . $id . "");
    }

    function GetAllAliasForLink($id) {
        return $this->db->result_array($this->db->query("SELECT langDoc.* FROM ns_tree left join id_lang_text as langDoc ON ns_tree.alias=langDoc.id WHERE ns_tree.id='$id' ORDER BY langDoc.lang ;"));
    }

    function GetInfoForLinkTree($id) {
        return $this->db->row_array($this->db->query("SELECT *,ns_tree.id as id FROM ns_tree,id_lang_text WHERE id_lang_text.lang='" . $GLOBALS['lang'] . "' AND id_lang_text.id=ns_tree.alias AND  ns_tree.id='$id'"));
    }

    function returnLink($id, $order, $vector, $pag, $search="", $mod_order="") {
        if (empty($mod_order) || $mod_order == "none" || strpos($mod_order, "-doc-") === false)
            $mod_order = "";
        else
            $mod_order=" AND mod_order='" . substr($mod_order, 5) . "'";

        if (empty($search) || $search == "none")
            return $this->db->result_array($this->db->query("SELECT SQL_CALC_FOUND_ROWS modules.*,ns_doc.* FROM ns_doc,ns_tree,modules WHERE ns_doc.father_id = ns_tree.id AND ns_tree.id=" . $id . " AND modules.class=ns_doc.module " . $mod_order . " ORDER BY " . mysql_real_escape_string(trim(substr($order, 0, 13))) . " " . mysql_real_escape_string(trim(substr($vector, 0, 4))) . " LIMIT " . $pag . "," . LIMIT_DB . ";"));
        else
            return $this->db->result_array($this->db->query("SELECT SQL_CALC_FOUND_ROWS modules.*,ns_doc.* FROM ns_doc,ns_tree,modules WHERE ns_doc.father_id = ns_tree.id AND ns_tree.id=" . $id . " AND modules.class=ns_doc.module " . $mod_order . " ORDER BY " . mysql_real_escape_string(trim(substr($order, 0, 13))) . " " . mysql_real_escape_string(trim(substr($vector, 0, 4))) . " ;"));
    }

    function GetInfoForLinkTreeAndModule($id) {
        return $this->db->row_array($this->db->query("SELECT ns_tree.*,modules.* FROM ns_tree,modules WHERE modules.class=ns_tree.module AND ns_tree.name='" . $id . "'"));
    }

    function GetInfoForLinkTreeByName($id) {
        return $this->db->row_array($this->db->query("SELECT  modules.*,  templates.name as namet,templates.*,ns_tree.*,ns_tree.id as idnt FROM ns_tree,templates,modules WHERE modules.class=ns_tree.module AND templates.id=ns_tree.template_out AND  ns_tree.name='" . $id . "' AND ns_tree.show_me=1 AND modules.events=1;"));
    }

    function GetInfoForLinkTreeById($id) {
        return $this->db->row_array($this->db->query("SELECT modules.*, ns_tree.id as idnt,templates.name as namet,templates.*,ns_tree.*,ns_tree.id as idnt FROM ns_tree,templates,modules WHERE modules.class=ns_tree.module AND templates.id=ns_tree.template_out AND  ns_tree.id='" . $id . "' AND ns_tree.show_me=1 AND modules.events=1;"));
    }

    function returnFreeLink() {
        return $this->db->result_array($this->db->query("SELECT ns_doc.* FROM ns_doc LEFT JOIN ns_tree ON ns_doc.father_id = ns_tree.id WHERE ns_tree.id IS  NULL"));
    }

    function add_doc($id_ns_tree, $id_ns_doc) {
        return $this->db->query("UPDATE ns_doc SET father_id='" . $id_ns_tree . "' WHERE id='" . $id_ns_doc . "'");
    }

    function uncouplingDoc($id) {
        return $this->db->query("UPDATE ns_doc SET father_id='0' WHERE id='" . $id . "'");
    }

    function saveDateNsdoc($ns, $post) {
        return $this->db->query("UPDATE ns_doc SET date='" . $post['ns_doc_date'] . "' WHERE id='" . $ns . "'");
    }

    function GetFoundRows() {
        $query = $this->db->query("SELECT FOUND_ROWS();");
        $query = $this->db->row_array($query);
        return $query['FOUND_ROWS()'];
    }

    function getAllModuleAndNs_tree() {
        return $this->db->result_array($this->db->query("SELECT templates.name as namet,templates.*,modules.name as namefunc,modules.*,ns_tree.*,ns_tree.id as idnt FROM modules LEFT JOIN ns_tree ON modules.class=ns_tree.module LEFT JOIN templates  ON  templates.id=ns_tree.template_out   ORDER BY number_launch; "));
    }

    function getLangPages($id) {
        return $this->db->result_array($this->db->query("SELECT * FROM lang LEFT JOIN id_lang_text ON id_lang_text.lang=lang.name AND id_lang_text.id='" . $id . "' WHERE id_lang_text.id IS NULL;"));
    }

    function insertPages($post) {
        return $this->db->insert("id_lang_text", $post);
    }

    function delnsdoc($nsdoc) {
        $this->delInventor($nsdoc);
        return $this->db->query("DELETE  FROM ns_doc WHERE id='" . $nsdoc . "'");
    }

    function getAllNstree() {
        return $this->db->result_array($this->db->query("SELECT * FROM id_lang_text,ns_tree WHERE ns_tree.alias=id_lang_text.id AND id_lang_text.lang='" . $GLOBALS['lang'] . "';"));
    }

    function getShedule($ns_tree, $intid="") {
        if ($intid)
            $arg = "OR invert_sc.idint = '" . (int) $intid . "'";
        else
            $arg = "OR invert_sc.ns_tree='" . (int) $ns_tree . "'";
        return $this->db->result_array($this->db->query("SELECT parent.*,modules.*,parent.name as namet,ns_doc.* FROM ns_tree as node,ns_tree as parent,modules,ns_doc WHERE node.id='" . $ns_tree . "' AND parent.rgt >= node.rgt AND parent.lft <= node.lft AND modules.class=ns_doc.module AND modules.schedule=1 AND modules.level_access <= '" . $_SESSION['user']['level_access'] . "' AND parent.id=ns_doc.father_id AND ns_doc.sch=1 AND ns_doc.show_me=1  AND   ns_doc.id NOT IN(SELECT invert_sc.iddoc FROM invert_sc WHERE invert_sc.iddoc=ns_doc.id AND( node.lft  BETWEEN invert_sc.lft AND invert_sc.rgt  " . $arg . " ))  ;"));
    }

    function getShedule2($ns_tree) {
        return $this->db->result_array($this->db->query("SELECT parent.*,modules.*,parent.name as namet,ns_doc.* FROM ns_tree as node,ns_tree as parent,modules,ns_doc WHERE node.id='" . $ns_tree . "' AND ns_doc.father_id !='" . $ns_tree . "' AND parent.rgt >= node.rgt AND parent.lft <= node.lft AND modules.class=ns_doc.module AND modules.schedule=1 AND modules.level_access <= '" . $_SESSION['user']['level_access'] . "' AND parent.id=ns_doc.father_id AND ns_doc.sch=1  AND   ns_doc.id NOT IN(SELECT invert_sc.iddoc FROM invert_sc WHERE  (node.lft  BETWEEN invert_sc.lft AND invert_sc.rgt) OR  (invert_sc.ns_tree='" . $ns_tree . "' AND invert_sc.iddoc=ns_doc.id))  ;"));
    }

    function getSheduleAll($ns_tree) {
        return $this->db->result_array($this->db->query("SELECT parent.*,modules.*,parent.name as namet,ns_doc.* FROM ns_tree as node,ns_tree as parent,modules,ns_doc WHERE node.id='" . $ns_tree . "' AND parent.rgt >= node.rgt AND parent.lft <= node.lft AND modules.class=ns_doc.module AND modules.schedule=1 AND modules.level_access <= '" . $_SESSION['user']['level_access'] . "' AND parent.id=ns_doc.father_id AND ns_doc.sch=1 AND ns_doc.show_me=1 AND   ns_doc.id NOT IN(SELECT invert_sc.iddoc FROM invert_sc WHERE invert_sc.iddoc=ns_doc.id AND( node.lft  BETWEEN invert_sc.lft AND invert_sc.rgt   ))  ;"));
    }

    function updateOpDb($val) {
        $this->db->query($val);
    }

    function getInvertor($id) {
        return $this->db->result_array($this->db->query("SELECT invert_sc.*,modules.*,ns_doc.*,invert_sc.id as idint FROM ns_tree,invert_sc,modules,(SELECT ns_doc.* FROM ns_tree as node,ns_tree as parent,ns_doc WHERE ns_doc.father_id=parent.id AND node.id='" . $id . "' AND ns_doc.sch=1 AND parent.rgt >= node.rgt AND parent.lft <= node.lft  ) as ns_doc WHERE ns_doc.module=modules.class AND ns_tree.id='" . $id . "' AND ((ns_tree.lft BETWEEN invert_sc.lft AND invert_sc.rgt) OR (invert_sc.ns_tree='" . $id . "' AND invert_sc.iddoc=ns_doc.id)) group by invert_sc.id;"));
    }

    function getInvertor2($id) {
        return $this->db->row_array($this->db->query("SELECT * FROM invert_sc WHERE id='" . $id . "';"));
    }

    function delInventor($ns_doc) {

        return $this->db->query("DELETE FROM invert_sc WHERE iddoc='" . $ns_doc . "';");
    }

    function getInvertAll() {
        return $this->db->result_array($this->db->query("SELECT * FROM modules,ns_doc,invert_sc WHERE invert_sc.iddoc = ns_doc.id AND ns_doc.module=modules.class;"));
    }

    function getArea($rgt, $lft) {
        return $this->db->row_array($this->db->query("SELECT * FROM ns_tree,id_lang_text WHERE ns_tree.lft='" . $lft . "' AND ns_tree.rgt='" . $rgt . "' AND ns_tree.alias=id_lang_text.id AND id_lang_text.lang='" . $GLOBALS['lang'] . "';"));
    }

    function returnScModAll() {
        return $this->db->result_array($this->db->query("SELECT * FROM ns_tree,id_lang_text,modules,ns_doc WHERE ns_doc.sch=1 AND ns_doc.module=modules.class AND ns_tree.id=ns_doc.father_id AND id_lang_text.id=ns_tree.alias AND id_lang_text.lang='" . $GLOBALS['lang'] . "';"));
    }

    function insertInv($post) {
        if (!empty($post['lr'])) {
            $lr = explode("|", $post['lr']);
            $post['lft'] = $lr[0];
            $post['rgt'] = $lr[1];
        }
        unset($post['lr']);
        return $this->db->insert("invert_sc", $post);
    }

    function updateInv($id, $post) {
        if (!empty($post['lr'])) {
            $lr = explode("|", $post['lr']);
            $post['lft'] = $lr[0];
            $post['rgt'] = $lr[1];
        } else {
            $post['lft'] = 0;
            $post['rgt'] = 0;
        }
        unset($post['lr']);
        return $this->db->update("invert_sc", $post, " id=" . $id);
    }

    function delInv($id) {
        return $this->db->query("DELETE FROM invert_sc WHERE id='" . $id . "';");
    }

    function createinvfordoc($idint, $post) {
        $post['idint'] = $idint;
        return $this->insertInv($post);
    }

    function getNs_doc($id) {
        return $this->db->row_array($this->db->query("SELECT * FROM ns_doc WHERE id=" . (int) $id . ";"));
    }

    function getCurentInventor($iddoc) {
        return $this->db->row_array($this->db->query("SELECT * FROM invert_sc WHERE idint = " . (int) $iddoc . ";"));
    }

    /* Clear db
      DELETE id_lang_text FROM   id_lang_text left join sys_info on sys_info.id_lang=id_lang_text.id WHERE sys_info.id_lang is null;
      TRUNCATE TABLE catalogp;
      TRUNCATE TABLE ns_doc;
      TRUNCATE TABLE ns_tree;
      TRUNCATE TABLE tags_side;
      TRUNCATE TABLE tags_voc;
      TRUNCATE TABLE `doc_view`;
     */
}

?>