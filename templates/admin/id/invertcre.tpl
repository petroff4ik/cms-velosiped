<h1><?=$l_invcreate;?></h1>
<br/>
<form action="<?=$admin_dir_full;?>invcreatedb" method="post">
<table class="table3" border="0" cellpadding="4" cellspacing="0" width="500">
        <tbody>
            <tr>
               <td><?=$l_inv_mod;?></td><td><?=$l_inv_area;?></td><td><?=$l_inv_nstree;?></td><td><?=$l_inv_idint;?></td>
            </tr>
           
            <tr>
                <td>
                    <select name="iddoc">
                        <?foreach($inv as $key=>$value):?>
                        <option value="<?=$value['id'];?>"><?=$value['name_module'];?> (<?=$value['text'];?>)<?=$value['types'];?><? echo @mb_substr(htmlspecialchars($value['private_info']['text']), 0, 30, 'UTF-8');?></option>
                        <?endforeach;?>
                    </select>
                </td>
               <td>
                   <select name="lr">
                        <option value="">--</option>
                        <?foreach($ns_tree as $key=>$value):?>
                        <option value="<?=$value['lft'];?>|<?=$value['rgt'];?>"><?=$value['text'];?></option>
                        <?endforeach;?>
                    </select>
               </td>
                 <td>
                    <select name="ns_tree">
                        <option value="">--</option>
                        <?foreach($ns_tree as $key=>$value):?>
                        <option value="<?=$value['id'];?>"><?=$value['text'];?></option>
                        <?endforeach;?>
                    </select>
               </td>
               
               
                <td>
                    <input name="idint" type="text" size="3"/>
               </td>

            </tr>

           

            <tr>

                <td></td><td></td><td></td><td></td>
            </tr>
        </tbody>

    </table>
    <input type="hidden" name="relink" value="<?=$_SERVER['HTTP_REFERER'];?>"/>   
<input type="submit" value="<?=$l_inv_create;?>"/>
</form>