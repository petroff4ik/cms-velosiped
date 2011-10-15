<h1><?=$c_create;?>!</h1>
<br />
<h3><?=$c_title;?></h3><br />

<form action='<?=$admin_dir_full;?>safe_launch/dv/insert/<?=$id;?>' method='post' >
    <input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>">
    <?foreach($lang_arr as $key=>$value):?>

    <span><?=$lang_desc;?> <?=$value['alias'];?></span><br />
    <?=$c_gtitle;?>
    <input name="title[<?=$value['name'];?>]" type="text" value="">
    <br /><br />
    <textarea cols="80" rows="10" class="mceEditor" name="text[<?=$value['name'];?>]" >

    </textarea>  <br />
    <a href="javascript:toggleEditor('text[<?=$value["name"];?>]')"><?=$d_sh;?></a><br />  <br /><br /><br />
    <?endforeach;?>


    <table cellspacing="15" border="0" >
        <tr>
            <td>
                <?=$save;?>
            </td>
            <td >
                <?=$side_dv;?>
            </td>
            <td>
                <?=$lang_title;?>
            </td>
            <td>
                <?=$small_version;?>
            </td>
            <td>
                <?=$l_inheritance;?>
            </td>
        </tr>
        <tr>
            <td><input type='submit' value='<?=$c_createb;?>'></td>
            <td>
                <select size="1" name="sidedoc">
                    <?foreach($side As $key2=>$value2):?>
                    <option value="<?=$value2['side'];?>"><?=$value2['side'];?></option>
                    <?endforeach;?>
                </select>
            </td>
            <td>
                <select size="1" name="show_me_title">
                    <option value="1"><?=$c_on;?></option>
                    <option value="0"><?=$c_off;?></option>
                </select>
            </td>

            <td>
                <select size="1" name="small_version">

                    <?if($doc[0]['small_version']):?>
                    <option value="1"><?=$c_on;?></option>
                    <option value="0"><?=$c_off;?></option>
                    <?else:?>
                    <option value="0"><?=$c_off;?></option>
                    <option value="1"><?=$c_on;?></option>
                    <?endif;?>
                </select>
            </td>
            <td>
                <select size="1" name="sch">
                    <option value="1"><?=$c_on;?></option>
                    <option value="0"><?=$c_off;?></option>
                </select>
            </td>
        </tr>
    </table>
</form>

<form action='<?=$admin_dir_full;?>quit/document'method='post' >
    <input style="margin-left:15px;" type='submit' value='<?=$c_quit;?>'>
</form>
