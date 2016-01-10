<incluir archivo="Header">
<menu>
<div class="container">
	<h3>Cuentas por cobrar</h3>
	<tabla datos="catalogo" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>
<incluir archivo="Footer">

<div id="myModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 id="titulo" class="modal-title">Agregar pago</h4>
            </div>
            <div class="modal-body">
            	<div id="errores"></div>
            	<button class="btn btn-info" type="button"onclick="$('#pago').val($('#saldo').html().replace(',',''))">Pagar el saldo <span class="badge" id="saldo"></span></button><br><br>
            	<input type="hidden" id="venta" value="">
            	<label>Monto de pago</label><input type="text" id="pago" class="form-control">
            </div>
            <div class="modal-footer">
            	<button type="button" class="btn btn-success btn-md" onclick="guardar()">Guardar</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function editarElemento(fila) {
	$("#saldo").html(fila.saldo)
	$("#venta").val(fila.clave)
	$('#myModal').modal('show')
}

function guardar() {
	if(parseFloat($("#pago").val()) > parseFloat($('#saldo').html().replace(',','')))
		$("#errores").html('<div class="alert alert-warning" role="alert">El monto del pago no puede exceder el saldo</div>')
	else {
		sincco.consumirAPI('POST','{BASE_URL}cxc/apiPost',{pago:$("#pago").val(),venta:$("#venta").val()})
		.done(function(data) {
			if(data.respuesta)
				window.location = '{BASE_URL}cxc'
		}).fail(function(jqXHR, textStatus, errorThrown) {
			console.log(errorThrown)
		})
	}
}
</script>

<incluir archivo="Footer">