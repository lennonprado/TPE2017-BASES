<?php
error_reporting(E_ALL);

class DB {
/* variables de conexi�n */
var $BaseDatos;
var $Servidor;
var $Usuario;
var $Clave;

/* identificador de conexi�n y consulta */
var $Conexion_ID;
var $Consulta_ID;

/* n�mero de error y texto error */
var $Errno = 0;
var $Error = "";


function DB(){
	try {
      $host = 'dbases.exa.unicen.edu.ar';/*port=5432*/
      $this->Conexion_ID = new PDO("pgsql:host=$host;port=6432;dbname=cursada", 'unc_246449', '246449');
      $this->Conexion_ID->exec('SET search_path TO unc_246449');
    } catch (PDOException $e) {
        header('Location: error.php');
        die();
    }
}
/*Conexi�n a la base de datos*/
function conectar(){
//$this->BaseDatos = $bd;
//$this->Servidor = $host;
//$this->Usuario = $user;
//$this->Clave = $pass;
	// Conectamos al servidor
	$host = 'dbases.exa.unicen.edu.ar';/*port=5432*/
	$this->Conexion_ID = new PDO("pgsql:host=$host;port=6432;dbname=cursada", 'unc_246449', '246449');
   $this->Conexion_ID->exec('SET search_path TO unc_246449');

	//$this->Conexion_ID = pg_connect("host=dbases.exa.unicen.edu.ar:6432 dbname=cursada user=unc_246449 password=246449");

	if (!$this->Conexion_ID) {
		$this->Error = "Ha fallado la conexi�n.";
		return 0;
	}
	//seleccionamos la base de datos
	if (!@mysql_select_db($this->BaseDatos, $this->Conexion_ID)) {
		$this->Error = "No hay conexion con la Base de Datos, intentalo mas tarde";
		return 0;
	}

	/* Si hemos tenido �xito conectando devuelve
	el identificador de la conexi�n, sino devuelve 0 */
	return $this->Conexion_ID;
}



/* Ejecuta un consulta */
function consulta($sql = ""){
	if ($sql == "") {
		$this->Error = "No ha especificado una consulta SQL";
		return 0;
	}
	//ejecutamos la consulta
    $result = @mysql_query($sql, $this->Conexion_ID);
	if (!$result) {
		$this->Errno = mysql_errno();
		$this->Error = mysql_error();
	}
	/* Si hemos tenido �xito en la consulta devuelve
	el identificador de la conexi�n, sino devuelve 0 */
	return $result;
}


/* Ejecuta un UPDATE */
function consulta_update($tabla = "", $campos ="", $where = ""){
	if ($tabla == "" or $campos == "" or $where == "") {
		$this->Error = "No ha especificado una consulta SQL";
		return 0;
	}
	//armamos y ejecutamos la consulta
	$sql = "UPDATE " . $tabla . " SET ". $campos . " WHERE " . $where . ";";
    $this->Consulta_ID = @mysql_query($sql, $this->Conexion_ID);
	if (!$this->Consulta_ID) {
		$this->Errno = mysql_errno();
		$this->Error = mysql_error();
	}
	/* Si hemos tenido �xito en la consulta devuelve
	el identificador de la conexi�n, sino devuelve 0 */
	return $this->Consulta_ID;
}


/* Ejecuta un INSERT */
function consulta_insert($tabla, $campos, $variables){
    if (($tabla=="") or ($campos=="") or ($variables=="")) {
		$this->Error = "No ha especificado una consulta SQL";
		return 0;
	}
	//armamos y ejecutamos la consulta
	$sql = "INSERT INTO " . $tabla . " (". $campos . ") VALUES (" . $variables . ");";
    $result = @mysql_query($sql, $this->Conexion_ID);
	if (!$result) {
		$this->Errno = mysql_errno();
		$this->Error = mysql_error();
	}
	/* Si hemos tenido �xito en la consulta devuelve
	el identificador de la conexi�n, sino devuelve 0 */
	return $result;
}

/* Ejecuta un DELETE */

function consulta_delete($tabla = "", $where =""){
	if ($tabla == "" or $campos = "" or $variables = "") {
		$this->Error = "No ha especificado una consulta SQL";
		return 0;
	}
	//armamos y ejecutamos la consulta
	$sql = "DELETE FROM " . $tabla . " WHERE " . $where . ";";
	$this->Consulta_ID = @mysql_query($sql, $this->Conexion_ID);
	if (!$this->Consulta_ID) {
		$this->Errno = mysql_errno();
		$this->Error = mysql_error();
	}
	/* Si hemos tenido �xito en la consulta devuelve
	el identificador de la conexi�n, sino devuelve 0 */
	return $this->Consulta_ID;
}



/* Devuelve el n�mero de campos de una consulta */
function numcampos() {
	return mysql_num_fields($this->Consulta_ID);
}

/* Devuelve el n�mero de registros de una consulta */
function numregistros(){
	return mysql_num_rows($this->Consulta_ID);
}

/* Devuelve el nombre de un campo de una consulta */
function nombrecampo($numcampo) {
	return mysql_field_name($this->Consulta_ID, $numcampo);
}

/* Muestra los datos de una consulta */
function verconsulta() {
	echo "<table border=1>\n";
	// mostramos los nombres de los campos
	for ($i = 0; $i < $this->numcampos(); $i++){
		echo "<td><b>".$this->nombrecampo($i)."</b></td>\n";
	}
	echo "</tr>\n";
	// mostrarmos los registros
	while ($row = mysql_fetch_row($this->Consulta_ID)) {
		echo "<tr> \n";
		for ($i = 0; $i < $this->numcampos(); $i++){
		echo "<td>".$row[$i]."</td>\n";
	}
	echo "</tr>\n";
	}

}

function desconectar() {
	@mysql_close($this->Conexion_ID);
}


} //fin de la Clse DB

?>
