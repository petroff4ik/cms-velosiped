<h1><?=$l_edit;?>!</h1>
<br />
 <h3><?=$c_title;?></h3><br />
 <form action='<?=$admin_dir_full;?>safe_launch/comment/update/<?=$id;?>' method='post' >
 <input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>">
 <?=$l_op;?>     <br />
 <select size="1" name="int_id">
 <?if(empty($comm[0]['comtex'])):?>
  <option value=""><?=$l_createemptyyou;?></option>
  <?else:?>
  <option value="<?=$comm[0]['comid'];?>"><?=$comm[0]['comtex'];?></option>
  <?endif;?>
  <?foreach($all_email as $key=>$value):?>
  <?if($comm[0]['id']!=$value['id']):?>
    <option value="<?=$value['id'];?>"><?=$l_answ;?><?=$value['text'];?></option>
    <?endif;?>
  <?endforeach;?>
</select>
<br />
<input name="idc" type="hidden" value="<?=$comm[0]['id'];?>">
<input name="email_id" type="hidden" value="<?=$comm[0]['email'];?>">
<input name="body_id" type="hidden" value="<?=$comm[1]['body'];?>">
<?=$l_email;?><br />
<input name="email" type="text" value="<?=$comm[0]['text'];?>">
<br />
<?=$l_body;?><br />
<textarea class="mceEditor" cols="40" rows="5" name="body"><?=$comm[1]['text'];?>
</textarea><br />
<a href="javascript:toggleEditor('body')"><?=$d_sh;?></a>
<br /><br />
<input type="submit" value="<?=$l_edits;?>">
</form>