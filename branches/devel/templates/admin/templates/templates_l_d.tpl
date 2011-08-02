<h2><?=$tem_load_del;?></h2>
<table  cellspacing="3"  border="0" >
<tr bgcolor="#BDBDBD">
 <td>
 <?=$tem_name;?>
 </td>
 <td>
 <?=$tem_del;?>
 </td>
</tr>
<?=$tr;?>
</table>
<br />
<form name="" action="<?=$admin_dir_full;?>load_files/templates" method="post" enctype="multipart/form-data">
<?=$tem_load;?>
  <input name="userfile" type="file" value="">
  <input type="submit" value="<?=$m_send;?>">
</form>