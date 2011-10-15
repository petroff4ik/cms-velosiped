<h1><?=$document;?></h1>
<br />
 <h3><?=$d_edit;?></h3><br />

<div style='float:left;padding:10px;'>
<form action='<?=$admin_dir_full;?>save_edit_d/<?=$id;?>/<?=$lang;?>/<?=$url_quit;?>/<?=$url_arg;?>'method='post' >

<input name="relink" type="hidden" value="<?=$relink;?>">

<textarea class="mceEditor" name="edit" >
   <?=$editor;?>
  </textarea>  <br />
<input type='submit' value='<?=$edm_save;?>'>

</form>
 <form action='<?=$admin_dir_full;?>quit/document'method='post' >
<input type='submit' value='Выход'>
</form>
<a href="javascript:toggleEditor('edit')"><?=$d_sh;?></a>

 </div>