<?php

    class HeteroevaluacionController
    {
        public function index()
        {
            $autoridades = Autoridades::findAll();
            $docentes = Docente::findAll();

            view("heteroevaluacion.index", ["autoridades" => $autoridades, "docentes" => $docentes]);
        }

        public function insert()
        {
            $data = json_decode(file_get_contents('php://input'));

            $idautoridad = Main::limpiar_cadena($data->idautoridad);
            $iddocente = Main::limpiar_cadena($data->iddocente);

            $idautoridad = Main::decryption($idautoridad);
            $iddocente = Main::decryption($iddocente);

            $params = [":idautoridad" => $idautoridad, ":iddocente" => $iddocente];
            $resp = Heteroevaluacion::Insert($params);
            
            $params = [":idautoridad" => $idautoridad];
            $resp = Heteroevaluacion::SelectAutoridadDocente($params);

            foreach($resp as $row)
            {
                $rows.= '<tr>
                            <td>'.$row->apellidos.' '.$row->nombres.'</td>
                            <td><a href="javascript:;" id="'.Main::encryption($row->idheteroevaluacion).'" onclick="eliminar(this.id)"><span class="material-icons-round text-warning">delete_forever</span></a></td>
                        </tr>';
            }

            echo json_encode($rows);
        }

        public function delete()
        {
            $data = json_decode(file_get_contents('php://input'));

            $idautoridad = Main::limpiar_cadena($data->idautoridad);
            $idheteroevaluacion = Main::limpiar_cadena($data->idheteroevaluacion);

            $idautoridad = Main::decryption($idautoridad);
            $idheteroevaluacion = Main::decryption($idheteroevaluacion);

            $params = [":idheteroevaluacion" => $idheteroevaluacion];
            $resp = Heteroevaluacion::Delete($params);
            
            $params = [":idautoridad" => $idautoridad];
            $resp = Heteroevaluacion::SelectAutoridadDocente($params);

            foreach($resp as $row)
            {
                $rows.= '<tr>
                            <td>'.$row->apellidos.' '.$row->nombres.'</td>
                            <td><a href="javascript:;" id="'.Main::encryption($row->idheteroevaluacion).'" onclick="eliminar(this.id)"><span class="material-icons-round text-warning">delete_forever</span></a></td>
                        </tr>';
            }

            echo json_encode($rows);
        }

        public function selectautoridaddocente($idautoridad)
        {
            $idautoridad = Main::limpiar_cadena($idautoridad);
            $idautoridad = Main::decryption($idautoridad);

            $params = [":idautoridad" => $idautoridad];
            $resp = Heteroevaluacion::SelectAutoridadDocente($params);

            foreach($resp as $row)
            {
                $rows.= '<tr>
                            <td>'.$row->apellidos.' '.$row->nombres.'</td>
                            <td><a href="javascript:;" id="'.Main::encryption($row->idheteroevaluacion).'" onclick="eliminar(this.id)"><span class="material-icons-round text-warning">delete_forever</span></a></td>
                        </tr>';
            }

            echo json_encode($rows);
        }
    }

?>