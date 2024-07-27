<?php

    class ResultadosdocentesController
    {
        public function index()
        {
            //$resultados = Resultadosdocentes::findAll();
            $docentes = Docente::findAll();
            view("resultadosdocentes.index", ["docentes" => $docentes]);
            // view("resultadosdocentes.index", ["resultados" => $resultados]);
        }        

        public function findid($iddocente)
        {
            $iddocente = Main::limpiar_cadena($iddocente);
            $iddocente = Main::decryption($iddocente);
            $rows = '';
            $params = [":iddocente" => $iddocente];            

            $auto = Resultadosdocentes::Autoevaluacion($params);
            foreach($auto as $row)
            {
                $a1 = number_format($row->indicador1, 2);
                $a2 = number_format($row->indicador2, 2);
                $a3 = number_format($row->indicador3, 2);
                $a4 = number_format($row->indicador4, 2);
                $a5 = number_format($row->indicador5, 2);
                $at = number_format($row->total, 2);
            }

            $coe = Resultadosdocentes::Coevaluacion($params);                
            foreach($coe as $row){
                $c1 = number_format($row->indicador1, 2);
                $c2 = number_format($row->indicador2, 2);
                $c3 = number_format($row->indicador3, 2);
                $c4 = number_format($row->indicador4, 2);
                $c5 = number_format($row->indicador5, 2);
                $ct = number_format($row->total, 2);
            }                    

            $vin = Resultadosdocentes::ResultadoArea([":iddocente" => $iddocente, ":idarea" => 1]);                
            foreach($vin as $row){
                $v1 = number_format($row->indicador1, 2);
                $v2 = number_format($row->indicador2, 2);
                $v3 = number_format($row->indicador3, 2);
                $v4 = number_format($row->indicador4, 2);
                $v5 = number_format($row->indicador5, 2);
                $vt = number_format($row->total, 2);
            }

            $inv = Resultadosdocentes::ResultadoArea([":iddocente" => $iddocente, ":idarea" => 2]);                
            foreach($inv as $row){
                $i1 = number_format($row->indicador1, 2);
                $i2 = number_format($row->indicador2, 2);
                $i3 = number_format($row->indicador3, 2);
                $i4 = number_format($row->indicador4, 2);
                $i5 = number_format($row->indicador5, 2);
                $it = number_format($row->total, 2);
            }

            $gest = Resultadosdocentes::ResultadoArea([":iddocente" => $iddocente, ":idarea" => 3]);                
            foreach($gest as $row){
                $g1 = number_format($row->indicador1, 2);
                $g2 = number_format($row->indicador2, 2);
                $g3 = number_format($row->indicador3, 2);
                $g4 = number_format($row->indicador4, 2);
                $g5 = number_format($row->indicador5, 2);
                $gt = number_format($row->total, 2);
            }

            $doc = Resultadosdocentes::ResultadoArea([":iddocente" => $iddocente, ":idarea" => 4]);                
            foreach($doc as $row){
                $d1 = number_format($row->indicador1, 2);
                $d2 = number_format($row->indicador2, 2);
                $d3 = number_format($row->indicador3, 2);
                $d4 = number_format($row->indicador4, 2);
                $d5 = number_format($row->indicador5, 2);
                $dt = number_format($row->total, 2);
            }

            $est = Resultadosdocentes::ResultadoEstudiante([":iddocente" => $iddocente]);                
            foreach($est as $row){
                $e1 = number_format($row->indicador1, 2);
                $e2 = number_format($row->indicador2, 2);
                $e3 = number_format($row->indicador3, 2);
                $e4 = number_format($row->indicador4, 2);
                $e5 = number_format($row->indicador5, 2);
                $et = number_format($row->total, 2);
                $en = $row->num;
            }

            // $avr = Resultadosdocentes::ResultadoArea([":iddocente" => $iddocente, ":idarea" => 5]);                
            // foreach($avi as $row){
            //     $r1 = number_format($row->indicador1, 2);
            //     $r2 = number_format($row->indicador2, 2);
            //     $r3 = number_format($row->indicador3, 2);
            //     $r4 = number_format($row->indicador4, 2);
            //     $r5 = number_format($row->indicador5, 2);
            //     $rt = number_format($row->total, 2);
            // }

            // $adm = Resultadosdocentes::ResultadoArea([":iddocente" => $iddocente, ":idarea" => 6]);                
            // foreach($adm as $row){
            //     $m1 = number_format($row->indicador1, 2);
            //     $m2 = number_format($row->indicador2, 2);
            //     $m3 = number_format($row->indicador3, 2);
            //     $m4 = number_format($row->indicador4, 2);
            //     $m5 = number_format($row->indicador5, 2);
            //     $mt = number_format($row->total, 2);
            // }

            $rows.='<tr>
                <td>1</td>
                <td class="text-wrap">Indicador 1</td>
                <td class="text-center">'.$a1.'</td>
                <td class="text-center">'.$c1.'</td>                        
                <td class="text-center">'.$v1.'</td>                
                <td class="text-center">'.$i1.'</td>
                <td class="text-center">'.$g1.'</td>
                <td class="text-center">'.$d1.'</td>
                <td class="text-center">'.$e1.'</td>
            </tr>
            <tr>
                <td>2</td>
                <td class="text-wrap">Indicador 2</td>
                <td class="text-center">'.$a2.'</td>
                <td class="text-center">'.$c2.'</td>                        
                <td class="text-center">'.$v2.'</td>
                <td class="text-center">'.$i2.'</td>
                <td class="text-center">'.$g2.'</td>
                <td class="text-center">'.$d2.'</td>
                <td class="text-center">'.$e2.'</td>
            </tr>
            <tr>
                <td>3</td>
                <td class="text-wrap">Indicador 3</td>
                <td class="text-center">'.$a3.'</td>
                <td class="text-center">'.$c3.'</td>                        
                <td class="text-center">'.$v3.'</td>
                <td class="text-center">'.$i3.'</td>
                <td class="text-center">'.$g3.'</td>
                <td class="text-center">'.$d3.'</td>
                <td class="text-center">'.$e3.'</td>
            </tr>
            <tr>
                <td>4</td>
                <td class="text-wrap">Indicador 4</td>
                <td class="text-center">'.$a4.'</td>
                <td class="text-center">'.$c4.'</td>                        
                <td class="text-center">'.$v4.'</td>
                <td class="text-center">'.$i4.'</td>
                <td class="text-center">'.$g4.'</td>
                <td class="text-center">'.$d4.'</td>
                <td class="text-center">'.$e4.'</td>
            </tr>
            <tr>
                <td>5</td>
                <td class="text-wrap">Indicador 5</td>
                <td class="text-center">'.$a5.'</td>
                <td class="text-center">'.$c5.'</td>                        
                <td class="text-center">'.$v5.'</td>
                <td class="text-center">'.$i5.'</td>
                <td class="text-center">'.$g5.'</td>
                <td class="text-center">'.$d5.'</td>
                <td class="text-center">'.$e5.'</td>
            </tr>
            <tr>
                <th colspan="2" class="text-center">PUNTAJE TOTAL</th>                
                <th class="text-center">'.$at.'</th>
                <th class="text-center">'.$ct.'</th>                        
                <th class="text-center">'.$vt.'</th>
                <th class="text-center">'.$it.'</th>
                <th class="text-center">'.$gt.'</th>
                <th class="text-center">'.$dt.'</th>
                <th class="text-center">'.$et.'</th>
            </tr>
            <tr>
                <th colspan="8" class="text-center text-danger">* Evaluado por '.$en.' estudiante(s)
            </tr>';

            echo json_encode($rows);            
        }
    }

?>