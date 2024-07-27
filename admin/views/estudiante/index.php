    <div class="container-fluid py-4">
        <div class="row">
            <div class="col-12">
            <div class="card card-frame">
                <div class="card-header bg-dark">
                    <h5 class="text-white float-start">Registro Heteroevaluación por parte de los Estudiantes</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <form id="form" role="form" class="text-start" autocomplete="off">
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
                                <div class="col-md-2">
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
                                <!-- <div class="col-md-3">
                                    <div class="input-group input-group-static mb-4">
                                        <label for="paralelo" class="ms-0">Paralelo</label>
                                        <select class="form-control" id="paralelo" name="paralelo">
                                            <option value="">-- Seleccione Paralelo --</option>ss
                                            <option value="A">A</option>
                                            <option value="B">B</option>
                                        </select>
                                    </div>
                                </div> -->
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
                                <div class="col-md-2">
                                    <div class="row">
                                        <div class="col-6">
                                            <button type="submit" class="btn btn-primary"><span class="material-icons-round">person_search</span></button>
                                        </div>
                                        </form>
                                        <div class="col-6">
                                            <button class="btn btn-success" onclick="exportTableToExcel('tbLista')"><span class="material-icons-round">get_app</span></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="row">
                        <div class="table-responsive">
                            <table id="tbLista" class="table table-hover table-condensed table-responsive">
                                <thead>
                                    <tr>
                                        <th class="text-center">NÚMERO ID</th>
                                        <th class="text-center">IDENTIFICACION</th>
                                        <th class="text-center">NOMBRES</th>
                                        <th class="text-center">ESTADO</th>
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
        <div class="modal fade" id="exampleModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    
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
    <script src="<?php echo DIR; ?>functions/estudiante.js"></script>
    
    