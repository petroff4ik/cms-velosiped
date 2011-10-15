<h2><?=$l_add_page;?></h2>
<?if(empty($lang)):?>
   <?=$l_pagesfnotfound;?>
<?else:?>
 <div style='float:left;padding:10px;'>
 <?=$edm_lang;?>
<form action='<?=$admin_dir_full;?>add_edit_d/' method='post' >
 <select size="1" name="lang">
<?foreach($lang as $key=>$value):?>
  <option value="<?=$value['name'];?>"><?=$value['alias'];?></option>
<?endforeach;?>
</select><br /><br />
<input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>">
<input name="id" type="hidden" value="<?=$id_lang_text;?>">
<textarea class="mceEditor" name="text" >
   <?=$editor;?>
  </textarea>  <br />
<input type='submit' value='<?=$l_add_page;?>'>

</form>
<br />
<a href="javascript:toggleEditor('text')"><?=$d_sh;?></a>

 </div>
<?endif;?>