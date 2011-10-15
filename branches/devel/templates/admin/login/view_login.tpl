<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><?=$l_admin_panel;?></title>
<style>
.grc {padding: 5px 15px;width:250px;}
.grc .e{display:block; position: relative;}
.grc .e *{display: block; overflow: hidden; position: relative; z-index: 2; font-size: 0px;}
.grc b.e b, .grc b.e i, .grc b.e u {height: 1px !important; background: #f1f5f6;}
.grc b.e b{margin: 0 5px;}
.grc b.e i{margin: 0 3px;}
.grc b.e u{margin: 0 2px;}
.grc b.e span{margin: 0 1px; height: 2px !important; background: #f1f5f6;}
.grc div{background: #f1f5f6; padding: 0 10px; color: black;}
input, textarea, select {
 background-color: #FFFFFF;
 border-style: solid;
 border-width: 1px;
 font-family: verdana, arial, sans-serif;
 font-size: 11px;
 color: #172739;
 padding: 2px;
border:1px solid;
}
</style>
</head>
 <body>
 <div align="center">
     <div class='grc' >
<b class='e'><b></b><i></i><u></u><span></span></b>
<div>
<div align="center"><?=$admin;?></div>
       <div align="center" style="color:#FF0000;height:20px;"><?=$error;?></div>

       <form action="<?=$admin_dir_full;?>" method="post">
       <table border="0" align="center">
       <tr>
       <td>
       <?=$d_lang;?>:
       <select style="margin-left:57px;" size="1" name="lang">
       <?
         $arr=explode(",",ADMIN_ARR_LANGS);
       foreach($arr as $key=>$value):?>
  		<option value="<?=$value;?>"><?=$value;?></option>
  		<?endforeach;?>
		</select>
       </td>
       </tr>
        <tr>
        <td>
       <?=$login;?>: <input name="login" value="" maxlength="10" size="10" type="text">
       </td>
        </tr>
         <tr>
       <td>
       <?=$password;?>: <input style="margin-left:43px;" name="pass" value=""  maxlength="10" size="10" type="password">
       </td>
     </tr>
      <tr>
      <td colspan="2" align="center">
<input name="submin" value="<?=$enter;?>" type="submit">
     </td>
     </tr>
  <table>
   </form>
               </div>
<b class='e'><span></span><u></u><i></i><b></b></b>
</div>
</div>
</div>
</body>
</html>