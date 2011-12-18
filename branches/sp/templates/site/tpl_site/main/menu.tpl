<? 
     	if ($id==$ppid){
               $side="<span class='{$module}' style='margin-left:".$level."0px;' id='curmenu'>$name</span><br />";
     	 }else{
                 $side=$space."<a class='{$module}' id='menua' style='margin-left:".$level."0px;' href='".$operator."'>".$name."</a><br />";
     	 }
      echo $side;
?>
<? if($module == "catalogp"):?>
<script type='text/javascript'>
    $(".catalogp").hover(
    function(){
        $("#sub_menu").slideDown();
    })
    $("#sub_menu").live('mouseleave',function(){
        $(this).slideUp();
    })
</script>
<?
$sub_menu = $this->_call_out_func("catalogp_model","get_all_branch_site",$id,0);
?>
<div id="sub_menu" style="display:none;width:200px;" >
   
<?foreach($sub_menu as $key=>$value):?>
<?if($idint == $value['idcp']):?>
    <span style='margin-left:<?=$level+1;?>0px;display:block;color: #3A2514;font-family: Garamond;font-size: 28px;text-align: left;font-weight: bolder;margin-top:5px;'><?=$value['text'];?></span>
    <?else:?>
    <a style='margin-left:<?=$level+1;?>0px;display:block;color: #3A2514;font-family: Garamond;font-size: 26px;text-align: left;margin-top:5px;' href="<?=$operator;?>/show_next/<?=$value['idcp'];?>"><?=$value['text'];?></a>
    <?endif;?>
    </br>
<?endforeach;?>
</div>
<? endif; ?>


