<tr  bgcolor="#e0e0e0"><form action="<?=$admin_dir_full;?>save_tmp_inf/<?=$id;?>" method="post">
    <td>
    <input name="id" type="text" value="<?=$id;?>">
    </td>
     <td>
     <input name="path_file" type="text" value="<?=$path_file;?>">
    </td>
     <td>
     <input name="name" type="text" value="<?=$name;?>">
    </td>
     <td>
    <select size="1" name="show_me">
  <option value=" <?=$show;?>"> <?=$show;?></option>
     <option value="<?=$show_n;?>"> <?=$show_n;?></option>
</select>
    </td>
     <td>
     <input type="submit" value="<?=$tem_save;?>">
     </td>
      </form>
    </tr>
