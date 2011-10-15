<?
     	if ($id==$ppid){
               $side="<span style='margin-left:".$level."0px;' id='curmenu'>$name</span><br />";
     	 }else{
                 $side=$space."<a id='menua' style='margin-left:".$level."0px;' href='".$operator."'>".$name."</a><br />";
     	 }
      echo $side;
?>