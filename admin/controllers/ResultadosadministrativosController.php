<?php

    class ResultadosadministrativosController
    {
        public function index()
        {
            // $resultados = Resultadosadministrativos::findAll();
            // view("resultadosadministrativos.index", ["resultados" => $resultados]);

            $administrativos = Administrativos::findAll();
            view("resultadosadministrativos.index", ["administrativos" => $administrativos]);
        }

        public function findid($idadministrativo)
        {
            $idadministrativo = Main::limpiar_cadena($idadministrativo);
            $idadministrativo = Main::decryption($idadministrativo);
            $rows = '';
            $params = [":idadministrativo" => $idadministrativo];            

            $auto = Resultadosadministrativos::Autoevaluacion($params);
            foreach($auto as $row)
            {
                $a1 = number_format($row->indicador1, 2);
                $a2 = number_format($row->indicador2, 2);
                $a3 = number_format($row->indicador3, 2);
                $a4 = number_format($row->indicador4, 2);
                $a5 = number_format($row->indicador5, 2);
                $a6 = number_format($row->indicador6, 2);
                $a7 = number_format($row->indicador7, 2);
                $a8 = number_format($row->indicador8, 2);
                $a9 = number_format($row->indicador9, 2);
                $a10 = number_format($row->indicador10, 2);
                $at = number_format($row->total, 2);
            }

            $coe = Resultadosadministrativos::Coevaluacion($params);                
            foreach($coe as $row){
                $c1 = number_format($row->indicador1, 2);
                $c2 = number_format($row->indicador2, 2);
                $c3 = number_format($row->indicador3, 2);
                $c4 = number_format($row->indicador4, 2);
                $c5 = number_format($row->indicador5, 2);
                $c6 = number_format($row->indicador6, 2);
                $c7 = number_format($row->indicador7, 2);
                $c8 = number_format($row->indicador8, 2);
                $c9 = number_format($row->indicador9, 2);
                $c10 = number_format($row->indicador10, 2);
                $ct = number_format($row->total, 2);
            }
            
            $het = Resultadosadministrativos::Heteroevaluacion($params);                
            foreach($het as $row){
                $h1 = number_format($row->indicador1, 2);
                $h2 = number_format($row->indicador2, 2);
                $h3 = number_format($row->indicador3, 2);
                $h4 = number_format($row->indicador4, 2);
                $h5 = number_format($row->indicador5, 2);
                $h6 = number_format($row->indicador6, 2);
                $h7 = number_format($row->indicador7, 2);
                $h8 = number_format($row->indicador8, 2);
                $h9 = number_format($row->indicador9, 2);
                $h10 = number_format($row->indicador10, 2);
                $ht = number_format($row->total, 2);
            }

            $rows.='<tr>
                        <td>Indicador 1</td>                
                        <td class="text-center">'.$a1.'</td>
                        <td class="text-center">'.$c1.'</td>                        
                        <td class="text-center">'.$h1.'</td>               
                    </tr>
                    <tr>
                        <td>Indicador 2</td>                
                        <td class="text-center">'.$a2.'</td>
                        <td class="text-center">'.$c2.'</td>                        
                        <td class="text-center">'.$h2.'</td>
                    </tr>
                    <tr>
                        <td>Indicador 3</td>                
                        <td class="text-center">'.$a3.'</td>
                        <td class="text-center">'.$c3.'</td>                        
                        <td class="text-center">'.$h3.'</td>
                    </tr>
                    <tr>
                        <td>Indicador 4</td>                
                        <td class="text-center">'.$a4.'</td>
                        <td class="text-center">'.$c4.'</td>                        
                        <td class="text-center">'.$h4.'</td>
                    </tr>
                    <tr>
                        <td>Indicador 5</td>                
                        <td class="text-center">'.$a5.'</td>
                        <td class="text-center">'.$c5.'</td>                        
                        <td class="text-center">'.$h5.'</td>
                    </tr>
                    <tr>
                        <td>Indicador 6</td>                
                        <td class="text-center">'.$a6.'</td>
                        <td class="text-center">'.$c6.'</td>                        
                        <td class="text-center">'.$h6.'</td>               
                    </tr>
                    <tr>
                        <td>Indicador 7</td>                
                        <td class="text-center">'.$a7.'</td>
                        <td class="text-center">'.$c7.'</td>                        
                        <td class="text-center">'.$h7.'</td>
                    </tr>
                    <tr>
                        <td>Indicador 8</td>                
                        <td class="text-center">'.$a8.'</td>
                        <td class="text-center">'.$c8.'</td>                        
                        <td class="text-center">'.$h8.'</td>
                    </tr>
                    <tr>
                        <td>Indicador 9</td>                
                        <td class="text-center">'.$a9.'</td>
                        <td class="text-center">'.$c9.'</td>                        
                        <td class="text-center">'.$h9.'</td>
                    </tr>
                    <tr>
                        <td>Indicador 10</td>                
                        <td class="text-center">'.$a10.'</td>
                        <td class="text-center">'.$c10.'</td>                        
                        <td class="text-center">'.$h10.'</td>
                    </tr>
                    <tr>
                        <th class="text-center">PUNTAJE TOTAL</th>                
                        <th class="text-center">'.$at.'</th>
                        <th class="text-center">'.$ct.'</th>                        
                        <th class="text-center">'.$ht.'</th>
                    </tr>';

            echo json_encode($rows);            
        }
    }

?>