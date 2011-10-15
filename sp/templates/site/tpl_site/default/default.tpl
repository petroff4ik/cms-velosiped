<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title><?=$title;?></title>
        <meta name="title" content="<?=$title;?>" />
        <meta name="keywords" content="<?=$meta_key;?>" />
        <meta name="description" content="<?=$meta_descr;?>" />
        <link rel="stylesheet" type="text/css" href="/templates/site/tpl_site/default/style.css" />
        <script type='text/javascript' src='/templates/js/jquery.js'></script>
        <script src="/templates/js/scrollTo.js" type="text/javascript" charset="utf-8"></script>
    </head>
    <body>
        <div id="wrap">
            <div id="header">
                <div id="logo">
                    <h1><?=$slogan1;?></h1>
                    <div><?=$slogan;?></div>
                </div>
                <ul id="nav">
                   <?=$menu;?>
                </ul>
            </div>
            <!-- /header -->
            <div id="content">
                <div class="side fl">
                    <div id="top">
                        
                        <ul class="meun">
            <?=$lang;?>
                        </ul>
                    </div>

                </div>
                <div class="main fr">
                    <div id="text">
                        <?=$body;?>
                        <?=$comment_vi;?>
                        <?=$comment;?>
                        
                    </div>
                    <div class="clearfix"></div>

                </div>
                <!-- /content -->
            </div>
            <div class="clearfix"></div>
            <div id="footer">
                <div id="ftinner">
                    <div class="ftlink fl">
                        <?
						if($clean_tree)
                        foreach($clean_tree as $key=>$value)
                            echo '<a href="'.$value['operator'].'">'.$value['text'].'</a> |';
                        ?>
                        
                        
                        <p id="copyright">© 2008. All Rights Reserved. <br/>
                            <a href="http://www.templatesold.com/" target="_blank">Website Templates</a> by <a href="http://www.free-css-templates.com/" target="_blank">Free CSS Templates</a></p>
                    </div>
                    <div class="valid fr"><img src="/templates/site/tpl_site/default/images/xhtml.gif" alt="xhtml valid" /> <img src="/templates/site/tpl_site/default/images/css.gif" alt="css valid" /></div>
                </div>
            </div>
            <!-- /footer -->
        </div>
    </body>
</html>