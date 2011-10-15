<h1><?=$c_edit;?>!</h1>
<br />
 <h3><?=$c_title;?></h3><br />
 <?
   $tags="";//
 ?>
 <?foreach($doc as $key=>$value):?>
  <?
    if($value['type']=="tags_tags") $tags.=",".$value['text'];
     if($value['type']=="tags_title"){ $title=$value['text'];$idt=$value['idlt'];}
     if($value['type']=="tags_metakey"){ $metakey=$value['text'];$id_mk=$value['idlt'];}
     if($value['type']=="tags_metadescr"){ $metadescr=$value['text'];$id_md=$value['idlt'];}
  ?>
 <?endforeach;?>
 <form  action="<?=$admin_dir_full;?>safe_launch/tags/update/<?=$id;?>" method="post">
 <input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>">
 <input name="lang" type="hidden" value="<?=$lang;?>">
 <span><?=$lang_desc;?> <?=$lang;?></span><br /><hr /><br />

  <?=$c_tags;?> <input style="margin-left:30px;" size="41" name="tags_tags" type="text" value="<?=substr($tags,1);?>"><br /><br />

  <?=$c_gtitle;?> <input size="41" name="tags[<?=$idt;?>]" type="text" value="<?=$title;?>"><br /><br />

 <?=$c_meatkeywords;?>:<br />
 <textarea cols="40" rows="3" name="tags[<?=$id_mk;?>]"><?=$metakey;?></textarea> <br /><br />

   <?=$c_meatdescr;?>:<br />
 <textarea cols="40" rows="3" name="tags[<?=$id_md;?>]"><?=$metadescr;?></textarea>
 <br /> <br /> <br /> <br />
 <input type="submit" value="<?=$c_save;?>">
 </form>
