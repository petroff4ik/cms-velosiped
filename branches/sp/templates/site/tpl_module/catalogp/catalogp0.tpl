<div align="center">
    <? foreach ($branch as $key => $value): ?>
        <a  style="float:left;margin:10px;font-size:14px;cursor:pointer;" href="/<?=$GLOBALS['lang'];?>/<?=$sys['ns_tree']['name'];?>/show_next/<?=$value['idcp'];?>"><b><?= mb_strtolower($value['text'], "UTF-8"); ?></b></a>
    <? endforeach; ?>
    </div>
