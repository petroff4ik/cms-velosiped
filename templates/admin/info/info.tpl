<h1><?=$info;?></h1>
<br />
<?=$g_title;?> v <?=VERSION;?>
<br />

<?
if($cache) $cache=$l_cache_on;
	else
		$cache=$l_cache_off;

 echo "<br><div style='margin-top:10px;clear:both;padding:10px;border:1px solid;float:left'>".$l_total_time.$end_time."<br />".$l_total_memory. round(memory_get_usage()/1024/1024, 2).'MB'."<br />".$l_cache_onoff.$cache." <br />".$l_cache_size.round($cache_size/1024/1024, 2)." MB</div>" ;?>
