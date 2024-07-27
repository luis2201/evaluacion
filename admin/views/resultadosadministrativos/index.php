    <div class="container-fluid py-4">
      <div class="row">
        <div class="col-12">
          <div class="card card-frame">
            <div class="card-header bg-dark">
              <h5 class="text-white">Resultados de Evaluación Administrativos</h5>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-md-12">
                    <table id="tbLista" class="table table-condensed table-stripped table-hover" style="font-size: 12px; width:100%;" cellspacing="0">
                        <thead class="bg-primary text-light">
                            <tr class="bg-dark">
                                <th colspan="7"class="text-center">LISTA DE RESULTADOS TOTALES</th>
                            </tr>
                            <tr>
                                <th class="text-center">#</th>
                                <th class="text-center">Apellidos</th>
                                <th class="text-center">Nombres</th>
                                <th class="text-center">Autoevaluacion</th>
                                <th class="text-center">Coevalaución</th>
                                <th class="text-center">Heteroevalaución</th>
                                <th class="text-center"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                                $i = 1;
                                foreach($administrativos as $row): 
                                  if($row->idadministrativo){
                            ?>
                                <tr>                                  
                                    <td><?php echo $i++; ?></td>
                                    <td><?php echo $row->apellidos; ?></td>
                                    <td><?php echo $row->nombres; ?></td>
                                    <td style="padding:0.5em" class="text-center">
                                      <?php 
                                        $autoevaluacion = Resultadosadministrativos::Autoevaluacion([":idadministrativo" => $row->idadministrativo]);
                                        foreach($autoevaluacion as $a){
                                          echo number_format($a->total,2);
                                        }
                                      ?>
                                    </td>
                                    <td style="padding:0.5em" class="text-center">
                                      <?php 
                                        $coevaluacion = Resultadosadministrativos::Coevaluacion([":idadministrativo" => $row->idadministrativo]);
                                        foreach($coevaluacion as $c){
                                          echo number_format($c->total,2);
                                        }
                                      ?>
                                    </td>
                                    <td style="padding:0.5em" class="text-center">
                                      <?php 
                                        $heteroevaluacion = Resultadosadministrativos::Heteroevaluacion([":idadministrativo" => $row->idadministrativo]);
                                        foreach($heteroevaluacion as $h){
                                          echo number_format($h->total,2);
                                        }
                                      ?>
                                    </td>
                                    <td class="text-center"><a id="<?php echo Main::encryption($row->idadministrativo); ?>" onclick="mostrar(this.id)" href="javascrip:;" data-bs-toggle="modal" data-bs-target="#modal-default"><span class="material-icons-round">remove_red_eye</span></a></td>
                                </tr>
                            <?php }endforeach; ?>
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
          <div class="modal-dialog modal- modal-dialog-centered modal-lg" role="document">
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
                    <table id="tbResultados" class="table table-collapsep table-hover table-stripped">
                      <thead class="bg-info text-light">
                        <tr>                          
                          <td class="text-center font-weight-bold"># Indicador</td>
                          <td class="text-center font-weight-bold">Autoevaluación</td>
                          <td class="text-center font-weight-bold">Coevaluación</td>
                          <td class="text-center font-weight-bold">Heteroevaluación</td>                              
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
  <script src="<?php echo DIR; ?>functions/global.js?v=1.0.0"></script>
  <script src="<?php echo DIR; ?>functions/resultados-administrativos.js?v=1.0.1"></script>