//Texto para las etiquetas de título en la navbar
document.getElementById("titulo-seccion").innerText = "Evaluación";
document.getElementById("titulo-pagina").innerText = "Portafolio Docente";
document.getElementById("titulo-principal").innerText = "Portafolio Docente";

//Class for default site
var mndashboard = document.getElementById('mnportafolio');
mndashboard.classList.add("active", "bg-gradient-primary");

//criterios de validación de los campos del formulario
var validator = $('#form').validate({
	onfocusout: false,
	onkeyup: false,
	onclick: false,
	focusInvalid: true,
	rules: {
		idcriterio: {
			required: true
		},
		documento: {
			required: true
		}
	},
	messages: {
		idcriterio: {
			required: "Seleccione un criterio para subir el documento"
		},
		documento: {
			required: "Seleccione un documento"
		}
	},
	errorPlacement: function (error, element) {
		//error.insertAfter(element);           
	},
	showErrors: function (errorMap, errorList) {
		var errors = validator.numberOfInvalids();
		if (errors) {
			validator.focusInvalid();
			$.alert({
				title: 'Información del Sistema',
				icon: 'fas fa-exclamation-circle',
				content: errorList[0].message,
				type: 'orange',
				theme: 'modern'
			});
		}
		this.defaultShowErrors();
	}
});

var num;
var idportafolio;

//Envío de datos del formulario
var form = document.getElementById("form");
form.addEventListener("submit", async function (event) {
	event.preventDefault();

	//validación de los campos del formulario
	var x = ($(this).validate());
	if (x.errorList.length > 0) {
		return;
	}

	let iddocente = document.getElementById('iddocente').value;
	let idcriterio = document.getElementById('idcriterio').value;
	let documento = document.getElementById('documento');

	var filePath = documento.value;
	var doc = documento.files[0];
	var allowedExtensions = /(\.pdf)$/i;

	if (!allowedExtensions.exec(filePath)) {
		$.alert({
			title: 'Alerta del Sistema',
			icon: 'fas fa-exclamation-circle',
			content: 'El archivo seleccionado no es válido. Seleccione un archivo en formato PDF.',
			type: 'orange',
			theme: 'modern'
		});

		documento.value = '';
		documento += " is-invalid";
		return;
	} else if (doc.size > 50000000) { // 2 MiB for bytes.
		$.alert({
			title: 'Alerta del Sistema',
			icon: 'fas fa-exclamation-circle',
			content: 'El archivo excede el tamaño máximo permitido. Seleccione un archivo con un máximo de 50MB',
			type: 'orange',
			theme: 'modern'
		});
		documento.value = '';
		documento.className += " is-invalid";
		return;
	} else {
		//input.classList.remove("is-invalid");
	}

	const formData = new FormData(form);  
	formData.append('iddocente', iddocente);
	formData.append('idcriterio', idcriterio);
	formData.append('documento', documento);

	await axios.post('https://evaluacion.itsup.edu.ec/docente/portafolio/findcriterio/', formData)
	.then(function (res){
		num = res.data.length;
	});

	if (num > 0) {
		$.alert({
			title: 'Alerta del Sistema',
			icon: 'fas fa-exclamation-circle',
			content: 'Ya se guardó un documento para ese criterio. Seleccione otro',
			type: 'orange',
			theme: 'modern',
			buttons: {
				aceptar: function () {
					
				}
			}
		});

		document.getElementById('idcriterio')
		document.getElementById
		return;
	}

	await axios.post('https://evaluacion.itsup.edu.ec/docente/portafolio/insert/', formData)
	.then(function (res) {
		if (res.data) {
			$.alert({
				title: 'Alerta del Sistema',
				icon: 'fa fa-thumbs-o-up',
				content: 'Documento guardado satisfactoriamente.',
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
				content: 'Ocurrió un error al intentar guardar el archivo. Intente nuevamente.',
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

//Eliminar el criterio con el documento adjunto
async function eliminar(idportafolio)
{
	$.confirm({
		title: 'Información del Sistema',
		icon: 'fa fa-question-circle',
		content: 'Desea eliminar el registro seleccionado? No se podrán revertir los cambios',
		theme: 'modern',
		type: 'blue',
		typeAnimated: true,
		buttons: {
			aceptar: async function () {
				idportafolio = idportafolio;

				await axios.get('https://evaluacion.itsup.edu.ec/docente/portafolio/delete/' + idportafolio)
				.then(function (res) {
					if(res.data){
						$.alert({
							title: 'Alerta del Sistema',
							icon: 'fa fa-thumbs-o-up',
							content: 'Documento eliminado satisfactoriamente.',
							type: 'blue',
							theme: 'modern',
							buttons: {
								aceptar: function () {
									window.location.reload();
								}
							}
						});
					} else{
						$.alert({
							title: 'Alerta del Sistema',
							icon: 'fas fa-exclamation-circle',
							content: 'Ocurrió un error al intentar eliminar el archivo. Intente nuevamente.',
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
				//window.location.reload();
			},
			cancelar: function () {

			}
		}
	});
}