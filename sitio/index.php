<?php

$host = 'dbases.exa.unicen.edu.ar';/*port=5432*/
$db = new PDO("pgsql:host=$host;port=6432;dbname=cursada", 'unc_246449', '246449');
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$sql = $db->prepare('SELECT * FROM gr18_disciplina ');
$sql->execute();
$disiplina = $sql->fetchAll();

//var_dump($disiplina);


$sql = $db->prepare('SELECT * FROM gr18_competencia ');
$sql->execute();
$res = $sql->fetchAll();

?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Comercializacion de Maquinarias | Inicio</title>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/2.1.3/mustache.js"></script>
  <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
  <!-- Latest compiled and minified CSS -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
  <!-- Optional theme -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
  <!-- Nuestra hoja de estilos -->
  <link rel="stylesheet" href="css/style.css" />

</head>
<body>
  <nav class="navbar" role="navigation" id="header">
    <div class="container">
      <div class="navbar-header">
        <a class="navbar-brand" href="index.html"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Olympic_flag.svg/300px-Olympic_flag.svg.png" title="Agencia de maquinarias" height="96" /></a>
      </div>
    <!-- Agrupar los enlaces de navegación, los formularios y cualquier otro elemento que se pueda ocultar al minimizar la barra -->
      <ul class="nav nav-pills pull-right">
        <li>
          <a  id="Inicio" class="active" href="index.php" >Inicio</a>
        </li>
        <li>
          <a id="Deportista" href="deportista.php" >Deportista</a>
        </li>
        <li>
          <a id="Inscripcion" href="inscripciones.php" >Inscripcion</a>
        </li>
      </ul>
    </div>
  </nav>
  <main class="container">
     <h1>Competencias</h1>
     <table class="table">
        <thead>
           <tr>
             <th>id</th>
             <th>Disiplina</th>
             <th>Nombre</th>
             <th>Fecha</th>
             <th>Lugar</th>
             <th>Localidad</th>
             <th>organizador</th>
             <th>individual</th>
             <th>fecha inscripcion</th>
             <th>jueces</th>
             <th>coberturatv</th>
             <th>mapa</th>
             <th>web</th>
             <th>Accion</th>
          </tr>
        </thead>
        <tbody>
           <form action="index.php" method="post">
           <tr>
             <td><input type="text" name="" id="" /></td>
             <td>
               <select >
                  <? for($t=0;$t<count($disiplina);$t++){?>
                     <option value="<?=$disiplina[$t]['cdodisciplina']?>"><?=$disiplina[$t]['nombre']?></option>
                  <? } ?>
               </select>
             </td>
             <td><input type="text" name="" id="" /></td>
             <td><input type="date" name="" id="" /></td>
             <td><input type="text" name="" id="" /></td>
             <td><input type="text" name="" id="" /></td>
             <td><input type="text" name="" id="" /></td>
             <td><select><option value="1">Indibidual</option><option value="0">Por Equipo</option></select></td>
             <td><input type="date" name="" id="" /></td>
             <td><input type="text" name="" id="" /></td>
             <td><input type="text" name="" id="" /></td>
             <td><select><option value="1">Si</option><option value="0">no</option></select></td>
             <td><input type="text" name="" id="" /></td>
             <td><input type="text" name="" id="" /></td>
           </tr>
           </form>
           <?
           if($res){
             for($i=0;$i<count($res);$i++){?>
                <tr> <td scope="row">1</td> <td>Mark</td> <td>Otto</td> <td>@mdo</td> </tr>
           <?}}else { ?>
              <tr> <td colspan="4">Sin datos</td> </tr>
           <? }?>

        </tbody>
     </table>
  </main>
  <footer class="container">
    Derechos Reservados
  </footer>
  <!-- Latest compiled and minified JavaScript -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
  <!-- Nuestros Js -->
</body>
</html>
