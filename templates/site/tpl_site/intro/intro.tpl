<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title><?=$title;?></title>
	<meta name="title" content="<?=$title;?>" />
	<meta name="keywords" content="<?=$meta_key;?>" />
	<meta name="description" content="<?=$meta_descr;?>" />
	<link rel="stylesheet" href="/templates/site/tpl_site/intro/style.css" type="text/css" media="screen, projection" />
	<!--[if lte IE 6]><link rel="stylesheet" href="/templates/site/tpl_site/intro/style_ie.css" type="text/css" media="screen, projection" /><![endif]-->
</head>

<body>
<div id="header"> </div>
<div id="wrapper">
<div align="center"><?=$logo;?>
</div>
<br /><br />
<div id="langmenu">
<?=$lang;?>
</div>
<br />
<div id="menu">
<?=$menu;?>
</div>


  <?=$body;?>
</div><!-- #wrapper -->


</body>
</html>