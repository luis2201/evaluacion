<?php

    class EstudianteController
    {
        public function index()
        {
            $carreras = Carrera::findAll();
            $estudiantes = Estudiante::findAll(); 

            view("estudiante.index", ["carreras" => $carreras, "estudiantes" => $estudiantes]);
        }

        public function findestudiante()
        {
            $idcarrera = Main::limpiar_cadena($_POST["idcarrera"]);
            $idsemestre = Main::limpiar_cadena($_POST["idsemestre"]);
            $jornada = Main::limpiar_cadena($_POST["jornada"]);
            
            $idcarrera = Main::decryption($_POST["idcarrera"]);
            $idsemestre = Main::decryption($_POST["idsemestre"]);

            $params= [":idcarrera" => $idcarrera, ":idsemestre" => $idsemestre, ":jornada" => $jornada];
            $resp = Estudiante::findEstudiante($params);

            foreach($resp as $row){
                $estados = Estudiante::validaEstado([":idestudiante" => $idestudiante]);
                $rows .= '<tr>
                            <td class="text-center">'.$row->idestudiante.'</td>
                            <td class="text-center">'.$row->cedula.'</td>
                            <td>'.$row->nombres.'</td>
                            <td class="text-center">'.$row->contrasena.'</td>
                        </tr>';
            }

            echo json_encode($rows);
        }

    }

?>