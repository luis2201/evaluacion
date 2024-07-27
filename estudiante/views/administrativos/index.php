        <input type="hidden" id="idestudiante" value="<?php echo Main::encryption($_SESSION['idestudiante_eval']); ?>">
        <div class="container-fluid py-4">
          <div class="row">
            <div class="col-12">
              <div class="card card-frame">
                <div class="card-header bg-dark">
                  <h5 class="text-white">Registro de Evaluación Estudiante - Administrativos</h5>
                </div>
                <div class="card-body">
                  <div class="row">
                    <div class="col-12">
                      <div class="table-responsive" style="width: 100%;">
                      <table class="table table-striped table-hover table-condensed table-bordered" style="width: 100%; font-size:smaller;" >
                        <thead class="bg-secondary text-light">
                          <tr>
                            <th colspan="6" class="bg-info text-center">RESPECTO A LA ATENCIÓN BRINDADA POR LOS ADMINISTRATIVOS</th>
                          </tr>
                          <tr>
                            <th rowspan="2" class="text-uppercase">
                              ¿Qué tan satisfecho estás con La capacidad<br>
                              de respuesta y amabilidad brindada por los<br>
                              siguientes administradores que lo han atendido?
                            </th>
                            <th class="text-center">Deficiente</th>
                            <th class="text-center">Regular</th>
                            <th class="text-center">Bueno</th>
                            <th class="text-center">Muy Bueno</th>
                            <th class="text-center">Excelente</th>
                          </tr>
                          <tr>
                            <th class="text-center">20 pts.</th>
                            <th class="text-center">40 pts.</th>
                            <th class="text-center">60 pts.</th>
                            <th class="text-center">80 pts.</th>
                            <th class="text-center">100 pts.</th>                            
                          </tr>                          
                        </thead>
                        <tbody>
                        <?php
                          
                          $i = 1;
                          foreach ($administrativos as $row) :                            
                            $resp = Administrativos::validaEvaluacion([":idestudiante" => $_SESSION['idestudiante_eval'], ":idadministrativo" => $row->idadministrativo]);
                            
                            foreach($resp as $heteroevaluacion){                              
                              $num = $heteroevaluacion->num;
                            }
                            
                            if($num == 0){
                         ?>                          
                            <tr>                              
                              <td><strong><?php echo $row->cargo; ?>: </strong><?php echo $row->administrativo; ?></td>
                              <td class="text-center"><input type="radio" id="<?php echo Main::encryption($row->idadministrativo); ?>" name="cal<?php echo $i; ?>" value="20" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="<?php echo Main::encryption($row->idadministrativo); ?>" name="cal<?php echo $i; ?>" value="40" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="<?php echo Main::encryption($row->idadministrativo); ?>" name="cal<?php echo $i; ?>" value="60" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="<?php echo Main::encryption($row->idadministrativo); ?>" name="cal<?php echo $i; ?>" value="80" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="<?php echo Main::encryption($row->idadministrativo); ?>" name="cal<?php echo $i; ?>" value="100" class="form-radio mt-2"></td>                              
                            </tr>
                          <?php } endforeach; ?>
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
        <script src="<?php echo DIR; ?>functions/administrativos.js"></script>