<?if(isset($_SESSION['messageF']) && !empty($_SESSION['messageF'])):?>
<?=$_SESSION['messageF'];?>
<? unset($_SESSION['messageF']);?>
<?endif;?>
<?$this->FormValidator= new FormValidator();?>
<form name="" action="<?=$site_url;?>comment/insert/<?=$sys['ns_tree']['id'];?>/<?=@$sys['ext_id'];?>" method="post">
<?if(empty($this->FormValidator->int_id)):?>
<div id="ab" style="display:none;"><?=$langs['comment']['answerto'];?><span id="answer" style="margin-left:10px;"></span></div>
<?else:?>
<div id="ab" ><b><?=$langs['comment']['answerto'];?></b><span id="answer" style="margin-left:10px;">
<?=$this->FormValidator->int_email;?>
</span></div>
<?endif;?>
<input id="int_email" name="int_email" type="hidden" value="<?=$this->FormValidator->int_email;?>">
<input id="inpint" name="int_id" type="hidden" value="<?=$this->FormValidator->int_id;?>">
<?=$langs['comment']['email'];?><br />
<input name="email" type="text" value="<?=$this->FormValidator->email;?>"><br />
<?=$langs['comment']['body_message'];?><br />
<textarea name="body" cols="70" rows="5"><?=$this->FormValidator->body;?>
</textarea><br /><br />
<img  src="/templates/captcha/cap.jpeg"  alt="" border="0"> <br />
<?=$langs['comment']['captcha'];?><br /><input  name="cap" size="4" type="text" value=""><br /><br />
<input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>">
<input type="submit" value="<?=$langs['comment']['add'];?>">
</form>