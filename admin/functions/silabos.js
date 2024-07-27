//Texto para las etiquetas de título en la navbar
document.getElementById("titulo-seccion").innerText = "Evaluación";
document.getElementById("titulo-pagina").innerText = "Sílabos";
document.getElementById("titulo-principal").innerText = "Sílabos por Asignaturas Docente";

//Class for default site
var mndashboard = document.getElementById('mnsilabos');
mndashboard.classList.add("active", "bg-gradient-primary");

var validator = $('#form').validate({	
	onfocusout		: false,
	onkeyup			: false,
	onclick			: false,
	focusInvalid	: true,	
	rules: {
		iddocente: {
	      	required	: true
		}, 
		idmateria: {
	      required		: true
		},
        idsemestre: {
            required	: true
        },
        paralelo: {
            required	: true
        },
        jornada: {
            required	: true
        }
	},
	messages: {
		iddocente: {
	        required	: "Seleccione Docente"
		},
		idmateria: {
	        required	: "Seleccione Materia"
		},
        idsemestre: {
            required	: "Seleccione Semetre"
        },
        paralelo: {
            required	: "Seleccione Paralelo"
        },
        jornada: {
            required	: "Seleccione Jornada"
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

var cmbIdDocente = document.getElementById("iddocente");
cmbIdDocente.addEventListener("change", async function (event) {
    let iddocente = this.value;
	
	axios.get('https://evaluacion.itsup.edu.ec/admin/silabos/findiddocente/' + iddocente)
	.then(function (res){
		let info = res.data;

		'use strict';
		const tbody = document.querySelector('#tbLista tbody');
		tbody.innerHTML = info;

		document.getElementById("idmateria").value = "";
		document.getElementById("idsemestre").value = "";
		document.getElementById("paralelo").value = "";
		document.getElementById("jornada").value = "";
	})
	.catch(function (error) {
		$.alert({		
			title   : 'Error del Sistema', 
			icon    : 'fas fa-info-circle',
			content : error.message,
			type    : 'orange',
			theme   : 'modern',
			buttons: {
				confirm: {
					text	: 'Continuar',
					action: function () {
						
					}				
				}			
			}
		});
	});
})

var form = document.getElementById("form");
form.addEventListener("submit", async function (event) {
    event.preventDefault();

    //validación de los campos del formulario
    var x = ($(this).validate());	
	if(x.errorList.length>0){		
		return;
	}

    let iddocente = document.getElementById("iddocente").value;
	let idsemestre = document.getElementById("idsemestre").value;
	let paralelo = document.getElementById("paralelo").value;
	let jornada = document.getElementById("jornada").value;
	let idmateria = document.getElementById("idmateria").value;

	var res = await axios.post('https://evaluacion.itsup.edu.ec/admin/silabos/finddocenteidmateria/', {
		iddocente,
		idsemestre,
		paralelo,
		jornada,
		idmateria
	});

	let info = res.data;

	if(info.length>0){
		$.alert({
			title: 'Alerta del Sistema',
			icon: 'fas fa-info-circle',
			content: 'Materia duplicada. Ingrese otra',
			type: 'orange',
			theme: 'modern',
			buttons: {
				aceptar: function () {
					
				}
			}
		});

		return;
	}

	axios.post('https://evaluacion.itsup.edu.ec/admin/silabos/insert/', {
		iddocente,
		idsemestre,
		paralelo,
		jornada,
		idmateria
	})
	.then(function (res){
		let info = res.data;

		$.alert({
			title: 'Alerta del Sistema',
			icon: 'fa fa-thumbs-o-up',
			content: 'Datos del Docente guardados satisfactoriamente.',
			type: 'blue',
			theme: 'modern',
			buttons: {
				aceptar: function () {
					
				}
			}
		});

		'use strict';
		const tbody = document.querySelector('#tbLista tbody');
		tbody.innerHTML = info;

		document.getElementById("idmateria").value = "";
		document.getElementById("idsemestre").value = "";
		document.getElementById("paralelo").value = "";
		document.getElementById("jornada").value = "";
	})
	.catch(function (error) {
		$.alert({		
			title   : 'Error del Sistema', 
			icon    : 'fas fa-info-circle',
			content : error.message,
			type    : 'orange',
			theme   : 'modern',
			buttons: {
				confirm: {
					text	: 'Continuar',
					action: function () {

					}				
				}			
			}
		});
	});
});

function eliminarSilabo(idsilabo)
{
	$.confirm({
		title: 'Alerta del Sistema',
		icon: 'fas fa-info-circle',
		content: 'Desea eliminar la materia seleccionada?',
		type: 'orange',
		theme: 'modern',
		buttons: {
			aceptar: function () {

				var res = axios.get('https://evaluacion.itsup.edu.ec/admin/silabos/delete/' + idsilabo);
				let info = res.data;

				let iddocente = document.getElementById("iddocente").value;
				
				axios.get('https://evaluacion.itsup.edu.ec/admin/silabos/findiddocente/' + iddocente)
				.then(function (res){
					let info = res.data;

					'use strict';
					const tbody = document.querySelector('#tbLista tbody');
					tbody.innerHTML = info;
				})
				.catch(function (error) {
					$.alert({		
						title   : 'Error del Sistema', 
						icon    : 'fas fa-info-circle',
						content : error.message,
						type    : 'red',
						theme   : 'modern',
						buttons: {
							confirm: {
								text	: 'Continuar',
								action: function () {

								}				
							}			
						}
					});
				});

			},
			cancelar: function () {
				return;
			}
		}
	});
}