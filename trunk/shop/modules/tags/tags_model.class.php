<?
  class tags_model extends add_model_module{

  function insert($class,$func,$ns_treeid,$post){


    $res=$this->db->query("START TRANSACTION;");
    $this->db->query("INSERT INTO ns_doc SET date=NOW(),father_id='".$ns_treeid."',show_me=1,module='".$class."', side_for_doc='module';");
    $ns_doc=mysql_insert_id();

    $lastid=$this->returnLastId("+");
     foreach($post['tags_title'] as $key=>$value){
     	$this->db->query("INSERT INTO id_lang_text SET text='".mysql_real_escape_string(trim(strip_tags($value)))."', id='".$lastid."' , lang='".$key."',date=NOW();");
     }
     $lastid=$this->returnLastId();
     $this->db->query("INSERT INTO tags_voc SET id_doc='".$lastid."', type='tags_title',pid='".$ns_doc."';");


     $lastid=$this->returnLastId("+");
     foreach($post['tags_metakey'] as $key=>$value){
     	$this->db->query("INSERT INTO id_lang_text SET text='".mysql_real_escape_string(trim(strip_tags($value)))."', id='".$lastid."' , lang='".$key."',date=NOW();");
     }
     $lastid=$this->returnLastId();
     $this->db->query("INSERT INTO tags_voc SET id_doc='".$lastid."', type='tags_metakey',pid='".$ns_doc."';");

     $lastid=$this->returnLastId("+");
     foreach($post['tags_metadescr'] as $key=>$value){
     	$this->db->query("INSERT INTO id_lang_text SET text='".mysql_real_escape_string(trim(strip_tags($value)))."', id='".$lastid."' , lang='".$key."',date=NOW();");
     }
     $lastid=$this->returnLastId();
     $this->db->query("INSERT INTO tags_voc SET id_doc='".$lastid."', type='tags_metadescr',pid='".$ns_doc."';");



     foreach($post['tags_tags'] as $key=>$value){
     $tags_array[$key]=explode(",",$value);
     }
     unset($post['tags_tags']);
     foreach($tags_array as $key=>$value){
     	foreach($value as $key2=>$value2){

     	$post['tags_tags'][$key][]=$value2;
     	}
     }


     $lastid=$this->returnLastId("+");
     $lastidcur=$lastid;
     foreach($post['tags_tags'] as $key=>$value){
     	foreach($value as $key2=>$value2){
     	$this->db->query("INSERT INTO id_lang_text SET text='".$value2."', id='".$lastid."' , lang='".$key."',date=NOW();");
     	$lastid++;
     	}
     	$lastid=$lastidcur;
     }
     $lastid=$this->returnLastId();
     for($i=$lastidcur;$i<=$lastid;$i++){
     $res2=$this->db->query("INSERT INTO tags_voc SET id_doc='".$i."', type='tags_tags',pid='".$ns_doc."';");
     }
      $this->db->query("COMMIT;");
     return $res2;
  }

    function getAllSideTags($id){
     return $this->db->result_array($this->db->query("SELECT * FROM side_site INNER JOIN templates ON templates.id=side_site.id_template AND templates.id='".$id."' LEFT JOIN tags_side ON tags_side.id_side=side_site.ids AND templates.id=tags_side.id_template;"));
    }

    function getAllSideTagsG($id){
     return $this->db->result_array($this->db->query("SELECT * FROM tags_side,side_site WHERE tags_side.id_side=side_site.ids AND side_site.id_template='".$id."' GROUP BY tags_side.type"));
    }

    function deltags_side(){
    return $this->db->query("TRUNCATE TABLE `tags_side`");
    }

    function set_tags_side($post,$class){
    	$res=$this->db->query("START TRANSACTION;");
    	$this->db->query("DELETE FROM side_module WHERE id='".$class."_"."sc"."' OR id='".$class."_"."st"."'");

      foreach($post['title'] as $key=>$value){
      	$this->db->query("INSERT INTO tags_side SET id_template='".$key."',id_side='".$value."',type='tags_title'");
      	 $this->db->query("INSERT INTO side_module VALUE('".$class."_st"."',(SELECT side FROM side_site WHERE ids='".$value."' and id_template='".$key."'),'".$key."');");
      	  $this->db->query("INSERT INTO side_module VALUE('".$class."_sc"."',(SELECT side FROM side_site WHERE ids='".$value."' and id_template='".$key."'),'".$key."');");
      }

       foreach($post['tags'] as $key=>$value){
       	if($key!="--"){
      	$this->db->query("INSERT INTO tags_side SET id_template='".$key."',id_side='".$value."',type='tags_tags'");
      	 $this->db->query("INSERT INTO side_module VALUE('".$class."_st"."',(SELECT side FROM side_site WHERE ids='".$value."' and id_template='".$key."'),'".$key."');");
      	  $this->db->query("INSERT INTO side_module VALUE('".$class."_sc"."',(SELECT side FROM side_site WHERE ids='".$value."' and id_template='".$key."'),'".$key."');");
      	  }
      }

       foreach($post['metakey'] as $key=>$value){
      	$this->db->query("INSERT INTO tags_side SET id_template='".$key."',id_side='".$value."',type='tags_metakey'");
      	 $this->db->query("INSERT INTO side_module VALUE('".$class."_st"."',(SELECT side FROM side_site WHERE ids='".$value."' and id_template='".$key."'),'".$key."');");
      	  $this->db->query("INSERT INTO side_module VALUE('".$class."_sc"."',(SELECT side FROM side_site WHERE ids='".$value."' and id_template='".$key."'),'".$key."');");
      }

         foreach($post['metadescr'] as $key=>$value){
      	$this->db->query("INSERT INTO tags_side SET id_template='".$key."',id_side='".$value."',type='tags_metadescr'");
      	 $this->db->query("INSERT INTO side_module VALUE('".$class."_st"."',(SELECT side FROM side_site WHERE ids='".$value."' and id_template='".$key."'),'".$key."');");
      	  $res2=$this->db->query("INSERT INTO side_module VALUE('".$class."_sc"."',(SELECT side FROM side_site WHERE ids='".$value."' and id_template='".$key."'),'".$key."');");
      }
      $this->db->query("COMMIT;");
      return $res2;
    }


    function get_doc($id,$lang,$search=""){
     if(!empty($search)) $search=" AND id_lang_text.text LIKE '%".$search."%'";
   	return  $this->db->result_array($this->db->query("SELECT ns_doc.show_me,modules.*,ns_doc.side_for_doc,id_lang_text.text,ns_doc.id,id_lang_text.lang,ns_doc.sch FROM modules,id_lang_text,tags_voc,ns_doc WHERE modules.class=ns_doc.module AND ns_doc.id=".$id."  AND ns_doc.id=tags_voc.pid AND  tags_voc.id_doc=id_lang_text.id AND id_lang_text.lang='".$lang."' ".$search." ;"));
   }

    function get_doc2($id,$lang){
   	return  $this->db->result_array($this->db->query("SELECT *,id_lang_text.id as idlt FROM id_lang_text,tags_voc,ns_doc WHERE  ns_doc.id=".$id." AND ns_doc.show_me=1 AND ns_doc.id=tags_voc.pid AND  tags_voc.id_doc=id_lang_text.id AND id_lang_text.lang='".$lang."';"));
   }

   function update($id,$post){
   	$res=$this->db->query("START TRANSACTION;");
    foreach($post['tags'] as $key=>$value){
    $res+=$this->db->query("UPDATE id_lang_text SET  text='".mysql_real_escape_string(trim(strip_tags($value)))."' WHERE id='".$key."' AND lang='".$post['lang']."';");
    }
    //tags
    $this->db->query("COMMIT;");
    return $res;
   }

   function getNdoc(){
   	return $this->db->result_array($this->db->query("SELECT *"));
   }

    function del($id,$lang){
   	if(!empty($lang))
   		 return $this->db->query("DELETE id_lang_text FROM id_lang_text,tags_voc,ns_doc WHERE tags_voc.id_doc=id_lang_text.id  AND tags_voc.pid=".$id."  AND ns_doc.id=tags_voc.pid AND id_lang_text.lang='".$lang."';");
   		 else
   		 return $this->db->query("DELETE id_lang_text,tags_voc,ns_doc FROM id_lang_text,tags_voc,ns_doc WHERE tags_voc.id_doc=id_lang_text.id  AND tags_voc.pid=".$id."  AND ns_doc.id=tags_voc.pid;");
   		}

   	function GetAllDoc($template,$class,$oper,$pid){
     return $this->db->result_array($this->db->query("SELECT * FROM side_module,tags_voc,tags_side,side_site,ns_doc,id_lang_text WHERE side_site.side=side_module.side AND side_module.id_template='".$template."' AND side_site.id_template='".$template."' AND side_module.id='".$class.$oper."' AND side_site.free=1 AND tags_side.id_side=side_site.ids AND tags_side.id_template='".$template."' AND tags_voc.type=tags_side.type AND tags_voc.pid=ns_doc.id AND ns_doc.show_me=1 AND ns_doc.father_id='".$pid."' AND ns_doc.module='tags' AND id_lang_text.id=tags_voc.id_doc AND id_lang_text.lang='".$GLOBALS['lang']."';"));
   	}

   	 function getPagesAbs($ns_doc){
       	 return $this->db->result_array($this->db->query("SELECT * FROM lang LEFT JOIN id_lang_text ON id_lang_text.lang=lang.name AND id_lang_text.id=(SELECT tags_voc.id_doc FROM tags_voc WHERE tags_voc.pid='".$this->security($ns_doc)."' LIMIT 1) WHERE id_lang_text.text is null;"));
       }


       function getIdLang($nsdoc){
       	return $this->db->result_array($this->db->query("SELECT * FROM tags_voc WHERE tags_voc.pid='".$this->security($nsdoc)."'"));
       }

  }
?>