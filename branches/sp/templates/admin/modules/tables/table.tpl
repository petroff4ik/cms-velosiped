<tr bgcolor="#e0e0e0">
     <td >
     <?=$id;?>
     </td>
      <td>
      <a href="<?=$admin_dir_full;?>mod_options/<?=$id;?>"><?=$class;?></a>
     </td>
      <td width="400">
      <?=mb_substr($help_annotation,0,500,'UTF-8');?>...
     </td>
     <td align="center"  width="90">
     <?=$m_sch;?>
     </td>
      <td align="center"  width="90">
     <?=$events;?>
     </td>



     <td  align="center" width="100">
     <?=$level_access;?>
     </td>
   </tr>