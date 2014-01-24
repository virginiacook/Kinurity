<?php
 // Connects to your Database 
 mysql_connect("localhost", "root", "") or die(mysql_error()); 
 mysql_select_db("mysql") or die(mysql_error()); 
 $data = mysql_query("SELECT * FROM images") 
 or die(mysql_error()); 
 Print "<table border cellpadding=0>"; 
 while($info = mysql_fetch_array( $data )) 
 { 
 Print "<tr>"; 
 Print "<td>".'<img src="'.$info['RGBVal'].'">' . "</td> "; 
 Print "<td>".'<img src="'.$info['IRVal'].'">' . " </td></tr>"; 
 } 
 Print "</table>"; 

 
   ?>
   <body>
   	<img src"kinurity\rgb1.jpg">
   </body>

