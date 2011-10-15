 <br />
<h2><?=$s_edit_user;?></h2>
<br />
<h3><?=$s_edit_user1;?></h3>

<table>
<tr>
<form name="" action="<?=$admin_dir_full;?>s_add_user/update/<?=$id_user;?>" method="post">
<td>
<?=$s_name;?>
</td>

<td>
 <?=$s_adress;?>
</td>

<td>
 <?=$s_pass;?>
</td>

<td>
 <?=$s_login;?>
</td>

</tr>


<tr>

<td>
<input name="name" type="text" value="<?=$name;?>">
</td>

<td>
   <input name="adress" type="text" value="<?=$adress;?>">
</td>

<td>
   <input name="pass" type="text" value="<?=$pass;?>">
</td>

<td>
   <select size="1" name="type">
      <option value="<?=$type;?>"><?=$type;?></option>
  <?=$select_op;?>
</select>
</td>

</tr>
<tr>

   <td colspan="3"><input type="submit" value="<?=$send;?>"></td>
</tr>

</form>

<tr>

   <td colspan="3"><input type="submit" value="<?=$del;?>" onclick="alaram('<?=$admin_dir_full;?>s_del_user/<?=$name;?>')"></td>
</tr>



<form name="" action="<?=$admin_dir_full;?>quit/edit_user" method="post">

<tr>

   <td colspan="3">  <input type="submit" value="<?=$quit;?>"></td>
</tr>

</form>
</table>