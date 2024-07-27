    <div class="container-fluid py-4">
      <div class="row">
        <div class="col-12">
          <div class="card card-frame">
            <div class="card-header bg-dark">
              <h5 class="text-white">Resultados de Evaluación Docente</h5>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="container table-responsive">
                    <table id="tbLista" class="table table-condensed table-stripped table-hover" style="font-size: 13px; width:100%;" cellspacing="0">
                        <thead class="bg-primary text-light">
                            <tr class="bg-dark">
                                <th colspan="10"class="text-center">LISTA DE RESULTADOS TOTALES</th>
                            </tr>
                            <tr>
                                <th style="padding:0.5em">#</th>                                
                                <th style="padding:0.5em">Docentes</th>
                                <th style="padding:0.5em">Autoevaluación</th>
                                <th style="padding:0.5em">Coevalaución</th>
                                <th style="padding:0.5em">Vinculación</th>
                                <th style="padding:0.5em">Investigación</th>
                                <th style="padding:0.5em">Gestión</th>
                                <th style="padding:0.5em">Docencia</th>
                                <th style="padding:0.5em">Estudiantes</th>
                                <!-- <th>A.V.</th>
                                <th>ADM.</th> -->
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                                $i = 1;
                                foreach($docentes as $row): 
                            ?>
                                <tr>
                                    <td style="padding:0.5em"><?php echo $i++; ?></td>
                                    <td style="padding:0.5em"><?php echo $row->apellidos.' '.$row->nombres; ?></td>                                    
                                    <td style="padding:0.5em" class="text-center">
                                      <?php 
                                        $autoevaluacion = Resultadosdocentes::ResultadoAutoevaluacion([":iddocente" => $row->iddocente]);
                                        foreach($autoevaluacion as $a){
                                          echo number_format($a->total,2);
                                        }
                                      ?>
                                    </td>
                                    <td style="padding:0.5em" class="text-center">
                                      <?php 
                                        $coevaluacion = Resultadosdocentes::ResultadoCoevaluacion([":iddocente" => $row->iddocente]);
                                        foreach($coevaluacion as $a){
                                          echo number_format($a->total,2);
                                        }
                                      ?>
                                    </td>
                                    <td style="padding:0.5em" class="text-center">
                                      <?php 
                                        $vinculacion = Resultadosdocentes::ResultadoArea([":iddocente" => $row->iddocente, ":idarea" => 1]);
                                        foreach($vinculacion as $v){
                                          echo number_format($v->total,2);
                                        }
                                      ?>
                                    </td>
                                    <td style="padding:0.5em" class="text-center">
                                      <?php 
                                        $vinculacion = Resultadosdocentes::ResultadoArea([":iddocente" => $row->iddocente, ":idarea" => 2]);
                                        foreach($vinculacion as $v){
                                          echo number_format($v->total,2);
                                        }
                                      ?>
                                    </td>
                                    <td style="padding:0.5em" class="text-center">
                                      <?php 
                                        $vinculacion = Resultadosdocentes::ResultadoArea([":iddocente" => $row->iddocente, ":idarea" => 3]);
                                        foreach($vinculacion as $v){
                                          echo number_format($v->total,2);
                                        }
                                      ?>
                                    </td>
                                    <td style="padding:0.5em" class="text-center">
                                      <?php 
                                        $vinculacion = Resultadosdocentes::ResultadoArea([":iddocente" => $row->iddocente, ":idarea" => 4]);
                                        foreach($vinculacion as $v){
                                          echo number_format($v->total,2);
                                        }
                                      ?>
                                    </td>
                                    <td style="padding:0.5em" class="text-center">
                                      <?php 
                                        $estudiantes = Resultadosdocentes::ResultadoEstudiante([":iddocente" => $row->iddocente]);
                                        foreach($estudiantes as $e){
                                          echo number_format($e->total,2);
                                        }
                                      ?>
                                    </td>
                                    <!-- <td class="text-center">
                                      <?php 
                                        $vinculacion = Resultadosdocentes::ResultadoArea([":iddocente" => $row->iddocente, ":idarea" => 5]);
                                        foreach($vinculacion as $v){
                                          echo number_format($v->total,2);
                                        }
                                      ?>
                                    </td>
                                    <td class="text-center">
                                      <?php 
                                        $vinculacion = Resultadosdocentes::ResultadoArea([":iddocente" => $row->iddocente, ":idarea" => 6]);
                                        foreach($vinculacion as $v){
                                          echo number_format($v->total,2);
                                        }
                                      ?>
                                    </td> -->
                                    <td style="padding:0.5em" class="text-center"><a id="<?php echo Main::encryption($row->iddocente); ?>" onclick="mostrar(this.id)" href="javascrip:;" data-bs-toggle="modal" data-bs-target="#modal-default"><span class="material-icons-round">remove_red_eye</span></a></td>
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
    
      <div class="col-md-4">        
        <div class="modal fade" id="modal-default" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
          <div class="modal-dialog modal- modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h6 class="modal-title font-weight-normal" id="modal-title-default">Resultados de Evaluación</h6>
                <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">×</span>
                </button>
              </div>
              <div class="modal-body">
                <div class="row">
                  <div class="col-md-12">
                    <table id="tbResultados" class="table table-collapsep table-hover table-stripped" style="font-size: smaller;">
                      <thead class="bg-info text-light">
                        <tr>
                          <td class="text-center font-weight-bold">#</td>
                          <td class="text-center font-weight-bold">Indicador</td>
                          <td class="text-center font-weight-bold">Autoevaluación</td>
                          <td class="text-center font-weight-bold">Coevaluación</td>                          
                          <td class="text-center font-weight-bold">Vinculación</td>                          
                          <td class="text-center font-weight-bold">Investigación</td>                          
                          <td class="text-center font-weight-bold">Gestión</td>                          
                          <td class="text-center font-weight-bold">Docencia</td>                          
                          <td class="text-center font-weight-bold">Estudiantes</td>                          
                          <!-- <td class="text-center font-weight-bold">Aula Virtual</td>                          
                          <td class="text-center font-weight-bold">Administrativo</td>                           -->
                        </tr>
                      </thead>
                      <tbody>
                        
                      </tbody>                      
                    </table>
                  </div>
                </div>
              </div>
              <div class="modal-footer">                
                <button type="button" class="btn btn-link  ml-auto" data-bs-dismiss="modal">Cerrar</button>
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
  <!-- DataTables JS -->
  <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/dataTables.buttons.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.bootstrap5.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.html5.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.print.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.colVis.min.js"></script>
  <script src="https://cdn.datatables.net/plug-ins/1.12.1/i18n/es-ES.json"></script>
  <!-- Site JS -->
  <script src="<?php echo DIR; ?>functions/resultados-docentes.js"></script>