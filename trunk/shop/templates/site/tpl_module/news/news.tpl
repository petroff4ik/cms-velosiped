<div style="padding:10px;margin:10px;background-color:#ffcb85;">
<?foreach($title as $key=>$value):?>
	       <b style="float:left;width:400px;"><?=mb_substr(strip_tags($value['text']),0,DELEMITER_SYMVOL-100,"utf-8");?></b>
	       <span style="float:right;margin-right:10px;"><?=$value['date'];?></span>
	       <br clear="all"/>
	       <hr />
	       <br />
	       <?foreach($shortdescr as $keyd=>$valued):?>
	       <?if($valued['idn']==$value['idn']):?>
	       <?=mb_substr(strip_tags($valued['text']),0,DELEMITER_SYMVOL,"utf-8");?>
	       <a href="<?=$site_url;?><?=$sys['ns_tree']['name'];?>/id/<?=$valued['id_doc'];?>"><?=$langs['dv']['next'];?></a>
	       <br /> <br /><br />
	       <?break;?>
	       <?endif;?>
	       <?endforeach;?>
<?endforeach;?>
<?=$link;?>
</div>