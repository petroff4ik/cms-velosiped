<?
 class user_auth_model extends add_model_module{

 	function return_login_users(){
     return $this->db->result_array($this->db->query("SELECT type,level,users.name From type_users,users WHERE users.id=type_users.id;"));
	}

    function return_pass($login){
	 $ret=$this->db->result_array($this->db->query("SELECT pass From type_users,users WHERE type_users.type='$login' and type_users.id=users.id"));
	 return $ret [0][pass];
	}

	function return_info_user($login){
     return  $this->db->result_array($this->db->query("SELECT users.adress,users.name,type_users.type,type_users.level From type_users,users WHERE type_users.type='$login' and type_users.id=users.id"));

	}

 }

?>