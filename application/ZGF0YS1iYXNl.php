<?php
$con = @mysqli_connect('127.0.0.1', 'jnpl', 'johnpaul', 'docker_db', '3308');
// $con = @mysqli_connect('172.22.0.3', 'jnpl', 'johnpaul', 'docker_db');

if (!$con) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    exit();
}

echo "Success: A proper connection to MySQL was made!" . PHP_EOL;
echo "Host information: " . mysqli_get_host_info($con) . PHP_EOL;

mysqli_close($con);
?>
