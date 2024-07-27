<?php

    class SilabosController
    {
        public function index()
        {
            $docentes = Docente::findAll();
            $materias = Materia::findAll();

            view("silabos.index", ["docentes" => $docentes, "materias" => $materias]);
        }

        public function findiddocente($iddocente)
        {
            $iddocente = Main::limpiar_cadena($iddocente);
            $iddocente = Main::decryption($iddocente);
            
            $params = [":iddocente" => $iddocente];
            $resp = Silabos::FindIdDocente($params);

            $rows = '';
            $i = 1;
            foreach($resp as $row)
            {
                switch ($row->idsemestre) {
                    case 1:
                        $semestre = 'Primero';
                        break;
                    case 2:
                        $semestre = 'Segundo';
                        break;
                    case 3:
                        $semestre = 'Tercero';
                        break;
                    case 4:
                        $semestre = 'Cuarto';
                        break;
                    case 5:
                        $semestre = 'Quinto';
                        break;
                    case 6:
                        $semestre = 'Sexto';
                        break;
                }
                $rows.='<tr>
                            <th scope="row" class="text-center">'.$i++.'</th>
                            <td>'.$row->materia.'</td>
                            <td class="text-center">'.$semestre.'</td>
                            <td class="text-center">'.$row->paralelo.'</td>
                            <td class="text-center">'.$row->jornada.'</td>
                            <td class="text-center"><a href="javascript:;" id="'.Main::encryption($row->idsilabo).'" onclick="eliminarSilabo(this.id);"><span class="material-icons-round text-danger">delete_forever</span></a></td>
                        </tr>';
            }

            echo json_encode($rows);
        }

        public function finddocenteidmateria()
        {
            $data = json_decode(file_get_contents('php://input'));

            $iddocente = Main::limpiar_cadena($data->iddocente);
            $idsemestre = Main::limpiar_cadena($data->idsemestre);
            $paralelo = Main::limpiar_cadena($data->paralelo);
            $jornada = Main::limpiar_cadena($data->jornada);
            $idmateria = Main::limpiar_cadena($data->idmateria);

            $iddocente = Main::decryption($iddocente);
            $idsemestre = Main::decryption($idsemestre);
            $idmateria = Main::decryption($idmateria);

            $params = [":iddocente" => $iddocente, ":idsemestre" => $idsemestre, ":paralelo" => $paralelo, ":jornada" => $jornada, ":idmateria" => $idmateria];
            $resp = Silabos::FindDocenteIdMateria($params);

            echo json_encode($resp);
        }

        public function insert()
        {
            $data = json_decode(file_get_contents('php://input'));

            $iddocente = Main::limpiar_cadena($data->iddocente);
            $idsemestre = Main::limpiar_cadena($data->idsemestre);
            $paralelo = Main::limpiar_cadena($data->paralelo);
            $jornada = Main::limpiar_cadena($data->jornada);
            $idmateria = Main::limpiar_cadena($data->idmateria);

            $iddocente = Main::decryption($iddocente);
            $idsemestre = Main::decryption($idsemestre);
            $idmateria = Main::decryption($idmateria);

            $params = [":iddocente" => $iddocente, ":idsemestre" => $idsemestre, ":paralelo" => $paralelo, ":jornada" => $jornada, ":idmateria" => $idmateria];
            $resp = Silabos::Insert($params);

            $params = [":iddocente" => $iddocente];
            $resp = Silabos::FindIdDocente($params);

            $rows = '';
            $i = 1;
            foreach($resp as $row)
            {
                $rows.='<tr>
                            <td scope="row">'.$i++.'</td>
                            <td>'.$row->materia.'</td>
                            <td class="text-center">'.$row->idsemestre.'</td>
                            <td class="text-center">'.$row->paralelo.'</td>
                            <td class="text-center">'.$row->jornada.'</td>
                            <td class="text-center"><a href="javascript:;" id="'.Main::encryption($row->idsilabo).'" onclick="eliminarSilabo(this.id);"><span class="material-icons-round text-danger">delete_forever</span></a></td>
                        </tr>';
            }

            echo json_encode($rows);
        }

        public function delete($idsilabo)
        {
            $idsilabo = Main::limpiar_cadena($idsilabo);
            $idsilabo = Main::decryption($idsilabo);

            $params = [":idsilabo" => $idsilabo];
            $resp = Silabos::Delete($params);

            echo json_encode($resp);
        }
    }

?>