 <?
 foreach($lang as $key=>$value){
     if($value['name']==$GLOBALS['lang']){
     	?>
     	<img src="/templates/images/lang/<?=$value['name'];?>.jpg"  alt="<?=$value['alias'];?>" border="0">
     	<?
      }else{
     	?>
     	 <a href="<?=$site_url;?>lang/choose/<?=$value['name'];?>">
<img src="/templates/images/lang/<?=$value['name'];?>.jpg"  alt="<?=$value['alias'];?>" border="0">
</a>
     	<?

      }
    }
?>