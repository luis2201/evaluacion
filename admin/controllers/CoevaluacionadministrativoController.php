<?php

    class CoevaluacionadministrativoController
    {
        public function index()
        {
            $administrativos = Administrativos::findAll();

            view("coevaluacionadministrativo.index", ["administrativos" => $administrativos]);
        }

        public function selectevaluadoradministrativo($idevaluador)
        {
            $idevaluador = Main::limpiar_cadena($idevaluador);
            $idevaluador = Main::decryption($idevaluador);

            $params = [":idevaluador" => $idevaluador];
            $resp = Coevaluacionadministrativo::SelectEvaluadorAdministrativo($params);

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
            $idadministrativo = Main::limpiar_cadena($data->idadministrativo);

            $idevaluador = Main::decryption($idevaluador);
            $idadministrativo = Main::decryption($idadministrativo);

            $params = [":idevaluador" => $idevaluador, ":idadministrativo" => $idadministrativo];
            $resp = Coevaluacionadministrativo::Insert($params);
            
            $params = [":idevaluador" => $idevaluador];
            $resp = Coevaluacionadministrativo::SelectEvaluadorAdministrativo($params);

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
            $idcoevaluacion = Main::limpiar_cadena($data->idcoevaluacionadministrativo);

            $idevaluador = Main::decryption($idevaluador);
            $idcoevaluacion = Main::decryption($idcoevaluacion);

            $params = [":idcoevaluacion" => $idcoevaluacion];
            $resp = Coevaluacionadministrativo::Delete($params);
            
            $params = [":idevaluador" => $idevaluador];
            $resp = Coevaluacionadministrativo::SelectEvaluadorAdministrativo($params);
            $rows = '';
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