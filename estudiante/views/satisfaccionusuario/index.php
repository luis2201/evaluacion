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
                            <th colspan="6" class="bg-info text-center">SATISFACCIÓN GENERAL DEL USUARIO</th>
                          </tr>
                          <tr>
                            <th rowspan="2" class="text-uppercase align-middle">¿Cómo calificaría usted lo siguiente?</th>
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
                            $resp = Satisfaccionusuario::validaEvaluacion([":idestudiante" => $_SESSION['idestudiante_eval'], ":parametro" => "p1"]);
                            
                            foreach($resp as $heteroevaluacion){                              
                              $num = $heteroevaluacion->num;
                            }
                            
                            if($num == 0){
                         ?>                          
                            <tr>                              
                              <th>Mantenimiento: El aseo en las aulas y otros espacios comunes</th>
                              <td class="text-center"><input type="radio" id="p1" name="cal1" value="20" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p1" name="cal1" value="40" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p1" name="cal1" value="60" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p1" name="cal1" value="80" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p1" name="cal1" value="100" class="form-radio mt-2"></td>                              
                            </tr>
                          <?php } ?>

                          <?php                          
                            $resp = Satisfaccionusuario::validaEvaluacion([":idestudiante" => $_SESSION['idestudiante_eval'], ":parametro" => "p2"]);
                            
                            foreach($resp as $heteroevaluacion){                              
                              $num = $heteroevaluacion->num;
                            }
                            
                            if($num == 0){
                         ?>                          
                            <tr>                              
                              <th>Mantenimiento: El aseo en los baños de la institución</th>
                              <td class="text-center"><input type="radio" id="p2" name="cal2" value="20" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p2" name="cal2" value="40" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p2" name="cal2" value="60" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p2" name="cal2" value="80" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p2" name="cal2" value="100" class="form-radio mt-2"></td>                              
                            </tr>
                          <?php } ?>

                          <?php                          
                            $resp = Satisfaccionusuario::validaEvaluacion([":idestudiante" => $_SESSION['idestudiante_eval'], ":parametro" => "p3"]);
                            
                            foreach($resp as $heteroevaluacion){                              
                              $num = $heteroevaluacion->num;
                            }
                            
                            if($num == 0){
                         ?>                          
                            <tr>                              
                              <th>Secretaría: Los procesos de matriculación y documentación en secretaría</th>
                              <td class="text-center"><input type="radio" id="p3" name="cal3" value="20" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p3" name="cal3" value="40" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p3" name="cal3" value="60" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p3" name="cal3" value="80" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p3" name="cal3" value="100" class="form-radio mt-2"></td>                              
                            </tr>
                          <?php } ?>

                          <?php                          
                            $resp = Satisfaccionusuario::validaEvaluacion([":idestudiante" => $_SESSION['idestudiante_eval'], ":parametro" => "p4"]);
                            
                            foreach($resp as $heteroevaluacion){                              
                              $num = $heteroevaluacion->num;
                            }
                            
                            if($num == 0){
                         ?>                          
                            <tr>                              
                              <th>Financiero: Los procesos de pagos y documentación en financiero</th>
                              <td class="text-center"><input type="radio" id="p4" name="cal4" value="20" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p4" name="cal4" value="40" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p4" name="cal4" value="60" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p4" name="cal4" value="80" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p4" name="cal4" value="100" class="form-radio mt-2"></td>                              
                            </tr>
                          <?php } ?>

                          <?php                          
                            $resp = Satisfaccionusuario::validaEvaluacion([":idestudiante" => $_SESSION['idestudiante_eval'], ":parametro" => "p5"]);
                            
                            foreach($resp as $heteroevaluacion){                              
                              $num = $heteroevaluacion->num;
                            }
                            
                            if($num == 0){
                         ?>                          
                            <tr>                              
                              <th>Comunicaciones: La publicidad de la institución</th>
                              <td class="text-center"><input type="radio" id="p5" name="cal5" value="20" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p5" name="cal5" value="40" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p5" name="cal5" value="60" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p5" name="cal5" value="80" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p5" name="cal5" value="100" class="form-radio mt-2"></td>                              
                            </tr>
                          <?php } ?>

                          <?php                          
                            $resp = Satisfaccionusuario::validaEvaluacion([":idestudiante" => $_SESSION['idestudiante_eval'], ":parametro" => "p6"]);
                            
                            foreach($resp as $heteroevaluacion){                              
                              $num = $heteroevaluacion->num;
                            }
                            
                            if($num == 0){
                         ?>                          
                            <tr>                              
                              <th>Técnicos: El servicio técnico/aula virtual</th>
                              <td class="text-center"><input type="radio" id="p6" name="cal6" value="20" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p6" name="cal6" value="40" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p6" name="cal6" value="60" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p6" name="cal6" value="80" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p6" name="cal6" value="100" class="form-radio mt-2"></td>                              
                            </tr>
                          <?php } ?>

                          <?php                          
                            $resp = Satisfaccionusuario::validaEvaluacion([":idestudiante" => $_SESSION['idestudiante_eval'], ":parametro" => "p7"]);
                            
                            foreach($resp as $heteroevaluacion){                              
                              $num = $heteroevaluacion->num;
                            }
                            
                            if($num == 0){
                         ?>                          
                            <tr>                              
                              <th>Seguridad: El servicio de guardianía </th>
                              <td class="text-center"><input type="radio" id="p7" name="cal7" value="20" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p7" name="cal7" value="40" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p7" name="cal7" value="60" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p7" name="cal7" value="80" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p7" name="cal7" value="100" class="form-radio mt-2"></td>                              
                            </tr>
                          <?php } ?>

                          <?php                          
                            $resp = Satisfaccionusuario::validaEvaluacion([":idestudiante" => $_SESSION['idestudiante_eval'], ":parametro" => "p8"]);
                            
                            foreach($resp as $heteroevaluacion){                              
                              $num = $heteroevaluacion->num;
                            }
                            
                            if($num == 0){
                         ?>                          
                            <tr>                              
                              <th>Gimnasio: atención y dirección recibida</th>
                              <td class="text-center"><input type="radio" id="p8" name="cal8" value="20" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p8" name="cal8" value="40" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p8" name="cal8" value="60" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p8" name="cal8" value="80" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p8" name="cal8" value="100" class="form-radio mt-2"></td>                              
                            </tr>
                          <?php } ?>

                          <?php                          
                            $resp = Satisfaccionusuario::validaEvaluacion([":idestudiante" => $_SESSION['idestudiante_eval'], ":parametro" => "p9"]);
                            
                            foreach($resp as $heteroevaluacion){                              
                              $num = $heteroevaluacion->num;
                            }
                            
                            if($num == 0){
                         ?>                          
                            <tr>                              
                              <th>ITSUP CLINIC: Atención recibida</th>
                              <td class="text-center"><input type="radio" id="p9" name="cal9" value="20" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p9" name="cal9" value="40" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p9" name="cal9" value="60" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p9" name="cal9" value="80" class="form-radio mt-2"></td>                              
                              <td class="text-center"><input type="radio" id="p9" name="cal9" value="100" class="form-radio mt-2"></td>                              
                            </tr>
                          <?php } ?>
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
        <script src="<?php echo DIR; ?>functions/satisfaccion-usuario.js"></script>