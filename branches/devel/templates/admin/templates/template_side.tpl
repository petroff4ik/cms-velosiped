<h2><?=$tem_side;?> </h2>
<div style="float:left;padding:10px;">
<table  cellspacing="3" border="0" >
<tr bgcolor="#BDBDBD">
  <td>
  <?=$tem_side;?>
  </td>
  <td>
  <?=$tem_opt;?>
  </td>
  <td>
  <?=$tem_del;?>
  </td>

</tr>

<?=$tr;?>
</table>
 </div>


 <div style="padding:10px;">
 <table  cellspacing="3"  border="0" >
 <tr bgcolor="#BDBDBD">
 <td><?=$tem_all;?>
 </td>
 </tr>
 <?=$tr_tem;?>
 </table>
 </div>
<br />
<div style="clear:both">
<form name="" action="<?=$admin_dir_full;?>tem_add_s/<?=$id;?>" method="post">
<?=$tem_add_side;?>
<input name="name" size="10" type="text" value="">
<input type="submit" value="<?=$send;?>">
</form>
</div>
