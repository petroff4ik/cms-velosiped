<h2><?=$s_element;?></h2>
<?=$s_all_list;?>&nbsp;&nbsp;<a href="<?=$admin_dir_full;?>element/0"><?=$s_cat_list;?></a> <br ><br />
 <table  cellspacing="3">
  <tr bgcolor="#BDBDBD">
    <td><?=$s_el_id;?>
    </td>
    <td><?=$s_el_url;?>
    </td>
    <td><?=$s_el_level;?>
    </td>
     <td><?=$s_el_name;?>
    </td>
  </tr>
      <?=$tr;?>
 </table>

 <br />
 <form name="" action="<?=$admin_dir_full;?>save_element" method="post">
 |<?=$s_el_url;?> | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<?=$s_el_level;?>  |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<?=$s_el_name;?>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<?=$s_id_level;?>|<br />
 <input name="url" type="text" value="">

 <input name="level" type="text" value="">

 <input name="name" type="text" value="">
  <input name="id_level" type="text" value="">
 <input type="submit" value="<?=$send;?>">
</form>