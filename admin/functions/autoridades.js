//Texto para las etiquetas de título en la navbar
document.getElementById("titulo-seccion").innerText = "Evaluación";
document.getElementById("titulo-pagina").innerText = "Autoridades";
document.getElementById("titulo-principal").innerText = "Registro de Autoridades";

//Class for default site
var mndashboard = document.getElementById('mnautoridades');
mndashboard.classList.add("active", "bg-gradient-primary");

var validator = $('#form').validate({	
	onfocusout		: false,
	onkeyup			: false,
	onclick			: false,
	focusInvalid	: true,	
	rules: {
		tipoidentificacion: {
	      	required	: true
		}, 
		identificacion: {
            required		: true,      
            minlength		: 10,
            maxlength		: 25
		},
        nombres: {
            required		: true,      
            minlength		: 4,
            maxlength		: 100
        },
        apellidos: {
            required		: true,      
            minlength		: 4,
            maxlength		: 100
        },
        correo: {
            required		: true,      
            minlength		: 6,
            maxlength		: 255,
            email           : true
        },
		idarea: {
			required	: true
	  	}
	},
	messages: {
		tipoidentificacion: {
	      required	: "Seleccione tipo de identificación"
		},
		identificacion: {
	      required	: "Ingrese número de identificacion",
	      minlength	: "El número de identificación debe tener al menos 10 caracteres",
	      maxlength	: "El número de identificacion no debe tener más de 25 caracteres"
		},
        nombres: {
            required	: "Ingrese nombres de la autoridad",
            minlength	: "El nombre de la autoridad debe tener al menos 4 caracteres",
	        maxlength	: "El nombre de la autoridad no debe tener más de 100 caracteres"
        },
        apellidos: {
            required	: "Ingrese apellidos de la autoridad",
            minlength	: "El apellido de la autoridad debe tener al menos 4 caracteres",
	        maxlength	: "El apellido de la autoridad no debe tener más de 100 caracteres"
        },
        correo: {
            required	: "Ingrese correo de la autoridad",
            minlength	: "El correo de la autoridad debe tener al menos 6 caracteres",
	        maxlength	: "El correo de la autoridad no debe tener más de 255 caracteres",
            email       : "Ingrese un correo válido"
        },
		idarea: {
			required	: "Seleccione Área"
		}
	},	
	errorPlacement: function(error,element){ 
			//error.insertAfter(element);           
	},
	showErrors: function(errorMap, errorList){ 
		var errors = validator.numberOfInvalids();
		if (errors) {
			validator.focusInvalid();
			$.alert({ 
				title	: 'Información del Sistema', 
				icon	: 'fas fa-exclamation-circle',
				content	: errorList[0].message,
				type	: 'orange',
				theme	: 'modern'				
			});
		}
		this.defaultShowErrors();  		
	}
});


