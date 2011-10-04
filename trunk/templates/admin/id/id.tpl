<h1><?= $id22; ?> <?= $alias; ?></h1>
<br />
<span><?= $edm_all_doc; ?></span><br /> <br />
<div style="float:left;">
    <span style="float:left">
        <?= $d_sort; ?>
        <select size="1" name="lang_ch" onchange="langCh(this,'<?= $idc; ?>','<?= $order; ?>','<?= $vector; ?>','<?= $pag; ?>','<?= urlencode($search); ?>','<?= $mod_order; ?>');">
            <? foreach ($lang as $key => $value): ?>
                <? if ($cur_lang == $value['name']): ?>
                    <option value="<?= $value['name']; ?>"><?= $value['alias']; ?></option>
                <? endif; ?>
            <? endforeach; ?>

            <? foreach ($lang as $key => $value): ?>
                <? if ($cur_lang != $value['name']): ?>
                    <option value="<?= $value['name']; ?>"><?= $value['alias']; ?></option>
                <? endif; ?>
            <? endforeach; ?>
        </select>
    </span>

    <div style="float:left;margin-left:10px;">
        <form action="<?= $admin_dir_full; ?>id/<?= $idc; ?>/<?= $cur_lang; ?>/<?= $order; ?>/<?= $vector; ?>/<?= $pag; ?>/none/<?= $mod_order; ?>" method="post">
            <input name="search" type="text" value=""> &nbsp; <input  type="submit" value="<?= $lang_search; ?>">
        </form>
    </div>
    <div style="float:left;margin-left: -10px;">
        <form action="<?= $admin_dir_full; ?>id/<?= $idc; ?>/<?= $cur_lang; ?>/<?= $order; ?>/<?= $vector; ?>/<?= $pag; ?>/none/<?= $mod_order; ?>" method="post">
            <input name="search" type="hidden" value=""> <input  type="submit" value="<?= $lang_search_clean; ?>">
        </form>
    </div>
    <a class="linkeditorid" title="<?= $lang_table_ni; ?>"  href="<?= $admin_dir_full; ?>invert"><img src="/templates/images/link16.jpg" title="<?= $lang_table_ni; ?>" border="0" alt="" /></a>
    <span class="spans" style="background-color: #FFFFFF;cursor: pointer;"><img src="/templates/images/link16c.jpg" title="<?= $lang_table_ni; ?>" border="0" alt="" /></span>
    <div id="dropbox2">
                                        <form method="post" action="<?= $admin_dir_full; ?>createinvfortree/<?= $idc;?> ">
                                            <select name="iddoc"  >
                                                <? foreach ($sch2 as $keyi => $valuei): ?>
                                                    <option value="<?= $valuei['id']; ?>"><?= $valuei['class']; ?>(<?= $valuei['namet']; ?>) <?=$valuei['types'];?></option>
                                                <? endforeach; ?>
                                            </select>
                                            <br/>
                                            <input style="margin-top:5px;margin-bottom:5px;" type="submit" value="<?= $l_create; ?>"/>
                                        </form>
                                </div>
    
</div>
<? if (!empty($sch)): ?>
    <span class="spans" style="border: 1px solid;padding:2px;background-color: #FFFFFF;float: right;cursor: pointer;margin-left:10px; "><?= $lang_table_n; ?></span>
   
        <div class="dropbox"> 
            <table class="table3" border="0" cellpadding="4" cellspacing="0" width="500">
                <tbody>
                    <tr>
                        <td><?= $lang_table_mod; ?></td><td><?= $lang_table_descr; ?></td><td><?= $lang_table_side; ?></td>
                    </tr>
                    <? foreach ($sch as $key => $value): ?>
                        <tr>
                            <td><a class="linkeditorid"  href="<?= $admin_dir_full; ?>id/<?= ($value['father_id'])?$value['father_id']:$value['father_id_res']; ?>"><?= $value['class']; ?></a> </td><td><?
                $textTemp = mb_substr(strip_tags($value['text']), 0, DELEMITER_SYMVOL, 'UTF-8');
                if (empty($textTemp))
                    echo mb_substr(htmlspecialchars($value['text']), 0, DELEMITER_SYMVOL, 'UTF-8');
                else
                    echo $textTemp . "....";
                        ?>
                                <? if ($value['types']): ?>
                                    (<?= $value['types']; ?>)
                                <? endif; ?>
                            </td><td><?= $value['side_for_doc']; ?></td>

                        </tr>

                    <? endforeach; ?>

                    <tr>

                        <td></td><td></td><td></td>
                    </tr>
                </tbody>

            </table>

    </div>
