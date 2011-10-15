<script type="text/javascript">	
    $(".img_icon").live("click",function(ob){
        var date = "/<?= $GLOBALS['lang']; ?>/catalogp/open?&path="+$(this).attr("path")+"&cat="+$(this).attr("cat")+"&file_name="+$(this).attr("file_name");
        myWin= open(date, "displayWindow", "status=no,toolbar=no,menubar=no");
		
    })
</script>
<div align="center">
    <? foreach ($branch as $key => $value): ?>
        <span class="cmenu" idn="<?= $key; ?>" style="float:left;margin:10px;font-size:14px;cursor:pointer;"><b><?= mb_strtolower($value['text'], "UTF-8"); ?></b></span>
    <? endforeach; ?>
    <div class="clear"/>

    <br /><br />
    <table border="0" width="600px" style="margin-top:50px;">
        <? foreach ($branch as $key => $value): ?>
            <tr>
                <td align="center"> <br /><br />
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
                            <b><?= $valueE['name']; ?></b>
                        </td>

                        <td align="right" valign="top">
                            <?= $valueE['addi']; ?>
                        </td>



                    </tr>

                    <tr >
                        <td  align="left" style="padding-bottom: 15px;"><?= $valueE['descr']; ?>
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
