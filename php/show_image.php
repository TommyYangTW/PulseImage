<?php

require_once("dbconn.php");
session_start(); 
$sql="SELECT image,image_type FROM pulse_image WHERE id=?"; 

$stmt = $db->prepare($sql);

if($stmt === false){
    trigger_error('Wrong SQL: '. $sql . ' Error: ' . $db->errno . ' ' . $db->error, E_USER_ERROR);
}
$a_params = array();
$a_bind_params=array();
$param_type = 's';

$id=$_REQUEST["id"];

$stmt->bind_param('s', $id);

// Execute query
if($stmt->execute())
{  
   /* bind variables to prepared statement */
    $stmt->bind_result($image, $image_type);
    while($stmt->fetch()) 
    {
		header('Content-Type: '.$image_type); 
//trigger_error('image size:'.mb_strlen($image).',image_type:'.$image_type);
    	echo $image;
    	break;
    }
}
else
{  
   printf('{"Msg":"Fail:'.$stmt->error.'"}');
}
        
/* close statement */
$stmt->close();
/* close connection */
$db->close();  
?>