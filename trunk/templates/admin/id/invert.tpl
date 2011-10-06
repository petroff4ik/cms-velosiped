<h1><?=$l_inventor;?></h1>
<br/>
<table  cellspacing="3"  >
    <tr bgcolor="#BDBDBD">
        <td><?=$l_inv_mod;?></td><td><?=$l_inv_area;?></td><td><?=$l_inv_nstree;?></td><td><?=$l_inv_idint;?></td><td><?=$l_inv_oper;?></td>
    </tr>
<?if(!empty($inv)):?>
    <?foreach($inv as $key=>$value):?>
    <tr bgcolor="#e0e0e0">
        <td><b><?=$value['name_module'];?></b> <? if ($value['types']): ?>(<?= $value['types']; ?>)<? endif; ?>
			<br/>
			<?if(isset($value['private_info']['text'])):?>
		<?=$value['private_info']['text'];?>
			<?else:?>
			<b>Info not found</b>
			<?endif;?>
		</td><td><?=$value['area']['text'];?></td><td><?=$value['tree']['text'];?></td><td>
        <?= mb_substr(htmlspecialchars($value['idint']['text']),0,200,"utf-8");?></td>
        <td>
            <a href="<?=$admin_dir_full;?>editinv/<?=$value['id'];?>" title="<?=$l_editinv;?>"><?=$l_inv_edit;?></a><br/>
            <a href="<?=$admin_dir_full;?>delinv/<?=$value['id'];?>" onclick="return confirm('<?=$id_del;?>');" title="<?=$l_delinv;?>"><?=$l_inv_del;?></a>
        </td>
    </tr>
    <?endforeach;?>
<?endif;?>
</table><br/></br>
<form action="<?=$admin_dir_full;?>invcreate" method="POST">
    <input type="submit" value="<?=$l_inv_create;?>"/>
</form>