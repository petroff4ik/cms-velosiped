<?$this->view("templates/admin/options/options.tpl");?>
<br /> <br />
<h2><?=$l_cache;?></h2>
<a href="<?=$admin_dir_full;?>cache_clean/"><?=$l_cache_clean;?></a>
<a href="<?=$admin_dir_full;?>cache_clean_old/"><?=$l_cache_old;?></a>  <br /><br />
<form  action="<?=$admin_dir_full;?>cache_clean_hand/" method="post">
 <?=$l_cache_hand;?> <br />
 <input name="hand" type="text" value="">
 <input type="submit" value="<?=$l_cache_clean;?>">
</form>

