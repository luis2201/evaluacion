<?php

    class CoevaluacionController
    {
        public function index()
        {
            $docentes = Docente::findAll();

            view("coevaluacion.index", ["docentes" => $docentes]);
        }

        public function selectevaluadordocente($idevaluador)
        {
            $idevaluador = Main::limpiar_cadena($idevaluador);
            $idevaluador = Main::decryption($idevaluador);

            $params = [":idevaluador" => $idevaluador];
            $resp = Coevaluacion::SelectEvaluadorDocente($params);

            foreach($resp as $row)
            {
                $rows.= '<tr>
                            <td>'.$row->apellidos.' '.$row->nombres.'</td>
                            <td><a href="javascript:;" id="'.Main::encryption($row->idcoevaluacion).'" onclick="eliminar(this.id)"><span class="material-icons-round text-warning">delete_forever</span></a></td>
                        </tr>';
            }

            echo json_encode($rows);
        }

        public function insert()
        {
            $data = json_decode(file_get_contents('php://input'));

            $idevaluador = Main::limpiar_cadena($data->idevaluador);
            $iddocente = Main::limpiar_cadena($data->iddocente);

            $idevaluador = Main::decryption($idevaluador);
            $iddocente = Main::decryption($iddocente);

            $params = [":idevaluador" => $idevaluador, ":iddocente" => $iddocente];
            $resp = Coevaluacion::Insert($params);
            
            $params = [":idevaluador" => $idevaluador];
            $resp = Coevaluacion::SelectEvaluadorDocente($params);

            foreach($resp as $row)
            {
                $rows.= '<tr>
                            <td>'.$row->apellidos.' '.$row->nombres.'</td>
                            <td><a href="javascript:;" id="'.Main::encryption($row->idcoevaluacion).'" onclick="eliminar(this.id)"><span class="material-icons-round text-warning">delete_forever</span></a></td>
                        </tr>';
            }

            echo json_encode($rows);
        }

        public function delete()
        {
            $data = json_decode(file_get_contents('php://input'));

            $idevaluador = Main::limpiar_cadena($data->idevaluador);
            $idcoevaluacion = Main::limpiar_cadena($data->idcoevaluacion);

            $idevaluador = Main::decryption($idevaluador);
            $idcoevaluacion = Main::decryption($idcoevaluacion);

            $params = [":idcoevaluacion" => $idcoevaluacion];
            $resp = Coevaluacion::Delete($params);
            
            $params = [":idevaluador" => $idevaluador];
            $resp = Coevaluacion::SelectEvaluadorDocente($params);

            foreach($resp as $row)
            {
                $rows.= '<tr>
                            <td>'.$row->apellidos.' '.$row->nombres.'</td>
                            <td><a href="javascript:;" id="'.Main::encryption($row->idcoevaluacion).'" onclick="eliminar(this.id)"><span class="material-icons-round text-warning">delete_forever</span></a></td>
                        </tr>';
            }

            echo json_encode($rows);
        }

    }

?>