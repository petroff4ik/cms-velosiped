<div id="map-cont" align="left">

	<ul>
		<? foreach ($cat as $key => $value): ?>
				<li style="margin-left:<?=$value['level']*10;?>px">
					<span id="separator">|<?=str_repeat('-', $value['level']);?></span><a href="/<?=$GLOBALS['lang'];?>/<?=$value['name'];?>/"><?= $value['text']; ?></a>
				</li>
		<? endforeach; ?>
	</ul>	

</div>