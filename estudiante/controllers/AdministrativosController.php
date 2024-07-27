<?php

  class AdministrativosController
  {
    public function index()
    {
      $administrativos = Administrativos::findAll();

      view("administrativos.index", ["administrativos" => $administrativos]);
    }

    public function insert()
    {
      $data = json_decode(file_get_contents('php://input'));

      $idestudiante = Main::limpiar_cadena($data->idestudiante);
      $idadministrativo = Main::limpiar_cadena($data->idadministrativo);
      $calificacion = Main::limpiar_cadena($data->calificacion);

      $idestudiante = Main::decryption($idestudiante);
      $idadministrativo = Main::decryption($idadministrativo);      

      $params = [":idestudiante" => $idestudiante, ":idadministrativo" => $idadministrativo, ":calificacion" => $calificacion];
      $resp = Administrativos::Insert($params);

      echo json_encode($resp);
    }
  }

?>