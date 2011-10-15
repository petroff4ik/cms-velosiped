<h1><?=$l_lang;?></h1>

<br />
 <table  cellspacing="3">
 <tr bgcolor="#BDBDBD">
 <td><?=$l_id;?>
 </td>
  <td><?=$l_name;?>
 </td>
  <td><?=$l_alias;?>
 </td>
 <td> <?=$l_save;?>
 </td>
   <td> <?=$l_ch_def;?>
 </td>
 <td><?=$l_del;?>
 </td>

</tr>
<?=$body_lang;?>
</table>
<br /><br />
<form  action="<?=$admin_dir_full;?>l_add" method="post">
  <table>
  <tr>
  	<td>
  	<?=$l_name;?>
  	</td>
  	<td>
  	<?=$l_alias;?>
  	</td>
  </tr>
  <tr>
  <td>
 <input name="name" type="text" value="">
 </td>

 <td>
 <input name="alias" type="text" value="">
 </td>
 </tr>
 <tr>
 <td colspan="2">
 <input type="submit" value="<?=$l_add;?>">
 </td>
 </tr>
 </table>
</form>