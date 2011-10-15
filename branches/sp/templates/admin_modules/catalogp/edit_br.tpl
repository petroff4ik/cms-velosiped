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
<h1><?= $c_edi22; ?>!</h1>
<br />
<h3><?= $c_title; ?></h3><br />
<div>
	<form action='<?= $admin_dir_full; ?>safe_launch/catalogp/update_br/<?= $doc[0]['id']; ?>' method='post' >
		<input name="relink" type="hidden" value="<?= $_SERVER['HTTP_REFERER']; ?>">
		<input name="lang" type="hidden" value="<?= $doc[0]['lang']; ?>">
		<input name="idcp" type="hidden" value="<?= $doc[0]['idcp']; ?>">
		<input name="idl" type="hidden" value="<?= $doc[0]['idl']; ?>">
		<input name="idl_descr" type="hidden" value="<?= $doc[1]['idl']; ?>">


		<input name="file_name" type="hidden" value="<?= $doc[0]['file_name']; ?>"/>
		<input name="path" type="hidden" value="<?= $doc[0]['path']; ?>"/>
		<div><img id="src_img"  src="<? echo (!empty($doc[0]['path']) && !empty($doc[0]['file_name'])) ? $admin_dir_full . "unsafe_launch/catalogp/open?path=thumb&cat=" . $doc[0]['father_id'] . "&file_name=" . $doc[0]['file_name'] : "/templates/images/blank.jpg"; ?>" ></div><br/>
		<div style="width: 32px;height: 32px;"><img width="32" height="32" id="loading" src="/templates/images/loading.gif" style="display:none;"></div><div id="answer" style="text-decoration:bold;height:32px;"><? if (!empty($warning)): ?><?= $l_warning; ?><? endif; ?></div>
		<?
		$size = getimagesize((!empty($doc[0]['path']) && !empty($doc[0]['file_name'])) ? SITE_DIR . $doc[0]['path'] . "thumb/" . $doc[0]['file_name'] : SITE_DIR . "templates/images/blank.jpg");
		$w = isset($size[0]) ? $size[0] : 100;
		$h = isset($size[1]) ? $size[1] : 100;
		$size_l = getimagesize((!empty($doc[0]['path']) && !empty($doc[0]['file_name'])) ? SITE_DIR . $doc[0]['path'] . "thumb/" . "large_" . $doc[0]['file_name'] : SITE_DIR . "templates/images/blank.jpg");
		$w_l = isset($size_l[0]) ? $size_l[0] : 500;
		$h_l = isset($size_l[1]) ? $size_l[1] : 500;
		?>

		<fieldset style="padding:10px;">
			<legend><?= $l_size_l; ?></legend>
			<span style="margin-right:10px;"><?= $l_width; ?><input size="4" name="width_l" type="text" value="<?= $w_l; ?>"/>px</span>
			<span><?= $l_height; ?><input size="4" name="height_l" type="text" value="<?= $h_l; ?>"/>px</span>
		</fieldset>
		<br/><br/>
		<fieldset style="padding:10px;">
			<legend><?= $l_size_t; ?></legend>
			<span style="margin-right:10px;"><?= $l_width; ?><input size="4" name="width" type="text" value="<?= $w; ?>"/>px</span>
			<span><?= $l_height; ?><input size="4" name="height" type="text" value="<?= $h; ?>"/>px</span>
		</fieldset>
		<br/><br/>
		<input type="button" value="<?= $l_del_img; ?>" onclick="return del_img();"/><br/><br/>
		<input id="fileToUpload" type="file" size="45" name="fileToUpload" class="input" onChange="return ajaxFileUpload();">
		<button class="button" id="buttonUpload" onclick="return ajaxFileUpload();"><?= $l_upload; ?></button>
		<br/><br/>

		<span><?= $lang_desc; ?> <?= $doc[0]['lang']; ?></span><br /><hr /><br />
		<select size="1" name="branch">
			<? foreach ($branch as $key => $value): ?>
				<? if ($value['idcp'] == $doc[0]['pid']): ?><option value="<?= $value['idcp']; ?>"><?= $value['text']; ?></option><? endif; ?>
			<? endforeach; ?>
			<option value="0">--</option>
			<? foreach ($branch as $key => $value): ?>
				<? if ($value['idcp'] != $doc[0]['pid']): ?><option value="<?= $value['idcp']; ?>"><?= $value['text']; ?></option><? endif; ?>
			<? endforeach; ?>
		</select>
		<br />
		<br />

		<table borsre="0">
				<tr>
					<td><?= $name_br; ?>&nbsp;</td><td><input name="name_alias" type="text" value="<?= $doc[0]['text']; ?>"></td>
				</tr>
				<tr>
					<td><?= $desc_el; ?>&nbsp; </td><td><textarea class="mceEditor" name="descr_br" cols="40" rows="4"><?= $doc[1]['text']; ?></textarea>
						<br/>
						<a href="javascript:toggleEditor('descr_br')"><?= $d_sh; ?></a>
					</td>
				</tr>
			</table>
		<?= $num_step; ?>&nbsp;<input size="1" name="pos" type="text" value="<?= $doc[0]['pos']; ?>">
	

		<input type="submit" value="<?= $c_edit; ?>">
	</form>
</div>