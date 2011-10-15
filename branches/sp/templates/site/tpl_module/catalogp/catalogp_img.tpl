<script type="text/javascript">	
	$(".img_icon").live("click",function(ob){
		var date = "/<?= $GLOBALS['lang']; ?>/catalogp/open?&path="+$(this).attr("path")+"&cat="+$(this).attr("cat")+"&file_name="+$(this).attr("file_name");
		myWin= open(date, "displayWindow", "status=no,toolbar=no,menubar=no");
		
	})
</script>
<div align="center">
	<? foreach ($branch as $key => $value): ?>
		<span class="cmenu" idn="<?= $key; ?>" style="float:left;margin:10px;font-size:28px;cursor:pointer;"><b><?= $value['text']; ?></b></span>
	<? endforeach; ?>
	<div class="clear"/>

	<br /><br />
	<table border="0" width="400px" style="margin-top:50px;">
		<? foreach ($branch as $key => $value): ?>
			<tr>
				<td colspan="3" align="center"> <br /><br />
					<span id="n<?= $key; ?>" style="margin:10px;font-size:23px;"><b><?= $value['text']; ?></b></span> <br /><br />
				</td>
			</tr>
		<?foreach ($element as $keyE => $valueE):?>
				<? if ($valueE['pid'] == $value['idcp']): ?>
					<tr>
						<td rowspan="2" width="100px" height="100px">
							<img style="cursor:pointer;margin-right:10px;" class="img_icon" width="100" height="100" file_name="<?= $value['file_name']; ?>" path="orgin" cat="<?= $value['father_id']; ?>" src="/<?= $GLOBALS['lang']; ?>/catalogp/open?file_name=<?= $value['file_name']; ?>&path=thumb&cat=<?= $value['father_id']; ?>" alt="img"/>
						</td>
						
						<td align="left" >
							<b><?= $valueE['name'];?></b>
						</td>
						
						<td align="left"><b><?= $valueE['descr']; ?></b>
						</td>
						
					</tr>

					<tr>
						<td colspan="2" align="left"><?= $valueE['addi'];?>
						</td>
					</tr>
				<? endif; ?>
			<? endforeach; ?>

		<? endforeach; ?>
	</table>
</div>
</div>
