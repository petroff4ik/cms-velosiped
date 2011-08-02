<tr bgcolor="#e0e0e0">
<form action="<?=$admin_dir_full;?>l_save_info/<?=$id;?>" method="post">
<td><input name="id" type="text" value="<?=$id;?>">
</td>

<td><input name="name" type="text" value="<?=$name;?>">
</td>

<td><input name="alias" type="text" value="<?=$alias;?>">
</td>
<td align='center'><input type="submit" value="<?=$l_send;?>">
</td>

</form>
<td align='center'>

<?=$l_ch_def_td;?>

</td>
<td align="center">
 <a href="#" onclick="alaram('<?=$admin_dir_full;?>l_del/<?=$id;?>');return false;"><img src="<?=$path;?>templates/images/del.jpg"   border="0"></a>
</td>
</tr>
