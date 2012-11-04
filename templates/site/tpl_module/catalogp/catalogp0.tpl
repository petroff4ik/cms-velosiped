<div align="center">
    <? foreach ($branch as $key => $value): ?>
        <a  style="float:left;margin:10px;font-size:24px;cursor:pointer;color:#3A2514;margin-top:100px;" href="/<?=$GLOBALS['lang'];?>/<?=$sys['ns_tree']['name'];?>/show_next/<?=$value['idcp'];?>"><b><?= mb_strtoupper($value['text'], "UTF-8"); ?></b></a>
    <? endforeach; ?>
    </div>