//Envío de datos del formulario
var form = document.getElementById("form");
form.addEventListener("submit", async function (event) {
	event.preventDefault();

	//validación de los campos del formulario
	var x = ($(this).validate());
	if (x.errorList.length > 0) {
		return;
	}

	let idautoridad = document.getElementById('idautoridad').value;
	let tipoidentificacion = document.getElementById('tipoidentificacion').value;
	let identificacion = document.getElementById('identificacion').value;
	let nombres = document.getElementById('nombres').value;
	let apellidos = document.getElementById('apellidos').value;
	let correo = document.getElementById('correo').value;
	let idarea = document.getElementById('idarea').value;

	const formData = new FormData(form);  
	formData.append('idautoridad', idautoridad);
	formData.append('tipoidentificacion', tipoidentificacion);
	formData.append('identificacion', identificacion);
	formData.append('nombres', nombres);
	formData.append('apellidos', apellidos);
	formData.append('correo', correo);
	formData.append('idarea', idarea);

	await axios.post(DIR + 'autoridades/findidentificacion/', formData)
	.then(function (res){
		num = res.data.length;
	});

	if (num > 0) {
		$.alert({
			title: 'Alerta del Sistema',
			icon: 'fas fa-exclamation-circle',
			content: 'Ya se ingresó el número de cédula para otra autoridad. Ingrese otro.',
			type: 'orange',
			theme: 'modern',
			buttons: {
				aceptar: function () {
					
				}
			}
		});

		document.getElementById('identificacion').value = "";		
		return;
	}

	num = 0; 

	await axios.post(DIR + 'autoridades/findcorreo/', formData)
	.then(function (res){
		num = res.data.length;		
	});

	if (num > 0) {
		$.alert({
			title: 'Alerta del Sistema',
			icon: 'fas fa-exclamation-circle',
			content: 'Ya se ingresó el correo para otra autoridad. Ingrese otro.',
			type: 'orange',
			theme: 'modern',
			buttons: {
				aceptar: function () {
					
				}
			}
		});

		document.getElementById('correo').value = "";		
		return;
	}
	
	await axios.post(DIR + 'autoridades/save/', formData)
	.then(function (res) {
		console.log(res.data)
		if (res.data) {
			$.alert({
				title: 'Alerta del Sistema',
				icon: 'fa fa-thumbs-o-up',
				content: 'Datos de la Autoridad guardados satisfactoriamente.',
				type: 'blue',
				theme: 'modern',
				buttons: {
					aceptar: function () {
						window.location.reload();
					}
				}
			});
		} else {
			$.alert({
				title: 'Alerta del Sistema',
				icon: 'fas fa-exclamation-circle',
				content: 'Ocurrió un error al intentar guardar los datos de la autoridad. Intente nuevamente.',
				type: 'orange',
				theme: 'modern',
				buttons: {
					aceptar: function () {

					}
				}
			});
		}

	})
	.catch(function (error) {
		$.alert({
			title: error.code,
			icon: 'fas fa-exclamation-circle',
			content: error.message,
			type: 'red',
			theme: 'modern',
			buttons: {
				aceptar: function () {

				}
			}
		});
	})
	
});


async function modificar(idautoridad){
	await axios.get(DIR + 'autoridades/findid/' + idautoridad)
	.then(function (res) {
		let info = res.data[0];

		document.getElementById("idautoridad").value = idautoridad;
		document.getElementById("tipoidentificacion").value = info.tipoidentificacion;
		document.getElementById("identificacion").value = info.identificacion;
		document.getElementById("nombres").value = info.nombres;
		document.getElementById("apellidos").value = info.apellidos;
		document.getElementById("correo").value = info.correo;
		document.getElementById("idarea").value = info.idarea;

		document.getElementById("correo").disabled = true;
	})
}

function eliminar(idautoridad){
	$.confirm({
		title: 'Alerta del Sistema',
		icon: 'fa fa-thumbs-o-up',
		content: 'Esta seguro de realizar esta acción? No se podrán deshacer los cambios',
		type: 'blue',
		theme: 'modern',
		buttons: {
			continuar: async function () {
				await axios.get(DIR + 'autoridades/delete/' + idautoridad)
				.then(function (res) {
					window.location.reload();
				})
			},
			cancelar: function() {
				
			}
		}
	});
}

