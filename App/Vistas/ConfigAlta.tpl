<incluir archivo="Header">
<menu>
<div class="container">
<h3>Configuración adicional</h3>
<form id="almacenes">
	<ciclo config>
		<label>Porcentaje Socio 1</label>
		<input type="text" class="form-control" name="porcentajeSocio1" value="{porcentajeSocio1}">
		<label>Porcentaje Socio 2</label>
		<input type="text" class="form-control" name="porcentajeSocio2" value="{porcentajeSocio2}">
		<label>Porcentaje Socio 3</label>
		<input type="text" class="form-control" name="porcentajeSocio3" value="{porcentajeSocio3}">
		<label>Porcentaje Socio 4</label>
		<input type="text" class="form-control" name="porcentajeSocio4" value="{porcentajeSocio4}">
	</ciclo config>
</form>
<br>
<p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardarConfig()">Guardar</a></p>
</div>
<script type="text/javascript">
function guardarConfig() {
	loader.show()
	sincco.consumirAPI('POST','{BASE_URL}config/apiUPD',$("#almacenes").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			msgModal.show('success','Guardado')
		loader.hide()
	}).fail(function(jqXHR, textStatus, errorThrown) {
		msgModal.show('warning','Hubo un error al guardar')
		loader.hide()
	})
}
</script>
<incluir archivo="Footer">