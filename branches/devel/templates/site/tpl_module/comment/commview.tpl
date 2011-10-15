<?if(isset($all_comm)):?>
<div>
 <?foreach($all_comm as $key=>$value):?>

   <b style="float:left;"><?=$langs['comment']['email'];?>: <?=strip_tags($value['text']);?></b>
	       <span style="float:right;margin-right:10px;"><?=$value['date'];?></span>
   <br />
   <hr/>
    <?=$langs['comment']['body_message'];?>:  <span style="float:right;margin-right:10px;"><img onclick="$('#inpint').val('<?=$value['idcomm'];?>');$('#int_email').val('<?=$value['text'];?>');$('#answer').text('<?=$value['text'];?>');$('#ab').show();$.scrollTo($('#ab'),300);" style="cursor:pointer" src="/templates/images/notebook.png"  alt="" border="0"></span>
   <div style="width:500px;">
   <?=$value['body'];?>
   </div>
   <br />
   <?foreach($all_commn as $keyn=>$valuen):?>
   		<?if(!empty($value) && $value['idcomm']==$valuen['int_id']):?>
      <div style="margin-left:100px">
        <b style="float:left;"><?=$langs['comment']['email'];?>: <?=strip_tags($valuen['text']);?></b>
	       <span style="float:right;margin-right:10px;"><?=$valuen['date'];?></span>
	       <br />
   <hr/>
	        <?=$langs['comment']['body_message'];?>:
	        <div style="width:500px;">
   <?=$valuen['body'];?>
   </div> <br /><br />
      </div>
      	<?endif;?>
   <?endforeach;?>
 <?endforeach;?>
</div>
<?endif;?>
<br clear="all"/>