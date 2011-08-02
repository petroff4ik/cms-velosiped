<h1><?=$c_create2;?>!</h1>
<br />
 <h3><?=$c_title;?></h3><br />

<form action='<?=$admin_dir_full;?>safe_launch/news/insert/<?=$id;?>' method='post' >

 <input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>">

 <?foreach($lang_arr as $key=>$value):?>
 <span><?=$lang_desc;?> <?=$value['alias'];?></span><br /><hr /><br />

  <?=$c_gtitle;?> <input size="41" name="title[<?=$value['name'];?>]" type="text" value=""><br /><br />

 <?=$c_shortdescr;?>:<br />
 <textarea cols="40" rows="3" name="shortdescr[<?=$value['name'];?>]"></textarea> <br /><br />

   <?=$c_body;?>:<br />
 <textarea cols="40" rows="15"  class="mceEditor" name="body[<?=$value['name'];?>]"></textarea><br />
 <a href="javascript:toggleEditor('body[<?=$value['name'];?>]')"><?=$d_sh;?></a>
 <br />  <br /> <br /> <br />
 <?endforeach;?>
 <?=$l_side;?>
 <select size="1" name="sidedoc">
   <?foreach($side As $key2=>$value2):?>
  <option value="<?=$value2['side'];?>"><?=$value2['side'];?></option>
  <?endforeach;?>
</select>

   <input type="submit" value="<?=$c_create;?>">
 </form>
