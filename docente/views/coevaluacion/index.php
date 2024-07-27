<div class="container-fluid py-4">
            <div class="row">
                <div class="col-12">
                    <div class="card card-frame">
                        <div class="card-header bg-dark">
                            <h5 class="text-white">Registro de Evaluación por Pares</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <table class="table table-striped table-hover table-condensed">
                                        <thead class="bg-secondary text-light">
                                            <tr>
                                                <th class="text-center">#</th>
                                                <th class="text-center">Docente</th>
                                                <th class="text-center">Estado</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <?php 
                                            $i = 1;
                                            foreach($coevaluaciones as $row): 
                                                $docente = $row->apellidos.' '.$row->nombres;
                                        ?>
                                            <tr>
                                                <td class="text-center"><?php echo $i++; ?></td>
                                                <td><?php echo $docente; ?></td>
                                                <td class="text-center">
                                                    <?php if($row->estado){ ?>
                                                        <span class="badge bg-success">EVALUADO</span>
                                                    <?php } else{ ?>
                                                        <a id="<?php echo Main::encryption($row->idcoevaluacion); ?>" href="javascript:;" class="btn-warning" onclick="evaluar(this.id);"><span class="badge bg-warning">Evaluar</span></a>
                                                    <?php } ?>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="coevaluacionModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="coevaluacionModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content">
                    <div class="modal-header bg-info">
                        <h5 class="modal-title text-light" id="coevaluacionModalLabel"><strong>Rúbrica de Evaluación de Desempeño Docente - Heteroevaluación</strong></h5>
                        <button type="button" class="btn-close text-light" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="card">
                            <div class="card-header bg-secondary" style="height: 10px;">
                                <div class="row">
                                    <div class="col-6">
                                        <label id="docente" for="fecha" class="text-light"></label>
                                    </div>
                                    <div class="col-6">
                                        <?php 
                                            $resp = Area::findIdAreaDocente($_SESSION['iddocente_eval']); 
                                            
                                            foreach($resp as $row):
                                                $idarea = $row->idarea;
                                                $area = $row->area;
                                        ?>
                                            <label for="area" class="text-light"><strong>Área: </strong><?php echo $row->area; ?></label>
                                            <input type="hidden" id="idarea" name="idarea" class="form-control text-light" value="<?php echo Main::encryption($row->idarea); ?>">
                                        <?php endforeach; ?>
                                    </div>
                                    
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                <table class="table-hover table-condensed table-striped table-bordered text-center align-middle" style="font-size: 12px; table-layout: auto; width: 100%;">
                                    <input type="hidden" id="idcoevaluacion" name="idcoevaluacion" value="">
                                    <thead>
                                        <tr>
                                            <th scope="col" class="bg-success text-light">Indicadores</th>
                                            <th scope="col" class="bg-success text-light">Excelente (20 puntos)</th>
                                            <th scope="col" class="bg-success text-light">Muy Bien (15 puntos)</th>
                                            <th scope="col" class="bg-success text-light">Bien (10 puntos)</th>
                                            <th scope="col" class="bg-success text-light">Regular (5 puntos)</th>
                                            <th scope="col" class="bg-success text-light">Insuficiente (0 puntos)</th>
                                            <th scope="col" class="bg-warning text-light">Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php 
                                            $i = 0;
                                            $resp = Pregunta::findPreguntaArea($idarea);
                                            foreach($resp as $row):
                                                $i++;
                                        ?>
                                        <tr>
                                            <th scope="row" rowspan="2"><?php echo $row->titulo; ?></th>
                                            <td><?php echo $row->p1; ?></td>
                                            <td><?php echo $row->p2; ?></td>
                                            <td><?php echo $row->p3; ?></td>
                                            <td><?php echo $row->p4; ?></td>
                                            <td><?php echo $row->p5; ?></td>
                                            <td rowspan="2"><input type="text" class="form-control" id="totalindicador<?php echo $i; ?>" name="totalindicador<?php echo $i; ?>" style="background-color: #fff" disabled="true"></td>
                                        </tr>
                                        <tr class="bg-secondary">
                                            <td><input type="radio" id="indicador<?php echo $i; ?>" name="indicador<?php echo $i; ?>" value="20" class="form-radio mt-2"></td>
                                            <td><input type="radio" id="indicador<?php echo $i; ?>" name="indicador<?php echo $i; ?>" value="15" class="form-radio mt-2"></td>
                                            <td><input type="radio" id="indicador<?php echo $i; ?>" name="indicador<?php echo $i; ?>" value="10" class="form-radio mt-2"></td>
                                            <td><input type="radio" id="indicador<?php echo $i; ?>" name="indicador<?php echo $i; ?>" value="5" class="form-radio mt-2"></td>
                                            <td><input type="radio" id="indicador<?php echo $i; ?>" name="indicador<?php echo $i; ?>" value="0" class="form-radio mt-2"></td>
                                        </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th scope="col" colspan="6" class="bg-success text-light">TOTAL</th>
                                            <th class="bg-warning"><input type="text" class="form-control" id="total" name="total" style="background-color: #fff" disabled="true"></th>
                                        </tr>
                                    </tfoot>
                                </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" onclick="finalizar()">Finalizar</button>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer py-4  ">
            <div class="container-fluid">
            <div class="row align-items-center justify-content-lg-between">
                <div class="col-lg-6 mb-lg-0 mb-4">
                <div class="copyright text-center text-sm text-muted text-lg-start">
                    © <script>
                    document.write(new Date().getFullYear())
                    </script>,
                    <a href="https://www.itsup.edu.ec" class="font-weight-bold" target="_blank">ITSUP</a>
                    Todos los derechos reservados.
                </div>
                </div>
            </div>
            </div>
        </footer>
    </div>
  </main>
  <!-- JQuery -->
  <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <!--   Core JS Files   -->
  <script src="<?php echo DIR; ?>assets/js/core/popper.min.js"></script>
  <script src="<?php echo DIR; ?>assets/js/core/bootstrap.min.js"></script>
  <script src="<?php echo DIR; ?>assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="<?php echo DIR; ?>assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script src="<?php echo DIR; ?>assets/js/plugins/chartjs.min.js"></script>
  <!-- Validate JS -->
  <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
  <!-- JQuery-Confirm -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
  <!-- Axios -->
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
  <!-- Site JS -->
  <script src="<?php echo DIR; ?>functions/coevaluacion.js"></script>
  
  