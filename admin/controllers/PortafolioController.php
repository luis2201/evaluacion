<?php

    class PortafolioController
    {
        public function index()
        {
            $docentes = Docente::findAll();

            view("portafolio.index", ["docentes" => $docentes]);
        }

        public function finddocentecriterio($iddocente)
        {
            $iddocente = Main::limpiar_cadena($iddocente);
            $iddocente = Main::decryption($iddocente);

            $params = ["iddocente" => $iddocente];
            $resp = Portafolio::findDocenteCriterio($params);
            $silabo = '';
            $rows = '';

            foreach($resp as $row){
                $documento = explode(".", $row->documento);

                if($row->idcriterio!=9){
                    $rows .='<tr>
                                <td class="text-center">'.$row->idcriterio.'</td>
                                <td>'.$row->criterio.'</td>
                                <td class="text-center"><a href="viewDocument.php?documento='.$documento[0].'" target="_blank" title="Ver documento"><span class="material-icons opacity-10 text-info">visibility</span></a></td>
                            </tr>';
                } else{
                    $silabos = Silabos::findIdDocente($params);
                    foreach($silabos as $s){
                        $pdf = explode(".", $s->silabo);
                        $srow .= '<a href="viewDocument.php?documento='.$pdf[0].'" target="_blank" title="Ver documento"><span class="material-icons opacity-10 text-info">visibility</span></a>';
                    }

                    $rows .='<tr>
                                <td class="text-center">'.$row->idcriterio.'</td>
                                <td>'.$row->criterio.'</td>
                                <td class="text-center">'
                                .$srow.
                                '</td>
                            </tr>';
                }
                
            }
           
            echo json_encode($rows);
        }

    }

?>