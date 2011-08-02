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
			url:'<?= $admin_dir_full; ?>safe_launch/gallery/upload/',
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
						$("#src_img").attr("src","<?=$admin_dir_full;?>unsafe_launch/gallery/open?path=thumb&cat="+data.cat+"&file_name="+data.name);
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
				url: "<? $admin_dir_full; ?>safe_launch/gallery/del_img/",
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
<div ><img id="src_img"  src="/templates/images/blank.jpg" /></div><br/>
<div style="width: 32px;height: 32px;"><img width="32" height="32" id="loading" src="/templates/images/loading.gif" style="display:none;"></div><div id="answer" style="text-decoration:bold;height:32px;"><?if(!empty($warning)):?><?=$l_warning;?><?endif;?></div>
<form name="form" method="POST" enctype="multipart/form-data" action='<?= $admin_dir_full; ?>safe_launch/gallery/insert/<?= $id; ?>'  >
	<input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>"/>
	<input name="file_name" type="hidden" value=""/>
	<input name="path" type="hidden" value=""/>
	<fieldset style="padding:10px;">
		<legend><?=$l_size_l;?></legend>
	<span style="margin-right:10px;"><?=$l_width;?><input size="4" name="width_l" type="text" value="500"/>px</span>
	<span><?=$l_height;?><input size="4" name="height_l" type="text" value="500"/>px</span>
	</fieldset>
	<br/><br/>
	<fieldset style="padding:10px;">
		<legend><?=$l_size_t;?></legend>
	<span style="margin-right:10px;"><?=$l_width;?><input size="4" name="width" type="text" value="100"/>px</span>
	<span><?=$l_height;?><input size="4" name="height" type="text" value="100"/>px</span>
	</fieldset>
	<br/><br/>
	<input type="button" value="<?= $l_del_img; ?>" onclick="return del_img();"/><br/><br/>
	<input id="fileToUpload" type="file" size="45" name="fileToUpload" class="input" onChange="return ajaxFileUpload();">
	<button class="button" id="buttonUpload" onclick="return ajaxFileUpload();"><?= $l_upload; ?></button>
	<br/><br/>

	<? foreach ($lang_arr as $key => $value): ?>
		<span><?= $lang_desc; ?> <?= $value['alias']; ?></span><br /><hr /><br />
		<textarea name="description[<?=$value['name'];?>]" cols="40" rows="5"></textarea>
		<br /><br />
	<? endforeach; ?>

	<br/> <br/> 
	<?=$l_show_description;?>
	<input name="show_description" type="CHECKBOX" checked="checked" />
	<br/><br/>
	<input type="submit" value="<?= $c_create; ?>">
</form>
