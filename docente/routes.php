<?php

session_start();

include_once "utils/defaults.php";
include_once "models/DB.php";
include_once "models/Main.php";
include_once "models/Login.php";
include_once "models/Criterios.php";
include_once "models/Portafolio.php";
include_once "models/Autoevaluacion.php";
include_once "models/Coevaluacion.php";
include_once "models/Area.php";
include_once "models/Pregunta.php";
include_once "models/Silabos.php";

$controller = ucfirst($_GET['controller']);

if(!file_exists("./controllers/".$controller."Controller.php")){
    $controller = "error";
}

if(!isset($_SESSION['iddocente_eval']) || $_SESSION['tipousuario_eval']!= 'DOCENTE'){
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