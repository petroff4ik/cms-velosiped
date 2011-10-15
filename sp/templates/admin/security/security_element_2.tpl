<h2><?=$s_element;?></h2>
<a href="<?=$admin_dir_full;?>element"><?=$s_all_list;?></a>&nbsp;&nbsp;<?=$s_cat_list;?> <br /><br />
 <table  cellspacing="3" >
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
 <table>
 <form name="" action="<?=$admin_dir_full;?>save_element" method="post">
  <tr>
 <td><?=$s_el_url;?></td><td><?=$s_el_level;?></td> <td><?=$s_el_name;?></td><td><?=$s_id_level;?></td>
</tr>
 <tr>
 <td>
 <input name="url" type="text" value="">
 </td>
 <td>
 <input name="level" type="text" value="">
 </td>
 <td>
 <input name="name" type="text" value="">
 </td>
 <td>
 <input name="id_level" type="text" value="<?=$id;?>">
 </td>
 <tr>
 <td colspan="4">
 <input type="submit" value="<?=$send;?>">
 </td>
 </tr>
 </tr>
</form>
</table>
