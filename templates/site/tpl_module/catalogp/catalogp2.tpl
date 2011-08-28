
<div align="center">
	<? foreach ($branch as $key => $value): ?>
		<a class="cmenu" idn="<?= $key; ?>" style="float:left;margin:10px;cursor:pointer;" href="/<?=$GLOBALS['lang'];?>/catalogp/branch/<?=$value['father_id'];?>/<?=$value['id_doc'];?>"><b><?= $value['text']; ?></b></a>
	<? endforeach; ?>
                <br clear="all"/>
</div>
