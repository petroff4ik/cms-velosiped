<link href="/templates/css/ajaxfileupload.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="/templates/js/ajaxfileupload.js"></script>
<script type="text/javascript">
	function ajaxFileUpload()
	{
		$("#loading")
		.ajaxStart(function(){
			$(this).show();
		})
		.ajaxComplete(function(){
			$(this).hide();
		});

		$.ajaxFileUpload
		(
		{
			url:'<?= $admin_dir_full; ?>safe_launch/catalogp/upload/',
			secureuri:false,
			fileElementId:'fileToUpload',
			dataType: 'json',
			data:{id:<?= $id; ?>,width:$("input[name=width]").val(),height:$("input[name=height]").val(),width_l:$("input[name=width_l]").val(),height_l:$("input[name=height_l]").val()},
			success: function (data, status)
			{
				if(typeof(data.error) != 'undefined')
				{
					if(data.error != '')
					{
						$("#answer").text(data.error);
							
					}else
					{
						$("#answer").text(data.msg);
						$("#src_img").attr("src","<?= $admin_dir_full; ?>unsafe_launch/catalogp/open?path=thumb&cat="+data.cat+"&file_name="+data.name);
						$("input[name=file_name]").val(data.name);
						$("input[name=path]").val(data.path);
					}
				}
			},
			error: function (data, status, e)
			{
				$("#answer").text(e);
			}
		}
	)
		
		return false;

	}
	
	function del_img(){
		if(!confirm("<?= $l_del_img; ?>?")){
			return false;
		}else{
			$.ajax({
				type: "POST",
				url: "<? $admin_dir_full; ?>safe_launch/catalogp/del_img/",
				data: "&file_name="+$("input[name=file_name]").val()+"&path="+$("input[name=path]").val(),
				dataType:"json",
				success: function(data){
					$("#answer").text(data.msg);
					$("#src_img").attr("src","/templates/images/blank.jpg");
					$("input[name=file_name]").val("");
					$("input[name=path]").val("");
				},
				error: function (data, status, e)
				{
					$("#answer").text(e);
				}
			});
		}
	}
</script>
<h1><?= $c_create2; ?>!</h1>
<br />
<h3><?= $c_title; ?></h3><br />
<input id="sw1"  type="radio" value="" onclick="$('#sw2').removeAttr('checked');$('#el').show();$('#brmenu').hide();" > <?= $c_el; ?><br />
<input id="sw2" type="radio" value="" checked onclick="$('#sw1').removeAttr('checked');$('#brmenu').show();$('#el').hide();"> <?= $c_el_br; ?>
<br/><br/>
<div ><img id="src_img"  src="/templates/images/blank.jpg" /></div><br/>
<div style="width: 32px;height: 32px;"><img width="32" height="32" id="loading" src="/templates/images/loading.gif" style="display:none;"></div><div id="answer" style="text-decoration:bold;height:32px;"><? if (!empty($warning)): ?><?= $l_warning; ?><? endif; ?></div>
<fieldset style="padding:10px;">
	<legend><?= $l_size_l; ?></legend>
	<span style="margin-right:10px;"><?= $l_width; ?><input size="4" name="width_l" type="text" value="500"/>px</span>
	<span><?= $l_height; ?><input size="4" name="height_l" type="text" value="500"/>px</span>
</fieldset>
<br/><br/>
<fieldset style="padding:10px;">
	<legend><?= $l_size_t; ?></legend>
	<span style="margin-right:10px;"><?= $l_width; ?><input size="4" name="width" type="text" value="100"/>px</span>
	<span><?= $l_height; ?><input size="4" name="height" type="text" value="100"/>px</span>
</fieldset>
<br/><br/>
<input type="button" value="<?= $l_del_img; ?>" onclick="return del_img();"/><br/><br/>
<input id="fileToUpload" type="file" size="45" name="fileToUpload" class="input" onChange="return ajaxFileUpload();">
<button class="button" id="buttonUpload" onclick="return ajaxFileUpload();"><?= $l_upload; ?></button>
<br/><br/>

<br clear="all" />
<div id="brmenu" >
	<h2><?= $l_elbr; ?></h2>
	<form action='<?= $admin_dir_full; ?>safe_launch/catalogp/insert_br/<?= $id; ?>' method='post' >
		<input name="file_name" type="hidden" value=""/>
		<input name="path" type="hidden" value=""/>
		<input name="relink" type="hidden" value="<?= $_SERVER['HTTP_REFERER']; ?>">
		<select size="1" name="branch">
			<option value="0">--</option>
			<? foreach ($branch as $key => $value): ?>
				<option value="<?= $value['idcp']; ?>"><?= $value['text']; ?></option>
			<? endforeach; ?>
		</select>
		<br />
		<br />
		<? foreach ($lang_arr as $key => $value): ?>
			<span><?= $lang_desc; ?> <?= $value['alias']; ?></span><br /><hr /><br />
			<table borsre="0">
				<tr>
					<td><?= $name_br; ?>&nbsp;</td><td><input name="branch_name[<?= $value['name']; ?>]" type="text" value=""></td>
				</tr>
				<tr>
					<td><?= $desc_el; ?>&nbsp; </td><td><textarea class="mceEditor" name="descr_br[<?= $value['name']; ?>]" cols="40" rows="4"></textarea>
						<br/>
						<a href="javascript:toggleEditor('descr_br[<?= $value['name']; ?>]')"><?= $d_sh; ?></a>
					</td>
				</tr>
			</table>
		<? endforeach; ?>
		<?= $num_step; ?>&nbsp;<input size="1" name="pos" type="text" value=""/><br /><br />
		<input type="submit" value="<?= $c_create; ?>">

	</form>

</div>

<br clear="all"/>


<div id="el" style='display:none;'>
	<h2><?= $l_el2; ?></h2>
	<? if (empty($branch)): ?> <br />
		<img src="/templates/images/warning.gif" border="0">
		<?= $l_warning; ?><br />
	<? else: ?>
		<form action='<?= $admin_dir_full; ?>safe_launch/catalogp/insert_el/<?= $id; ?>' method='post' >
			<input name="file_name" type="hidden" value=""/>
			<input name="path" type="hidden" value=""/>
			<input name="relink" type="hidden" value="<?= $_SERVER['HTTP_REFERER']; ?>">

			<select size="1" name="branch">
				<? foreach ($branch as $key => $value): ?>
					<option value="<?= $value['idcp']; ?>"><?= $value['text']; ?></option>
				<? endforeach; ?>
			</select>
			<br />
			<br />
			<? foreach ($lang_arr as $key => $value): ?>
				<span><?= $lang_desc; ?> <?= $value['alias']; ?></span><br /><hr /><br />
				<table borsre="0">
					<tr>
						<td><?= $name_el; ?>&nbsp;</td><td><input name="name[<?= $value['name']; ?>]" type="text" size="60" value=""></td>
					</tr>
					<tr>
						<td><?= $desc_el; ?>&nbsp; </td><td><textarea class="mceEditor" name="descr[<?= $value['name']; ?>]" cols="40" rows="4"></textarea>
						
						<br/>
						<a href="javascript:toggleEditor('descr[<?= $value['name']; ?>]')"><?= $d_sh; ?></a>
						</td>
					</tr>
					<tr>
						<td><?= $price_el; ?>&nbsp;<td><input name="price[<?= $value['name']; ?>]" type="text" size="2" value=""></td>
					</tr>
				</table><br /><br />
			<? endforeach; ?>
			<input type="submit" value="<?= $c_create; ?>">
		</form>

	<? endif; ?>
</div>
<br clear="all"/>