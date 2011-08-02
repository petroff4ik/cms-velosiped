
   <tr bgcolor="#e0e0e0">
   <td> <?=$id;?>
   </td>
   <td><a href="<?=$admin_dir_full;?>edit_user/<?=$id_user;?>"><?=$name;?></a>
   </td>
   <td><?=$adress;?>
   </td>
   <td><?=$pass;?>
   </td>
   <td align="center"> <a href="#" onclick="alaram('<?=$admin_dir_full;?>s_del_user/<?=$name;?>');return false;"><img src="<?=$path;?>templates/images/del.jpg"  border="0"></a>
   </td>
   </tr>
