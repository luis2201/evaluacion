var validator = $('#form').validate({	
	onfocusout		: false,
	onkeyup			: false,
	onclick			: false,
	focusInvalid	: true,	
	rules: {
		usuario: {
	      	required		: true,      
	      	minlength		: 6,
	      	maxlength		: 25
		}, 
		contrasena: {
	      required		: true,      
	      minlength		: 6,
	      maxlength		: 25
		}
	},
	messages: {
		usuario: {
	      required	: "Ingrese su usuario",
	      minlength	: "El usuario debe ser una cadena de al menos 8 caracteres",
	      maxlength	: "El usuario debe ser un cadena no mayor a 25 caracteres"
		},
		contrasena: {
	      required	: "Ingrese su contrasena",
	      minlength	: "La contraseña debe ser una cadena de al menos 8 caracteres",
	      maxlength	: "La contraseña debe ser un cadena no mayor a 25 caracteres"
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
form.addEventListener("submit", function(event){
    event.preventDefault();

    var x = ($(this).validate());	
	if(x.errorList.length>0){		
		return;
	}

	let usuario = document.getElementById("usuario").value;
	let contrasena = document.getElementById("contrasena").value;

	axios.post('https://evaluacion.itsup.edu.ec/autoridades/login/validate', {
		usuario,
		contrasena
	})
	.then(function (res){
		if(res.data.length > 0){
			window.location.href = 'dashboard';
		} else{
			$.confirm({		
				title   : 'Información del Sistema', 
				icon    : 'fas fa-info-circle',
				content : 'Usuario y/o contraseña incorrecto. Vuelva a intentar.',
				type    : 'orange',
				theme   : 'modern',
				buttons: {
					confirm: {
						text	: 'Continuar',
						action: function () {
							location.reload();
						}				
					}			
				}
			});
		}
	})
});