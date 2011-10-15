<h1><?=$l_readtemplate;?></h1>
<br>
<form action="<?=$admin_dir_full;?>saveftemplate" method="POST">
    <textarea name="content" cols="111" rows="40"><?=$content;?></textarea><br/><br/>
<input type="submit" value="<?=$l_save;?>"/> 
<input type="hidden" name="relink" value="<?=$_SERVER['HTTP_REFERER'];?>"/>
<input type="hidden" name="filenames" value="<?=$filenames;?>"/>

</form>