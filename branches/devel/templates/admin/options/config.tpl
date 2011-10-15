<?$this->view("templates/admin/options/options.tpl");?>
<br /> <br />
<h2><?=$l_config;?></h2>
<form  action="<?=$admin_dir_full;?>config_save/" method="post">
<textarea rows="40" cols="100" name="config">
<?=$file;?>
</textarea> <br /><br />
<input type="submit" value="<?=$l_save;?>">
</form>

