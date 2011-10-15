<?

########################################################
##                                                    ##
## FILE BROWSER - PHP CLASS             VERSION 1.3.1 ##
## OPEN SOURCE            FREE FOR NON-COMMERCIAL USE ##
##                                                    ##
## AUTHOR: BOGDAN ZARCHIEVICI                         ##
##                                                    ##
## LICENSED UNDER CREATIVE COMMONS                    ##
## ATTRIBUTION-NONCOMMERCIAL-SHAREALIKE 2.5           ##
##                                                    ##
########################################################

class file_browser_templates {

    var $interface = null;

    function layout_header() {

        echo '<center>';
        echo '<font face="Tahoma" size="2" style="font-size: 10pt">';
        echo '<table align="center" bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="0" height="100%" width="750">';
        echo '	<tr>';
        echo '		<td valign="top"><br/>';
    }

    function layout_footer($directory, $select, $version) {
        echo '			<table align="center" bgcolor="#2E2E2E" border=0 cellpadding=0 cellspacing=0 height=57 width=780>';
        echo '				<tr>';
        echo '					<td align=left nowrap="nowrap" style="padding-left: 10px"><font face="Tahoma" size=1 style="font-size: 8pt" color="#808080"><b>Current Directory:</b><br>' . $directory . '</td>';
        if (!empty($select))
            echo '					<td align=left nowrap="nowrap" style="padding-left: 50px; padding-right: 50px"><font face="Tahoma" size=1 style="font-size: 8pt" color="#808080"><b>Filter:</b><br>Showing files that start with ' . ucfirst($select) . '</td>';
        else
            echo '					<td align=left nowrap="nowrap" style="padding-left: 50px; padding-right: 50px"><font face="Tahoma" size=1 style="font-size: 8pt" color="#808080"><b>Filter:</b><br>None. Showing all files.</td>';
        echo '					<td align=right nowrap="nowrap" style="padding-right: 10px" width="100%"><font face="Tahoma" size=1 style="font-size: 8pt" color="#808080"><b>PHP File Browser</b><br>Version ' . $version . '<br></td>';
        echo '				</tr>';
        echo '			</table>';
        echo '			<br/>';
        echo '		</td>';
        echo '	</tr>';
        echo '</table>';
        echo '</font>';
        echo '</center>';
    }

    function layout_nofiles($filter) {
        echo '	<tr>';
        echo '		<td align="center" bgcolor="#F3F0ED" width="10"  height="21" nowrap="nowrap" style="">&nbsp;</td>';
        echo '		<td align="center" bgcolor="#F3F0ED" colspan="4" nowrap="nowrap" style="padding-left: 05px; padding-right: 05px"><font face="Tahoma" size="2" style="font-size: 8pt" color="#343434"><b>No files';
        if ($filter)
            echo ' match the filter you have selected.'; else
            echo '.'; echo '</b></font></td>';
        echo '		<td align="center" bgcolor="#F3F0ED" width="10"  height="21" nowrap="nowrap" style="">&nbsp;</td>';
        echo '	</tr>';
        echo '	<tr>';
        echo '		<td align="center" bgcolor="#FFFFFF" colspan="7"></td>';
        echo '	</tr>';
        echo '	<tr>';
        echo '		<td align="center" bgcolor="#FFFFFF" colspan="7"></td>';
        echo '	</tr>';
    }

    function layout_headings() {
        echo '			<table align="center" border="0" cellpadding="0" cellspacing="0" width="780">';
        echo '				<tr>';
        echo '					<td align="center" bgcolor="#2E2E2E" width="10"  height="21" nowrap="nowrap" style="">&nbsp;</td>';
        echo '					<td align="right" bgcolor="#2E2E2E"  height="21" nowrap="nowrap" style="padding-left: 05px; padding-right: 10px"><font face="Tahoma" size=1 style="font-size: 8pt; text-decoration: none;" color="#808080"><b>Type</b></font></td>';
        echo '					<td align="left" bgcolor="#2E2E2E"   width="100%" height="21" nowrap="nowrap" style="padding-left: 05px; padding-right: 10px"><font face="Tahoma" size=1 style="font-size: 8pt; text-decoration: none;" color="#808080"><b>Title</b></font></td>';
        echo '					<td align="right" bgcolor="#2E2E2E"  height="21" nowrap="nowrap" style="padding-left: 05px; padding-right: 10px"><font face="Tahoma" size=1 style="font-size: 8pt; text-decoration: none;" color="#808080"><b>Size</b></font></td>';
        echo '					<td align="right" bgcolor="#2E2E2E"  height="21" nowrap="nowrap" style="padding-left: 05px; padding-right: 05px"><font face="Tahoma" size=1 style="font-size: 8pt; text-decoration: none;" color="#808080"><b>Date Modified</b></font></td>';
        echo '					<td align="center" bgcolor="#2E2E2E" width="10"  height="21" nowrap="nowrap" style="">&nbsp;</td>';
        echo '				</tr>';
        echo '				<tr>';
        echo '					<td align=center colspan="7"></td>';
        echo '				</tr>';
    }

