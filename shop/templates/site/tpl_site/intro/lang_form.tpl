 <?
 foreach($lang as $key=>$value){
     if($value['name']==$GLOBALS['lang']){
     	?>
     	 <span id="curlang"> <?=$value['alias'];?></span>
     	<?
      }else{
     	?>
     	 <a id="langmenua" href="<?=$site_url;?>lang/choose/<?=$value['name'];?>"><?=$value['alias'];?></a>
     	<?

      }
    }
?>