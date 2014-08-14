<?php

require_once("dbconn.php");
session_start(); 
$sql="INSERT INTO pulse_image (id,user,pulse_0_0,pulse_0_1,pulse_0_2,pulse_0_3,pulse_0_4,".
                "pulse_1_0,pulse_1_1,pulse_1_2,pulse_1_3,pulse_1_4,".
                "pulse_2_0,pulse_2_1,pulse_2_2,pulse_2_3,pulse_2_4,".
                "pulse_3_0,pulse_3_1,pulse_3_2,pulse_3_3,pulse_3_4,".
                "pulse_4_0,pulse_4_1,pulse_4_2,pulse_4_3,pulse_4_4,".
                "pulse_5_0,pulse_5_1,pulse_5_2,pulse_5_3,pulse_5_4,image,image_type) ".
                " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'image/png')"; 

$stmt = $db->prepare($sql);

if($stmt === false){
    trigger_error('Wrong SQL: '. $sql . ' Error: ' . $db->errno . ' ' . $db->error, E_USER_ERROR);
}
$a_params = array();
$a_bind_params=array();
$param_type = 'ssssssssssssssssssssssssssssssssb';

$data=$_REQUEST["image"];
list($type, $data) = explode(';', $data);
list(, $data)      = explode(',', $data);
$data = base64_decode($data);

$a_bind_params[]=$_REQUEST["id"]; 
//$a_bind_params[]=$data;


if(isset($_REQUEST["user"]))
    $a_bind_params[]=$_REQUEST["user"];
else
    $a_bind_params[]=null;
    
for($i = 0; $i < 30; $i++)
{
    if(isset($_REQUEST["pulse".$i]))
        $a_bind_params[]=$_REQUEST["pulse".$i];
    else
        $a_bind_params[]=null;
}
/* with call_user_func_array, array params must be passed by reference */
$a_params[] = & $param_type;
for($i = 0; $i < 33; $i++) {
    /* with call_user_func_array, array params must be passed by reference */
    $a_params[] = & $a_bind_params[$i];
}

//trigger_error('aaa SQL: ' . $sql . ' Error: ' . $db->errno . ' ' . $db->error, E_USER_ERROR);
//$stmt->bind_param('ibs', $id, $image,$user);
call_user_func_array(array($stmt, 'bind_param'), $a_params);
$stmt->send_long_data(32,$data);


// Execute query
if($stmt->execute())
{  
   printf('{"Msg":"OK"}');
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