<h3 style="margin-bottom:20px;"><?= $e_edit_cat; ?>  <?= $name; ?></h3>
<div style="background-color:#e0e0e0;padding:5px;">
	<div style='float:right;'>
		<?= $dir; ?>
	</div>
	<?= $dir_doc; ?>
	<br>
	<form action='<?= $admin_dir_full; ?>save_edit/<?= $id; ?>/<?= $alias; ?>' method='post' >

		<br>




		<fieldset>
			<legend><?= $ad_info; ?></legend>
			&nbsp; <?= $e_name_cat; ?> &nbsp;<img style="background-color:grey;" src="<?= $path; ?>templates/images/pw.gif"  border="0">
			<input type='text' value='<?= $name; ?>' name='add_in' readonly>  <input name="autos" type="checkbox" value="ON" onclick="click_check(this);" checked> <?= $lang_avtosapol; ?>
			<br />
			<br />
			<? foreach ($aliaslink As $key => $value): ?>
				&nbsp; <?= $value['lang']; ?>&nbsp;&nbsp;&nbsp;<img style="background-color:grey;" src="<?= $path; ?>templates/images/pw.gif"  border="0">&nbsp;<input name="<?= $value['lang']; ?>" type="text" value="<?= $value['text']; ?>">
				<br /><br />
			<? endforeach; ?>
		</fieldset>
		<br />
		<fieldset>
			<legend><?= $ad_op; ?></legend>


			<?= $ad_view; ?>
			<? if ($show_me): ?>
				<SELECT name='show' size='1'>
					<OPTION value='1'><?= $e_show; ?>
					<OPTION value='0'><?= $e_hide; ?>
				</SELECT>
			<? else: ?>
				<SELECT name='show' size='1'>
					<OPTION value='0'><?= $e_hide; ?>
					<OPTION value='1'><?= $e_show; ?>
				</SELECT>
			<? endif; ?>


			<fieldset>
				<legend><?= $lang_templates; ?></legend>
				<table border="0" CELLSPACING="7px">
					<tr>
						<td><?= $e_template_out; ?></td>
						<td> <select size="1" name="template_out" onchange="chechk(this);" >

								<? foreach ($alltemplates as $key => $value): ?>
									<? if ($template_out == $value['id']): ?>  <option value="<?= $value['id']; ?>"><?= $value['name']; ?></option>  <? endif; ?>
								<? endforeach; ?>

								<? foreach ($alltemplates as $key => $value): ?>
									<? if ($value['id'] != $template_out): ?>
										<option value="<?= $value['id']; ?>"><?= $value['name']; ?></option>
									<? endif; ?>
								<? endforeach; ?>

							</select>
						</td>

						<td><?= $e_side; ?></td>
						<td>
							<select size="1" name="side" id="sel">
								<option value="<?= $side; ?>"><?= $side; ?></option>
								<? foreach ($showside as $key => $value): ?>
									<option value="<?= $value['side']; ?>"><?= $value['side']; ?></option>
								<? endforeach; ?>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<?= $c_ti; ?>
						</td>
						<td>
							<input name="templates_int" type="text" value="<?= $templates_int; ?>">
						</td>
					</tr>

				</table>
			</fieldset>
			<table border="0" CELLSPACING="7px">
				<tr>
					<td><?= $e_externalAdress; ?></td>
					<td><input name="adress" type="text" value="<?= $adress; ?>"></td>
				</tr>
				<tr>
					<td><?= $e_module; ?> </td>
					<td>
						<select size="1" name="module">


							<? foreach ($allModules as $key => $value): ?>
								<? if ($module == $value['class']): ?>  <option value="<?= $module; ?>"><?= $value['name_module']; ?></option><? endif; ?>
							<? endforeach; ?>
									<option value='undefined'><?= $l_undefined; ?></option>
							<? foreach ($allModules as $key => $value): ?>
								<? if ($module != $value['class']): ?><option value="<?= $value['class']; ?>"><?= $value['name_module']; ?></option><? endif; ?>
							<? endforeach; ?>

						</select>
					</td>
				</tr>


				<tr>

					<td style="color:#BEBEBE;"><?= $c_short_a; ?>
					</td>
					<td><input  name="short_a" type="checkbox" value="" <? if (!empty($short_a))
								echo"checked"; ?>>
					</td>

					<td><?= $c_max_short_a; ?>
					</td>
					<td> <input name="max_short_a" type="checkbox" value="" <? if (!empty($max_short_a))
								echo"checked"; ?>>
					</td>

				</tr>
						<? if (!empty($tree)): ?>
					<tr>
						<td >
	<?= $l_pos_tree; ?>
						</td>
						<td>
							<select size="1" name="move">
								<option value="">--</option>
								<option value="pos"><?= $l_pos_treem; ?></option>
								<option value="mov"><?= $l_pos_add; ?></option>
							</select>
							<select size="1" name="idt">
								<option value="--">--</option>
								<? foreach ($tree as $key => $value): ?>
									<? if ($value['level']): ?>
										<option value="<?= $value['id']; ?>"><?= $value['text']; ?></option>
		<? endif; ?>
	<? endforeach; ?>
							</select>
						</td>

					</tr>
<? endif; ?>
				<tr><td>
						<input type='submit' value='<?= $e_save; ?>'>
					</td></tr>
				</form>

				<tr><td>
						<form action='<?= $admin_dir_full; ?>quit/'method='post' >
							<input type='submit' value='<?= $e_quit; ?>'>
						</form>
					</td></tr>
			</table>
		</fieldset>
</div>


