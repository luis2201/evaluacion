<?php

  class SatisfaccionusuarioController
  {
    public function index()
    {      
      view("satisfaccionusuario.index", []);
    }

    public function insert()
    {
      $data = json_decode(file_get_contents('php://input'));

      $idestudiante = Main::limpiar_cadena($data->idestudiante);
      $parametro = Main::limpiar_cadena($data->parametro);
      $calificacion = Main::limpiar_cadena($data->calificacion);

      $idestudiante = Main::decryption($idestudiante);    

      $params = [":idestudiante" => $idestudiante, ":parametro" => $parametro, ":calificacion" => $calificacion];
      $resp = Satisfaccionusuario::Insert($params);

      echo json_encode($resp);
    }
  }

?>