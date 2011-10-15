
<?if($show_me_title):?>
<b style="font-size:18px;"><?=$title;?></b><br /> <hr/>
<?endif;?>
<?if($small_version):?>
<div style="margin-top:20px;"><span style="float:left;"><?=mb_substr($text,0,100,"utf-8");?></span> <a style="float:left;margin-top:15px;margin-left:3px;" href="<?=$site_url;?>dv/show/<?=$template_out;?>/<?=$idg;?>"><?=$langs['dv']['next'];?>...</a></div>
<?else:?>

 <?=$text;?>

<?endif;?>
