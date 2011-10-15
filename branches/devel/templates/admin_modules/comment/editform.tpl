<h1><?= $l_comm_editform; ?></h1>
<br/>
<b><?=$types;?></b>
<form action='<?= $admin_dir_full; ?>safe_launch/comment/inserteditform/' method='post' >
    <textarea name="edit" cols="111" rows="40">
        <? echo $files; ?>
    </textarea>
    
    <br/><br/>

    <table cellspacing="15" border="0" >
        <tr>

            
                
                <td>
                    <?=$l_side_doc;?>
                </td>
                
                <td>
                <select size="1" name="side_for_doc">

                    <?if(isset($ns_doc)):?>
                    <option value="<?=$ns_doc['side_for_doc'];?>"><?=$ns_doc['side_for_doc'];?></option>
                    <?endif;?>

                    <?foreach($side As $key2=>$value2):?>
                    <?if($ns_doc['side_for_doc'] != $value2['side'] ):?>
                    <option value="<?=$value2['side'];?>"><?=$value2['side'];?></option>
                    <?endif;?>
                    <?endforeach;?>
                </select>
            </td>
            <td>
                <?=$l_inheritance;?>
            </td>
            <td>
                
                <select size="1" name="sch">
                    <?if($sch):?>
                    <option value="1"><?=$c_on;?></option>
                    <option value="0"><?=$c_off;?></option>
                    <?else:?>
                    <option value="0"><?=$c_off;?></option>
                    <option value="1"><?=$c_on;?></option>
                    <?endif;?>
                </select>
            </td>
        </tr>
    </table>
    <br/>

    <input type="hidden" name="types" value="<?=$types;?>"/>
    <input type="hidden" name="father_id" value="<?=$ns_tree;?>"/>
    <input type="hidden" name="show_me" value="1"/>
     <input type="hidden" name="id" value="<?=$id;?>"/>
    <input type="hidden" name="date" value="<?=date("Y-m-d");?>"/>
    <input type="hidden" name="relink" value="<?=$_SERVER['HTTP_REFERER'];?>"/>
    <input style="margin-left:15px;" type="submit" value="<?= $l_save; ?>"/>


</form>