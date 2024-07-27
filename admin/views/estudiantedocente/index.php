    <div class="container-fluid py-4">
        <div class="row">
            <div class="col-12">
            <div class="card card-frame">
                <div class="card-header bg-dark">
                    <h5 class="text-white float-start">Registro Heteroevaluación por parte de los Estudiantes</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="input-group input-group-static mb-4">
                                <label for="idcarrera" class="ms-0">Carrera</label>
                                <select class="form-control" id="idcarrera" name="idcarrera">
                                    <option value="">-- Seleccione una Carrera --</option>
                                    <?php foreach($carreras as $row): ?>
                                        <option value="<?php echo Main::encryption($row->idcarrera); ?>"><?php echo $row->carrera; ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="input-group input-group-static mb-4">
                                <label for="idsemestre" class="ms-0">Semestre</label>
                                <select class="form-control" id="idsemestre" name="idsemestre">
                                    <option value="">-- Seleccione Semestre --</option>
                                    <option value="<?php echo Main::encryption(1); ?>">Primero</option>
                                    <option value="<?php echo Main::encryption(2); ?>">Segundo</option>
                                    <option value="<?php echo Main::encryption(3); ?>">Tercero</option>
                                    <option value="<?php echo Main::encryption(4); ?>">Cuarto</option>
                                    <option value="<?php echo Main::encryption(5); ?>">Quinto</option>
                                    <option value="<?php echo Main::encryption(6); ?>">Sexto</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="input-group input-group-static mb-4">
                                <label for="jornada" class="ms-0">Jornada</label>
                                <select class="form-control" id="jornada" name="jornada">
                                    <option value="">-- Seleccione Jornada --</option>
                                    <option value="Matutino">Matutino</option>
                                    <option value="Vespertino">Vespertino</option>
                                    <option value="Nocturno">Nocturno</option>
                                    <option value="Intensivo">Intensivo</option>
                                    <option value="En Línea">En Línea</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <button id="btnModal" type="button" class="btn btn-primary"><span class="material-icons-round">person_add</span></button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="table-responsive">
                            <table id="tbLista" class="table table-hover table-condensed table-responsive">
                                <thead>
                                    <tr>
                                        <th class="text-center">CEDULA</th>
                                        <th class="text-center">APELLIDOS</th>
                                        <th class="text-center">NOMBRES</th>
                                        <th class="text-center">MATERIA</th>
                                        <th class="text-center">SEMESTRE</th>
                                        <th class="text-center">JORNADA</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="profesorModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="profesorModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Nómina de Docentes Registrados en el Sistema</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">x</button>
                    </div>
                    <div class="modal-body">
                        <div class="card">
                            <div class="card-body">
                                <div class="container">
                                    <table id="tbListaDocente" class="table table-hover table-condensed" style="font-size: 12px; margin-top: -50px;">
                                        <thead>
                                            <tr>
                                                <th>CEDULA</th>
                                                <th>APELLIDOS</th>
                                                <th>NOMBRES</th>
                                                <th>MATERIA</th>
                                                <th>SEMESTRE</th>
                                                <th>JORNADA</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php foreach($docentes as $row): ?>
                                                <tr>
                                                    <td><?php echo $row->identificacion; ?></td>
                                                    <td><?php echo $row->apellidos; ?></td>
                                                    <td><?php echo $row->nombres; ?></td>
                                                    <td><?php echo $row->materia; ?></td>
                                                    <td>
                                                        <?php 
                                                            switch ($row->idsemestre) {
                                                                case '1':
                                                                    echo 'Primero';
                                                                    break;
                                                                
                                                                case '2':
                                                                    echo 'Segundo';
                                                                    break;

                                                                case '3':
                                                                    echo 'Tercero';
                                                                    break;
                                                                
                                                                case '4':
                                                                    echo 'Cuarto';
                                                                    break;
                                                                
                                                                case '5':
                                                                    echo 'Quinto';
                                                                    break;
                                                                
                                                                case '6':
                                                                    echo 'Sexto';
                                                                    break;
                                                            }  
                                                        ?>
                                                    </td>
                                                    <td><?php echo $row->jornada; ?></td>
                                                    <td>
                                                        <a id="<?php echo Main::encryption($row->idsilabo); ?>" href="javascript:;" onclick="registrar(this.id);"><span class="material-icons-round">add_circle</span></a>
                                                    </td>
                                                </tr>
                                            <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" data-bs-dismiss="modal">Cerrar</button>
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
    <script src="<?php echo DIR; ?>functions/estudiante-docente.js"></script>
    
    