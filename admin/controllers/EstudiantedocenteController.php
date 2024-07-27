<?php

    class EstudiantedocenteController
    {
        public function index()
        {
            $carreras = Carrera::findAll();
            $docentes = Docente::DocenteMateriaAll();

            view("estudiantedocente.index", ["carreras" => $carreras, "docentes" => $docentes]);
        }

        public function register()
        {
            $data = json_decode(file_get_contents('php://input'));

            $idsilabo = Main::limpiar_cadena($data->idsilabo);
            $idcarrera = Main::limpiar_cadena($data->idcarrera);
            $idsemestre = Main::limpiar_cadena($data->idsemestre);
            $jornada = $data->jornada;

            $idsilabo = Main::decryption($idsilabo);
            $idcarrera = Main::decryption($idcarrera);
            $idsemestre = Main::decryption($idsemestre);            

            $params = [":idcarrera" => $idcarrera, ":idsemestre" => $idsemestre, ":jornada" => $jornada];
            $estudiantes = Estudiante::findEstudiante($params);

            $i = count($estudiantes);
            $n = 0;
            foreach($estudiantes as $row){
                $params = [":idestudiante" => $row->idestudiante, ":idsilabo" => $idsilabo];
                $resp = Estudiantedocente::Register($params);

                if($resp){
                    $n = $n+1;
                }
            }

            echo json_encode(["i" => $i, "n" => $n]);
        }

        public function finddocenteidsemestre()
        {            
            $resp = Estudiantedocente::findDocenteIdSemestre();
            $rows = '';
            
            foreach ($resp as $row) {
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
                $rows.= '<tr>
                            <td class="text-center">'.$row->identificacion.'</td>
                            <td>'.$row->apellidos.'</td>
                            <td>'.$row->nombres.'</td>
                            <td>'.$row->materia.'</td>
                            <td class="text-center">'.$semestre.'</td>
                            <td class="text-center">'.$row->jornada.'</td>
                            <td></td>
                        </tr>';
            }

            echo json_encode($rows);
        }
    }

?>