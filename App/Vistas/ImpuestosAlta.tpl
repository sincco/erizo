<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
<h3>Alta de impuestos</h3>
<form id="impuestos">
	<label>Desde</label><br>
	<input data-provide="datepicker" data-date-format="dd/mm/yyyy" name="desde"><br>
	<label>Hasta (en blanco para evitar vigencia)</label><br>
	<input data-provide="datepicker" data-date-format="dd/mm/yyyy" name="hasta"><br>
	<label>Porcentaje IVA</label><br>
	<input type="text" class="form-control" name="ivaPorcentaje"><br>
	<label>Porcentaje IEPS</label><br>
	<input type="text" class="form-control" name="iepsPorcentaje">
</form>
<br>
<p><a class="btn btn-primary btn-lg" href="#" role="button" onclick="guardar()">Guardar</a></p>
</div>
<script type="text/javascript">
function guardar() {
	sincco.consumirAPI('POST','{BASE_URL}impuestos/apiPost',$("#impuestos").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}impuestos'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}
</script>
<incluir archivo="Footer">