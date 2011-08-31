<h3 style="margin-bottom:10px;"><?= $ad_add_del; ?> <?= $cat; ?> </h3>  <br />
<div style="background-color:#e0e0e0;padding:5px;">
	<form name="name_addin" action="<?= $admin_dir_full; ?>add_in/<?= $id; ?>" method="post">

		<input name="oper" type="radio" value="add" checked> <?= $ad_add_cat; ?> <?= $cat; ?><br />
		<? if ($id > 1): ?>
			<input name="oper" type="radio" value="addafter" >  <?= $ad_insert; ?> <?= $cat; ?><br /> <br />
		<? endif; ?>
		<fieldset>
			<legend><?= $ad_info; ?></legend>
			<table border="0" CELLSPACING="7px">
				<tr>

					<td><?= $ad_name; ?>&nbsp;<img style="background-color:grey;" src="<?= $path; ?>templates/images/pw.gif"  border="0"></td>
					<td><input type="text" readonly name="add_in">
						<input name="autos" type="checkbox" value="ON" onclick="click_check(this);" checked> <?= $lang_avtosapol; ?>
					</td>
				</tr>
				<? foreach ($lang as $key => $value): ?>
					<tr>
						<td>
							<?= $value['name']; ?>&nbsp;<img style="background-color:grey;" src="<?= $path; ?>templates/images/pw.gif"  border="0">
						</td>
						<td>
							<input name="lang[<?= $value['name']; ?>]" type="text" value="">
						</td>
					</tr>
				<? endforeach; ?>
			</table>
		</fieldset>
		<br />





		<fieldset>
			<legend><?= $ad_op; ?></legend>
			<table border="0" CELLSPACING="7px" >
				<tr>
					<td><?= $ad_view; ?></td>
					<td>
						<SELECT name='show' size='1'>
							<OPTION value='1'><?= $ad_show; ?>
							<OPTION value='0'><?= $ad_hide; ?>
						</SELECT>
					</td>
				</tr>
			</table>



			<fieldset>
				<legend><?= $lang_templates; ?></legend>
				<table border="0" CELLSPACING="7px">
					<tr>
						<td >
							<?= $c_out; ?>
						</td>
						<td>
							<select size="1" name="template_out" onchange="chechk(this);">

								<? foreach ($alltemplates as $key => $value): ?>
									<option value="<?= $value['id']; ?>"><?= $value['name']; ?></option>
								<? endforeach; ?>
							</select>
						</td>
						<td>
							<?= $ad_side; ?></td>

						<td>
							<SELECT name='side' size='1' id="sel">
								<? foreach ($showside as $key => $value): ?>
									<OPTION value='<?= $value['side']; ?>'><?= $value['side']; ?></option>
								<? endforeach; ?>
							</SELECT>
						</td>
					</tr>
					<tr>
						<td>
							<?= $c_ti; ?>
						</td>
						<td>
							<input name="templates_int" type="text" value="">
						</td>
					</tr>
				</table>

				<br />
			</fieldset>


			<table border="0" CELLSPACING="7px">

				<tr>
					<td>
						<?= $ad_adress; ?>
					</td>
					<td>
						<input type='text' value='' name='adress'>
					</td>
				</tr>

				<tr>
					<td><?= $ad_mod; ?></td>
					<td>
						<SELECT name='mod' size='1' >
							<OPTION value='undefined'><?= $l_undefined; ?></option>
							<? foreach ($allModules as $key => $value): ?>
								<OPTION value='<?= $value['id']; ?>'><?= $value['name_module']; ?></option>
							<? endforeach; ?>
						</SELECT>
					</td>
				</tr>

				<tr>


					<td width="40">
					</td>


				</tr>
				<tr>

					<td style="color:#BEBEBE;"><?= $c_short_a; ?>
					</td>
					<td><input name="short_a" type="checkbox" value="">
					</td>

					<td><?= $c_max_short_a; ?>
					</td>
					<td> <input name="max_short_a" type="checkbox" value="" checked>
					</td>

				</tr>



			</table>
		</fieldset>


		<br />

		<input type="submit" value="<?= $ad_send; ?>">
	</form>



	<br />
	<hr>
	<br />

	<font color='red'><?= $ad_del; ?></font> <?= $ad_cat; ?> <?= $cat; ?> <br />
	<input type="submit" value="<?= $ad_send; ?>" onclick="alaram(<?= $id; ?>,'cat')">

	<form action='<?= $admin_dir_full; ?>quit/'method='post' >
		<input type='submit' value='<?= $ad_quit; ?>'>
	</form>
</div>