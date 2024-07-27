<?php

    class CoevaluacionController
    {
        public function index()
        {
            $coevaluaciones = Coevaluacion::SelectEvaluadorDocente([":idevaluador" => $_SESSION['iddocente_eval']]);

            view("coevaluacion.index", ["coevaluaciones" => $coevaluaciones]);
        }

        public function findcoevaluaciondocente($idcoevaluacion)
        {
            $idcoevaluacion = Main::limpiar_cadena($idcoevaluacion);
            $idcoevaluacion = Main::decryption($idcoevaluacion);
            
            $params = [":idcoevaluacion" => $idcoevaluacion];
            $resp = Coevaluacion::findCoevaluacionDocente($params);

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
            $total = Main::limpiar_cadena($data->total);

            $idcoevaluacion = Main::decryption($idcoevaluacion);

            $params = [":idcoevaluacion" => $idcoevaluacion, ":indicador1" => $indicador1, ":indicador2" => $indicador2, ":indicador3" => $indicador3, ":indicador4" => $indicador4, ":indicador5" => $indicador5, ":total" => $total];
            $resp = Coevaluacion::Insert($params);
          
            echo json_encode($resp);
        }

    }

?>