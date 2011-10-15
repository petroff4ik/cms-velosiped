<h1><?=$l_options;?></h1>
<br />
<fieldset>
<legend><?=$l_side;?></legend>
<form action="<?=$admin_dir_full;?>mod_options/<?=$id_module;?>/" method="post">


 <table border="0">

<?foreach($templates as $key=>$value):?>
<tr>
<td> <?=$l_template;?></td> <td> <b><?=$value['name'];?></b></td>
</tr>

<tr>
<td>
<?=$l_title;?>
</td>
<td>
<select size="1" name="title[<?=$value['id'];?>]">

<?foreach($value['side'] as $key2=>$value2):?>
<?if($value2['ids']==$value2['id_side'] && $value2['type']=="tags_title"):?>
  <option value="<?=$value2['ids'];?>"><?=$value2['side'];?></option>
  <? $cur=$value2['ids'];?>
  <?break;?>
  <?endif;?>
<?endforeach;?>

<? $pn="";?>
<option value="--">--</option>
<?foreach($value['side'] as $key2=>$value2):?>
<?if($pn!=$value2['side'] && $value2['ids']!=$cur):?>
<? $pn=$value2['side'];?>
  <option value="<?=$value2['ids'];?>"><?=$value2['side'];?></option>
  <?endif;?>
<?endforeach;?>
</select>
</td>
</tr>

<tr>
<td><?=$l_tags;?></td>
<td>
<select size="1" name="tags[<?=$value['id'];?>]" >
<?foreach($value['side'] as $key2=>$value2):?>
<?if($value2['ids']==$value2['id_side'] && $value2['type']=="tags_tags"):?>
  <option value="<?=$value2['ids'];?>"><?=$value2['side'];?></option>
   <? $cur=$value2['ids'];?>
  <?break;?>
  <?endif;?>
<?endforeach;?>

<? $pn="";?>
<option value="--">--</option>
<?foreach($value['side'] as $key2=>$value2):?>
  <?if($pn!=$value2['side'] && $value2['ids']!=$cur):?>
<? $pn=$value2['side'];?>
  <option value="<?=$value2['ids'];?>"><?=$value2['side'];?></option>
  <?endif;?>
<?endforeach;?>
</select>
</td>
</tr>

<tr>
<td><?=$l_metakey;?></td>
<td>
<select size="1" name="metakey[<?=$value['id'];?>]">
<?foreach($value['side'] as $key2=>$value2):?>
<?if($value2['ids']==$value2['id_side'] && $value2['type']=="tags_metakey"):?>
  <option value="<?=$value2['ids'];?>"><?=$value2['side'];?></option>
   <? $cur=$value2['ids'];?>
  <?break;?>
  <?endif;?>
<?endforeach;?>

<? $pn="";?>
<option value="--">--</option>
<?foreach($value['side'] as $key2=>$value2):?>
 <?if($pn!=$value2['side'] && $value2['ids']!=$cur):?>
<? $pn=$value2['side'];?>
  <option value="<?=$value2['ids'];?>"><?=$value2['side'];?></option>
  <?endif;?>
<?endforeach;?>
</select>
</td>
</tr>

<tr>
<td>
<?=$l_metadescr;?></td>
<td>
<select size="1" name="metadescr[<?=$value['id'];?>]">
<?foreach($value['side'] as $key2=>$value2):?>
<?if($value2['ids']==$value2['id_side'] && $value2['type']=="tags_metadescr"):?>
  <option value="<?=$value2['ids'];?>"><?=$value2['side'];?></option>
   <? $cur=$value2['ids'];?>
  <?break;?>
  <?endif;?>
<?endforeach;?>

<? $pn="";?>
<option value="--">--</option>
<?foreach($value['side'] as $key2=>$value2):?>
  <?if($pn!=$value2['side'] && $value2['ids']!=$cur):?>
<? $pn=$value2['side'];?>
  <option value="<?=$value2['ids'];?>"><?=$value2['side'];?></option>
  <?endif;?>
<?endforeach;?>
</select>
</td>
</tr>
<tr>
<td colspan="2" align="center">--
</td>
</tr>

  <?endforeach;?>
 </table>
<input type="submit" name="save" value="<?=$l_save;?>">
  </fieldset>

  </form>