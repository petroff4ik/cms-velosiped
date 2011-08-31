<? $this->view("templates/admin/options/options.tpl"); ?>
<br /><br />
<h2><?= $l_log; ?></h2>
<br />
<form  action="<?= $admin_dir_full; ?>log/" method="post">
    <?= $l_log2; ?>
    <select size="1" name="log">
        <? if ($ch == "error.log"): ?>
            <option value="error.log"><?= $l_log_error; ?></option>
            <option value="action.log"><?= $l_log_action; ?></option>
        <? else: ?>
            <option value="action.log"><?= $l_log_action; ?></option>
            <option value="error.log"><?= $l_log_error; ?></option>
        <? endif; ?>
    </select> <input type="submit" value="<?= $l_log_ch; ?>">
    <br /> <br />
    <input name="clean" type="submit" value="<?= $l_clean_log; ?>">  <? echo round(filesize(LOG_DIR) / 1024 / 1024, 2); ?> mb
</form>
<br />
<div style="width:780px;border:1px solid;padding:10px;height: 500px; overflow: scroll;">
    <?= $file; ?>
</div> <br />
