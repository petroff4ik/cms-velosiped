<h2><? echo $l_comname;?></h2> <?=$fgf;?>
<br />
<b><?=@$res;?></b>

<form  action="<?=$admin_dir_full;?>mod_options/<?=$id_module;?>" method="post">
<fieldset>
<legend><?=$lbymod;?></legend>
<?=$l_mod;?>&nbsp;
<select size="1" name="class_id">
<?foreach($mod as $key=>$value):?>
 <option value="<?=$value['id'];?>"><?=$value['class'];?></option>
<?endforeach;?>
</select>
<?=$l_func;?>&nbsp;<input name="func" type="text" value=""> <?=$l_int;?>&nbsp;<input name="iid" type="text" value="">  <?=$l_rek;?>&nbsp;<input name="rec" type="checkbox" value="1">
 <input name="show_me" type="hidden" value="1">
<br /><br />
<input  name="insert_mod" type="submit" value="<?=$l_save;?>">
</fieldset>
</form>


<form  action="<?=$admin_dir_full;?>mod_options/<?=$id_module;?>" method="post">
<fieldset>
<legend><?=$l_bytree;?></legend>
<?=$l_tree;?>&nbsp;
 <select size="1" name="tree_id">
<?foreach($tree as $key=>$value):?>
 <option value="<?=$value['id'];?>"><?=$value['text'];?></option>
<?endforeach;?>
</select>
<?=$l_rek;?>&nbsp;<input name="rec" type="checkbox" value="1">
<input name="show_me" type="hidden" value="1">
<br />   <br />
 <input name="insert_tree" type="submit" value="<?=$l_save;?>">
</fieldset>
</form>

<br /><br />
<hr />  <br />

<table cellspacing="1" cellpadding="3" border="1"  rules="all" >
 <tr>

 <td><?=$l_mod;?> / <?=$l_tree;?>
 </td>

 <td><?=$l_func;?>
  </td>

   <td><?=$l_int;?>
  </td>

   <td><?=$l_rek;?>
  </td>

   <td>
   <?=$l_show_me;?>
  </td>

  <td>
   <?=$l_del;?>
  </td>

 </tr>

 <?foreach($cp as $key=>$value):?>
 <tr>
 <td><?=$value['class'];?>
 </td>

  <td><?=$value['func'];?>
 </td>

  <td><?=$value['iid'];?>
 </td>

  <td><?=$value['rec'];?>
 </td>

  <td>
  <form  action="<?=$admin_dir_full;?>mod_options/<?=$id_module;?>/<?=$value['id'];?>"  method="post">
  <?if($value['show_me']):?>
  <input name="show_me" type="hidden" value="0">
    <input name="update_c" type="submit" value="<?=$l_hides;?>">
  <?else:?>
   <input name="update_c" type="submit" value="<?=$l_shows;?>">
    <input name="show_me" type="hidden" value="1">
  <?endif;?>
</form>
 </td>
 <td>
 <a onclick="return confirm('<?=$l_del;?>');return false;"  href="<?=$admin_dir_full;?>mod_options/<?=$id_module;?>/<?=$value['id'];?>/del"><img src="/templates/images/del.jpg"  border="0"></a>
 </td>
 </tr>
 <?endforeach;?>
  <?foreach($cp2 as $key=>$value):?>
 <tr>
 <td><?=$value['text'];?>
 </td>
   <td><?=$value['func'];?>
 </td>

  <td><?=$value['iid'];?>
 </td>

  <td><?=$value['rec'];?>
 </td>

  <td>
  <form  action="<?=$admin_dir_full;?>mod_options/<?=$id_module;?>/<?=$value['id'];?>"  method="post">
  <?if($value['show_me']):?>
    <input name="update_c" type="submit" value="<?=$l_hides;?>">
     <input name="show_me" type="hidden" value="0">
  <?else:?>
   <input name="update_c" type="submit" value="<?=$l_shows;?>">
    <input name="show_me" type="hidden" value="1">
  <?endif;?>
</form>
 </td>
  <td>
 <a onclick="return confirm('<?=$l_del;?>');"  href="<?=$admin_dir_full;?>mod_options/<?=$id_module;?>/<?=$value['id'];?>/del"><img src="/templates/images/del.jpg"  border="0"></a>
 </td>
 </tr>
 <?endforeach;?>
</table>