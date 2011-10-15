<h1><?=$c_create;?>!</h1>
<br />
 <h3><?=$c_title;?></h3><br />

<form action='<?=$admin_dir_full;?>safe_launch/tags/insert/<?=$id;?>' method='post' >

 <input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>">

 <?foreach($lang_arr as $key=>$value):?>
 <span><?=$lang_desc;?> <?=$value['alias'];?></span><br /><hr /><br />

  <?=$c_tags;?> <input style="margin-left:30px;" size="41" name="tags_tags[<?=$value['name'];?>]" type="text" value=""><br /><br />

  <?=$c_gtitle;?> <input size="41" name="tags_title[<?=$value['name'];?>]" type="text" value=""><br /><br />

 <?=$c_meatkeywords;?>:<br />
 <textarea cols="40" rows="3" name="tags_metakey[<?=$value['name'];?>]"></textarea> <br /><br />

   <?=$c_meatdescr;?>:<br />
 <textarea cols="40" rows="3" name="tags_metadescr[<?=$value['name'];?>]"></textarea>
 <br /> <br /> <br /> <br />
 <?endforeach;?>
   <input type="submit" value="<?=$c_create;?>">
 </form>
