<?php

if (!function_exists("view")) {
    function view($nombreVista, $params)
    {
      foreach ($params as $key => $param) {
          $$key = $param;
      }
      $vista = explode('.', $nombreVista); // [0] => tareas, [1] => index

      if($vista[0]=='login' || $vista[0]=='register' || $vista[0]=='carrera') {
        include_once "./views/{$vista[0]}/$vista[1].php";
        
      } else{
        include_once './views/layout/header.php';
        include_once './views/layout/aside.php';
        include_once './views/layout/navbar.php';
        include_once "./views/{$vista[0]}/$vista[1].php";
        include_once './views/layout/footer.php';
      }
    }
}