<script type="text/javascript">	
    $(".img_icon").live("click",function(ob){
        var date = "/<?= $GLOBALS['lang']; ?>/catalogp/open?&path="+$(this).attr("path")+"&cat="+$(this).attr("cat")+"&file_name="+$(this).attr("file_name");
        myWin= open(date, "displayWindow", "status=no,toolbar=no,menubar=no");
		
    })
</script>
<?
function my_ucfirst($string, $e ='utf-8') { 
    if (function_exists('mb_strtoupper') && function_exists('mb_substr') && !empty($string)) { 
        $string = mb_strtolower($string, $e); 
        $upper = mb_strtoupper($string, $e); 
            preg_match('#(.)#us', $upper, $matches); 
            $string = $matches[1] . mb_substr($string, 1, mb_strlen($string, $e), $e); 
    } 
    else { 
        $string = ucfirst($string); 
    } 
    return $string; 
}  
?>
<div align="center">
    <? foreach ($branch as $key => $value): ?>
        <span class="cmenu" idn="<?= $key; ?>" style="float:left;margin:10px;font-size:14px;cursor:pointer;font-size:16px;"><b><?= my_ucfirst($value['text']); ?></b></span>
    <? endforeach; ?>
    <div class="clear"/>

    <br /><br />
    <table border="0" width="600px" style="margin-top:50px;">
        <? foreach ($branch as $key => $value): ?>
        <tr>
             <?if(!empty($value['file_name'])):?>
                 <td align="center" colspan="2"> 
                <img style="cursor:pointer;margin-right:10px;" class="img_icon"    src="/<?= $GLOBALS['lang']; ?>/catalogp/open?file_name=<?= $value['file_name']; ?>&path=orgin&cat=<?= $value['father_id']; ?>" alt="img"/>
                 </td>
                <?endif;?>
        </tr>
            <tr>
                <td align="center"> 
                    
                    <br /><br />
                    <span id="n<?= $key; ?>" style="margin:10px;font-size:23px;"><b><?= mb_strtoupper($value['text'], "UTF-8"); ?></b></span> <br /><br />
                </td>
                <td align="right" >
                    <b><?= mb_strtolower($value['descr'], "UTF-8"); ?></b>
                </td>
            </tr>
            <? foreach ($element as $keyE => $valueE): ?>
                <? if ($valueE['pid'] == $value['idcp']): ?>
                    <tr>
                        <td  align="left" valign="top">
                            <b style="font-size:16px;"><?= $valueE['name']; ?></b>
                        </td>

                        <td align="right" valign="top" width="100">
                            <i style="font-size:14px;"><?= $valueE['addi']; ?></i>
                        </td>



                    </tr>

                    <tr >
                        <td  align="left" style="padding-bottom: 15px;font-size:14px;"><?= $valueE['descr']; ?>
                        </td>
                        <td align="right" >

                        </td>
                    </tr>
                    
                <? endif; ?>
            <? endforeach; ?>

        <? endforeach; ?>
    </table>
</div>
</div>
