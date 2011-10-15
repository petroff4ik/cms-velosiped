<div style="border:2px solid;margin:20px;padding:10px;" >
<p align="center">
<? if(isset($_SESSION['messageF']['user_auth'])){	 echo $_SESSION ['messageF']['user_auth'];
	 unset($_SESSION ['messageF']);
}
?></p>
<form  action="<?=$site_url;?>user_auth/logined" method="post">
   <input name="login" type="text" value="">
   <input name="pass" type="text" value="">
   <input type="submit" value="<?=$langs['user_auth']['u_enter'];?>">
</form>

</div>