  <br />
<h2><?=$s_edit_user;?></h2> <br />
<h3><?=$s_edit_login1;?></h3>

<table>
<form name="" action="<?=$admin_dir_full;?>s_add_login/<?=$id;?>" method="post">
<tr>
<td>
  <?=$s_login;?>
</td>

<td>
 <?=$s_level;?>
</td>

</tr>

<tr>
<td><input name="type" type="text" value="<?=$type;?>"></td>
<td><input name="level" type="text" value="<?=$level;?>"></td>
</tr>
<tr>
<td colspan="2">
<input type="submit" value="<?=$send;?>">
<td>
</tr>
</form>
<tr><td colspan="2">
<input type="submit" value="<?=$del;?>" onclick="alaram('<?=$admin_dir_full;?>s_del_login/<?=$id;?>')">
</td></tr>
<tr>
<td colspan="2">
<form name="" action="<?=$admin_dir_full;?>quit/edit_user" method="post">
<input type="submit" value="<?=$quit;?>">
</form>
</td></tr>
</table>