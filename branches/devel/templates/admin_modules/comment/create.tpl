<h1><?=$c_create2;?>!</h1>
<br />
 <h3><?=$c_title;?></h3><br />
 <form action='<?=$admin_dir_full;?>safe_launch/comment/insert/<?=$id;?>' method='post' >
 <input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>">
 <?=$l_op;?>     <br />
 <select size="1" name="int_id">
 <?if(isset($comid)):?>
 <option value="<?=$comid;?>"><?=$text;?></option>
 <?else:?>
  <option value=""><?=$l_createempty;?></option>
  <?endif;?>
  <?foreach($all_email as $key=>$value):?>
    <option value="<?=$value['id'];?>"><?=$l_answ;?><?=$value['text'];?></option>
  <?endforeach;?>
</select>
<br />
<?=$l_email;?><br />
<input name="email" type="text" value="">
<br />
<?=$l_body;?><br />
<textarea class="mceEditor" cols="40" rows="5" name="body">
</textarea>
<a href="javascript:toggleEditor('arr[<?=$doc[2]['idl'];?>]')"><?=$d_sh;?></a>
<br /><br />
<input type="submit" value="<?=$l_create;?>">
</form>