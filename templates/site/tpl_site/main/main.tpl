<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title><?=$title;?></title>
        <meta name="title" content="<?=$title;?>" />
        <meta name="keywords" content="<?=$meta_key;?>" />
        <meta name="description" content="<?=$meta_descr;?>" />
        <link rel="icon" type="image/png" href="/pom.png" />
        <link rel="stylesheet" href="/templates/site/tpl_site/main/style.css" type="text/css" media="screen, projection" />
        <!--[if lte IE 6]><link rel="stylesheet" href="/templates/site/tpl_site/main/style_ie.css" type="text/css" media="screen, projection" /><![endif]-->
        <script type='text/javascript' src='/templates/js/jquery.js'></script>
        <script src="/templates/js/scrollTo.js" type="text/javascript" charset="utf-8"></script>
        <script>
         $(function () { // run this code on page load (AKA DOM load)

        var scroll_timer;
        var displayed = false;
        var $message = $('#message');
        var $window = $(window);
        var top = $(document.body).children(0).position().top;

        $window.scroll(function () {
        window.clearTimeout(scroll_timer);
        scroll_timer = window.setTimeout(function () {
        if($window.scrollTop() <= top)
        {
        displayed = false;
        $message.fadeOut(500);
        }
        else if(displayed == false)
        {
        displayed = true;
        $message.stop(true, true).fadeIn(500).click(function () { $message.fadeOut(500); });
        }
        }, 100);
        });
        $('#top-link').click(function(e) {
        e.preventDefault();
        $.scrollTo(0,300);
        });

        $('.cmenu').click(function(e) {
         e.preventDefault();
        $.scrollTo($("#n"+$(this).attr("idn")),300);
        });
        });
        </script>
    </head>

    <body>
        <div id="top"></div><div id="message"><a href="#top" id="top-link"><img src="/templates/site/tpl_site/main/images/up.jpg"  border="0"></a></div>
        <div id="wrapper">
            <div id="header"></div><!-- #header-->



            <div id="middle">

                <div id="container">
                    <div id="content">
				<?=$body;?>
                        <br clear="all"/> 
<?=$comment_vi;?>
<?=$comment;?>
                        &nbsp;
                    </div><!-- #content-->
                </div><!-- #container-->

                <div class="sidebar" id="sideLeft">
<a href="<?=SITE_URL;?>" title="home"><?=$mini_logo;?></a>
                    <div id="menu">
	      <?=$menu;?>
                    </div>
                    <div id="langmenu">
	     <?=$lang;?>
                    </div>
                </div><!-- .sidebar#sideLeft -->

            </div><!-- #middle-->


        </div><!-- #wrapper -->

    </body>
</html>