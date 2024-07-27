<?php

    class HeteroevaluacionController
    {
        public function index()
        {  
            $heteroevaluaciones = Heteroevaluacion::SelectEstudianteDocente([":idestudiante" => $_SESSION['idestudiante_eval']]);

            view("heteroevaluacion.index", ["heteroevaluaciones" => $heteroevaluaciones]);
        }

        public function findheteroevaluaciondocente($idevaluacion)
        {
            $idevaluacion = Main::limpiar_cadena($idevaluacion);
            $idevaluacion = Main::decryption($idevaluacion);
            
            $params = [":idevaluacion" => $idevaluacion];
            $resp = Heteroevaluacion::findHeteroevaluacionDocente($params);

            echo json_encode($resp);
        }

        public function insertar()
        {
            $data = json_decode(file_get_contents('php://input'));

            $idevaluacion = Main::limpiar_cadena($data->idevaluacion);
            $indicador1 = Main::limpiar_cadena($data->indicador1);
            $indicador2 = Main::limpiar_cadena($data->indicador2);
            $indicador3 = Main::limpiar_cadena($data->indicador3);
            $indicador4 = Main::limpiar_cadena($data->indicador4);
            $indicador5 = Main::limpiar_cadena($data->indicador5);
            $total = Main::limpiar_cadena($data->total);

            $idevaluacion = Main::decryption($idevaluacion);

            $params = [":idevaluacion" => $idevaluacion, ":indicador1" => $indicador1, ":indicador2" => $indicador2, ":indicador3" => $indicador3, ":indicador4" => $indicador4, ":indicador5" => $indicador5, ":total" => $total];
            $resp = Heteroevaluacion::Insert($params);
          
            echo json_encode($resp);
        }

    }

?>