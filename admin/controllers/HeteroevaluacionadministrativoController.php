<?php

    class HeteroevaluacionadministrativoController
    {
        public function index()
        {
            $autoridades = Autoridades::findAll();
            $administrativos = Administrativos::findAll();

            view("heteroevaluacionadministrativo.index", ["autoridades" => $autoridades, "administrativos" => $administrativos]);
        }

        public function insert()
        {
            $data = json_decode(file_get_contents('php://input'));

            $idautoridad = Main::limpiar_cadena($data->idautoridad);
            $idadministrativo = Main::limpiar_cadena($data->idadministrativo);

            $idautoridad = Main::decryption($idautoridad);
            $idadministrativo = Main::decryption($idadministrativo);

            $params = [":idautoridad" => $idautoridad, ":idadministrativo" => $idadministrativo];
            $resp = Heteroevaluacionadministrativo::Insert($params);
            
            $params = [":idautoridad" => $idautoridad];
            $resp = Heteroevaluacionadministrativo::SelectAutoridadAdministrativo($params);

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
            $resp = Heteroevaluacion::SelectAutoridadAdministrativo($params);

            foreach($resp as $row)
            {
                $rows.= '<tr>
                            <td>'.$row->apellidos.' '.$row->nombres.'</td>
                            <td><a href="javascript:;" id="'.Main::encryption($row->idheteroevaluacion).'" onclick="eliminar(this.id)"><span class="material-icons-round text-warning">delete_forever</span></a></td>
                        </tr>';
            }

            echo json_encode($rows);
        }

        public function selectautoridadadministrativo($idautoridad)
        {
            $idautoridad = Main::limpiar_cadena($idautoridad);
            $idautoridad = Main::decryption($idautoridad);

            $params = [":idautoridad" => $idautoridad];
            $resp = Heteroevaluacionadministrativo::SelectAutoridadAdministrativo($params);

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