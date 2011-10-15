<div align="left">
<? foreach ($arrfile as $key => $value): ?>
	<img onclick="del_img(this);" style="cursor:pointer;" class="img_icon" width="100" height="100" file_name="<?= $value; ?>"   src="/<?= $GLOBALS['lang']; ?>/gallery/open?file_name=<?= $value; ?>&path=thumb&cat=<?= $id; ?>" />
	<?if(is_int(($key--)/4) && key>0):?><br/><?endif;?>
<? endforeach; ?>
</div>	