<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
<h3>Alta de vendedores</h3>
<form id="vendedores">
	<label>Usuario</label>
	<select id="vendedor" name="usuario" class="form-control">
		<option value="0">Selecciona un perfil de usuario</option>
		<ciclo usuarios>
			<option value="{usuario}">{nombre}</option>
		</ciclo usuarios>
	</select>
	<label>Almacen</label>
	<select id="almacen" name="almacen" class="form-control">
		<option value="0">Selecciona un almacen</option>
		<ciclo almacenes>
			<option value="{almacen}">{descripcion}</option>
		</ciclo almacenes>
	</select>
	<label>% Comisión</label>
	<input type="text" name="comision" class="form-control">
</form>
<br>
<p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardar()">Guardar</a></p>
</div>
<script type="text/javascript">
function guardar() {
	sincco.consumirAPI('POST','{BASE_URL}vendedores/apiPost',$("#vendedores").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}vendedores'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}
</script>
<incluir archivo="Footer">