<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
<h3>Alta de plan de ventas</h3>
<form id="planventas">
	<label>Desde</label><br>
	<input data-provide="datepicker" data-date-format="dd/mm/yyyy" name="desde"><br>
	<label>Hasta (en blanco para evitar vigencia)</label><br>
	<input data-provide="datepicker" data-date-format="dd/mm/yyyy" name="hasta"><br>
	<label>Monto</label><br>
	<input type="text" class="form-control" name="monto"><br>
</form>
<br>
<p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardar()">Guardar</a></p>
</div>
<script type="text/javascript">
function guardar() {
	sincco.consumirAPI('POST','{BASE_URL}planventas/apiPost',$("#planventas").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}planventas'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}
</script>
<incluir archivo="Footer">