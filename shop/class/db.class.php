<?

/**
 * @author PetrOFF <andi-fm@ya.ru>
 * 
 * @package DB
 * @category Core
 * 
 * Functio for work database
 * CI foreve :)
 */
class db extends error {

	private $link_id;
	private $query_id;
	private $db_name;
	private $total_time = 0;

	function __construct($hostname="", $user="", $password="", $db="") {
		$this->link_id = mysql_pconnect($hostname, $user, $password);
		if (!$this->link_id && $db != "") {
			$this->show_error("db", "Error connect Mysql or wrong table name.");
		} else {
			if (!mysql_select_db($db, $this->link_id))
				$this->show_error("db", "Not connect");
			$this->db = $db;
		}
		mysql_query("set names " . CHARSET, $this->link_id);
	}

	function __destruct() {
		$this->close();
	}

	function query($string="", $arg=false) {//echo $string."<br /><br />";
		try {
			$time_start = list($sm, $ss) = explode(' ', microtime());
			$string = $this->compile_binds($string, $arg);
			$this->query_id = mysql_query($string, $this->link_id);
			$time_end = list($em, $es) = explode(' ', microtime());
			$this->total_time += ( $em + $es) - ($sm + $ss);
			if (mysql_error())
				throw new Exception("query wrong");
			return mysql_affected_rows();
		} catch (Exception $e) {
			$this->show_error("db", "query wrong", $this->link_id, $e . " <br /><b>" . mysql_error() . "  <br />" . $string . "</b> Time:" . $this->total_time);
		}
	}

	function result_array($query_id="") {
		try {
			if (empty($this->query_id))
				$this->show_error("db", "Empty link query!");
			$res = array();
			for ($i = 0; $i < $this->total_rows($this->query_id); $i++) {
				array_push($res, mysql_fetch_assoc($this->query_id));
			}
			if (mysql_error())
				throw new Exception("result_array error");
			return $res;
		} catch (Exception $e) {
			$this->show_error("db", "result_array error", $this->link_id);
		}
	}

	function row_array() {
		try {
			if (empty($this->query_id))
				$this->show_error("db", "Empty link query!");
			$res = array();
			array_push($res, mysql_fetch_assoc($this->query_id));
			if (mysql_error())
				throw new Exception("row_array error");
			return $res[0];
		} catch (Exception $e) {
			$this->show_error("db", "row_array error", $this->link_id);
		}
	}

	function row_num() {
		try {
			if (empty($this->query_id))
				$this->show_error("db", "Empty link query!");
			$res = array();
			array_push($res, mysql_fetch_row($this->query_id));
			if (mysql_error())
				throw new Exception("row_num error");
			return $res[0];
		} catch (Exception $e) {
			$this->show_error("db", "row_array error", $this->link_id);
		}
	}

	function row($query_id="") {
		if ($query_id != "")
			$this->query_id = $query_id;
		$res = array();
		array_push($res, mysql_fetch_object($this->query_id));
		return $res[0];
	}

	function result_object($query_id="") {
		if ($query_id != "")
			$this->query_id = $query_id;
		$res = array(0);
		for ($i = 0; $i < $this->total_rows($this->query_id); $i++) {
			array_push($res, mysql_fetch_object($this->query_id));
		}
		return $res;
	}

	function total_rows($query_id="") {
		try {
			if ($query_id != "")
				$this->query_id = $query_id;
			$total_rows = mysql_num_rows($this->query_id);
			if (mysql_error())
				throw new Exception("total_rows error");
			return $total_rows;
		} catch (Exception $e) {
			$this->show_error("db", "total_rows error", $this->link_id);
		}
	}

	function close() {
		return mysql_close($this->link_id);
	}

	function retur_ins_id() {
		return mysql_insert_id($this->link_id);
	}

	function take_info($return, $table, $compared_sql, $compared_request) {
		$tmp = $this->result_array($this->query("SELECT $return From $table WHERE $compared_sql='$compared_request' LIMIT 1;"));
		return $tmp [0] [$return];
	}

	function insert($table = '', $set = NULL) {
		if (is_array($set) && !empty($set) && !empty($table)) {
			$set = $this->audit($table, $set);
			if (empty($set)) {
				$this->error("array don't audit insert");
				return;
			}
			$sql = $this->_insert($table, array_keys($set), array_values($set));
			return $this->query($sql);
		} else {
			$this->error("empty table or set: function Insert->db");
		}
	}

	function update($table = '', $set = NULL, $where = NULL) {
		if (is_array($set) && !empty($set) && !empty($table)) {
			$set = $this->audit($table, $set);
			if (empty($set)) {
				$this->error("array don't audit");
				return;
			}
			$sql = $this->_update($table, $set, $where);
			return $this->query($sql);
		} else {
			$this->error("empty table or set : function Update->db");
		}
	}

	function _update($table, $values, $where, $orderby = array(), $limit = FALSE) {
		foreach ($values as $key => $val) {
			$valstr[] = $key . " = " . $val;
		}

		$limit = (!$limit) ? '' : ' LIMIT ' . $limit;

		$orderby = (count($orderby) >= 1) ? ' ORDER BY ' . implode(", ", $orderby) : '';

		$sql = "UPDATE " . $table . " SET " . implode(', ', $valstr);

		$sql .= $orderby . " WHERE " . $where;

		return $sql;
	}

	function _insert($table, $keys, $values) {
		return "INSERT INTO " . $table . " (" . implode(', ', $keys) . ") VALUES (" . implode(', ', $values) . ")";
	}

	function audit($table, $arr) {
		$fields = mysql_list_fields($this->db, $table, $this->link_id);
		$columns = mysql_num_fields($fields);
		$ret = array();
		for ($i = 0; $i < $columns; $i++) {
			$f = mysql_field_name($fields, $i);
			if (array_key_exists($f, $arr)) {
				$ret[$f] = "'" . $arr[$f] . "'";
			}
		}
		return $ret;
	}

	function escape($str) {
		if (is_string($str)) {
			$str = "'" . mysql_real_escape_string(trim($str)) . "'";
		} elseif (is_bool($str)) {
			$str = ($str === FALSE) ? 0 : 1;
		} elseif (is_null($str)) {
			$str = 'NULL';
		}

		return $str;
	}

	function compile_binds($sql, $binds) {
		if (strpos($sql, "?") === FALSE) {
			return $sql;
		}

		if (!is_array($binds)) {
			$binds = array($binds);
		}

		$segments = explode("?", $sql);


		if (count($binds) >= count($segments)) {
			$binds = array_slice($binds, 0, count($segments) - 1);
		}

		$result = $segments[0];
		$i = 0;
		foreach ($binds as $bind) {
			$result .= $this->escape($bind);
			$result .= $segments[++$i];
		}

		return $result;
	}

}

?>