 <table  cellspacing="3" width="700">
  <tr bgcolor="#BDBDBD">

    <td><div style="float:left;height:10px;width:10px;margin-right:5px;background-color:#BDBDBD;"><?=$doc_img_id;?></div><a href="<?=$admin_dir_full;?>document/<?=$pag;?>/doc_img_id/<?=$vector;?>/<?=$lang;?>/<?=$search;?>"><?=$nomber;?></a>
    </td>

     <td><div style="float:left;height:10px;width:10px;margin-right:5px;background-color:#BDBDBD;"><?=$doc_img_dt;?></div><a href="<?=$admin_dir_full;?>document/<?=$pag;?>/doc_img_dt/<?=$vector;?>/<?=$lang;?>/<?=$search;?>"> <?=$d_date;?> </a>
    </td>


     <td><?=$d_text;?>
    </td>

     <td>
     <form name="" action="<?=$admin_dir_full;?>document/<?=$pag;?>/<?=$oper;?>/<?=$vector2;?>/<?=$lang;?>/<?=$search;?>" method="post">
     <?=$d_lang;?>&nbsp;
     <select size="1" name="ch_lang">
     <?=$option;?>
	</select>
	<input type="submit" value="<?=$d_sort;?>">
</form>


    </td>

  </tr>

  <?=$tr;?>

 </table>
  <br />
 <form name="" action="<?=$admin_dir_full;?>document/<?=$pag;?>/<?=$oper;?>/<?=$vector2;?>/<?=$lang;?>/<?=$search;?>" method="post">
  <input name="search" type="text" value="">
  <input type="submit" value="<?=$d_search;?>">
</form>