  <tr bgcolor="#e0e0e0">
     <td>
     <input name="id" size="2" type="text" value="<?=$id;?>">
     </td>
       <td>
       <?=$m_name;?><br />
     <input size="6" name="class" type="text" value="<?=$class;?>"> <br /><br />
     <?=$m_ins;?> <br />
      <input size="6" name="name" type="text" value="<?=$name;?>">
     </td>

      <td>
      <?=$m_name_module;?><br />
      <textarea name="ins" row="5" col="5"><?=$name_module;?></textarea>
      <br /><br />
      <?=$m_help;?>
      <textarea name="help" row="5" col="5"><?=$help_annotation;?></textarea>
      <br />
     </td>


     <td>
     <?=$m_sch;?><br />
      <select size="1" name="sch">
     <?=$opt_sch;?>
    </select> <br /><br />


     <?=$m_events;?><br />

    <select size="1" name="event">
     <?=$opt_event;?>
    </select>
     </td>
     <td>
     <?=$side_sch;?>
     </td>


     <td>
     <?=$side_ev;?>
     </td>
     <td>
     <textarea cols="6" rows="6" name="tem"><?=$templates;?></textarea><br /><br />
       <select size="1" name="la">
     <option value="<?=$level_access;?>"><?=$level_access;?></option>
    <?for($i=0;$i<=$max_level[0]['level'];$i++):?>
  <option value="<?=$i;?>"><?=$i;?></option>
  <?endfor;?>
</select>
     </td>



     <td width="100">
      <input size="2" name="Name" type="text" value="">
     <? foreach($all_mod as $key=>$value):?>
     <br />
        <div style="display:inline;;float:left;background-color:#e0e0e0;">
        <?=$value['class'];?>
        </div>
        <?if($value['class']==$class):?>
         <div style='position:relative;float:left;margin-left:10px;background-color:#e0e0e0;'>
          <input name="nl" type="hidden" value="<?=$number_launch;?>">
         <input type='button' value='<' onclick="top.location.href='<?=$admin_dir_full;?>save_nl/up/<?=$id;?>';">
         <input type='button' value='>' onclick="top.location.href='<?=$admin_dir_full;?>save_nl/down/<?=$id;?>';">

         </div> <br />
        <?endif?>
        <br />

      <?endforeach?>

     </td>

   </tr>