<? endif; ?>





<? if (!empty($inv)): ?>
    <span class="spans" style="border: 1px solid;padding:2px;background-color: #FFFFFF;float: right;cursor: pointer;margin-left:10px; "><?= $lang_table_ni; ?></span>
         <div class="dropbox">
            <table class="table3" border="0" cellpadding="4" cellspacing="0" width="500">
                <tbody>

                    <tr>
                        <td><img src="/templates/images/link16.jpg" border="0"/></td><td><?= $lang_table_mod; ?></td><td><?= $lang_table_descr; ?></td>
                    </tr>
                    <? foreach ($inv as $key => $value): ?>
                        <tr>
                            <td width="50">
                                <? if (!empty($value['func']) || !empty($value['idint'])): ?>
                                    <img src="/templates/images/asterisk.png" alt="<?= $lang_invnotarget; ?>" title="<?= $lang_invnotarget; ?>" border="0"/>
                                <? else: ?>

                                <? endif; ?>
                            </td><td><a class="linkeditorid"  href="<?= $admin_dir_full; ?>editinv/<?= $value['idint']; ?>"><?= $value['name_module']; ?></a></td><td><?= $value['help_annotation']; ?><? if ($value['types']): ?>
                                    (<?= $value['types']; ?>)
                                <? endif; ?></td>

                        </tr>

                    <? endforeach; ?>

                    <tr>

                        <td></td><td></td><td></td>
                    </tr>
                </tbody>

            </table>

    </div>
<? endif; ?>
<br/>
<br clear="all"/>
<? if (isset($mod_orders) && !empty($mod_orders)): ?>
    <span style="margin-left:10px;"><?= $lang_mod_order; ?></span>
    <select size="1" name="modorder" onchange="langCh2(this,'<?= $idc; ?>','<?= $order; ?>','<?= $vector; ?>','<?= $pag; ?>','<?= urlencode($search); ?>','<?= $cur_lang; ?>');">>
        <? foreach ($mod_orders as $key => $value): ?>
            <? if ($mod_order == $key): ?>
                <option value="<?= $key; ?>"><?= $value; ?></option>
            <? endif; ?>
        <? endforeach; ?>
        <option value="none">--</option>
        <? foreach ($mod_orders as $key => $value): ?>
            <? if ($mod_order != $key): ?>
                <option value="<?= $key; ?>"><?= $value; ?></option>
            <? endif; ?>
        <? endforeach; ?>
    </select>
<? endif; ?>






<br clear="all"/> <br/>

