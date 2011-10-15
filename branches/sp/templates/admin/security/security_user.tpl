<h2><?=$s_user;?> </h2>
 <table  cellspacing="3" >
   <tr bgcolor="#BDBDBD">
   <td> <?=$s_id;?>
   </td>
   <td><?=$s_name;?>
   </td>
   <td><?=$s_adress;?>
   </td>
   <td><?=$s_pass;?>
   </td>
    <td><?=$s_login;?>
   </td>
   <td><?=$s_level;?>
   </td>
   </tr>
   <?foreach($user as $key=>$value):?>
  <tr bgcolor="#e0e0e0">
   <td> <?=$value['id'];?>
   </td>
   <td><a href="<?=$admin_dir_full;?>edit_user/<?=$value['id_user'];?>"><?=$value['name'];?></a>
   </td>
   <td><?=$value['adress'];?>
   </td>
   <td><?=$value['pass'];?>
   </td>
   <td><a href="<?=$admin_dir_full;?>s_edit_login/<?=$value['id'];?>"><?=$value['type'];?></a>
   </td>
   <td align="center"><?=$value['level'];?>
   </td>
   </tr>
   <?endforeach;?>
 </table>
<br/>
<div align="center"><?=$link;?></div>