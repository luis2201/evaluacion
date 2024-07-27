//Texto para las etiquetas de título en la navbar
document.getElementById("titulo-seccion").innerText = "Evaluación";
document.getElementById("titulo-pagina").innerText = "Heteroevaluación Administrativo";
document.getElementById("titulo-principal").innerText = "Registro Evaluadores Administrativo";

//Class for default site
var mndashboard = document.getElementById('mnheteroevaluacionadministrativo');
mndashboard.classList.add("active", "bg-gradient-primary");

var cmbIdAutoridad = document.getElementById("idautoridad");
cmbIdAutoridad.addEventListener("change", async function(event){
    'use strict';
    const tbody = document.querySelector('#tbLista tbody');
    tbody.innerHTML = '';

    if(cmbIdAutoridad.value==""){
        return;
    }

    let idautoridad = cmbIdAutoridad.value;
    await axios.get(DIR + 'heteroevaluacionadministrativo/selectautoridadadministrativo/' + idautoridad)
    .then(function (res) {
        let rows = res.data;
        tbody.innerHTML = rows;
    })
});

var administrativoModal = new bootstrap.Modal(document.getElementById('administrativoModal'), {
    keyboard: false
})

function lista()
{
    let idautoridad = document.getElementById("idautoridad").value;
    if(idautoridad==''){
        $.alert({ 
            title	: 'Información del Sistema', 
            icon	: 'fas fa-exclamation-circle',
            content	: 'Seleccione una Autoridad',
            type	: 'orange',
            theme	: 'modern'				
        });
        
        return;
    }

    administrativoModal.show();
}

async function agregar(idadministrativo)
{
    let idautoridad = document.getElementById("idautoridad").value;

    $.confirm({
		title: 'Alerta del Sistema',
		icon: 'fa fa-question',
		content: 'Esta seguro que desea realizar esta asignación?',
		type: 'blue',
		theme: 'modern',
		buttons: {
			continuar: async function () {
				await axios.post(DIR + 'heteroevaluacionadministrativo/insert/', {
                    idautoridad,
                    idadministrativo
                })
				.then(function (res) {
                    let rows = res.data;

                    'use strict';
                    const tbody = document.querySelector('#tbLista tbody');
                    tbody.innerHTML = '';

		            tbody.innerHTML = rows;
				})
			},
			cancelar: function() {
				
			}
		}
	});
}

async function eliminar(idheteroevaluacion)
{
    let idautoridad = document.getElementById("idautoridad").value;

    $.confirm({
		title: 'Alerta del Sistema',
		icon: 'fa fa-question',
		content: 'Esta seguro que desea eliminar este registro?',
		type: 'blue',
		theme: 'modern',
		buttons: {
			continuar: async function () {
				await axios.post(DIR + 'heteroevaluacionadministrativo/delete/', {
                    idautoridad,
                    idheteroevaluacion
                })
				.then(function (res) {
                    let rows = res.data;

                    'use strict';
                    const tbody = document.querySelector('#tbLista tbody');
                    tbody.innerHTML = '';
                    
		            tbody.innerHTML = rows;
				})
			},
			cancelar: function() {
				
			}
		}
	});
}