<table  cellspacing="3"  >
    <tr bgcolor="#BDBDBD">

        <td>
            <a class="linkeditorid"  href="<?= $admin_dir_full; ?>changevector/<?= $idc; ?>/<?= $cur_lang; ?>/date/<?= $vector; ?>/<?= $pag; ?>/<?= urlencode($search); ?>/<?= $mod_order; ?>"><?= $lang_date; ?></a>
        </td>
        <td width="250px">
            <?= $edm_doc; ?>
        </td>

        <td>
            <?= $edm_lang; ?>

        </td>

        <td>
            <a class="linkeditorid"  href="<?= $admin_dir_full; ?>changevector/<?= $idc; ?>/<?= $cur_lang; ?>/class/<?= $vector; ?>/<?= $pag; ?>/<?= urlencode($search); ?>/<?= $mod_order; ?>"><?= $edm_nameModule; ?></a>
        </td>





        <td>
            <a class="linkeditorid"  href="<?= $admin_dir_full; ?>changevector/<?= $idc; ?>/<?= $cur_lang; ?>/show_me/<?= $vector; ?>/<?= $pag; ?>/<?= urlencode($search); ?>/<?= $mod_order; ?>"><?= $edm_SH; ?></a>
        </td>

        <td >
            <a class="linkeditorid"  href="<?= $admin_dir_full; ?>changevector/<?= $idc; ?>/<?= $cur_lang; ?>/side_for_doc/<?= $vector; ?>/<?= $pag; ?>/<?= urlencode($search); ?>/<?= $mod_order; ?>"><?= $edm_side; ?></a>
        </td>

        <td >
            <?= $edm_operation; ?>
        </td>

    </tr>

    <? if (!empty($all_doc)): ?>
        <? foreach ($all_doc as $key => $value): ?>
            <tr bgcolor="#e0e0e0">
                <td>
                    <? if (isset($value['erlink'])): ?>
                        <div align="center" style="background-color: #e0e0e0;"><img src="/templates/images/warning.gif"  border="0"></div>
                    <? else: ?>
                        <script>
                            $(function() {
                                $('.ns_doc_date<?= $key; ?>').datepicker({
                                    dateFormat:'yy-mm-dd',
                                    regional:['<?= $GLOBALS['lang']; ?>'],
                                    onSelect: function(dateText, inst) {
                                        $('.ns_doc_date<?= $key; ?>').val(dateText);
                                    }

                                });
                            });
                        </script>
                        <form name="ns_doc_date"  action="<?= $admin_dir_full; ?>savedate/<?= $value['id']; ?>/" method="post">
                            <input class="ns_doc_date<?= $key; ?>" style="cursor:pointer" name="ns_doc_date" readonly="on" size="9" type="text" value="<?= $value['ns_doc_date']; ?>"><br />
                            <input style="margin-top:5px;margin-bottom:5px;" type="submit" value="<?= $edm_save; ?>">

                        </form>
                    <? endif; ?>
                </td>
                <td width="250px">
                    <? if($value['inv']): ?>
                     <a class="linkeditorid" title="<?= $lang_table_ni; ?>"  href="<?= $admin_dir_full; ?>editinv/<?=$value['inv']['id'];?>"><img src="/templates/images/link16.jpg" title="<?= $lang_table_ni; ?>" border="0" alt="" /></a>
                    <? endif;?>
                    <? if (isset($value['erlink'])): ?>
                        <?= $lang_erlink; ?>
                    <? else: ?>
                        <?= @$value['text_ext']; ?><?
            $textTemp = mb_substr(strip_tags($value['text']), 0, DELEMITER_SYMVOL, 'UTF-8');
            if (empty($textTemp))
                echo mb_substr(htmlspecialchars($value['text']), 0, DELEMITER_SYMVOL, 'UTF-8');
            else
                echo $textTemp . "....";
                        ?>
                    <? endif; ?>

                </td>

                <td>

                    <?= $value['lang']; ?>

                </td>
                <td>
                    <?= $value['name_module']; ?>
                </td>



                <td>





                    <?
                    if (isset($value['show_me'])) {
                        if ($value['show_me']) {
                            echo'<a class="linkeditorid"  href="' . $admin_dir_full . 'hidedoc/' . $value['id'] . '/' . $idc . '/0">' . $edm_hide . '</a>';
                            echo'<span><b>' . $edm_show . '</b></span>';
                        } else {
                            echo'<a class="linkeditorid"  href="' . $admin_dir_full . 'showdoc/' . $value['id'] . '/' . $idc . '/1">' . $edm_show . '</a>';
                            echo'<span ><b >' . $edm_hide . '</b></span>';
                        }
                    }
                    ;
                    ?>

                </td>

                <td >
                    <? if ($value['side_for_doc'] != "module"): ?>
                        <? if ($value['side_only_read']): ?>
                            <?= $value['side_for_doc']; ?>
                        <? else: ?>
                            <form  action="<?= $admin_dir_full; ?>saveSideDoc/<?= $value['id']; ?>/<?= $idc; ?>" method="post">

                                <select size="1" name="sidedoc">
                                    <option value="<?= $value['side_for_doc']; ?>"><?= $value['side_for_doc']; ?></option>
                                    <? foreach ($side_doc As $key2 => $value2): ?>
                                        <? if ($value['side_for_doc'] != $value2['side']): ?>
                                            <option value="<?= $value2['side']; ?>"><?= $value2['side']; ?></option>
                                        <? endif; ?>
                                    <? endforeach; ?>
                                </select>
                                <br />
                                <input style="margin-top:5px;margin-bottom:5px;" type="submit" value="<?= $edm_save; ?>">
                            </form>
                        <? endif; ?>
                    <? else: ?>
                        <?= $lang_side_module; ?>
                    <? endif; ?>
                </td>

                <td>
                    <? if ($value['sch_menu']): ?>
                        <?= $value['sch_menu_']; ?>
                        <? echo @$value['sch_add_menu']; ?>
                        <a class="linkeditoridmenu"  href="<?= $admin_dir_full; ?>delnsdoc/<?= $value['id']; ?>" onclick="return confirm('<?= $id_del; ?>');"><?= $l_delnsdoc; ?></a>  
                    <? else: ?>
                        <? if (!empty($value['pages'])): ?>
                            <? echo'<a class="linkeditoridmenu"   href="' . $admin_dir_full . 'insertpagesindoc/' . $value["class"] . "/" . $value['id'] . '">' . $edm_insert_page . '</a><br />'; ?>
                            <? echo'<a class="linkeditoridmenu"  onclick="return confirm(\'' . $id_del . '\');" href="' . $admin_dir_full . 'delnsdoc/' . $value['id'] . '">' . $edm_del_doc . '</a><br />'; ?>
                        <? endif; ?>
                        <? if ($value['mod_options']): ?>
                            <? echo $value['mod_options']; ?>
                        <? endif; ?>
                        <? if (isset($value['erlink'])): ?>
                            <? if ($value['s_add'])
                                echo'<a class="linkeditoridmenu"  href="' . $admin_dir_full . 'safe_launch/' . $value["class"] . '/add/' . $value['id'] . '/' . $value['lang'] . '">' . $edm_create . '</a><br />'; ?>
                        <? else: ?>
                            <? if ($_SESSION['user']['level'] >= ADMIN_THRESHOLD): ?>
                                <span class="spans" style="cursor: pointer;color:#005D85;font-weight: bold;text-decoration: underline;padding-bottom: 5px;display:block;"><?= $l_createinvfordoc; ?></span>
                                    <div id="dropbox3">
                                        <form method="post" action="<?= $admin_dir_full; ?>createinvfordoc/<?= $value['id']; ?>">
                                            <select name="iddoc"  >
                                                <? foreach ($sch3 as $keyi => $valuei): ?>
                                                    <option value="<?= $valuei['id']; ?>"><?= $valuei['class']; ?>(<?= $valuei['namet']; ?>) <?=$valuei['types'];?></option>
                                                <? endforeach; ?>
                                            </select>
                                            <br/>
                                            <input style="margin-top:5px;margin-bottom:5px;" type="submit" value="<?= $l_create; ?>"/>
                                        </form>
                                </div>
                            <? endif; ?>
                            <? if ($value['s_edit'])
                                echo'<a class="linkeditoridmenu"  class="linkeditoridmenu"  href="' . $admin_dir_full . 'safe_launch/' . $value["class"] . '/edit/' . $value['id'] . '/' . $value['lang'] . '">' . $edm_edit . '</a><br />'; ?>
                            <a class="linkeditoridmenu"  href="/admin/uncoupling/<?= $value['id']; ?>"><?= $edm_uncoupling; ?></a> <br />
                            <? if ($value['s_del'])
                                echo'<a class="linkeditoridmenu"   onclick="return confirm(\'' . $id_del . '\');"  href="' . $admin_dir_full . 'safe_launch/' . $value["class"] . '/del/' . $value['id'] . '/' . '">' . $edm_del_all . '</a>'; ?><br/>
                        <? endif; ?>
                    <? endif; ?>
                </td>
            </tr>
        <? endforeach; ?>
    <? endif; ?>


