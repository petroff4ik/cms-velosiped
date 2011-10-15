<br /><br />
<span style="color:#BEBEBE;"><?=$insert;?></span><input  name="insert" type="checkbox" value="ON"><br />
<span style="color:#BEBEBE;"><?=$insert2;?></span><input name="insert" type="checkbox" value="ON"><br />
<?=$d_lang;?>&nbsp;
<select size="1" name="lang" id="lang">
<option value="<?=$GLOBALS['lang'];?>"><?=$GLOBALS['lang'];?></option>
<?foreach($lang as $key=>$value):?>
<?if($GLOBALS['lang']!=$value['name']):?>
<option value="<?=$value['name'];?>"><?=$value['name'];?></option>
<?endif;?>
  <?endforeach;?>
</select>
               </div>
<b class='e'><span></span><u></u><i></i><b></b></b>
</div>
</div>

</body>
</html>