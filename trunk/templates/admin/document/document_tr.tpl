 <tr bgcolor="#e0e0e0">

    <td width="40"><?=$id;?>
    </td>

     <td width="30%"><?=$date;?>
    </td>


     <td width="30%">[
     <?if($p):?>
     <a style="color:#228B22;" title="<?=$l_add_pages;?>" href="<?=$admin_dir_full;?>add_page/<?=$id;?>">p</a>&nbsp;
     <?endif;?>
     <a title="<?=$l_edit_pages;?>" href="<?=$admin_dir_full;?>edit_doc/<?=$id;?>/<?=$lang;?>/document/<?=$pag;?>">e</a>]&nbsp;&nbsp;<?=mb_substr(strip_tags($text),0,100,'UTF-8');?>.......
    </td>

     <td><?=$lang;?>
    </td>

  </tr>