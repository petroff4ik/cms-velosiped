<script type="text/javascript">
	$(".pag_link").live("click",function(ob){
		var url = $(this).attr("link");
		$.ajax({
			type: "POST",
			url: url,
			dataType:"json",
			beforeSend:function(){
				$("#cur_img").html('<img src="/templates/images/loading.gif" border="0"/>');	
			},
			success: function(json){
				$("#gallery-contr").html(json.body);
			}
	});
})
	
$(".img_icon").live("click",function(ob){
	var date = "/<?= $GLOBALS['lang']; ?>/gallery/open?&path="+$(this).attr("path")+"&cat="+$(this).attr("cat")+"&file_name="+$(this).attr("file_name");
	$("#load").show();
	$("#orgin").attr("file_name",$(this).attr("file_name"));
	$("#cur_img img").attr('src',date);
	description = $(this).attr("alt");
	if(description == "img")
		$("#description").text("");
	else
		$("#description").text(description);
})
	
$("#orgin").live("click",function(ob){
	var date = "/<?= $GLOBALS['lang']; ?>/gallery/open?&path="+$(this).attr("path")+"&cat="+$(this).attr("cat")+"&file_name="+$(this).attr("file_name");
	myWin= open(date, "displayWindow", "status=no,toolbar=no,menubar=no");
		
})
</script>
<div id="gallery-contr" align="center">
	<? $this->view("templates/site/tpl_module/gallery/list.tpl", $img + $link); ?>
</div>





