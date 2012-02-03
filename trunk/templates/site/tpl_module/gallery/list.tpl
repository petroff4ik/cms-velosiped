<div  style="width:32px;height: 32px;padding:20px;" align="center"><img id="load" style="display:none;" src="/templates/images/loading.gif" border="0" /></div>
<div id="cur_img" style="padding:10px;">
	<?if(isset($img[0]['show_description']) && $img[0]['show_description']):?>
	<span id="description"><?=$img[0]['text'];?></span>
	<?endif;?>
	<br/><br/>
	<img file_name="<?= @$img[0]['file_name']; ?>" path="orgin" cat="<?= @$img[0]['father_id']; ?>" style="cursor:pointer;" id="orgin" onload="$('#load').hide();" src="/<?= $GLOBALS['lang']; ?>/gallery/open?file_name=<?= (!empty($img[0]['path']) && !empty($img[0]['file_name'])) ?  $img[0]['file_name'] : ""; ?>&path=large&cat=<?=$img[0]['father_id'];?>" border="0" />
	
</div>
<div align="center">
<? foreach ($img as $key => $value): ?>
	<img style="cursor:pointer;" class="img_icon" width="100" height="100" file_name="<?= $value['file_name']; ?>" path="large" cat="<?= $value['father_id']; ?>" src="/<?= $GLOBALS['lang']; ?>/gallery/open?file_name=<?= $value['file_name']; ?>&path=thumb&cat=<?= $value['father_id']; ?>" alt="<? echo $value['show_description']?$value['text']:"img";?>"/>
	<?if(is_int(($key--)/4) && key>0):?><br/><?endif;?>
<? endforeach; ?>
</div>	
<div align="center"><?= $link; ?></div>
