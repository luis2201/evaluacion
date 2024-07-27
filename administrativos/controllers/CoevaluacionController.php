<?php

    class CoevaluacionController
    {
        public function index()
        {
            $coevaluaciones = Coevaluacion::SelectEvaluadorAdministrativo([":idevaluador" => $_SESSION['idadministrativo_eval']]);

            view("coevaluacion.index", ["coevaluaciones" => $coevaluaciones]);
        }

        public function findcoevaluacionadministrativo($idcoevaluacion)
        {
            $idcoevaluacion = Main::limpiar_cadena($idcoevaluacion);
            $idcoevaluacion = Main::decryption($idcoevaluacion);
            
            $params = [":idcoevaluacion" => $idcoevaluacion];
            $resp = Coevaluacion::findCoevaluacionAdministrativo($params);

            echo json_encode($resp);
        }

        public function insert()
        {
            $data = json_decode(file_get_contents('php://input'));

            $idcoevaluacion = Main::limpiar_cadena($data->idcoevaluacion);
            $indicador1 = Main::limpiar_cadena($data->indicador1);
            $indicador2 = Main::limpiar_cadena($data->indicador2);
            $indicador3 = Main::limpiar_cadena($data->indicador3);
            $indicador4 = Main::limpiar_cadena($data->indicador4);
            $indicador5 = Main::limpiar_cadena($data->indicador5);
            $indicador6 = Main::limpiar_cadena($data->indicador6);
            $indicador7 = Main::limpiar_cadena($data->indicador7);
            $indicador8 = Main::limpiar_cadena($data->indicador8);
            $indicador9 = Main::limpiar_cadena($data->indicador9);
            $indicador10 = Main::limpiar_cadena($data->indicador10);
            $total = Main::limpiar_cadena($data->total);

            $idcoevaluacion = Main::decryption($idcoevaluacion);

            $params = [":idcoevaluacion" => $idcoevaluacion, ":indicador1" => $indicador1, ":indicador2" => $indicador2, ":indicador3" => $indicador3, ":indicador4" => $indicador4, ":indicador5" => $indicador5, ":indicador6" => $indicador6, ":indicador7" => $indicador7, ":indicador8" => $indicador8, ":indicador9" => $indicador9, ":indicador10" => $indicador10, ":total" => $total];
            $resp = Coevaluacion::Insert($params);
          
            echo json_encode($resp);
        }

    }

?>