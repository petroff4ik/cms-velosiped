
<div align="center">
    <table border ="0">
        <? for($i=0;$i<=count($branch);$i++): ?>
        <tr>
            <td>
            <a class="cmenu"  style="float:left;margin:10px;cursor:pointer;" href="/<?= $GLOBALS['lang']; ?>/catalogp/branch/<?= $branch[$i]['father_id']; ?>/<?= $branch[$i]['id_doc']; ?>"><b><?= $branch[$i]['text']; ?></b></a>
            </td>
            <? $i++;?>
            <? if(isset($branch[$i])):?>
             <td>
            <a class="cmenu"  style="float:left;margin:10px;cursor:pointer;" href="/<?= $GLOBALS['lang']; ?>/catalogp/branch/<?= $branch[$i]['father_id']; ?>/<?= $branch[$i]['id_doc']; ?>"><b><?= $branch[$i]['text']; ?></b></a>
            </td>
            <?endif;?>
        </tr>
            <? endfor; ?>

    </table>
</div>
