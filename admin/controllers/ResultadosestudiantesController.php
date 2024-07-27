<?php

  class ResultadosestudiantesController
  {
    public function index()
    {
      $administrativos = Resultadosestudiantes::findAdministrativos();

      view("resultadosestudiantes.index", ["administrativos" => $administrativos]);
    }
  }

?>