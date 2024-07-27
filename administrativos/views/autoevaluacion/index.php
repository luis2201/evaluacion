        <div class="container-fluid py-4">
            <div class="row">
                <div class="col-12">
                    <div class="card card-frame">
                        <div class="card-header bg-dark">
                            <h5 class="text-white">Registro de Autoevaluación Administrativo</h5>
                        </div>
                        <div class="card-body">
                        <?php
                            $fechaActual = date('Y-m-d');
                            if($fechaActual<=date('2024-04-11')){
                        ?>
                            <div class="row">
                                <div class="col-12">
                                    <table class="table table-striped table-hover table-condensed">
                                        <thead class="bg-secondary text-light">
                                            <tr>
                                                <th class="text-center">#</th>
                                                <th class="text-center">Administrativo</th>
                                                <th class="text-center">Estado</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <?php 
                                            $i = 0;
                                            foreach($autoevaluaciones as $row): 
                                                $administrativo = $row->apellidos.' '.$row->nombres;
                                                $i++;
                                        ?>
                                                <tr>
                                                    <td class="text-center"><?php echo $i; ?></td>
                                                    <td><?php echo $row->apellidos.' '.$row->nombres; ?></td>
                                                    <td class="text-center">
                                                        <?php if($row->estado){ ?>
                                                            <span class="badge bg-success">EVALUADO</span>
                                                        <?php } else{ ?>
                                                            <a id="<?php echo Main::encryption($row->idautoevaluacion); ?>" href="javascript:;" class="btn-warning" onclick="evaluar(this.id);"><span class="badge bg-warning">Evaluar</span></a>
                                                        <?php } ?>
                                                    </td>
                                                </tr>
                                            <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        <?php } else { ?>
                            <div class="row">
                            <div class="alert alert-primary alert-dismissible text-white fade show" role="alert">
                                <span class="alert-icon align-middle">
                                    <span class="material-icons text-md">
                                        notifications
                                    </span>
                                </span>
                                <span class="alert-text"><strong>Alerta!</strong> La fecha para registrar la Autoevaluación ha expirado!</span>
                            </div>
                            </div>
                        <?php } ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="autoevaluacionModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="autoevaluacionModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content">
                    <div class="modal-header bg-info">
                        <h5 class="modal-title text-light" id="autoevaluacionModalLabel"><strong>Rúbrica de Evaluación de Desempeño administrativo - Autoevaluación</strong></h5>
                        <button type="button" class="btn-close text-light" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="card">
                            <div class="card-header bg-secondary" style="height: 10px;">
                                <div class="row">
                                    <div class="col-6">
                                        <label id="administrativo" for="fecha" class="text-light"></label>
                                    </div>
                                    <div class="col-6">
                                        <?php 
                                            $resp = Area::findIdAreaadministrativo($_SESSION['idadministrativo_eval']); 
                                            
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
                                    <input type="hidden" id="idautoevaluacion" name="idautoevaluacion" value="">
                                    <thead>
                                        <tr>
                                            <th scope="col" class="bg-success text-light">Indicadores</th>
                                            <th scope="col" class="bg-success text-light">Excelente (20 puntos)</th>
                                            <th scope="col" class="bg-success text-light">Muy Bueno (15 puntos)</th>
                                            <th scope="col" class="bg-success text-light">Bueno (10 puntos)</th>
                                            <th scope="col" class="bg-success text-light">Regular (5 puntos)</th>
                                            <th scope="col" class="bg-success text-light">Deficiente (1 puntos)</th>
                                            <th scope="col" class="bg-warning text-light">Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php 
                                            $i = 0;
                                            $resp = Pregunta::findPreguntaAreaAutoevaluacion($idarea);
                                            
                                            foreach($resp as $row):
                                                $i++;
                                        ?>
                                        <tr>
                                            <th scope="row"><?php echo $row->titulo; ?></th>                                            
                                            <td class="bg-dark"><input type="radio" id="indicador<?php echo $i; ?>" name="indicador<?php echo $i; ?>" value="20" class="form-radio mt-2"></td>
                                            <td class="bg-dark"><input type="radio" id="indicador<?php echo $i; ?>" name="indicador<?php echo $i; ?>" value="15" class="form-radio mt-2"></td>
                                            <td class="bg-dark"><input type="radio" id="indicador<?php echo $i; ?>" name="indicador<?php echo $i; ?>" value="10" class="form-radio mt-2"></td>
                                            <td class="bg-dark"><input type="radio" id="indicador<?php echo $i; ?>" name="indicador<?php echo $i; ?>" value="5" class="form-radio mt-2"></td>
                                            <td class="bg-dark"><input type="radio" id="indicador<?php echo $i; ?>" name="indicador<?php echo $i; ?>" value="1" class="form-radio mt-2"></td>
                                            <td><input type="text" class="form-control text-center" id="totalindicador<?php echo $i; ?>" name="totalindicador<?php echo $i; ?>" style="background-color: #fff" disabled="true"></td>
                                        </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th scope="col" colspan="6" class="bg-success text-light">TOTAL</th>
                                            <th class="bg-warning"><input type="text" class="form-control text-center" id="total" name="total" style="background-color: #fff" disabled="true"></th>
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
  <script src="<?php echo DIR; ?>functions/global.js?v=1.0.0"></script>
  <script src="<?php echo DIR; ?>functions/autoevaluacion.js?v=1.0.1"></script>
  
  