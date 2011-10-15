<div style="padding:10px;float:right;border:5px solid;">
 <?=$langs['user_auth']['hello_login'];?>&nbsp;<b><?=$login_name;?></b> <br /><?=$langs['user_auth']['we_are'];?> &nbsp; <b><?=$login_type;?></b> <br /><?=$langs['user_auth']['level_access'];?>&nbsp;<b> <?=$level_access_l;?></b><br />
 <form name="" action="<?=$site_url;?>user_auth/logout" method="post">
 <input type="submit" value="<?=$langs['user_auth']['quit'];?>">
</form>
</div>

<br />