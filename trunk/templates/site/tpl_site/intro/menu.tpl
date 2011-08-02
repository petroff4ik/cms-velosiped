<?
     	if ($ppid==$id){
               $side='<tr>
	<td><img src="/templates/site/tpl_site/intro/images/spacer.gif" alt="" border="0" width="23" height="1">'.$name.'</td>
</tr>';
     	 }else{
                 $side=$space.'<tr>
	<td><img src="/templates/site/tpl_site/intro/images/spacer.gif" alt="" border="0" width="23" height="1"><a href="'.$operator.'">'.$name.'</a></td>
</tr>';
     	 }
      echo $side;
?>