</table>


<br />
<div align="center"><?= $link; ?></div>

<br />
<? if (!empty($create_module)): ?>
    <form  action="<?= $admin_dir_full; ?>launch/create/<?= $idc; ?>" method="post">
        <fieldset>
            <legend><?= $lang_id_new_create; ?></legend>
            <table border="0">
                <tr>

                    <td><?= $l_chose_lang; ?>
                    </td>

                    <td>
                        <select size="1" name="lang_cur">
                            <option value=""><?= $l_allfor; ?></option>
                            <? foreach ($lang as $key => $value): ?>
                                <option value="<?= $value['id']; ?>"><?= $value['alias']; ?></option>
                            <? endforeach; ?>
                        </select>
                    </td>

                    <td>
                        <select size="1" name="mod">
                            <? foreach ($create_module as $key => $value): ?>

                                <?
                                echo'<option value="' . $value['class'] . '">' . $value['name_module'] . '</option>';
                                ?>


                            <? endforeach; ?>
                        </select>
                    </td>
                    <td>
                        <input type="submit" value="<?= $edm_add; ?>">
                    </td>
                </tr>
            </table>
        </fieldset>
    </form>
<? endif; ?>
<br /><br />
<? if (!empty($freeLink)): ?>
    <fieldset>
        <legend><?= $e_freeDoc; ?></legend>
        <form name="" action="<?= $admin_dir_full; ?>add_doc/<?= $idc; ?>" method="post">
            <select size="1" name="add_doc">
                <? foreach ($freeLink as $key => $value): ?>
                    <option value="<?= $value['id']; ?>"><? echo strip_tags(substr($value['text'], 0, 200)) . "..."; ?></option>
                <? endforeach; ?>
            </select>
            <input type="submit" value="<?= $e_add; ?>">
        </form>

    </fieldset>
<? endif; ?>

