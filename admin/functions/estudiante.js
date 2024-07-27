//Texto para las etiquetas de título en la navbar
document.getElementById("titulo-seccion").innerText = "Evaluación";
document.getElementById("titulo-pagina").innerText = "Heteroevaluación";
document.getElementById("titulo-principal").innerText = "Registro Heteroevaluación por parte de los Estudiantes";

//Class for default site
var mndashboard = document.getElementById('mnestudiante');
mndashboard.classList.add("active", "bg-gradient-primary");

var validator = $('#form').validate({	
	onfocusout		: false,
	onkeyup			: false,
	onclick			: false,
	focusInvalid	: true,	
	rules: {
		idcarrera: {
	      	required	: true
		}, 
        idsemestre: {
            required	: true
        },
        jornada: {
            required	: true
        }
	},
	messages: {
		idcarrera: {
	        required	: "Seleccione Carrera"
		},
        idsemestre: {
            required	: "Seleccione Semetre"
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

var form = document.getElementById("form");
form.addEventListener("submit", async function (event) {
    event.preventDefault();

    //validación de los campos del formulario
    var x = ($(this).validate());	
	if(x.errorList.length>0){		
		return;
	}

    let idcarrera = document.getElementById("idcarrera").value;
	let idsemestre = document.getElementById("idsemestre").value;
	let jornada = document.getElementById("jornada").value;

	const formData = new FormData(form);  
	formData.append('idcarrera', idcarrera);
	formData.append('idsemestre', idsemestre);
	formData.append('jornada', jornada);

	await axios.post('https://evaluacion.itsup.edu.ec/admin/estudiante/findestudiante/', formData )
	.then(function (res){
		let info = res.data;
console.log(info)
		'use strict';
		const tbody = document.querySelector('#tbLista tbody');
		tbody.innerHTML = info;
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

function exportTableToExcel(tableID, filename = ''){
    var downloadLink;
    var dataType = 'application/vnd.ms-excel';
    var tableSelect = document.getElementById(tableID);
    var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');
    
    // Specify file name
    filename = filename?filename+'.xls':'lista_estudiantes.xls';
    
    // Create download link element
    downloadLink = document.createElement("a");
    
    document.body.appendChild(downloadLink);
    
    if(navigator.msSaveOrOpenBlob){
        var blob = new Blob(['ufeff', tableHTML], {
            type: dataType
        });
        navigator.msSaveOrOpenBlob( blob, filename);
    }else{
        // Create a link to the file
        downloadLink.href = 'data:' + dataType + ', ' + tableHTML;
    
        // Setting the file name
        downloadLink.download = filename;
        
        //triggering the function
        downloadLink.click();
    }
}