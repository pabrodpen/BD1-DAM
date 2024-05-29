<?php
$servername = "localhost";
$username = "pabrodpen";
$password = "duqmV-g@Hg4c8Er";
$dbname = "duqmV-g@Hg4c8Er";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
  die("Error de conexión: " . $conn->connect_error);
}
echo "Conexión exitosa";
?>
