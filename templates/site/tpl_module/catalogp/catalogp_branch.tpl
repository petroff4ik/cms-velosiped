<div id="center">
    <table border="0">
        <tr>
            <td width="400" align="left" valign="top">
                <div align="left" style="margin-bottom:20px;"><?=$br['text'];?></div>
                <div align="left"><?=$br['descr'];?></div>
            </td>
            <td width="200" align="left" valign="top">
                <?foreach($el as $key=>$value):?>
                <a href="/<?=$GLOBALS['lang'];?>/catalogp/element/<?=$value['father_id'];?>/<?=$value['id_doc'];?>"><?=$value['text'];?></a><br/>
                <?endforeach;?>
            </td>
        </tr>
    </table>
</div>