    function layout_letters($chrooted, $directory, $select) {
        foreach (array_map('chr', range(ord('a'), ord('z'))) as $letter)
            $letters[] = $letter;
        echo '			<table align="center" border=0 cellspacing=0 cellpadding=0 height=21>';
        echo '				<tr>';
        echo '					<td align=center bgcolor="#';
        if ($select == "numbers")
            echo "BF000D"; else
            echo "2E2E2E"; echo '" onmouseover="this.style.cursor = \'hand\';" onmouseup="location.href=\'' . ADMIN_DIR_FULL."edittemplate";
        if ($chrooted != $directory)
            echo '?dir=' . base64_encode (realpath($directory)) . '&'; else
            echo '?'; echo 'select=numbers\'" width=22><a href="' . ADMIN_DIR_FULL."edittemplate";
        if ($chrooted != $directory)
            echo '?dir=' . base64_encode (realpath($directory)) . '&'; else
            echo '?'; echo 'select=numbers" style="text-decoration: none"><font face="Tahoma" style="font-size: 8pt" size=1 color=white><b>#</b></a></td><td align="center" bgcolor="#FFFFFF" width="2"></td>';
        for ($X = 0; $X < count($letters); $X++) {
            echo '					<td align="center" bgcolor="#';
            if ($select == $letters[$X])
                echo 'BF000D'; else
                echo '2E2E2E'; echo '" onmouseover="this.style.cursor = \'hand\';" onmouseup="location.href=\'' . ADMIN_DIR_FULL."edittemplate";
            if ($chrooted != $directory)
                echo '?dir=' . base64_encode (realpath($directory)) . '&'; else
                echo '?'; echo 'select=' . $letters[$X] . '\'" width="22"><a href="' . ADMIN_DIR_FULL."edittemplate";
            if ($chrooted != $directory)
                echo '?dir=' . base64_encode (realpath($directory)) . '&'; else
                echo '?'; echo 'select=' . $letters[$X] . '" style="text-decoration: none"><font face="Tahoma" style="font-size: 8pt" size=1 color=white><b>' . ucfirst($letters[$X]) . '</b></a></td><td align="center" bgcolor="#FFFFFF" width="2"></td>';
        }
        echo '					<td align=center bgcolor="#';
        if ($select == "all" OR $select == "")
            echo 'BF000D'; else
            echo '2E2E2E'; echo '" onmouseover="this.style.cursor = \'hand\';" onmouseup="location.href=\'' . ADMIN_DIR_FULL."edittemplate";
        if ($chrooted != $directory)
            echo '?dir=' . base64_encode (realpath($directory)); echo '\'" width="132"><a href="' . ADMIN_DIR_FULL."edittemplate";
        if ($chrooted != $directory)
            echo '?dir=' .base64_encode (realpath($directory)); echo '" style="text-decoration: none"><font face="Tahoma" style="font-size: 8pt" size=1 color=white><b>All</b></a></td>';
        echo '				</tr>';
        echo '			</table>';
        echo '			<br>';
    }

    function layout_row($filename) {
        echo '	<tr>';
        echo '		<td align="center" bgcolor="#F3F0ED" width="10"  height="21" nowrap="nowrap" style="">&nbsp;</td>';
        echo '		<td align="right" bgcolor="#F3F0ED"  height="21" nowrap="nowrap" style="padding-left: 05px; padding-right: 10px"><font face="Tahoma" size="2" style="font-size: 8pt" color="#AEAAA6"><b>' . $filename['type'] . '</b></font></td>';
        echo '		<td align="left" bgcolor="#F3F0ED"   height="21" nowrap="nowrap" style="padding-left: 05px; padding-right: 05px"><a href="' . $filename['link'] . '" style="text-decoration: none"><font face="Tahoma" size="2" style="font-size: 8pt" color="#343434"><b>' . $filename['title'] . '</b></font></a></td>';
        echo '		<td align="right" bgcolor="#F3F0ED"  height="21" nowrap="nowrap" style="padding-left: 05px; padding-right: 10px"><font face="Tahoma" size="2" style="font-size: 8pt" color="#AEAAA6"><b>' . $filename['size'] . '</b></font></td>';
        echo '		<td align="right" bgcolor="#F3F0ED"  height="21" nowrap="nowrap" style="padding-left: 05px; padding-right: 05px"><font face="Tahoma" size="1" style="font-size: 8pt" color="#AEAAA6"><b>' . $filename['update'] . '</b></font></td>';
        echo '		<td align="center" bgcolor="#F3F0ED" width="10"  height="21" nowrap="nowrap" style="">&nbsp;</td>';
        echo '	</tr>';
        echo '	<tr>';
        echo '		<td align="center" bgcolor="#FFFFFF" colspan="7"></td>';
        echo '	</tr>';
        echo '	<tr>';
        echo '		<td align="center" bgcolor="#FFFFFF" colspan="7"></td>';
        echo '	</tr>';
    }

}

?>