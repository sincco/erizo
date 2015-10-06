//JQUERY: Agregar parseo de formulario a datos JSON 
(function ($) {
    $.fn.serializeJSON = function () {
        var o = {}
        var a = this.serializeArray()
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]]
                }
                o[this.name].push(this.value || '')
            } else {
                o[this.name] = this.value || ''
            }
        })
        return o
    }
})(jQuery)

//SINCCO: Agrupación de funciones cutomizadas
var sincco = new function() {
//Validación de RFC
	this.validarRFC = function(cadena) {
		var exp = /^[A-Z,Ñ,&]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9][A-Z,0-9]?[A-Z,0-9]?[0-9,A-Z]?/i
    	return exp.test(cadena)
	}
//Validación de Correo
	this.validarCorreo = function(cadena) {
		var exp = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
    	return exp.test(cadena)
	}
//Validar no vacia
	this.esVacio = function(cadena) {
		cadena = cadena.trim()
		return (!cadena || 0 === cadena.length)
	}
//Consumir una API/REST
	this.consumirAPI = function(metodo,url,datos) {
		return $.ajax({ 
			type: metodo,
			url: url,
			data: JSON.stringify(datos),
			headers: {"x-access-token": localStorage.getItem('userToken')},
			contentType: "application/json",
			dataType: "json",
			async: true,
			processData: false,
			cache: false,
		})
	}
}
