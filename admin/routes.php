<?php

session_start();

include_once "utils/defaults.php";
include_once "models/DB.php";
include_once "models/Main.php";
include_once "models/Login.php";
include_once "models/Criterios.php";
include_once "models/Area.php";
include_once "models/Autoridades.php";
include_once "models/Docente.php";
include_once "models/Portafolio.php";
include_once "models/Estudiante.php";
include_once "models/Carrera.php";
include_once "models/Heteroevaluacion.php";
include_once "models/Coevaluacion.php";
include_once "models/Materia.php";
include_once "models/Silabos.php";
include_once "models/Estudiantedocente.php";
include_once "models/Administrativos.php";
include_once "models/Coevaluacionadministrativo.php";
include_once "models/Heteroevaluacionadministrativo.php";
include_once "models/Resultadosdocentes.php";
include_once "models/Resultadosadministrativos.php";
include_once "models/Resultadosestudiantes.php";

$controller = ucfirst($_GET['controller']);

if(!file_exists("./controllers/".$controller."Controller.php")){
    $controller = "error";
}

if(!isset($_SESSION['usuario_eval']) || $_SESSION['tipousuario_eval']!= 'ADMINISTRADOR'){
    $controller = "login";
}

$action = $_GET['action'];
$id = $_GET['id'];

if (empty($action))
    $action = "index";

$ctrlName = ucfirst($controller) . "Controller";

include "./controllers/$ctrlName.php";
$ctrl = new $ctrlName;
$ctrl->{$action}($id);

?>