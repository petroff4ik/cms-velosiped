<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>

<!-- This template was created by Mantis-a [http://www.mantisa.cz/]. For more templates visit Free website templates [http://www.mantisatemplates.com/]. -->
<base href="<?=$admin_dir_full;?>"/>
<meta name="Description" content="admin..." />
<meta name="Keywords" content="cms..." />
<meta name="robots" content="all,follow" />
<meta name="author" content="..." />
<meta name="copyright" content="Mantis-a [http://www.mantisa.cz/]" />

<meta http-equiv="Content-Script-Type" content="text/javascript" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!-- CSS -->
<link rel="stylesheet" href="/templates/css/style.css" type="text/css" media="screen, projection, tv" />
<!--[if lte IE 7]><link rel="stylesheet" type="text/css" href="/templates/css/style-ie.css" media="screen, projection, tv" /><![endif]-->
<link rel="stylesheet" href="/templates/css/style-print.css" type="text/css" media="print" />
<link rel="stylesheet" href="/templates/css/jquery-ui.css" type="text/css"  />
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />

<title><?=$titlepage;?></title>
<script type='text/javascript' src='/templates/js/jquery.js'></script>
<script type='text/javascript' src='/templates/js/jquery-ui.js'></script>
<script type='text/javascript' src='/templates/js/jquery.ui.datepicker-ru.js'></script>
<script type='text/javascript' src='/templates/js/func.js'></script>
<script type='text/javascript' src='/templates/js/tree.js'></script>
 <script type="text/javascript" src="<?=$path;?>/editor/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({

// General options



mode : "specific_textareas",
editor_selector : "mceEditor",


theme : "advanced",
plugins : "style,typograf,layer,table,advhr,advimage,advlink,emotions,iespell,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras",

theme_advanced_buttons1 : "typograf,save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
theme_advanced_toolbar_location : "top",
theme_advanced_toolbar_align : "left",
theme_advanced_statusbar_location : "bottom",
theme_advanced_resizing : true,
setup : function(ed) {

           
          ed.onBeforeSetContent.add(function(ed, o) {
               
                o.content = o.content.replace(/<\?/gi, "&lt?");
                o.content = o.content.replace(/\?>/gi, "?&gt");
          });
     }
    
});
</script>


<script type="text/javascript">
var admin_dir_js="<?=ADMIN_DIR_FULL;?>";
<?if($_SESSION['update']['oper']=="start"):?>
startUpdate('<?=PUPD;?>','<?=SITE_URL;?>','<?=VERSION;?>');
<?endif;?>
<?if($_SESSION['update']['oper']=="load.file"):?>
proxy(<?=json_encode(array("oper"=>"load.file","file"=>$_SESSION['update']['file'],"serverurl"=>$_SESSION['update']['path']));?>);
<?endif;?>
function alaram(path){
choose=confirm('<?=$query_del;?>');
if(choose){
window.location.href=path;
}
}
function toggleEditor(id) {
if (!tinyMCE.get(id))
tinyMCE.execCommand('mceAddControl', false, id);
else
tinyMCE.execCommand('mceRemoveControl', false, id);
}
</script>
</head>

<body>
   <a style="float:right;margin:2px;"  href="<?=$admin_dir_full;?>quit_adm/" title="<?=$quit;?>"><img src="/templates/images/img/delete.jpg" alt="<?=$quit;?>" border="0"></a>
   <a style="float:right;margin:2px;" title="<?=$info;?>" href="<?=$admin_dir_full;?>info/"><img src="/templates/images/img/info.jpg" alt="<?=$info;?>" border="0"></a>
	<!-- Header -->
	<div id="header">

		<!-- Your gallery name  -->
		<h1 class="style"><a href="#"><?=$g_title;?></a></h1>
		<!-- Your gallery name end -->

			<!-- Your slogan -->
			<h2 class="style"><?=$g_title2;?>&hellip;</h2>
			<!-- Your slogan end -->


		<?=$login_info;?>  <?=$sys_info;?>


<a href="#skip-menu" class="hidden">Skip menu</a>

		<!-- Menu -->
		<ul id="menu">
		<li><a title="<?=$all_cat;?>" href="<?=$admin_dir_full;?>"><?=$all_cat;?></a></li>
<li><a title="<?=$all_modules;?>" href="<?=$admin_dir_full;?>modules/"><?=$all_modules;?></a></li>
<li><a title="<?=$templates;?>" href="<?=$admin_dir_full;?>templates/"><?=$templates;?></a></li>
<li><a title="<?=$s_security;?>" href="<?=$admin_dir_full;?>securitys/"><?=$s_security;?></a></li>
<li><a title="<?=$l_lang;?>" href="<?=$admin_dir_full;?>lang/"><?=$l_lang;?></a></li>
<li><a title="<?=$document;?>" href="<?=$admin_dir_full;?>document/"><?=$document;?></a></li>
<li><a title="<?=$options;?>" href="<?=$admin_dir_full;?>options/"><?=$options;?></a></li>
<li><a title="<?=$in_site;?>" href="<?=$path;?>"><?=$in_site;?></a> </li>

		</ul>
		<!-- Menu end -->
	</div>
	<!-- Header end -->

<hr class="noscreen" />

<div id="skip-menu"></div>

	<!-- Content box -->
	<div id="content-box">
		<div id="content-box-in" >
		<div  style='width: 850px;margin-top:20px;margin-bottom:100px;'>
<div class='grc' >
<b class='e'><b></b><i></i><u></u><span></span></b>
<div style="padding-bottom:10px;"> <?=$body;?>

</div>
<b class='e'><span></span><u></u><i></i><b></b></b>
</div>
</div>

            <br /><br />
			<div class="cleaner">&nbsp;</div>
		</div>
	</div>
	<!-- Content box end -->

<hr class="noscreen" />

	<!-- Footer -->
	<div id="footer">
		<div id="footer-in">
			<p class="footer-left">&copy; <a href="http://www.petroff.org.ua"><?=$f_title;?></a>, 2010 - <?=date("Y");?></p>
			<p class="footer-right"><a href="http://www.mantisatemplates.com/">Free web templates</a> by <a href="http://www.mantisa.cz/">Mantis-a</a></p>
		</div>
	</div>
	<!-- Footer end -->

</body>
</html>

