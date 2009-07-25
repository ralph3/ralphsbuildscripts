<?php
/*
 *
 *  The RBS Version Cache PHP Frontend v1.0
 *
 *  Copyright 2006 Ralph Jones
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

$datad = "%%%%RBSDIR%%%%/.cache/version_check_data";

error_reporting(E_PARSE|E_ERROR);

function parse_data($data_file){
  $data    = file($data_file);
  $ret = array("version"=>$data[0],"mirrors"=>"");
  $data[0] = "";
  foreach($data as $link){
    if($link){
      if(!$mirrors){
        $mirrors=$link;
      }else{
        $mirrors=$mirrors."\n".$link;
      }
    }
  }
  if($mirrors){
    $ret["mirrors"] = explode("\n", $mirrors);
  }
  return($ret);
}

$ttitle="Packages";
if($_REQUEST['show_version']||$_REQUEST['show_mirrors']){
  header('Content-type: text/plain');
  if($_REQUEST['show_version']){
    $pkgname = $_REQUEST['show_version'];
  }else if($_REQUEST['show_mirrors']){
    $pkgname = $_REQUEST['show_mirrors'];
  }
  if(is_file($datad."/".$pkgname)){
    $parsed = parse_data($datad."/".$pkgname);
    if($_REQUEST['show_version']){
      echo($parsed["version"]);
    }else if($_REQUEST['show_mirrors']){
      foreach($parsed["mirrors"] as $mirror){
        if($mirror) echo($mirror."\n");
      }
    }
  }
  exit(0);
}else if($_REQUEST['show_html_mirrors']){
  if(is_file($datad."/".$_REQUEST['show_html_mirrors'])){
    $ttitle="Mirrors For ".$_REQUEST['show_html_mirrors'];
  }
}
?>

<HTML>
  <HEAD>
    <TITLE>The RBS Version Cache PHP Frontend</TITLE>
  </HEAD>
  <BODY BGCOLOR=#F6F6EA>
    <CENTER>
<table border="0" cellpadding="1" cellspacing="1">
  <tr>
    <td width="100%" align="center">
      <table style="width: 100%;" border="1" cellpadding="1" cellspacing="1">
        <tr>
          <td width="100%" align="center">
            <?php echo($ttitle); ?>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td width="100%" align="center">
      <table style="width: 100%;" border="1" cellpadding="1" cellspacing="1">
<?php
if($_REQUEST['show_html_mirrors']&&is_file($datad."/".$_REQUEST['show_html_mirrors'])){
    echo("
  
  <tr>
    <td width=\"100%\" align=\"left\">
        ");
  $parsed = parse_data($datad."/".$_REQUEST['show_html_mirrors']);
  $looped=FALSE;
  foreach($parsed["mirrors"] as $mirror){
    if($mirror) {
      if($looped) echo("<br>");
      echo("&nbsp;&nbsp;<a href=\"".$mirror."\">".$mirror."</a>&nbsp;\n");
      $looped=TRUE;
    }
  }
    echo("
    </td>
  </tr>
        ");
}else{
  $files=glob($datad."/*");
  sort($files);
  foreach($files as $data_file){
    $parsed = parse_data($data_file);
    $pkgname = basename($data_file);
    echo("
  
  <tr>
    <td align=\"left\">
      &nbsp;&nbsp;");
    echo("<a href=\"".$_SERVER["PHP_SELF"]."?show_html_mirrors=".str_replace('+', '%2B', $pkgname)."\">".$pkgname."</a>\n");
    echo("&nbsp;
    </td>
    <td align=\"left\">
      &nbsp;&nbsp;");
    echo($parsed["version"]."\n");
    echo("&nbsp;
    </td>
  </tr>
  ");
  }
}
?>
      </table>
    </td>
  </tr>
</table>
<?php
if($_REQUEST['show_html_mirrors']&&is_file($datad."/".$_REQUEST['show_html_mirrors'])){
  echo("<br><a href=\"".$_SERVER["PHP_SELF"]."\">Back</a>\n");
}
?>
    </CENTER>
  </BODY>
</HTML>
