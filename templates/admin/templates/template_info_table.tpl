  <br />
  <h2><?=$tem_today;?></h2>
  <div style="float:left;margin-right:10px;">
  <table  cellspacing="3"  border="0"  >
    <tr bgcolor="#BDBDBD">
    <td>
    <?=$tem_id;?>
    </td>
     <td>
     <?=$tem_path;?>
    </td>
     <td>
     <?=$tem_name;?>
    </td>
     <td>
     <?=$tem_show;?>
    </td>
    </tr>

    <tr  bgcolor="#e0e0e0">
    <td>
    <?=$tem[0]['id'];?>
    </td>
     <td>
     <?=$tem[0]['path_file'];?>
    </td>
     <td>
     <?=$tem[0]['name'];?>
    </td>
     <td align="center">
     <?=$show;?>
    </td>
    </tr>
  </table>
  </div>
       <div style="margin-left:10px;margin-top:-30px;;float:left;">
       <img src="<?=$path;?>templates/images/see_.jpg"  border="0">
        <img src="<?=$path;?><?=$tem[0]['path_small_img'];?>"  border="0">
  </div>
  <br clear="all" />
    <?=$tem_side;?>
  <table  cellspacing="3" border="0" >
  	<tr bgcolor="#BDBDBD">
  	<?=$td;?>
  	</tr>
  </table>