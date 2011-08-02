<?if(isset($protype['title'])):?>
<h1><?=$protype['title'];?></h1>
<?else:?>
<h1><?=$c_createp;?></h1>
<?endif;?>   <br />
<form  action="<?=$site_dir_full;?>safe_launch/<?=$pt['class'];?>/insertpages/<?=$pt['nsdoc'];?>" method="post">
<input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>">
<select size="1" name="lang">
<?foreach($lang as $key=>$value):?>
  <option value="<?=$value['name'];?>"><?=$value['alias'];?></option>
<?endforeach;?>
</select>
<br /> <br />
<?foreach($pt['descr'] as $key=>$value):?>
<?if($value['editor']):?>
<?=$value['title'];?> <br />
 <textarea cols="<?=$value['col'];?>" class="mceEditor" name="fields[<?=$value['idlang'];?>]">
 </textarea>  <br />
 <a href="javascript:toggleEditor('fields[<?=$value['idlang'];?>]')"><?=$d_sh;?></a>
 <br /><br />
<?else:?>
<?=$value['title'];?> <br />
<input name="fields[<?=$value['idlang'];?>]" size="<?=$value['col'];?>" type="text" value="">
<br /><br />
<?endif;?>
<?endforeach;?>
<br />
<input type="submit" value="<?=$l_insert_pages;?>">
</form>