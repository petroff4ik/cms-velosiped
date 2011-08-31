
  <h3 style="margin-bottom:20px;"><?=$c_create_doc;?> <?=$cat;?></h3>
<div style="background-color:#e0e0e0;padding:5px;">
 <div style='float:right;'>
<?=$dir;?>
</div>
<div style='float:left'>
<form action='<?=$admin_dir_full;?>save_doc/<?=$id;?>'method='post' >
<?=$c_name_doc;?>
<br>
<input type='text' value='' name='name'>
<br>
<?=$c_show_doc;?>
 <SELECT name='show_me' size='1'>
 <OPTION value='1'><?=$c_show;?>
 <OPTION value='0'><?=$c_hide;?>
 </SELECT>

<textarea name="edit" >

  </textarea>
<input type='submit' value='<?=$c_save;?>'>
</form>

  <form action='<?=$admin_dir_full;?>quit/'method='post' >
<input type='submit' value='<?=$c_quit;?>'>
</form>
 </div>
</div>

