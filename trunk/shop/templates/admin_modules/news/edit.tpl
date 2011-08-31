<h1><?=$c_edi2;?>!</h1>
<br />
 <h3><?=$c_title;?></h3><br />

<form action='<?=$admin_dir_full;?>safe_launch/news/update/<?=$doc[0]['id'];?>' method='post' >

 <input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>">
 <input name="lang" type="hidden" value="<?=$doc[0]['lang'];?>">

 <span><?=$lang_desc;?> <?=$doc[0]['lang'];?></span><br /><hr /><br />

  <?=$c_gtitle;?> <input size="41" name="arr[<?=$doc[0]['idl'];?>]" type="text" value="<?=$doc[0]['text'];?>"><br /><br />

 <?=$c_shortdescr;?>:<br />
 <textarea cols="40" rows="3" name="arr[<?=$doc[1]['idl'];?>]"><?=$doc[1]['text'];?></textarea> <br /><br />

   <?=$c_body;?>:<br />
 <textarea cols="40" rows="15"  class="mceEditor" name="arr[<?=$doc[2]['idl'];?>]"><?=$doc[2]['text'];?></textarea><br />
 <a href="javascript:toggleEditor('arr[<?=$doc[2]['idl'];?>]')"><?=$d_sh;?></a>
 <br />  <br /> <br /> <br />
 <?=$l_side;?>
 <select size="1" name="sidedoc">
     <option value="<?=$doc[0]['side_for_doc'];?>"><?=$doc[0]['side_for_doc'];?></option>
   <?foreach($side As $key2=>$value2):?>
   <?if($value2['side']!=$doc[0]['side_for_doc']):?>
  <option value="<?=$value2['side'];?>"><?=$value2['side'];?></option>
  <?endif;?>
  <?endforeach;?>
</select>

   <input type="submit" value="<?=$c_edit;?>">
 </form>
