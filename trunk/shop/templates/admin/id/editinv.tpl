<h1><?=$l_editinv;?></h1>
<br/>
<form action="<?=$admin_dir_full;?>updateinv/<?=$curent['id'];?>" method="post">
    <table class="table3" border="0" cellpadding="4" cellspacing="0" width="500">
        <tbody>
            <tr>
                <td><?=$l_inv_mod;?></td><td><?=$l_inv_area;?></td><td><?=$l_inv_nstree;?></td><td><?=$l_inv_idint;?></td>
            </tr>

            <tr>
                <td>
                    <select name="iddoc">
                        <?foreach($inv as $key=>$value):?>
                        <?if($curent['iddoc']==$value['id']):?>
                         <option value="<?=$value['id'];?>"><?=$value['name_module'];?> (<?=$value['text'];?>)<?=$value['types'];?></option>
                        <?endif;?>
                        <?endforeach;?>
                        <?foreach($inv as $key=>$value):?>
                        <?if($curent['iddoc']!=$value['id']):?>
                        <option value="<?=$value['id'];?>"><?=$value['name_module'];?> (<?=$value['text'];?>)<?=$value['types'];?></option>
                        <?endif;?>
                        <?endforeach;?>
                    </select>
                </td>
                <td>
                    <select name="lr">
                        <?foreach($ns_tree as $key=>$value):?>
                        <?if($curent['lft']==$value['lft'] && $curent['rgt']==$value['rgt']):?>
                         <option value="<?=$value['lft'];?>|<?=$value['rgt'];?>"><?=$value['text'];?></option>
                        <?endif;?>
                        <?endforeach;?>
                        <option value="">--</option>
                        <?foreach($ns_tree as $key=>$value):?>
                       <?if($curent['lft']!=$value['lft'] && $curent['rgt']!=$value['rgt']):?>
                         <option value="<?=$value['lft'];?>|<?=$value['rgt'];?>"><?=$value['text'];?></option>
                        <?endif;?>
                        <?endforeach;?>
                    </select>
                </td>
                 <td>
                    <select name="ns_tree">
                        <?foreach($ns_tree as $key=>$value):?>
                        <?if($curent['ns_tree']==$value['id']):?>
                        <option value="<?=$value['id'];?>"><?=$value['text'];?></option>
                        <?endif;?>
                        <?endforeach;?>
                        <option value="">--</option>
                        <?foreach($ns_tree as $key=>$value):?>
                        <?if($curent['ns_tree']!=$value['id']):?>
                        <option value="<?=$value['id'];?>"><?=$value['text'];?></option>
                        <?endif;?>
                        <?endforeach;?>
                    </select>
                </td>

                 <td>
                    <input name="idint" type="text" size="3" value="<?=$curent['idint'];?>"/>
               </td>

            </tr>



            <tr>

                <td></td><td></td><td></td><td></td>
            </tr>
        </tbody>

    </table>
    <input type="hidden" name="relink" value="<?=$_SERVER['HTTP_REFERER'];?>"/>   
    <input type="submit" value="<?=$l_inv_save;?>"/>
</form>