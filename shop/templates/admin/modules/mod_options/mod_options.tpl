<h1> <?=$m_mod;?></h1> <br />

<form action="<?=$admin_dir_full;?>m_save_mod/" method="post">
 <table  cellspacing="3" width="850px;">
   <tr bgcolor="#BDBDBD">
     <td>
     <?=$m_id;?>
     </td>
      <td>
      <?=$m_sinfo;?>
     </td>

      <td>
       <?=$m_info;?>
     </td>

     <td>
     <?=$m_onoff;?>
     </td>
     <td>
     <?=$m_side_sch;?>

     </td>


     <td>
       <?=$m_side_ev;?>
     </td>
     <td>
     <?=$m_tem;?> - <br /><?=$m_la;?>
     </td>

     <td>
     <?=$m_nl;?>
     </td>


   </tr>

 <?=$tr;?>
  </table> <br />
  <input type="submit" value="<?=$ad_send;?>">
  </form>
  <form name="" action="<?=$admin_dir_full;?>quit/modules" method="post">
   <input type="submit" value="<?=$m_quit;?>">
</form>
  <br />
  <h4><?=$m_options;?></h4>
  <hr>
 <?if(isset($sys['result'])):?>
<?if($sys['result']):?>
<h3 style="color:#008B00;"><?=$l_mods_ok;?></h3>
<?else:?>
<h3 style="color:#FF0000;"><?=$l_mods_bad;?></h3>
<?endif;?>
<?endif;?>
  <?=$mod_option;?>