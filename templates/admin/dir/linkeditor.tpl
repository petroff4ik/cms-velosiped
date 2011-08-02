<?=$space;?><img src='<?=$path;?>/templates/images/line.jpg'><a href='' onclick="chechk(this);return false;" path="/<?=$name;?>" fullpath="/<?=$name;?>" curname="<?=$name;?>"><?=$text;?></a>
<?if(!empty($pages)):?>
<img onclick="showD(this);" style="cursor:pointer;" src="/templates/images/doc.jpg"  border="0">
<div style="margin:10px;padding:10px;border:1px solid;display:none;"><?=$l_chose_branch_page;?><br />
 <?=$pages;?>
</div>
<?endif;?>
