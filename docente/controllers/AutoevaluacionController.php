<?php

    class AutoevaluacionController
    {
        public function index()
        { 
            $autoevaluaciones = Autoevaluacion::SelectAutoevaluacionDocente([":iddocente" => $_SESSION['iddocente_eval']]);

            view("autoevaluacion.index", ["autoevaluaciones" => $autoevaluaciones]);
        }

        public function findautoevaluaciondocente($idautoevaluacion)
        {
            $idautoevaluacion = Main::limpiar_cadena($idautoevaluacion);
            $idautoevaluacion = Main::decryption($idautoevaluacion);
            
            $params = [":idautoevaluacion" => $idautoevaluacion];
            $resp = Autoevaluacion::findAutoevaluacionDocente($params);

            echo json_encode($resp);
        }

        public function insert()
        {
            $data = json_decode(file_get_contents('php://input'));

            $idautoevaluacion = Main::limpiar_cadena($data->idautoevaluacion);
            $indicador1 = Main::limpiar_cadena($data->indicador1);
            $indicador2 = Main::limpiar_cadena($data->indicador2);
            $indicador3 = Main::limpiar_cadena($data->indicador3);
            $indicador4 = Main::limpiar_cadena($data->indicador4);
            $indicador5 = Main::limpiar_cadena($data->indicador5);
            $total = Main::limpiar_cadena($data->total);

            $idautoevaluacion = Main::decryption($idautoevaluacion);

            $params = [":idautoevaluacion" => $idautoevaluacion, ":indicador1" => $indicador1, ":indicador2" => $indicador2, ":indicador3" => $indicador3, ":indicador4" => $indicador4, ":indicador5" => $indicador5, ":total" => $total];
            $resp = Autoevaluacion::Insert($params);
          
            echo json_encode($resp);
        }
    }

?>