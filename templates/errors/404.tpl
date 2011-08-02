<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<html xmlns="http://www.w3.org/1999/xhtml">
<title>404</title>

<script type="text/javascript">
</script>

<script type="text/javascript">
</script>
<head>

<body>
<div style="margin:0 auto;width:700px;margin-top:50px;">
<div style="float:left;">
 <img src="/templates/images/404p.jpg"   border="0">
</div>
 <div style="margin-top:100px;float:left;margin-left:20px;text-align:center;" >
<?if(isset($this->lang['langs']['message']['show_404'])):?>
<h1><?=$this->lang['langs']['message']['show_404'];?>  </h1>
<?if(!empty($add)):?>
<span style="color:#736F6E;font-size:8px;">(<? print_r(@$params);?>, <?=@$method;?>)<?=$add;?></span>
<?endif;?>
<?else:?>
<h1>Not found page.</h1>
<span style="color:#736F6E;font-size:10px;">*(not found lang_file)</span>
<br />
<span style="color:#736F6E;font-size:8px;">(<? print_r($params);?>, <?=$method;?>)</span>
<?if(!empty($add)):?>
<span style="color:#736F6E;font-size:8px;"><?=$add;?></span>
<?endif;?>
<?endif;?>
</div>
</div>


</body>
</html>

