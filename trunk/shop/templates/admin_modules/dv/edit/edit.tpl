<h1><?=$c_create;?>!</h1>
<br />
<h3><?=$c_title;?></h3><br />
<form action='<?=$admin_dir_full;?>safe_launch/dv/update/<?=$doc['idg'];?>' method='post' >

      <input name="relink" type="hidden" value="<?=$_SERVER['HTTP_REFERER'];?>">
    <span><?=$lang_desc;?> <?=$doc['alias'];?></span><br />
    <?=$c_gtitle;?>
    <input name="title[<?=$doc['name'];?>]" type="text" value=" <?=$doc['title'];?>">
    <br /> <br />
    <textarea cols="80" rows="10" class="mceEditor" name="text[<?=$doc['name'];?>]" >
 <?=$doc['text'];?>
    </textarea>  <br />
    <a href="javascript:toggleEditor('text[<?=$doc['name'];?>]')"><?=$d_sh;?></a><br />  <br /><br /><br />



    <table cellspacing="15"  border="0">
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
                    <option value="<?=$doc['side_for_doc'];?>"><?=$doc['side_for_doc'];?></option>
                    <?foreach($side As $key2=>$value2):?>
                    <?if($value2['side']!=$doc['side_for_doc']):?>
                    <option value="<?=$value2['side'];?>"><?=$value2['side'];?></option>
                    <?endif;?>
                    <?endforeach;?>
                </select>
            </td>
            <td>
                <select size="1" name="show_me_title">

                    <?if($doc['show_me_title']):?>
                    <option value="1"><?=$c_on;?></option>
                    <option value="0"><?=$c_off;?></option>
                    <?else:?>
                    <option value="0"><?=$c_off;?></option>
                    <option value="1"><?=$c_on;?></option>
                    <?endif;?>
                </select>
            </td>

            <td>
                <select size="1" name="small_version">

                    <?if($doc['small_version']):?>
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
                    <?if($doc['sch']):?>
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
</form>

<form action='<?=$admin_dir_full;?>quit/document'method='post' >
    <input style="margin-left:15px;" type='submit' value='<?=$c_quit;?>'>
</form>
