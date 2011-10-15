<link href="/templates/css/default.css" rel="stylesheet" type="text/css" />
<script>
	var SID = "<?php echo session_id(); ?>";
	var ID = "<?= $id; ?>";
	var admin_dir_full = "<? $admin_dir_full; ?>";
</script>
<script type="text/javascript" src="/templates/js/swfupload.js"></script>
<script type="text/javascript" src="/templates/js/swfupload.queue.js"></script>
<script type="text/javascript" src="/templates/js/fileprogress.js"></script>
<script type="text/javascript" src="/templates/js/handlers.js"></script>
<script type="text/javascript">
	var upload1, upload2;

	window.onload = function() {
		upload1 = new SWFUpload({
			// Backend Settings
			upload_url: "<?= ADMIN_DIR_FULL; ?>safe_launch/gallery/upload/",

			// File Upload Settings
			file_size_limit : "102400",	// 100MB
			file_types : "*.jpg; *.png; *.jpeg; *.gif",
			file_types_description : "Images",
			file_queue_limit : "0",
			file_post_name: "fileToUpload",

			// Event Handler Settings (all my handlers are in the Handler.js file)
			file_dialog_start_handler : fileDialogStart,
			file_queued_handler : fileQueued,
			file_queue_error_handler : fileQueueError,
			file_dialog_complete_handler : fileDialogComplete,
			upload_start_handler : uploadStart,
			upload_progress_handler : uploadProgress,
			upload_error_handler : uploadError,
			upload_success_handler : uploadSuccess,
			upload_complete_handler : uploadComplete,
			queue_complete_handler : queueComplete,

			// Button Settings
			button_image_url : "/templates/images/XPButtonUploadText_61x22.png",
			button_placeholder_id : "spanButtonPlaceholder1",
			button_width: 61,
			button_height: 22,
				
			// Flash Settings
			flash_url : "/templates/js/swfupload.swf",
				

			custom_settings : {
				progressTarget : "fsUploadProgress1",
				cancelButtonId : "btnCancel1"
			},
				
			// Debug Settings
			debug: false
		});

			

	}
	
	function del_img(ob){
		if(!confirm("<?= $l_del_img; ?>?")){
			return false;
		}else{
			$(ob).hide();
			$.ajax({
				type: "POST",
				url: "<? $admin_dir_full; ?>safe_launch/gallery/del_img/",
				data: "&file_name="+$(ob).attr("file_name")+"&path="+"templates/admin_modules/gallery/upload/"+ID+"/",
				dataType:"json",
				success: function(data){
					$("#answer").text(data.msg);

				},
				error: function (data, status, e)
				{
					$("#answer").text(e);
				}
			});
		}
	}
</script>


<h1><?= $c_create3; ?>!</h1>
<br />
<h3><?= $c_title; ?></h3><br />
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
<div>
	<div class="fieldset flash" id="fsUploadProgress1">
		<span class="legend"><?= $l_load_file; ?></span>
	</div>
	<div style="padding-left: 5px;">
		<span id="spanButtonPlaceholder1"></span>
		<input id="btnCancel1" type="button" value="Cancel Uploads" onclick="cancelQueue(upload1);" disabled="disabled" style="margin-left: 2px; height: 22px; font-size: 8pt;" />
		<br />
	</div>
</div>
<br/><br/>
<form name="form" method="POST" action='<?= $admin_dir_full; ?>safe_launch/gallery/insert/<?= $id; ?>'  >
	<input name="types" type="hidden" value="all" />
	<input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>"/>
	<? foreach ($lang_arr as $key => $value): ?>
		<span><?= $lang_desc; ?> <?= $value['alias']; ?></span><br /><hr /><br />
		<textarea name="description[<?= $value['name']; ?>]" cols="40" rows="5"></textarea>
		<br /><br />
	<? endforeach; ?>

	<br/> <br/> 
	<?= $l_show_description; ?>
	<input name="show_description" type="CHECKBOX" checked="checked" />
	<br/><br/>
	<input type="submit" value="<?= $c_create; ?>">
</form>
<br/>
<div id="answer" style="padding:10px;"></div>
<div id="gallery">
	<?= @$imgs; ?>
</div>