var table = $('#tbLista').DataTable({
	lengthChange: false,
	//buttons: ['copy', 'excel', 'pdf', 'colvis'],
	buttons: [
		{
			extend: 'copy',
			exportOptions: {
				columns: [ 0, 1, 2, 3, 5 ]
			},
			messageTop: 'Nómina de Autoridades Registrados en el Sistema'
		},
		{
			extend: 'excel',
			exportOptions: {
				columns: [ 0, 1, 2, 3, 5 ]
			},
			messageTop: 'Nómina de Autoridades Registrados en el Sistema'
		},
		{
			extend: 'pdf',
			exportOptions: {
				columns: [ 0, 1, 2, 3, 4, 5 ]
			},
			messageTop: 'Nómina de Autoridades Registrados en el Sistema'
		},
		'colvis'
	],
	language: {
	  "processing": "Procesando...",
	  "lengthMenu": "Mostrar _MENU_ registros",
	  "zeroRecords": "No se encontraron resultados",
	  "emptyTable": "Ningún dato disponible en esta tabla",
	  "infoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
	  "infoFiltered": "(filtrado de un total de _MAX_ registros)",
	  "search": "Buscar:",
	  "infoThousands": ",",
	  "loadingRecords": "Cargando...",
	  "paginate": {
		"first": "Primero",
		"last": "Último",
		"next": "Siguiente",
		"previous": "Anterior"
	  },
	  "aria": {
		"sortAscending": ": Activar para ordenar la columna de manera ascendente",
		"sortDescending": ": Activar para ordenar la columna de manera descendente"
	  },
	  "buttons": {
		"copy": "Copiar",
		"colvis": "Visibilidad",
		"collection": "Colección",
		"colvisRestore": "Restaurar visibilidad",
		"copyKeys": "Presione ctrl o u2318 + C para copiar los datos de la tabla al portapapeles del sistema. <br \/> <br \/> Para cancelar, haga clic en este mensaje o presione escape.",
		"copySuccess": {
		  "1": "Copiada 1 fila al portapapeles",
		  "_": "Copiadas %ds fila al portapapeles"
		},
		"copyTitle": "Copiar al portapapeles",
		"csv": "CSV",
		"excel": "Excel",
		"pageLength": {
		  "-1": "Mostrar todas las filas",
		  "_": "Mostrar %d filas"
		},
		"pdf": "PDF",
		"print": "Imprimir",
		"renameState": "Cambiar nombre",
		"updateState": "Actualizar",
		"createState": "Crear Estado",
		"removeAllStates": "Remover Estados",
		"removeState": "Remover",
		"savedStates": "Estados Guardados",
		"stateRestore": "Estado %d"
	  },
	  "autoFill": {
		"cancel": "Cancelar",
		"fill": "Rellene todas las celdas con <i>%d<\/i>",
		"fillHorizontal": "Rellenar celdas horizontalmente",
		"fillVertical": "Rellenar celdas verticalmentemente"
	  },
	  "decimal": ",",
	  "searchBuilder": {
		"add": "Añadir condición",
		"button": {
		  "0": "Constructor de búsqueda",
		  "_": "Constructor de búsqueda (%d)"
		},
		"clearAll": "Borrar todo",
		"condition": "Condición",
		"conditions": {
		  "date": {
			"after": "Despues",
			"before": "Antes",
			"between": "Entre",
			"empty": "Vacío",
			"equals": "Igual a",
			"notBetween": "No entre",
			"notEmpty": "No Vacio",
			"not": "Diferente de"
		  },
		  "number": {
			"between": "Entre",
			"empty": "Vacio",
			"equals": "Igual a",
			"gt": "Mayor a",
			"gte": "Mayor o igual a",
			"lt": "Menor que",
			"lte": "Menor o igual que",
			"notBetween": "No entre",
			"notEmpty": "No vacío",
			"not": "Diferente de"
		  },
		  "string": {
			"contains": "Contiene",
			"empty": "Vacío",
			"endsWith": "Termina en",
			"equals": "Igual a",
			"notEmpty": "No Vacio",
			"startsWith": "Empieza con",
			"not": "Diferente de",
			"notContains": "No Contiene",
			"notStartsWith": "No empieza con",
			"notEndsWith": "No termina con"
		  },
		  "array": {
			"not": "Diferente de",
			"equals": "Igual",
			"empty": "Vacío",
			"contains": "Contiene",
			"notEmpty": "No Vacío",
			"without": "Sin"
		  }
		},
		"data": "Data",
		"deleteTitle": "Eliminar regla de filtrado",
		"leftTitle": "Criterios anulados",
		"logicAnd": "Y",
		"logicOr": "O",
		"rightTitle": "Criterios de sangría",
		"title": {
		  "0": "Constructor de búsqueda",
		  "_": "Constructor de búsqueda (%d)"
		},
		"value": "Valor"
	  },
	  "searchPanes": {
		"clearMessage": "Borrar todo",
		"collapse": {
		  "0": "Paneles de búsqueda",
		  "_": "Paneles de búsqueda (%d)"
		},
		"count": "{total}",
		"countFiltered": "{shown} ({total})",
		"emptyPanes": "Sin paneles de búsqueda",
		"loadMessage": "Cargando paneles de búsqueda",
		"title": "Filtros Activos - %d",
		"showMessage": "Mostrar Todo",
		"collapseMessage": "Colapsar Todo"
	  },
	  "select": {
		"cells": {
		  "1": "1 celda seleccionada",
		  "_": "%d celdas seleccionadas"
		},
		"columns": {
		  "1": "1 columna seleccionada",
		  "_": "%d columnas seleccionadas"
		},
		"rows": {
		  "1": "1 fila seleccionada",
		  "_": "%d filas seleccionadas"
		}
	  },
	  "thousands": ".",
	  "datetime": {
		"previous": "Anterior",
		"next": "Proximo",
		"hours": "Horas",
		"minutes": "Minutos",
		"seconds": "Segundos",
		"unknown": "-",
		"amPm": [
		  "AM",
		  "PM"
		],
		"months": {
		  "0": "Enero",
		  "1": "Febrero",
		  "10": "Noviembre",
		  "11": "Diciembre",
		  "2": "Marzo",
		  "3": "Abril",
		  "4": "Mayo",
		  "5": "Junio",
		  "6": "Julio",
		  "7": "Agosto",
		  "8": "Septiembre",
		  "9": "Octubre"
		},
		"weekdays": [
		  "Dom",
		  "Lun",
		  "Mar",
		  "Mie",
		  "Jue",
		  "Vie",
		  "Sab"
		]
	  },
	  "editor": {
		"close": "Cerrar",
		"create": {
		  "button": "Nuevo",
		  "title": "Crear Nuevo Registro",
		  "submit": "Crear"
		},
		"edit": {
		  "button": "Editar",
		  "title": "Editar Registro",
		  "submit": "Actualizar"
		},
		"remove": {
		  "button": "Eliminar",
		  "title": "Eliminar Registro",
		  "submit": "Eliminar",
		  "confirm": {
			"_": "¿Está seguro que desea eliminar %d filas?",
			"1": "¿Está seguro que desea eliminar 1 fila?"
		  }
		},
		"error": {
		  "system": "Ha ocurrido un error en el sistema (<a target=\"\\\" rel=\"\\ nofollow\" href=\"\\\">Más información&lt;\\\/a&gt;).<\/a>"
		},
		"multi": {
		  "title": "Múltiples Valores",
		  "info": "Los elementos seleccionados contienen diferentes valores para este registro. Para editar y establecer todos los elementos de este registro con el mismo valor, hacer click o tap aquí, de lo contrario conservarán sus valores individuales.",
		  "restore": "Deshacer Cambios",
		  "noMulti": "Este registro puede ser editado individualmente, pero no como parte de un grupo."
		}
	  },
	  "info": "Mostrando _START_ a _END_ de _TOTAL_ registros",
	  "stateRestore": {
		"creationModal": {
		  "button": "Crear",
		  "name": "Nombre:",
		  "order": "Clasificación",
		  "paging": "Paginación",
		  "search": "Busqueda",
		  "select": "Seleccionar",
		  "columns": {
			"search": "Búsqueda de Columna",
			"visible": "Visibilidad de Columna"
		  },
		  "title": "Crear Nuevo Estado",
		  "toggleLabel": "Incluir:"
		},
		"emptyError": "El nombre no puede estar vacio",
		"removeConfirm": "¿Seguro que quiere eliminar este %s?",
		"removeError": "Error al eliminar el registro",
		"removeJoiner": "y",
		"removeSubmit": "Eliminar",
		"renameButton": "Cambiar Nombre",
		"renameLabel": "Nuevo nombre para %s",
		"duplicateError": "Ya existe un Estado con este nombre.",
		"emptyStates": "No hay Estados guardados",
		"removeTitle": "Remover Estado",
		"renameTitle": "Cambiar Nombre Estado"
	  }
	}
  });

  table.buttons().container()
	.appendTo('#tbLista_wrapper .col-md-6:eq(0)');