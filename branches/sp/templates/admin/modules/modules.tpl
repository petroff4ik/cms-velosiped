<h1> <?=$m_mod;?></h1>
<form action="<?=$admin_dir_full;?>load_files/modules" enctype="multipart/form-data" method="post">
<?=$m_load_files;?>

<input type="file" name="userfile" value="<?=$m_search;?>">
<input type="submit" value="<?=$m_send;?>">&nbsp;<?=$load_info;?>
</form><br />
  <table   cellspacing="3" border="0"  width="800px">
   <tr  bgcolor="#BDBDBD">
     <td >
     <?=$m_id;?>
     </td>
      <td width="100px">
      <?=$m_name;?>
     </td>

      <td>
      <?=$m_help;?>
     </td>
     <td>
     <?=$m_sch;?>
     </td>
      <td>
     <?=$m_events;?>
     </td>


     <td>
     <?=$m_la;?>
     </td>
   </tr>
   <?=$modules;?>
  </table>


