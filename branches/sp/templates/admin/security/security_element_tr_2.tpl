
  <tr bgcolor="#e0e0e0">
    <td><?=$id;?>
    </td>
    <td><?=$url;?>
    </td>
    <td><form name="" action="<?=$admin_dir_full;?>save_l/<?=$id;?>" method="post">

<input name="level" type="text" value="<?=$level;?>" size="3">  <input type="submit" value="&lt;"></form>
    </td>
     <td><a href="<?=$admin_dir_full;?>element/<?=$id;?>"><?=$name;?></a>

    </td>
  </tr>
